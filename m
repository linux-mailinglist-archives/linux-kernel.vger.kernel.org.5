Return-Path: <linux-kernel+bounces-89258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B33286ED50
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B372880E8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507E2A95E;
	Sat,  2 Mar 2024 00:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uc0F4Ca6"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73D110E3
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 00:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709338617; cv=none; b=K4vHjT3EN7dy0Lek3FjcVyO8b5zstbqHT6rLL+L05276+Y9jNsAGHiGodRM6aRv8yM8RLKZYZTE4Wo/aQGTkmWFJgQyYPjkLwc84OeNONvD7ejLcak2SwwlyAFAPtT+loXHnoo6MGyFS24MZ2oRoAmvrJ01lpa9ORSogROTeQok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709338617; c=relaxed/simple;
	bh=pgSiW+xTZmFhlX83o7Jy94TLdmZvLPZgS0gnfRjbOfE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=K9+RlpTjsgyBpA5FNjDLYbV24LNZywXio+DnpxXm2DkgmAthiwhevykjY93pe3FsG4sfws1jFvcaZwcKltr974kDamQH4XaZioKJSxpdwSCL0QVEIK+7+L9o4PI9bCbrDd7Z5KqGApnQTsMDhtl034rQC5BREBAcEOqjan/GtHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uc0F4Ca6; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so4694612276.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 16:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709338614; x=1709943414; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XJVqfGzfplRxpO5E0p6+cO7VAdJkT8FDhuCSfsmbM5I=;
        b=Uc0F4Ca6r8FXVZSUSeciJODpxecUFJ/UH7kkvl3HBmmg/tnNFI76oedrrciyfRf6Y1
         E1jOXF4ihLc1zmwvOgWN3Kl0aOyJ0azxqpHreaSEc0Kj3upVwVp/bNvz/RZbgnC395Ij
         rDPZbS8QSTFTYfvOb0Oww8lruD1oaiyIeaJFTbosCz0/MNWm4qlH0ug/svU9uYhijzzg
         d8pugB0guCjYycedqAJ4bDhh8DzbBrJq0EkbDjnfKc/oFjFQNAjZwpz6NHfLbnOEY7EY
         c02pkEpj/IaNrWg2F4jabQYmXd1XzgD11FSLo/qjcUh3ZB+i2nWmIfqVtMpnPUeWLI9z
         JXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709338614; x=1709943414;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJVqfGzfplRxpO5E0p6+cO7VAdJkT8FDhuCSfsmbM5I=;
        b=vSW/cGhNh56lyPpuQp2iAGNHyDOW6aUJbY52AkuTOvXQeoOLl5nuA0XmP+XZVqeS/J
         F7we83eR8S7fxcL5gqhcYZ9q7g3U7NzEuw817QkC8bx1uj+Z5PYKTkg84VAkw2DreTdj
         vhxdU7XInFqeyxf5lzFrSHM6hs+Yi/ViKwYF+2OYqkcsUDxPkiJDtRCqxXQr5wnSUFKP
         OwpqoWP7kg4ek9MfPDBHZf3rY7jzhq0s7MC8zwhCncxHM+944wii7qF39d8cpTjt6q8t
         3QEGo8JKM9JZapYeQdRxggNzRFKzAPd96MjRcDr2OTkFH2AJc1gXQJMVBrm1WVKQBk6F
         Anzg==
X-Forwarded-Encrypted: i=1; AJvYcCWCHJ+P90Pji8kmmUZWHKF/8d/mQfxQsE3AzR76IRBa5lYZSsDFkkWb3gYzOkbJXEjFt38AFvUQNbnLLDdXpj5vhRnT4CN3EdO2FwwZ
X-Gm-Message-State: AOJu0YydH8dF6uKPoH5knSJr+/n5Ctu/Kgm9igCsEfBOSd5pHeu9Uoe3
	KdKkIatXtYE33rnhNLtyBPro8pKKpnAt1/ooTWSGcYwgw2VagcPJdxuSs/nhctjOO6srmWlSyPh
	L4CHydzIA0g==
X-Google-Smtp-Source: AGHT+IF8MBkXR+4X6PdgrM7IJa8RzUArE+pN73OYsy0OYujkB856aRXm5tQ58UhSH5oUu5ad9tsySL5EyAhqGQ==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:2afe:1a8e:f846:999f])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:1209:b0:dc6:e20f:80cb with SMTP
 id s9-20020a056902120900b00dc6e20f80cbmr115663ybu.3.1709338613902; Fri, 01
 Mar 2024 16:16:53 -0800 (PST)
Date: Fri,  1 Mar 2024 16:15:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240302001603.1012084-1-ipylypiv@google.com>
Subject: [PATCH v2 0/5] NCQ Priority sysfs sttributes for libsas
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series adds sas_ncq_prio_supported and sas_ncq_prio_enable
sysfs sttributes for libsas managed SATA devices. Existing libata sysfs
attributes cannot be used directly because the ata_port location is
different for libsas.

Changes since v1:
- Dropped the "sas_" prefix to align sysfs sttributes naming with AHCI.
- Dropped ternary operators to make the code more readable.
- Corrected the formatting %u -> %d in sysfs_emit().
- Changed kstrtol() to kstrtobool() in [ata|sas]_ncq_prio_enable_store().
- Changed comments to use the "/* */" style instead of "//".
- Added libsas SATA sysfs attributes to mvsas and hisi_sas.
- Dropped the 'Reviewed-by' tags because they were not sent in-reply
  to the patch emails.

Igor Pylypiv (5):
  ata: libata-sata: Factor out NCQ Priority configuration helpers
  scsi: libsas: Define NCQ Priority sysfs attributes for SATA devices
  scsi: pm80xx: Add libsas SATA sysfs attributes group
  scsi: mvsas: Add libsas SATA sysfs attributes group
  scsi: hisi_sas: Add libsas SATA sysfs attributes group

 drivers/ata/libata-sata.c              | 139 ++++++++++++++++++-------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |   6 ++
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   6 ++
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |   6 ++
 drivers/scsi/libsas/sas_ata.c          |  92 ++++++++++++++++
 drivers/scsi/mvsas/mv_init.c           |   7 ++
 drivers/scsi/pm8001/pm8001_ctl.c       |   5 +
 drivers/scsi/pm8001/pm8001_init.c      |   1 +
 drivers/scsi/pm8001/pm8001_sas.h       |   1 +
 include/linux/libata.h                 |   4 +
 include/scsi/sas_ata.h                 |   6 ++
 11 files changed, 233 insertions(+), 40 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


