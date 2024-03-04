Return-Path: <linux-kernel+bounces-91341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE44870FC8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FC35B240C6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EF97E0FF;
	Mon,  4 Mar 2024 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OyE/bcIB"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34027D089
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 22:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590114; cv=none; b=XZMPOKoT/4FaeD9MEnKlovTZWbgX3s05Q87hYRFA8PyCN4r5s9Y0xvY6ghwFKXbBQyR3eC2eaRX4BZyu1RnVP7M6Xr8isibuARLrC5vhEONgLLzHwzerhZRjAy2VxqpQJdvr9VvXSzjMH7+GLDL28xXtIq07wqRZ2WJk/olf1vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590114; c=relaxed/simple;
	bh=7lui4HEwt3nyzuBq3kOGgxhbVfQ4kTvXlTnHRxF4y2g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P88vwo5fZvUN6KG3PyIt+9XBpNXY9XbbbbM7V6vxA0Q/337rsCfrg8yHt/XpC67Pk2QOwk1w5TK8f8GG2lnL0YM16CTZUfSRpGLyC5e/vEMcV0dAhJ7MlnJCKTdEHHttWQT0N/bxzi7jKjs0n6B8t+WStaixbzDeBJkyfzWXUYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OyE/bcIB; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc691f1f83aso2150063276.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 14:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709590112; x=1710194912; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fllhBTjW6GX9iEnv/LwNN/tFNgKMHmXcnmtxo/1RJIg=;
        b=OyE/bcIBE9zeJ/Bm0iuOrgXR/lfkIGCqbljW+669V6DIikYmROin9LG7goN/I+b1s2
         PBjjWjYK0kMp3ezTV6VPVPoh/rrzORxIMi8F9vCxLKOnfRM7Tien7sU/ywiYMZP+3V96
         j44FvMTXl0ojTaG9VeepmRf0cjjQneTS7A4Jpby24hqq7pY5pcY/j6zCq8NJWg16Cxn6
         B6ztXIcXrUXmWRJwBAoAguW4D0thCdddkP3KrxPHD5O1VrJ5Gc676hae7ohrCYftAb5k
         e+8Znkp0lO01iIzbFvsmjoxJAeZ9onKBgWMhuwBBq+E5/Zr4QW2w97OjpZ+xjdtFiyl8
         WP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709590112; x=1710194912;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fllhBTjW6GX9iEnv/LwNN/tFNgKMHmXcnmtxo/1RJIg=;
        b=OzvP8YGj4gVEiv5seiqf6H0d5VAu2Jg4qCeWyHyZ9QI5HVFPjS4Z9GF0yl8E9tMmxo
         g9CZ07Urt+Z3ibEt8RUwV+QbJdYG/ekoyVQgbD2mFkwLA3+nyoM7gIohC/Cyp4KKkS9h
         VE/uSbpA6W6j15gbn8g2miAWEHywQSxOm3wcTPq0fQD0AAPqo+e0OIYPRYzb4dbUaHki
         bp7Vn61IvVneeSbT7tmPn1Ikc9QvGyCXO/1x+arKpF9iMTIPHUI/SAhxm1sCVJPrw1KZ
         HkqL8kzdeZVPQuZcPvYQVfMDGMQDOcgUFnfhLSCq2lsz54mfmLbXtDCJ13qeOUjvX687
         rHQw==
X-Forwarded-Encrypted: i=1; AJvYcCUdkX8Rp4vBXBVOspkhzpdI2V6kMA/3IK+gFcbroNzCKsdV1zAheqZxcx2SS63omg+ss5oxI3jrIyNPxJ5mW1Q8Nig1K+9poJFR2679
X-Gm-Message-State: AOJu0Yy94ZYpkrw6GfbVvxFreDVS7A8lZODHk1QZFhsHqVgVESlJ8HJd
	/K8VgLjUpYLLzmkTovPqMHTTPeLwm3vFSamstUTsUr0RS/VwxDTvlmJVNQS2nYnYkH78t2dvApG
	E4uS37HAGhw==
X-Google-Smtp-Source: AGHT+IHptqL+KH146p/jJHXv8G+GG/vYikPUWRaYAjtq0JMV4p7qsJi+Ner0U+3RmjBfP4O7X2Cx+gNL7fNivw==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:e901:e760:20cd:d870])
 (user=ipylypiv job=sendgmr) by 2002:a25:8a87:0:b0:dc7:463a:46d2 with SMTP id
 h7-20020a258a87000000b00dc7463a46d2mr158322ybl.0.1709590112026; Mon, 04 Mar
 2024 14:08:32 -0800 (PST)
Date: Mon,  4 Mar 2024 14:08:12 -0800
In-Reply-To: <20240304220815.1766285-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304220815.1766285-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304220815.1766285-5-ipylypiv@google.com>
Subject: [PATCH v4 4/7] scsi: mvsas: Add libsas SATA sysfs attributes group
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


