Return-Path: <linux-kernel+bounces-118702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C649988BE36
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46784B243AC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03941548FA;
	Tue, 26 Mar 2024 09:42:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1432524BA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446162; cv=none; b=Ji1jXjJrFuP58qPFQQEEdDStE2qW6VwTxO9Ot1Qb6OuYyVdPWR0zf1IVDlQVBrhD/bTEtfkECXPEzZ0eK7nzcg/HDNXkU3IKKietuUuEuKCPdZIsNInOBffrW6GruGnJvQRirUHn9t0Pn9VJjBsjUjGH1sKwBK2oaX1zZFbO17Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446162; c=relaxed/simple;
	bh=RscovsXRzmzemMJFnyNGe3wc4+9Y5R3smnl33ekIzXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=knZQPCvsIrixqC6M6wCerLW64SVz6bkXeLpjrBo3BXpevqsmwSi42Ug8fcSUUUNMphl1FD7bEXxM8z8EmR1PePLxsiUUsgJsVTC3vQ0IJIzLGHYQd/y71vGUU1aQDQ5OflWuhpEk/52ACtWhE+EGPDtEz1sj8S5mMv1r7onqA0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=localhost)
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <r.czerwinski@pengutronix.de>)
	id 1rp3KG-00056x-2r; Tue, 26 Mar 2024 10:42:36 +0100
From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel@pengutronix.de,
	Rouven Czerwinski <r.czerwinski@pengutronix.de>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mmc: debugfs: convert permissions to octal
Date: Tue, 26 Mar 2024 10:42:13 +0100
Message-ID: <20240326094215.212930-1-r.czerwinski@pengutronix.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: r.czerwinski@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Convert the existing symbolic permissions to the octal presentation as
this is the preferred representation for debugfs permissions.

Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
---
 drivers/mmc/core/debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 1642ea72d22c..6dbab860e453 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -351,11 +351,11 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 	root = debugfs_create_dir(mmc_hostname(host), NULL);
 	host->debugfs_root = root;
 
-	debugfs_create_file("ios", S_IRUSR, root, host, &mmc_ios_fops);
+	debugfs_create_file("ios", 0400, root, host, &mmc_ios_fops);
 	debugfs_create_file("caps", 0600, root, &host->caps, &mmc_caps_fops);
 	debugfs_create_file("caps2", 0600, root, &host->caps2,
 			    &mmc_caps2_fops);
-	debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
+	debugfs_create_file_unsafe("clock", 0600, root, host,
 				   &mmc_clock_fops);
 
 	debugfs_create_file_unsafe("err_state", 0600, root, host,
@@ -388,7 +388,7 @@ void mmc_add_card_debugfs(struct mmc_card *card)
 	root = debugfs_create_dir(mmc_card_id(card), host->debugfs_root);
 	card->debugfs_root = root;
 
-	debugfs_create_x32("state", S_IRUSR, root, &card->state);
+	debugfs_create_x32("state", 0400, root, &card->state);
 }
 
 void mmc_remove_card_debugfs(struct mmc_card *card)

base-commit: 928a87efa42302a23bb9554be081a28058495f22
-- 
2.44.0


