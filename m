Return-Path: <linux-kernel+bounces-87785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC1986D8FC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51FFB1C212E9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43A72C18E;
	Fri,  1 Mar 2024 01:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I5p8Jb4k"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833F6383AA
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709257116; cv=none; b=ieYXcNfJp9TUgj9fJF8MB0NEgPBIdUDOBmMCGfx2TkcDBRQvlq5GRwjdAAl+M502hwR+ZhLpwf7V4vP+imMdHJL3Ep/oG2QHTKlFI10YGFTcTasV+mqjBtcbHXP4eaTfem6+DO7+56tZoQ1BgX+IzT54KXUZAfV6f4U+m0t5bT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709257116; c=relaxed/simple;
	bh=BHm3bafsiy1rPpFyzr2QCqwbYutNJj2AhwXm2Nw+tbo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CzPJV/Wo/uQplLfiECExeNyD2BH1nTKnWs4hvl88d8O4VfqrYxWhdrVfVXOZlu0EVUr8OtFb1xGnZZDXpPHSg9YIB8Xu0dvYogszJSrnw+TfjTo+8EDLnd0OMi2jAaZAQ92KFCCgQrumtuylRhyC0NUF29k7F4uGmkzEw7ImaFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I5p8Jb4k; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607c9677a91so25849197b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709257113; x=1709861913; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=avuTBfkDXK1hv1D4bL2KM6unjJu36TT8oh9Ptp0s5ao=;
        b=I5p8Jb4kUHB/kLPAWKq9jA7ke/gbWnb0Uq+9Pbk8Xztvg1Ynnmc9sa6PLKrZVe/Ana
         rhdi8bD2VD0yf5uyomkqWk0zU+W9NKANjNEInWkUuPyDHsuKLgkjv7Loxtx3Xp4UAiZt
         t2sgCv4J/Ed/YupGQLzM4RCF2krnEazj3lDGEyt99/VRxLexDffy4TJUZp5QW8VDViKu
         3BIXKQY42/mSgqdLv2URhNoY5f011FGbfwP93nlxA+JghadG7jhnoMH5cQd2rfvlWNDJ
         GDWmi3AhXuBYqnlFdqssK0+PFa1cRRNyIj7Z9zJa2QuduAtaoxcabUxKOKYbZRFbecam
         M8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709257113; x=1709861913;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=avuTBfkDXK1hv1D4bL2KM6unjJu36TT8oh9Ptp0s5ao=;
        b=aACzEwM5LRbksdvi7i6E2r5+MoxWFJbgGd0MW73XR3oljLa9i5b8GaI2cDMWWdJXTt
         J1R9j4s01imzwEj6+vaS7YEEGHBQUheA5HdHFpJjZsOgQ1ymF6I4k5lPap1/BNam8FxD
         a4mczJvJVxanOLYBhi4+9fv/7HjpWIYto0aQB8Kkj9jhOdJ7p51enLAz9U4CAkxykyJn
         VcrL6/9XZJYjt6LRj1l7I5BOITzXArqpnwCGftmDKeXur5ud1OQqkj9RlXmUxBVfWak9
         9Bhr8ErgK8vOOnxCPbdqrNELJyhd2uYdAyYqBeu+hpz2aYqEw17oalpoamyh4p3duWHK
         PC3w==
X-Forwarded-Encrypted: i=1; AJvYcCXKWNTCKBtVRxxx/Ou6uTGVrMF8U3r8btvCyXewDIeUjhyOhuA1CUdcF99MOrsFkg8ZmOKuzuNpsY0sLtbRYQcurj89vJLHNWdXgUum
X-Gm-Message-State: AOJu0YzpRRenKup+0fukQgYpDN2owGGrrrCOET9RopeZCxAwIMKE/qYu
	dFajEzfXi/YWb1+1uDMOlaDta5wK6Ld195l1WcT5H2BaSpWafm7hu4LeBF0SyohrP9N19pUfMKi
	wX4lmD/5blA==
X-Google-Smtp-Source: AGHT+IEC0MPeDboQHO/1B3vR+Iq5QjH11ZYMccDwztB1zAvvRbVdodFYQk+/U00WFKidW8wJFALdRMRUrASHwA==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:3564:51b2:6cdf:92fb])
 (user=ipylypiv job=sendgmr) by 2002:a05:690c:e18:b0:609:247a:bdc5 with SMTP
 id cp24-20020a05690c0e1800b00609247abdc5mr59222ywb.4.1709257113724; Thu, 29
 Feb 2024 17:38:33 -0800 (PST)
Date: Thu, 29 Feb 2024 17:37:59 -0800
In-Reply-To: <20240301013759.516817-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301013759.516817-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240301013759.516817-4-ipylypiv@google.com>
Subject: [PATCH 3/3] scsi: pm80xx: Add libsas SATA sysfs attributes group
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>, 
	TJ Adams <tadamsjr@google.com>
Content-Type: text/plain; charset="UTF-8"

The added sysfs attributes group enables the configuration of NCQ Priority
feature for HBAs that rely on libsas to manage SATA devices.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Reviewed-by: TJ Adams <tadamsjr@google.com>
---
 drivers/scsi/pm8001/pm8001_ctl.c  | 5 +++++
 drivers/scsi/pm8001/pm8001_init.c | 1 +
 drivers/scsi/pm8001/pm8001_sas.h  | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
index 5c26a13ffbd2..9ffe1a868d0f 100644
--- a/drivers/scsi/pm8001/pm8001_ctl.c
+++ b/drivers/scsi/pm8001/pm8001_ctl.c
@@ -1039,3 +1039,8 @@ const struct attribute_group *pm8001_host_groups[] = {
 	&pm8001_host_attr_group,
 	NULL
 };
+
+const struct attribute_group *pm8001_sdev_groups[] = {
+	&sas_ata_sdev_attr_group,
+	NULL
+};
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index ed6b7d954dda..e6b1108f6117 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -134,6 +134,7 @@ static const struct scsi_host_template pm8001_sht = {
 	.compat_ioctl		= sas_ioctl,
 #endif
 	.shost_groups		= pm8001_host_groups,
+	.sdev_groups		= pm8001_sdev_groups,
 	.track_queue_depth	= 1,
 	.cmd_per_lun		= 32,
 	.map_queues		= pm8001_map_queues,
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index 3ccb7371902f..ced6721380a8 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -717,6 +717,7 @@ int pm80xx_fatal_errors(struct pm8001_hba_info *pm8001_ha);
 void pm8001_free_dev(struct pm8001_device *pm8001_dev);
 /* ctl shared API */
 extern const struct attribute_group *pm8001_host_groups[];
+extern const struct attribute_group *pm8001_sdev_groups[];
 
 #define PM8001_INVALID_TAG	((u32)-1)
 
-- 
2.44.0.278.ge034bb2e1d-goog


