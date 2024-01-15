Return-Path: <linux-kernel+bounces-25577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B4782D2E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 02:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0CA281538
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9508B15B3;
	Mon, 15 Jan 2024 01:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="REKN8IlM"
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B087137B;
	Mon, 15 Jan 2024 01:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
Delivered-To: dpsmith@apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1705281357; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jAuUvxVU8D23KdA/HZzdCYNvhAgM+U2WBQn/wpcFl3at/a7pKAY6U5Y8n9xcyCPfABMDNOCWj55cmjZ0rN7Xv3Mz2o8uWEOKV7WK7s9P+o8U7PB2PJh1e4SiPEDZcsJLE0SeAXhU0QIASsZFzZ4/HQTizxx6W1W2tWDTEZbbiCc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1705281357; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zLf9QVptryF0InKzR9EnfMAiKSvtoQon6fPnRpBNJf8=; 
	b=AVEbSNz512ykrZY1XLGhjtJNfbD1VYDoe/IzDbx8nOqrKSI982N6IdpKErV3vzquzvC5YSvCt7wgoeJ8hy91bhpPSAam46SC6qqxzz8F0igywFLcrCYAY/32OnEvMrmcaFKkbalL2qaTYZGtH6OmllNd1HB+fRPDfzeTHBDyoqQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1705281357;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=zLf9QVptryF0InKzR9EnfMAiKSvtoQon6fPnRpBNJf8=;
	b=REKN8IlMTZyPV8JlO3ggYaFu6+/zE+z2855+XdJ+CJ4Z3kYVyBr1achSluEl8lQ3
	z9w5VcizG8PhPrkirrcC+6XQ9+ri5dKUY9i76jpBff/Z5lN9ELhTrrb8nwXz4qTfx4S
	yN8E8gMManHaWMD9NRr2O//JG7ELgFWOA+jlzU0o=
Received: from sisyou.hme. (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1705281355612388.34342267689556; Sun, 14 Jan 2024 17:15:55 -0800 (PST)
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Daniel P. Smith" <dpsmith@apertussolutions.com>,
	Ross Philipson <ross.philipson@oracle.com>,
	Kanth Ghatraju <kanth.ghatraju@oracle.com>,
	Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH] tpm: make locality handling resilient
Date: Sun, 14 Jan 2024 20:15:44 -0500
Message-Id: <20240115011546.21193-1-dpsmith@apertussolutions.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Commit 933bfc5ad213 introduced the use of a locality counter to control when
locality request was actually sent to the TPM. This locality counter created a
hard enforcement that the TPM had no active locality at the time of the driver
initialization. The reality is that this may not always be the case coupled
with the fact that the commit indiscriminately decremented the counter created
the condition for integer underflow of the counter. The underflow was triggered
by the first pair of request/relinquish calls made in tpm_tis_init_core and all
subsequent calls to request/relinquished calls would have the counter flipping
between the underflow value and 0. The result is that it appeared all calls to
request/relinquish were successful, but they were not. The end result is that
the locality that was active when the driver loaded would always remain active,
to include after the driver shutdown. This creates a significant issue when
using Intel TXT and Locality 2 is active at boot. After the GETSEC[SEXIT]
instruction is called, the PCH will close access to Locality 2 MMIO address
space, leaving the TPM locked in Locality 2 with no means to relinquish the
locality until system reset.

The commit seeks to address this situation through three changes. The first is
to walk the localities during initialization and close any open localities to
ensure the TPM is in the assumed state. Next is to put guards around the
counter and the requested locality to ensure they remain within valid values.
The last change is to make the request locality functions be consistent in
their return values. The functions will either return the locality requested if
successful or a negative error code.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Reported-by: Kanth Ghatraju <kanth.ghatraju@oracle.com>
Fixes: 933bfc5ad213 ("tpm, tpm: Implement usage counter for locality")
---
 drivers/char/tpm/tpm-chip.c     |  2 +-
 drivers/char/tpm/tpm_tis_core.c | 20 +++++++++++++++-----
 include/linux/tpm.h             |  2 ++
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 42b1062e33cd..e7293f85335a 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -49,7 +49,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
 		return rc;
 
 	chip->locality = rc;
-	return 0;
+	return chip->locality;
 }
 
 static void tpm_relinquish_locality(struct tpm_chip *chip)
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 1b350412d8a6..c8b9b0b199dc 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -180,7 +180,8 @@ static int tpm_tis_relinquish_locality(struct tpm_chip *chip, int l)
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
 	mutex_lock(&priv->locality_count_mutex);
-	priv->locality_count--;
+	if (priv->locality_count > 0)
+		priv->locality_count--;
 	if (priv->locality_count == 0)
 		__tpm_tis_relinquish_locality(priv, l);
 	mutex_unlock(&priv->locality_count_mutex);
@@ -226,18 +227,21 @@ static int __tpm_tis_request_locality(struct tpm_chip *chip, int l)
 			tpm_msleep(TPM_TIMEOUT);
 		} while (time_before(jiffies, stop));
 	}
-	return -1;
+	return -EBUSY;
 }
 
 static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
-	int ret = 0;
+	int ret = -EIO;
+
+	if (l > TPM_MAX_LOCALITY)
+		return -EINVAL;
 
 	mutex_lock(&priv->locality_count_mutex);
 	if (priv->locality_count == 0)
 		ret = __tpm_tis_request_locality(chip, l);
-	if (!ret)
+	if (ret >= 0)
 		priv->locality_count++;
 	mutex_unlock(&priv->locality_count_mutex);
 	return ret;
@@ -1108,7 +1112,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	u32 intmask;
 	u32 clkrun_val;
 	u8 rid;
-	int rc, probe;
+	int rc, probe, locality;
 	struct tpm_chip *chip;
 
 	chip = tpmm_chip_alloc(dev, &tpm_tis);
@@ -1169,6 +1173,12 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		goto out_err;
 	}
 
+	/* It is not safe to assume localities are closed on startup */
+	for (locality = 0; locality <= TPM_MAX_LOCALITY; locality++) {
+		if (check_locality(chip, locality))
+			tpm_tis_relinquish_locality(chip, locality);
+	}
+
 	/* Take control of the TPM's interrupt hardware and shut it off */
 	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
 	if (rc < 0)
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4ee9d13749ad..f2651281f02e 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -116,6 +116,8 @@ struct tpm_chip_seqops {
 	const struct seq_operations *seqops;
 };
 
+#define TPM_MAX_LOCALITY		4
+
 struct tpm_chip {
 	struct device dev;
 	struct device devs;
-- 
2.30.2


