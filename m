Return-Path: <linux-kernel+bounces-89262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2196A86ED5D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56D91F2156D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4D713AD4;
	Sat,  2 Mar 2024 00:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NqBmaVw+"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC5C125AC
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 00:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709338625; cv=none; b=fBWhql0/uFW3c2DuKSdoWRwGIuqLx6fCSIptc9oD81iRp5hZU+P6m3NYIlXQyoKdf0rKyuJJRvak6DT2bTvJ5ABuA+N1WkJhJ6TLH328I1OEPPBa5p0h5UX7w+lSryLuGS+UpjZ9xEk+dwvVR+JlkEeYUuoRRfX9wuXeURuik/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709338625; c=relaxed/simple;
	bh=bjPtSxZSirainXwWirJU3J0oe9KNdxmW81tZ+T9YgIw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VpFk0TyqV5+/RV0qZz2Tvu6qjGD0jQV05QoAVmb1hIQ1Gln4A6VgwZ49MAhnBho8IUbn7w8jrApCyCceHsRc0a5WFT/nXd3gajwV/fIgR6ETxqU3sxroMX0kwghwJsjjTPac3qlkYQUmVmCQtV5ZSTeWSdU09/QiB4ngvSy2FqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NqBmaVw+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60802b0afd2so25855297b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 16:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709338623; x=1709943423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cz+zzq0hSSZv+LNtbHhOy76RrAuTvZz0C7UUtpPGk5c=;
        b=NqBmaVw+4RQgYIfxwns4Hj+hw6aLAd179C/AdDV+zJb5Ml9Ia8IoMrgg/bTv7AGBOh
         TdaCIHLiwFDjLEdIL0k9rTHyTAzlnyvZKETtyaw6u681mM0tX1Eke+jo+M5fsjYJd9qd
         SSp3zJ/+BDfWcqU4/gMgvAzgzc5ddKPIKQ1s12C2gA37TQ4xN8AIIZOfv0TUix8cgZ9y
         YGDZnAS2GI/0/oZ9Jty2qxx6H2C3e7cZ6kZKnQuwnietELKVpPoxjng86RCHx2+BS5eg
         YQDWzvo/qX+gL49oA8MTSylTKwAvcUSLqCO8qCZvvMdoC1AoYqSFplW9VcsBcgqaFeP9
         goig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709338623; x=1709943423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cz+zzq0hSSZv+LNtbHhOy76RrAuTvZz0C7UUtpPGk5c=;
        b=Ah3Cgi44+pbcAf54ZL9/8D0CCWM5nV6ZFavNQY00tDCC2/4fd6ZY6S+O0MOsOC6mMH
         mFVuZv8450TWd9h9Vms4Gk9MR+gvgFriIRVzUpwr4LUXTdxUD/xoOb+XyqDcCF4gQzV0
         OWQdcui0vf/jbnp6PslPsEYL2cYAxq6edyWyrpRgan4IPq/FPvpcPZwjwsddTX3tVO3E
         OczdU0itL/e13qOJDejsqwePKh7MLwCyo9OWmBG7UpdLUptng/beR66ztvHPiv4za7yX
         Rwcae3FObzPoCVSX3Br+5jv7hr+5gif0DDEO+gRmgA8xBiSkYiOZuK7U4rlxv0xkD6kD
         YPAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKGZHsWEiLUccDg5dq7Um0KxFGWZHo2U3vDH1qj+HsEW8CtYeB31axCKWIw/19pn+67AzipiyR6vpE+HW1QYXEKpwHBH1p9TYGuzpG
X-Gm-Message-State: AOJu0YwKwBMRqu8b/7OP1MUi8lDRZlTazmIsOH8TEs4lDb8LLW+zC+Q/
	+RLNPqtBFLnDutLmkSwEGbuE1QTzehwTD+xKrq0IFKXflpHpAyT1zBaHPVM1gTx7ilZGWaz+PeP
	rSkQ6hLSPCQ==
X-Google-Smtp-Source: AGHT+IG+aso8DlILFFU3hOZkQxoXGg0/2rizQ7SMEtEdYiKh5yDyTO6FrayYjPmqaZro4E9t7cvjrUqndk6pUg==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:2afe:1a8e:f846:999f])
 (user=ipylypiv job=sendgmr) by 2002:a81:9808:0:b0:607:8f65:5433 with SMTP id
 p8-20020a819808000000b006078f655433mr688164ywg.4.1709338622812; Fri, 01 Mar
 2024 16:17:02 -0800 (PST)
Date: Fri,  1 Mar 2024 16:16:01 -0800
In-Reply-To: <20240302001603.1012084-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302001603.1012084-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240302001603.1012084-5-ipylypiv@google.com>
Subject: [PATCH v2 4/5] scsi: mvsas: Add libsas SATA sysfs attributes group
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

The added sysfs attributes group enables the configuration of NCQ Priority
feature for HBAs that rely on libsas to manage SATA devices.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/scsi/mvsas/mv_init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 43ebb331e216..80cbe030ac53 100644
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
+	NULL,
+};
+
 module_init(mvs_init);
 module_exit(mvs_exit);
 
-- 
2.44.0.278.ge034bb2e1d-goog


