Return-Path: <linux-kernel+bounces-129851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F66897145
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BADD81F2C534
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56082148825;
	Wed,  3 Apr 2024 13:34:45 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6593A1419BA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151284; cv=none; b=rtHoPU1s4Q9nFR9xRMjm+LqGYeEf7T/6l64bR9op8kDbtx0hwMekQ0GlEE55HUrK6f/0M8Lw+OEKwfiXmRU+9kmPEVRutS0b3ltSyRFtg7M+J/oXVC67wSGg3ALw3SfSErZhP3DnUjLMH5x38mkJI3cZZKao0yHD3TiIBVG2gGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151284; c=relaxed/simple;
	bh=Uhg9IjwFN5pZbBEmeO1zYD0ndeXFaKI0Ar6X/oyg7/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2xiV2VppdLFNbEPca+4JOl1y54dOQrwzJqM2IByqaRslr71WYaXZwuv1DGWmG00MmBfesMw7r0igu860EkmaJxejQLkBtsoiwbdSQ4PLf8ts+cHrBvm7J1Z52Q2tcvhYYd/u6yf6WfQj+zvtpNO2ZI/PO1CNrckfq7911jvMgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 3 Apr
 2024 16:33:28 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 3 Apr 2024
 16:33:27 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <syzbot+ff14db38f56329ef68df@syzkaller.appspotmail.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [v9fs?] KMSAN: uninit-value in p9_client_rpc (2)
Date: Wed, 3 Apr 2024 06:33:01 -0700
Message-ID: <20240403133301.14177-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <000000000000a77e580614ded85a@google.com>
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

If p9_check_errors() fails in p9_client_rpc(), req->rc.tag won't be
initialized and trace_9p_client_res() will try to print it before
exiting with error, triggering KMSAN. Fix it by having id and tag
fields inited with zero values.

Please test.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

 net/9p/client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/9p/client.c b/net/9p/client.c
index e265a0ca6bdd..a9d613af7455 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -235,6 +235,8 @@ static int p9_fcall_init(struct p9_client *c, struct p9_fcall *fc,
 	if (!fc->sdata)
 		return -ENOMEM;
 	fc->capacity = alloc_msize;
+	fc->id = 0;
+	fc->tag = 0;
 	return 0;
 }
 

