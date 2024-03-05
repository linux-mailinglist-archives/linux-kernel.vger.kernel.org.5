Return-Path: <linux-kernel+bounces-93129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B226872B67
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F191F24DCD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F781353E3;
	Tue,  5 Mar 2024 23:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="obb3hSn9"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D853A134CD2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 23:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683124; cv=none; b=cyh7KQCrS6eV169bLuOl5JCv+zTCFDC0qYILA1naO4s4hUCfp8I2f8RyvgGoGV39tE0MPLWrJGpkzyN/8HIk+/GN07im6THNmmAud3HMI7h/fnV5t2SQy38fJ+FWr46V6U70b59DZOWBHLiv5hFR3Xea3vCNs7o4TPMebKpe48o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683124; c=relaxed/simple;
	bh=G9sVD8mPANACI8XvBa42u5K2t+gtYc3kf7MUNETx/FI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A0Xaw3Hz5oPC5SD/BxfEbSafmUAl+M4ZqKS6HrbKO+7i7OjjC25hyU04Pb17JzgGs0zD2BrCCcFPDS6eOU+Laj42P9PM9OKznRY2Vn3AJV9R9xf7yuA5Ahb+Nl+uAIzb+efL8+N0hLDc0IK7EV4Kw/LnRBNchSuv1p0fcALojOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=obb3hSn9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269686aso9316124276.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 15:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709683122; x=1710287922; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RQNseeqHGtqWgtmESvK7C+bOjnnAotGHLghFADtiiV8=;
        b=obb3hSn9jvFIgJFV1G9xQmFb1V+ziNTojM59NIGGUk1cQSUwePPY/dx6w7R0FgHKg7
         pFZt4/iggdytxHt560AMymqfzpUCG8TnyB5rE0illMmA6Pz2orJQL5Jj30w2urKyiJ6o
         GEiiS2OiAo6fbRlW01D2E77hplwRiABs1H0JjZ7Rr+vAlz4epZ2VYoQJ5Vs6LR5wjgUo
         p00xCOmkdvSTKbmfb9mzvvdKILenz9chanMjtCqChTPewCukNWkQpVOMT+ELYPA5n9w5
         DWKSgfB4OokSyqa1sJegGLoC+wxQPYTcg+dzecGvOh/1iejLQJOt1EHXmnNRAIALaBpq
         C/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709683122; x=1710287922;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQNseeqHGtqWgtmESvK7C+bOjnnAotGHLghFADtiiV8=;
        b=kJmD3p9NknOaDY7aC61jlxxEfSMjO000WikZlCRHws0yI/Ylx/LnsP1dB0g0f26Qou
         lBjMeDfH6JpyS9sy94aOfKYs2NYdE7L3KA13vCgoPLexfwZjeUKrPtZLKyhtx03hmAAA
         HN89/rTGuyJDFnmHa2e6440dTt7itKjNMcnGRdmU48jU7OwrbyvFsnjTRuL4TUkoYXn3
         T9L8Dk/92i4WRuX+mySf6c3TErCn9/XSdugJOkiJdVz0fMih9RoiyY4TUNAm6WWbUKJZ
         u3iSItudEDp1xPYwO3aHUWD4mWXElp/Q4vBFu7NXRnxONcyGtQoDaDwNyXRTW0gBPfia
         Mt5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTPjSL63+LxMPL9QMLdlg8XlNXMDyDgprgVCZ4+eTDe7TNexOXY9EZcjB4Ry/6g2M3kd+DxkZvOzfUBijsLLxTkI3++eYvMlvnD6nD
X-Gm-Message-State: AOJu0YzApW3whvJOToMZ7t8ZGVBPxpXvC7m1GZhtAO8PGUtpOXmGYQpi
	OcCxIMSjCuIWLCWW9KUFgLwK/d4A1M5a952rVEzoU/2HnMuSMI+a98u4i0Kd+HY8rzAU0sJzAR0
	SST2CX+HmGw==
X-Google-Smtp-Source: AGHT+IHaquBcMiTxzYXCHsL6kDeJ0KhsQhgDryCyWCWhVsJvol4BTI3/dpyBoM2x0YMxdYD9SKzVxCeFdg6qVw==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:69ff:df2c:aa81:7b74])
 (user=ipylypiv job=sendgmr) by 2002:a25:dc4c:0:b0:dc6:d1d7:d03e with SMTP id
 y73-20020a25dc4c000000b00dc6d1d7d03emr586973ybe.8.1709683122054; Tue, 05 Mar
 2024 15:58:42 -0800 (PST)
Date: Tue,  5 Mar 2024 15:58:21 -0800
In-Reply-To: <20240305235823.3308225-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305235823.3308225-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305235823.3308225-7-ipylypiv@google.com>
Subject: [PATCH v6 6/7] scsi: aic94xx: Add libsas SATA sysfs attributes group
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
 drivers/scsi/aic94xx/aic94xx_init.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 8a3340d8d7ad..ccccd0eb6275 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -14,6 +14,7 @@
 #include <linux/firmware.h>
 #include <linux/slab.h>
 
+#include <scsi/sas_ata.h>
 #include <scsi/scsi_host.h>
 
 #include "aic94xx.h"
@@ -34,6 +35,7 @@ MODULE_PARM_DESC(use_msi, "\n"
 static struct scsi_transport_template *aic94xx_transport_template;
 static int asd_scan_finished(struct Scsi_Host *, unsigned long);
 static void asd_scan_start(struct Scsi_Host *);
+static const struct attribute_group *asd_sdev_groups[];
 
 static const struct scsi_host_template aic94xx_sht = {
 	.module			= THIS_MODULE,
@@ -60,6 +62,7 @@ static const struct scsi_host_template aic94xx_sht = {
 	.compat_ioctl		= sas_ioctl,
 #endif
 	.track_queue_depth	= 1,
+	.sdev_groups		= asd_sdev_groups,
 };
 
 static int asd_map_memio(struct asd_ha_struct *asd_ha)
@@ -951,6 +954,11 @@ static void asd_remove_driver_attrs(struct device_driver *driver)
 	driver_remove_file(driver, &driver_attr_version);
 }
 
+static const struct attribute_group *asd_sdev_groups[] = {
+	&sas_ata_sdev_attr_group,
+	NULL
+};
+
 static struct sas_domain_function_template aic94xx_transport_functions = {
 	.lldd_dev_found		= asd_dev_found,
 	.lldd_dev_gone		= asd_dev_gone,
-- 
2.44.0.278.ge034bb2e1d-goog


