Return-Path: <linux-kernel+bounces-91476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2686E871215
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66A2CB23A7F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAB114012;
	Tue,  5 Mar 2024 00:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ln1VZLKu"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E328F12B6C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 00:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599883; cv=none; b=a0xbpc4a/z2bRSa8zeyW1QJbx9Ff50HYZJfbMYGgjnxrAk1TWHk4ev7K3wy+izyq54SBz94JAK2BgwQKdsay2KgLqFs3cdndZpE4foksCC70QlKq94tQvyue536CpNZ5uIw6KnQuyLw/HmSfhglckZHRWL1tO7yq5RRe6T/2M4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599883; c=relaxed/simple;
	bh=l1B7DL+QxZKXAInqPgoxYQhQfMm3hZjNqcIgYcFRiA0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eXmnBzpGzhkFCc/rH32QuMxWpo4H8Qz+uo71iuA2L9Ub6zC4xiPfBYwwEf3/HkBWJ2fPBuGw0ohI2mFwjC/16JfNGhlMFIDNYlyMJYENVn1vkSHESfd9ylsDlNnlXLAF+nBJ+Aq6zw+jqUzT7RDhxPQvps0IUH86bgLo9+3ax7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ln1VZLKu; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60987370f06so39918687b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 16:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709599880; x=1710204680; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/rSrKaEP0cu2EEhDxf63kSlEB7iQAh36Fr8Ir9gTxu4=;
        b=ln1VZLKu5+RmXA1sFmdN5RLOFSeHEvBQQuxNFPSMvRvaOrd0Pk4eLH082LtqedwjXJ
         9H91dKjKnun1LO9vq57Xkr5j2VjJ07C5pkiDWieMvRYt3lBhAv0hNJNffY6yz+ZLgTai
         DNWjUluuL5AsxpqwO9IpLg6FSsLdr+ynR1DwGcEN4K0subUdDnBM9TrlquJrFNxzOkI9
         rprR0cVzZDWvUbVmh1HVE1Ng2o0sSOJE4YSh1HJI0CjudrtbVI6qcqA+Ee5eKy8Mx2Q5
         shdvR3IMqByi9uCkYIZ8zqPq3lf8zeQQ7r+h58i8DYbCsk35g39fmSTJsCyyfPXTkxBf
         /BLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709599880; x=1710204680;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rSrKaEP0cu2EEhDxf63kSlEB7iQAh36Fr8Ir9gTxu4=;
        b=tYhq1h4GvZBI7rDX5a22ZWEgE8WUgIO2OPgwTPzs8b5UzfRcvl5cO7Qm7TlWY1gQ4f
         d9Uozg77b0FLsRidgMWxq9szRu9li1Y2Zq9wn44jXiGXOqoep2DqwKXIOo4EAnkwNIat
         l+9cKYF6+k2BvPPXNYNeaGalyhi0/3GHpg2T2xUFY8+kiFpS0sLOBwLOfQC1qxxltQ0u
         W/35KnjKo4CXFHb9dEiFZKmYpF2ctd6thrO7T8lWHAIILnpnkcP5YkfNH+azi/0cX2HH
         2N959j0Onz2iHLQbT0vGlcgEjArMffEcBkEahX8aJJmasp+cESQpWUPgXZHH5aCGRRfl
         NmAw==
X-Forwarded-Encrypted: i=1; AJvYcCVwP72M9P2QaQTj1Je+7r61CBKt+gjAFeMTRy9wH1ORIrUhZgyrPhMXFmnPiGedA42rpXwumMLjpvR6FVZg2xZt3MpSHXy2LWV0TCI2
X-Gm-Message-State: AOJu0YzBwsEKkhV8oGr/3ATYa+ca7zYkove6+Xiz11W7tuPkJXSji5B8
	BXXjrbZTtuB4KR6uPSXxLmLb0mjney6ASYMMWmgzWsuhxYFkyPlaj+nAOrZdT4LkBlRNVy7HmFZ
	YysgpEkHUJQ==
X-Google-Smtp-Source: AGHT+IH0taBqeMsbYKpUMKAKLG8w3t/pn1bQnH1/UJUTTJL6q6kvljHPQbPcYP7rtlwNxzaYSsc13QQM44B3KA==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:e901:e760:20cd:d870])
 (user=ipylypiv job=sendgmr) by 2002:a81:9a05:0:b0:608:2ad5:cd28 with SMTP id
 r5-20020a819a05000000b006082ad5cd28mr2227317ywg.4.1709599880122; Mon, 04 Mar
 2024 16:51:20 -0800 (PST)
Date: Mon,  4 Mar 2024 16:51:02 -0800
In-Reply-To: <20240305005103.1849325-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305005103.1849325-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305005103.1849325-7-ipylypiv@google.com>
Subject: [PATCH v5 6/7] scsi: aic94xx: Add libsas SATA sysfs attributes group
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


