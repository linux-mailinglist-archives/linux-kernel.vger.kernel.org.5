Return-Path: <linux-kernel+bounces-112413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298FC887988
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6CA1C20D5D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6494D595;
	Sat, 23 Mar 2024 16:48:59 +0000 (UTC)
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254AA1EB34;
	Sat, 23 Mar 2024 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711212538; cv=none; b=JgxWn3SzgOKq58uY2vRbE3tAtR8xTj2lve/tuTQG1T+VJkpQrt1X5H2rkV8hmTdzjRDZxAE5YYkhsb6adRN3i6mZ61cl5dgSO0pH7SRydu2bW+bfhKVSli2+aI2N0Tj8Gt2JMPYWqe5TaVjRU/lNgggU1DyddBG9DSts+LvtxJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711212538; c=relaxed/simple;
	bh=MlBKbMKD9Dmu0WeAhFQgBUoftrbeRMDpgT0/F1G5hOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n/UiPYdsT1j/wSzX1iwMNY7R47vaqJXXy4GdVwFQeFXQKfMkTg5IpKSLP3kawvb2xp6h4pPbQ8BR3zZB+RKnfbGhQ0seGeyRLpxb3610Z3xaWGczKQETkyywmP8MXmgkSNYyRNww9pk+4p95gw4kRPvkYa5IFyb8c1tqZjuWh7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id 2D99DA02C5;
	Sat, 23 Mar 2024 17:48:54 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ChON3L8JAySc; Sat, 23 Mar 2024 17:48:54 +0100 (CET)
Received: from begin (aamiens-653-1-111-57.w83-192.abo.wanadoo.fr [83.192.234.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 13220A02A6;
	Sat, 23 Mar 2024 17:48:54 +0100 (CET)
Received: from samy by begin with local (Exim 4.97)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1ro4Y9-00000005zEE-2agA;
	Sat, 23 Mar 2024 17:48:53 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: gregkh@linuxfoundation.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org,
	speakup@linux-speakup.org,
	stable@vger.kernel.org
Subject: [PATCH] speakup: Avoid crash on very long word
Date: Sat, 23 Mar 2024 17:48:43 +0100
Message-ID: <20240323164843.1426997-1-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case a console is set up really large and contains a really long word
(> 256 characters), we have to stop before the length of the word buffer.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Fixes: c6e3fd22cd538 ("Staging: add speakup to the staging directory")
Cc: stable@vger.kernel.org
---
 drivers/accessibility/speakup/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
index 1fbc9b921c4f..736c2eb8c0f3 100644
--- a/drivers/accessibility/speakup/main.c
+++ b/drivers/accessibility/speakup/main.c
@@ -574,7 +574,7 @@ static u_long get_word(struct vc_data *vc)
 	}
 	attr_ch = get_char(vc, (u_short *)tmp_pos, &spk_attr);
 	buf[cnt++] = attr_ch;
-	while (tmpx < vc->vc_cols - 1) {
+	while (tmpx < vc->vc_cols - 1 && cnt < sizeof(buf) - 1) {
 		tmp_pos += 2;
 		tmpx++;
 		ch = get_char(vc, (u_short *)tmp_pos, &temp);
-- 
2.43.0


