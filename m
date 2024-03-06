Return-Path: <linux-kernel+bounces-93193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451F7872C23
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0244E28701E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9CE1AAD0;
	Wed,  6 Mar 2024 01:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mroJrfGy"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F51C17742
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 01:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709688161; cv=none; b=MqIltn/c0bPEGVtrt5nSEgP3J5GWP4YH3dG7dPlrFrTGDB+yGbdyYB3UB2U78+GrmENvCZLo+FdA9eRNXejR+V05ViE3ZQxDJvG/aGN+e3lvNMvA9EcTM6inTREmW6unYNsiYAjhkBbvL4SiiiYI1vD2txBuH6pVTccrYZg5mXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709688161; c=relaxed/simple;
	bh=wcg4s+VBRSyuqCYnMen4yuigKnSiE8NtEjtig8qUC2o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CoYwTGIpOWwD6E7Q35BlVFboPUjzqjbioLkcRPRsHxkHWNjQmKlQ5Nn9A6bRE4UPDuV3GdGEpddA/3v8fZSzclQKNxlNra8ex6gbNNvz4FJ1JQpoOumGQckyBonfLNW1nHsNkNLuudaG3Qk2/Xn+pqaEV54bGLy8+VF4OnWVUlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mroJrfGy; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609d8275c70so4795287b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 17:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709688158; x=1710292958; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xvuQ4kezab1KlrTxoR3eIfXTgSjXQ9ZPEoqhGuVUIVQ=;
        b=mroJrfGyyEw0InFhfjPw6H4li267zjABJNkx4asSKDHCLlYGmazQQMdXZ42j4fnS+e
         +JOtE6KxovlBawr+yzBahaDx5mzghMSexEyPiJMR8LrzDK1tHuPwJPFnOeQYrhSW9HDW
         3hsqucdPShK+iNw+YxMgbd8+txfQ3BcxIRP4/jxBBIi//noGuUqgoqhBG1K5y05MXm96
         LPu32UoVScy08MR1c6arGd6thA78Fo1lPGi6Lq47Q4459P9Mx9/Yzr0ZISaCtq0GmN0h
         /OjtJFgBElSoLz1OkKVlGpyLfwkyytgk2+CTRn0qlFpoY44CKTzhgCzZUp3qbIRopK9O
         0jgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709688158; x=1710292958;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvuQ4kezab1KlrTxoR3eIfXTgSjXQ9ZPEoqhGuVUIVQ=;
        b=S/0TJ7Sd2I4qlxVisTVgfpeMhah64wQ2WV52eBHiaB8lVgbGl1Zo7oMuTF3st19PdI
         2UiFpLL2GIY1L73jUyR9FvpCEkFMM2KGARIMPJeP+QUJ/4vMjfdaskEefuF2AyyU650y
         xYH67tahvEuv4fgIKB86ypcpSVg5XeryUMaPb9IlzG6xJhxmee1vyPm7b4gumfNDs0in
         9qaSP8oOHJEHx6e/RkPOkptisYxmV4HikaqcPKpDxamdCyW1K+c9drVyuGznLii7GmBZ
         7HrwkOPjL2db0GE2YJNwL2X/02Tsrwj6p/2WCRMiDhQpGiS9YsB8wQ2OqU4iDVsg6RCo
         RCjw==
X-Forwarded-Encrypted: i=1; AJvYcCVt7WF4p77b4jQKLfKutJyL8kvjhafYJ2VhpIJRyJXcaXKol+JOwFffLibULZVckkt8dfJH9asHxNbIPlw3szYQ4wIARGpFf5oMgGD2
X-Gm-Message-State: AOJu0Yxn8Th5pj6DPAZZAC7DW34YosBKdkcjcxC/yEgaY2GAC4TT8kFv
	SCfOhkqP1Dhwpb6wQAuwF3wmlHmaLSzsD/dnWIfm7smzcJu4ICDn1ug6Tz8bLsLX9f91Zo3+zcz
	EQNtNRh7sKA==
X-Google-Smtp-Source: AGHT+IHtVVDAQr0HlC7Y5wW7LyESC5hemfsg9S9HuZaVvIMxC3e30XENP7rU5kXxBG6Pcf0SSGSVZruuEt/ECw==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:69ff:df2c:aa81:7b74])
 (user=ipylypiv job=sendgmr) by 2002:a25:c585:0:b0:dc2:2ace:860 with SMTP id
 v127-20020a25c585000000b00dc22ace0860mr493435ybe.2.1709688158684; Tue, 05 Mar
 2024 17:22:38 -0800 (PST)
Date: Tue,  5 Mar 2024 17:22:23 -0800
In-Reply-To: <20240306012226.3398927-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306012226.3398927-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306012226.3398927-5-ipylypiv@google.com>
Subject: [PATCH v7 4/7] scsi: mvsas: Add libsas SATA sysfs attributes group
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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/scsi/mvsas/mv_init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 43ebb331e216..f1090bb5f2c9 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -26,6 +26,7 @@ static const struct mvs_chip_info mvs_chips[] = {
 };
 
 static const struct attribute_group *mvst_host_groups[];
+static const struct attribute_group *mvst_sdev_groups[];
 
 #define SOC_SAS_NUM 2
 
@@ -53,6 +54,7 @@ static const struct scsi_host_template mvs_sht = {
 	.compat_ioctl		= sas_ioctl,
 #endif
 	.shost_groups		= mvst_host_groups,
+	.sdev_groups		= mvst_sdev_groups,
 	.track_queue_depth	= 1,
 };
 
@@ -779,6 +781,11 @@ static struct attribute *mvst_host_attrs[] = {
 
 ATTRIBUTE_GROUPS(mvst_host);
 
+static const struct attribute_group *mvst_sdev_groups[] = {
+	&sas_ata_sdev_attr_group,
+	NULL
+};
+
 module_init(mvs_init);
 module_exit(mvs_exit);
 
-- 
2.44.0.278.ge034bb2e1d-goog


