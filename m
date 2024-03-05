Return-Path: <linux-kernel+bounces-91477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F99871218
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C322877FD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D5014A83;
	Tue,  5 Mar 2024 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zGTq+ph1"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E098F55
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 00:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599884; cv=none; b=pcs6fF9g+SvJ2f04M5Ov6Qv2OBsOO99oL3qYCkGzedzRv54463RPf/9cZZyYFL1/14tzQVbKCXjXJOj1lxC21AkLdQtWAh8mdeQhjTfjIbrt4huInNfDJWweno9WlQKxjeZHWJWFDFaI5MYBMf6W08CmloA5Yw+4WBt/lNsuZYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599884; c=relaxed/simple;
	bh=JK5ZL4PnU5QeI+1YMzB3uaBk//5D5vcBBN1SI7nMnwU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cVeqiuY5/zVT9nubPLDmN75E4r+gkiR1DDbUN0uZugvbOdqDLjqHx7cHfV9Z6RhBp3rOL0EBhaRwPmgaQSih7MVUhGWcWRSUGJxN6S9Nev+4cRSVxz88P96GTdMFCB57Uy/sFAqz9VEIOGGfW6HPItfr1Y+ZaLQfptr6WNWXyf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zGTq+ph1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607e613a1baso89859967b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 16:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709599882; x=1710204682; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uY5VRSDJS+IotGAZM4PBm3CjluNBdRiBTTCOlg+57LQ=;
        b=zGTq+ph1Gt70cMez1/KmQsCju6MOn1yHDUKz8BGOzj8khX4msGBh50eXZTILZoQggV
         zNzK8E0InmCpWO1aodtcdShw2yyxFs8zuUCTOHuaCe7TPdTz4UcQ8Ne//PEqeS/ZFvmU
         /r4gQIpgdnK3ooK+gyRibZ10mRWtX2DMs0U1i9ALw3D4Wgh6n27Sdtq193dLc0gaepCF
         2yzPFl7O5jn3RvZ7Ki0LAI2uvovNcfBc8RALvq/TZqUzPXYR3dEYS4cnv45MpuMNocbC
         gLsp/Fa5YlMx5vnXamD6HO/GHCz0dppimHbdYcIgLuP8muVILGcyuDMLvWy2iWPdEZWS
         clAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709599882; x=1710204682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uY5VRSDJS+IotGAZM4PBm3CjluNBdRiBTTCOlg+57LQ=;
        b=GgUyN4wV09Tollrk6P93t/pGEVeDDEmUGxJAry0nmpPbzJUN//tcbr46LqgQTLQBLw
         9oDeN2Ejrw9BIJvLobZreNECiUeBtBBZT221Mlz0j1AtWm3THHVmeGGxTTnbZXsmcP/I
         t02VdUGO0Ig5F+0GEa7banKrLYZedM1X/Q1ivvgPeDFF4kCU/g0JRYQ2EAaG5i2JYdlh
         ck970zYKW+gyJ8TH6FfNNaPg0o2VPYsTYGoHi22SRn2DFId9tDr0rF0+Zs5PbiiOG29S
         MKk8upA+XuKBOGUNAbVr0GQXp1Ng+31oS3cCNEpMO9ZOsmlHw3vRYwXHz6Vr990TCOUI
         uIeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOWICZ5JPrpichnIBX/uKcJ1hLSxN8N+C8N4KMN/bfPzCL17QQFmujfZ8boN+S6s6t3JKEyp4qiHDCx6j/waqU4b/KUscZm+0VriZz
X-Gm-Message-State: AOJu0YwIfZYm0lpHyFt1KI0grI8skCzUtT2mxEOzKDZHZof04aNpOk/Q
	N+Y2QsAq4ls5GJRpyznaR176zkvc0GOHe1706j95BgusRErmkF8mWAv7YtSiG8sD05Aidi5H9J1
	iVVapFwhqFw==
X-Google-Smtp-Source: AGHT+IFlhgHHWVA1TkUHFLU46HuPh9Pm+a647sbF3wlljbxMV51Ln2wZuV9e2Yf7mOeLRXIgQSgT+g4jkbhtQA==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:e901:e760:20cd:d870])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:1885:b0:dc6:207e:e8b1 with SMTP
 id cj5-20020a056902188500b00dc6207ee8b1mr2710413ybb.2.1709599882317; Mon, 04
 Mar 2024 16:51:22 -0800 (PST)
Date: Mon,  4 Mar 2024 16:51:03 -0800
In-Reply-To: <20240305005103.1849325-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305005103.1849325-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305005103.1849325-8-ipylypiv@google.com>
Subject: [PATCH v5 7/7] scsi: isci: Add libsas SATA sysfs attributes group
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
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/scsi/isci/init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index 6277162a028b..8658dcd61b87 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -149,6 +149,11 @@ static struct attribute *isci_host_attrs[] = {
 
 ATTRIBUTE_GROUPS(isci_host);
 
+static const struct attribute_group *isci_sdev_groups[] = {
+	&sas_ata_sdev_attr_group,
+	NULL
+};
+
 static const struct scsi_host_template isci_sht = {
 
 	.module				= THIS_MODULE,
@@ -176,6 +181,7 @@ static const struct scsi_host_template isci_sht = {
 	.compat_ioctl			= sas_ioctl,
 #endif
 	.shost_groups			= isci_host_groups,
+	.sdev_groups			= isci_sdev_groups,
 	.track_queue_depth		= 1,
 };
 
-- 
2.44.0.278.ge034bb2e1d-goog


