Return-Path: <linux-kernel+bounces-91342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6DE870FCC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04F7FB2606F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02417E787;
	Mon,  4 Mar 2024 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YFF2GFFk"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411F579DCE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590116; cv=none; b=MUDDX/CVhNOTzkFF4etZaZylMAbfnsmfs6MnlB1lq7dHIjFBXSK/6g4THfC0hrdjsckK5wlj68g1+0A4K8O1gqt+yEf4d94ZhHyXVNf7Hl0Bt96Mi9Id0dj5FPm/YtHpMVW3U0+cugMv8AxUOKVjFp8LvoG5crHE/tUmrts1BsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590116; c=relaxed/simple;
	bh=SbjbdjZWUXBzT2LxbKT4DNqotCfdqsZJ3zhnbS10R1g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=syuXygb2DXYfb4LBXNd8xkR2YUbJXmzQPBrPzOdXJSjx1hjqxDgOnMDlAqum3pD8sdzyp3FOpMnDJSX6mplMnM+wJ/lEsT5DaIAFxIcecYbbWC1KJtA7qHsFKFks1S2KMNo8ENPc08kC//eneSml4B0fpJxdyHAL1ctmCyBX9oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YFF2GFFk; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so8751790276.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 14:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709590114; x=1710194914; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u66W4yA8M+KF0Llg68xH23MwaMjWX70CKgHvWJ3oECY=;
        b=YFF2GFFkect0CcmJBk6glB9KZUeLUXgxIcsgpYgUr8T2Vq4vqlCF+bQLvgOP1ZTmtO
         GF7PseOy70CcoeozA+NodicCvjCi+rtuVIy6j9QTUlHIRgzSNRCJOK6jHc+/GfpgvGJr
         FerfHqQupkyZadxBDohuqNYYH6jGkcZUKDuRO6pZfTCt4UoPI+siEvXAz2ud89LpsCOg
         D8zyHD20UKBwW7Ow458+3eBrPUp7ryWU81E7SPRMPXM/Jw6gh+L8yxnLl1KGi/nDI0mj
         IHxLHI710sjYLhN/TsbzlWye5+YAH5no1nS5CdLpcpLiSMzXtUvCJAH1thNdKgRp27yL
         sRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709590114; x=1710194914;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u66W4yA8M+KF0Llg68xH23MwaMjWX70CKgHvWJ3oECY=;
        b=dsU4flcfpORFBMlzs2RJXn3y+XOVfP2RX4ochsl5XKyWwCdxdt0psezZOs+YrBc2i9
         PL3pmMywpMd6OfAPyk83hq9QrCcKPoZQ418nMz7iBwlZDJQJABBCJeytCbjoMKfO2Sh5
         UsGnYStQJBWUe6tu47gyIHqh2r+UxotjeDS30qCivy+1zZWxLnVYLnGcpxSWLAk/4/CN
         ofbp7w9dOH6QOOylOOZbF8+97vCUw+uJasx63znCARYKirA4OR8BVWZjN3VkpMOsOAtg
         6pGtYnL6lt/oKu7YthX7sqBZRF9yv6mSnwnHaSd5AAQXOOUbMvk/cNhzQ70Bt8cO67Jv
         RvZg==
X-Forwarded-Encrypted: i=1; AJvYcCV8Wg8hcvQ3bstVFp2bN+lSSUV3BnfdTwM0cn5oVNclRAgjba/PcOdYUj6cI+7C11koUrJNIGoDLxIyj1gT4cxBypFlNgnJQqgKdkrC
X-Gm-Message-State: AOJu0Yz6fBDmGXyGiyx/z9mqE8fwFZHEAEkNXlTwkP6Npj+gZsCbMpNf
	gk6jFfPY83GJoEAE7jZzCT/1UmSWkOqqjKTdJbk2VZ27tZgHheYxX26T5EdrQOIC5J8wuAIU0df
	QWRZlJ2wAoA==
X-Google-Smtp-Source: AGHT+IFZfyS+uFwGZLzMHFOeD5UY68eEdzKNnsQfushZQwAV/48zAAnVPGQYWTjxCo6N90NONLdqyIYTRFvRSQ==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:e901:e760:20cd:d870])
 (user=ipylypiv job=sendgmr) by 2002:a25:abc2:0:b0:dc6:e5e9:f3af with SMTP id
 v60-20020a25abc2000000b00dc6e5e9f3afmr2651172ybi.9.1709590114389; Mon, 04 Mar
 2024 14:08:34 -0800 (PST)
Date: Mon,  4 Mar 2024 14:08:13 -0800
In-Reply-To: <20240304220815.1766285-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304220815.1766285-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304220815.1766285-6-ipylypiv@google.com>
Subject: [PATCH v4 5/7] scsi: hisi_sas: Add libsas SATA sysfs attributes group
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

Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 6 ++++++
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 6 ++++++
 2 files changed, 12 insertions(+)

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


