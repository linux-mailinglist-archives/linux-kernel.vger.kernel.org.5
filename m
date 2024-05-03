Return-Path: <linux-kernel+bounces-167785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25158BAF29
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7608B20FC0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEC641A80;
	Fri,  3 May 2024 14:42:25 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396F679E5
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714747345; cv=none; b=YG0GGk9CRu6WliHXE1tUC/1KEPWwS4uzGYSRo0lI+XJgQTopsw/+/8B7chMu/r/d5niH5wggz2PYgyxT6L6z5/RLvCCkzzsZ4wz88i8aJ9y7GR/C+dgvAsU1wJQG1NfKJ1XKTJAysyG4LEozDkU83cUJwWlVnL1BXMKosW+4rxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714747345; c=relaxed/simple;
	bh=mDc7l4BQOtQuW0woQaACXN7GwQ/3uPIg/A4ox0GMq4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMHYeQLjb03hc3czQJ4PDLkLBd3WOcGZjQhbebThHQSuEfbYPz9MbGaAIW7hceoZYtXV37P5xqZn3fL2onUEKj7tkh0RddfS14yd2bryK0SynIUhwPK0TKzCU9Sfherny6WxBLFaogTwlLNYj90RCP0D5EtQqoTFz0UbfEtd9AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 3 May
 2024 17:41:05 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 3 May 2024
 17:41:05 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <syzbot+97b4444a5bd7bf30b3a8@syzkaller.appspotmail.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in skcipher_walk_virt
Date: Fri, 3 May 2024 07:40:55 -0700
Message-ID: <20240503144055.3820-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <000000000000dcd2ae06178bccb0@google.com>
References:
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

req->base.flags were not initialized, zero might suit in this case.
Do it with skcipher_request_set_callback() as it's common practice.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 fs/bcachefs/checksum.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/bcachefs/checksum.c b/fs/bcachefs/checksum.c
index 7ed779b411f6..088fd2e7bdf1 100644
--- a/fs/bcachefs/checksum.c
+++ b/fs/bcachefs/checksum.c
@@ -102,6 +102,7 @@ static inline int do_encrypt_sg(struct crypto_sync_skcipher *tfm,
 	int ret;
 
 	skcipher_request_set_sync_tfm(req, tfm);
+	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, sg, sg, len, nonce.d);
 
 	ret = crypto_skcipher_encrypt(req);

