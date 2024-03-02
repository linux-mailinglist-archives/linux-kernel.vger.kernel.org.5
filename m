Return-Path: <linux-kernel+bounces-89583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F1C86F251
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 21:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF8F282EB0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B0847F46;
	Sat,  2 Mar 2024 20:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0rKlX2OV"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7F24597D
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 20:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709410622; cv=none; b=NkQzHqTJlsDnD6xmF/VAUg5cqr3yS5bVK+pBiCOMXOE0wPcJLfz5tlVj+Yh5QupD9ftk4Q6G6bJl898si/0HMeZAwwmOInJh4nv3OfTMefcXkkVu0EBLbId2RG7I1U5/9z07Vp9yIJDv9qMESGZcTLftywEz0o7+nCI/0kGV/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709410622; c=relaxed/simple;
	bh=oCEOlszWbRebAJRFgYlHh9o1ZpJRj0ce/17rkZ3A3M8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OjRqaWjwjHY5zWCnraTyK0y1AF8kVHzA07368zHsEwqyqmKHqo3xacRRDbfOZE4fp/1QEh1RAgktowZ/ncR+uXja8QSITrY5Wvog/9WJ6pfntxYBhinDQNmXTrmJ8HQgu2DpvowvkaYm1uH4O3xQCAVfvKZkBBiXnYnq9lCq94I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0rKlX2OV; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609a1063919so1537297b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 12:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709410620; x=1710015420; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aUX3zhIus5O92bJYySj4+GAcqh6w/58AkwOdnSqPEQ8=;
        b=0rKlX2OVeDcCZqIEma/ZErmDlV4K9UaJtBQ6QVFl5BpMMamTGG2188njqqx65XsUDp
         HObo4Q5wUdNhzzCOarMGqduVfrmWhLZu8Sdm2mKppHQiTPdKZT+WLYhQzsa4Wp0ARUbN
         QN5pMqraZ77vJs0ckpdU5lyhyslk86iiNxXEoapA7HUsDWKX/OT2DcZlP48t2i6Sd11d
         NN9lDLToUjLaKSQAlyYOvZiQw9qV+EBs4VBYe2RkzIcfgTKFc/F+u46XJzXGXWL90wtt
         mH4dun9q38W/wiXuunLVNE4dIWhBBCA6KJZnf+7OIbcmH520V1DIZg264hGdUiqWoj+Z
         ugDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709410620; x=1710015420;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUX3zhIus5O92bJYySj4+GAcqh6w/58AkwOdnSqPEQ8=;
        b=X+3f3yJNqKtdhaXRMlkyp6BB7yKO7yk2pJIF0cf5GhwBW2F9bE5GQ5ldxxjjKjQ0V5
         B60KwkDNNcGPLEJTxl+Dsn66GqPtMHO/izy+ZjZ27T1D2ASnpvnHw5s8e+rGVLmDSTiO
         m5ZHWyJZ3wt4fhXDpDVXTfl85gdmkCIFqhr1v8JA5TUogZnsUhK4ce/PqnhbINyTcyAe
         AeerweYuBgt1zVCp11mxvJrFtIXkCwksRNjo6tADc6OWIY6sXXWmTQV8iuZiNk0yDXD4
         xGsVFC/Ocyuf43+dddOf26odCy/3agq3X3IREGzCfoViT4tpM82hXMTwvReE//APzOT+
         +jgw==
X-Forwarded-Encrypted: i=1; AJvYcCVWDNZBu3/QdX7s3A8WHCyiwi+PlddWJd/rMqu41vUUnve6SUfBk2DjgozLHRzswa8uOtVrpqMh2UJ+gEfSl7QnmFt6fSSfmEMn1TO/
X-Gm-Message-State: AOJu0Yww3X7oYUQ8eJzF5CtXAzz8MCj+4AkujJvPmPVjjH9Cyzk/2mHC
	Nu5FFnso3etCTPu6GlDOK79pqqpx57xq8+RPsKkUYrRtr6LO/6al1g90H3xQbIRFBxaVJx5PwaF
	o07/rs4HBkA==
X-Google-Smtp-Source: AGHT+IHgCXtzfWBmcD9CpInBcTWMzlmfCDT/PNOKdkaMmCViK6GIE0I9O9/LGXEYrJj2cpMkwLyWd8wZAD3b1A==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:41a7:9019:9a7:b404])
 (user=ipylypiv job=sendgmr) by 2002:a05:690c:c86:b0:608:ce23:638c with SMTP
 id cm6-20020a05690c0c8600b00608ce23638cmr1457644ywb.4.1709410620335; Sat, 02
 Mar 2024 12:17:00 -0800 (PST)
Date: Sat,  2 Mar 2024 12:16:34 -0800
In-Reply-To: <20240302201636.1228331-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302201636.1228331-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240302201636.1228331-6-ipylypiv@google.com>
Subject: [PATCH v3 5/7] scsi: hisi_sas: Add libsas SATA sysfs attributes group
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>, 
	Xiang Chen <chenxiang66@hisilicon.com>, Artur Paszkiewicz <artur.paszkiewicz@intel.com>, 
	Bart Van Assche <bvanassche@acm.org>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

The added sysfs attributes group enables the configuration of NCQ Priority
feature for HBAs that rely on libsas to manage SATA devices.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 6 ++++++
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 6 ++++++
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 3c555579f9a1..97864b56a71f 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1734,6 +1734,11 @@ static struct attribute *host_v1_hw_attrs[] = {
 
 ATTRIBUTE_GROUPS(host_v1_hw);
 
+static const struct attribute_group *sdev_groups_v1_hw[] = {
+	&sas_ata_sdev_attr_group,
+	NULL
+};
+
 static const struct scsi_host_template sht_v1_hw = {
 	.name			= DRV_NAME,
 	.proc_name		= DRV_NAME,
@@ -1758,6 +1763,7 @@ static const struct scsi_host_template sht_v1_hw = {
 	.compat_ioctl		= sas_ioctl,
 #endif
 	.shost_groups		= host_v1_hw_groups,
+	.sdev_groups		= sdev_groups_v1_hw,
 	.host_reset             = hisi_sas_host_reset,
 };
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 73b378837da7..b5d379ebe05d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3544,6 +3544,11 @@ static struct attribute *host_v2_hw_attrs[] = {
 
 ATTRIBUTE_GROUPS(host_v2_hw);
 
+static const struct attribute_group *sdev_groups_v2_hw[] = {
+	&sas_ata_sdev_attr_group,
+	NULL
+};
+
 static void map_queues_v2_hw(struct Scsi_Host *shost)
 {
 	struct hisi_hba *hisi_hba = shost_priv(shost);
@@ -3585,6 +3590,7 @@ static const struct scsi_host_template sht_v2_hw = {
 	.compat_ioctl		= sas_ioctl,
 #endif
 	.shost_groups		= host_v2_hw_groups,
+	.sdev_groups		= sdev_groups_v2_hw,
 	.host_reset		= hisi_sas_host_reset,
 	.map_queues		= map_queues_v2_hw,
 	.host_tagset		= 1,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index b56fbc61a15a..9b69ea16a1e6 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2929,6 +2929,11 @@ static struct attribute *host_v3_hw_attrs[] = {
 
 ATTRIBUTE_GROUPS(host_v3_hw);
 
+static const struct attribute_group *sdev_groups_v3_hw[] = {
+	&sas_ata_sdev_attr_group,
+	NULL
+};
+
 #define HISI_SAS_DEBUGFS_REG(x) {#x, x}
 
 struct hisi_sas_debugfs_reg_lu {
@@ -3340,6 +3345,7 @@ static const struct scsi_host_template sht_v3_hw = {
 	.compat_ioctl		= sas_ioctl,
 #endif
 	.shost_groups		= host_v3_hw_groups,
+	.sdev_groups		= sdev_groups_v3_hw,
 	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
 	.host_reset             = hisi_sas_host_reset,
 	.host_tagset		= 1,
-- 
2.44.0.278.ge034bb2e1d-goog


