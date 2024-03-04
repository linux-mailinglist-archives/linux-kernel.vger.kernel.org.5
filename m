Return-Path: <linux-kernel+bounces-91337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113BD870FBC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42DB71C21BAD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3F77BAE6;
	Mon,  4 Mar 2024 22:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gK69VB13"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6315078B5E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590105; cv=none; b=XQcXI3sHnM05Oe/MRCcbJhe+/3zeYNWrQwlZgqifHOjewftVKLV78B5/MV8rv0zQlW8Zk2r+5gUA02bQmzKWNA1SNy/ydOezqx0nUunq1fHS1/FzH8H+4TKx+XXejfueZqiIs1G88LQ/ErbJmawnQsA9i3Y1cuca7AuJtMQUq+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590105; c=relaxed/simple;
	bh=KIrzPff8X5XmBjckpJFSRt5Ce/eTKlP0CC/qHYRxzi0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cvW0ZJbwf6M8LRLYluAYiXMVMpp5Pm0bUGcpx3lL3r/RA7Z/A1/OSf4Jue5/DsyPDcuTI+IwU0RnlBaRhghco2Pq2rYndqvzpOUsiP0wmCJnRwAVqGwsnr5rTPl+CDC4w+ugJzvP7xwiFg6knbeLvetJcpGTbGLbEKJWIUwgPco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gK69VB13; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60987370f06so38149897b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 14:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709590103; x=1710194903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iiyGGgw6bcoBER0ifxC4m6qALOEoGZjmpZBnddiCFAg=;
        b=gK69VB13A5WQRg3IyuSkO5W2U06HQ/NfhISbOS2R3sfkLrA0LnjxrHtUS0YNItIZJD
         4WSt3SlFr5Iu35Z+m0hWwTXJaVPGW/4+r6aYK+l8K1f8YXTm0kTytz9IpoR64AY600if
         DvknDbOuRz5IFOT/G9TH90+L6/zdRfVEVnqT9iNrDN8nl2ByeQ1/m2UIN7jQ3+BvSxEw
         khZqZRm5peD9ouZmY0d/prurBHz4Ab/h5MmiUWK2KI5Mu/igvyKR/83toUtUSFANE+U3
         Z4wLkpbLcG0hjh9yRBt4w1kJ6K8iX3VjMoq1ZUzu74RB0RFAiCnljPzcG4XAF0V29Pvd
         OeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709590103; x=1710194903;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iiyGGgw6bcoBER0ifxC4m6qALOEoGZjmpZBnddiCFAg=;
        b=Wdwjg6bDXVzzazL9/OI1LxqZ9obqobRKQxvF+QCW/6vYk8/q/qcc+pQ3Q6Y/pkDZTI
         E0v5ReC5NReWN9nSWJaJdSeQFI1LXTvdjfsrYJyt9cKqBeaUiOS/MEzWo3JNsnC33TkW
         ysWerP9LvwN3LnsjPrrTXMGLpcEMsBPa2T9E9E7GS46t9e+4epkMl8gd3TtQYTowgekf
         bQNOhYkAiKQQ0hnG84ReCEmTTJVdxKh+PVZQ/4fCITqwKwc+hWvrK+ZwUAzdTdyHfKDq
         Dg5a3loXrEna9v6ycvtUJ8jTr730ooD1le1ge5qQfNhkAR9XTiYL1xq8icg9JY5ChevI
         cfkg==
X-Forwarded-Encrypted: i=1; AJvYcCXgX/npuiJicu+T0mvxi/i8HEkKw2SXVU9uPIr3zbT5f+2nZef9baJTgwYhL9NiegcrqZK30zk9GaW4t5Gq6rPWvR5IZuR5iTlKyxSK
X-Gm-Message-State: AOJu0YyZuWB6gdleU5+VHzV6FrtCbwchOSqNcVk71LlKUcjsQprBOftB
	Uo1VmEA6db80d+DnxtO6dVvb8J9tZ2mwG/8PgRFaCRoRNpc8jGmouzs9bUttb6X1H9wUoeqc8xT
	iDMCUycHfuw==
X-Google-Smtp-Source: AGHT+IGsSvRu6925/ExZ3ABV5J9532cs88Tl/YIa/JO0Nr+gzNoaIb13r29iBifRSQrCWjWrgQVYP70iNzAyuA==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:e901:e760:20cd:d870])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:70d:b0:dc6:c94e:fb85 with SMTP
 id k13-20020a056902070d00b00dc6c94efb85mr357414ybt.2.1709590103406; Mon, 04
 Mar 2024 14:08:23 -0800 (PST)
Date: Mon,  4 Mar 2024 14:08:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304220815.1766285-1-ipylypiv@google.com>
Subject: [PATCH v4 0/7] NCQ Priority sysfs sttributes for libsas
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

This patch series adds sas_ncq_prio_supported and sas_ncq_prio_enable
sysfs sttributes for libsas managed SATA devices. Existing libata sysfs
attributes cannot be used directly because the ata_port location is
different for libsas.

Changes since v3:
- Changed ata_ncq_prio_supported() and ata_ncq_prio_enabled() to store
  the result into a boolean variable passed by address.
- Removed the "usable with both libsas and libata" wording from
  ata_ncq_prio_* helper's function comments.
- Removed the unlikely() in ata_ncq_prio_enable() because the function
  is not in a fastpath.
- Dropped hisi_sas v1 HW driver changes because it doesn't support SATA.

Changes since v2:
- Added libsas SATA sysfs attributes to aic94xx and isci.

Changes since v1:
- Dropped the "sas_" prefix to align sysfs sttributes naming with AHCI.
- Dropped ternary operators to make the code more readable.
- Corrected the formatting %u -> %d in sysfs_emit().
- Changed kstrtol() to kstrtobool() in [ata|sas]_ncq_prio_enable_store().
- Changed comments to use the "/* */" style instead of "//".
- Added libsas SATA sysfs attributes to mvsas and hisi_sas.
- Dropped the 'Reviewed-by' tags because they were not sent in-reply
  to the patch emails.

Igor Pylypiv (7):
  ata: libata-sata: Factor out NCQ Priority configuration helpers
  scsi: libsas: Define NCQ Priority sysfs attributes for SATA devices
  scsi: pm80xx: Add libsas SATA sysfs attributes group
  scsi: mvsas: Add libsas SATA sysfs attributes group
  scsi: hisi_sas: Add libsas SATA sysfs attributes group
  scsi: aic94xx: Add libsas SATA sysfs attributes group
  scsi: isci: Add libsas SATA sysfs attributes group

 drivers/ata/libata-sata.c              | 140 ++++++++++++++++++-------
 drivers/scsi/aic94xx/aic94xx_init.c    |   8 ++
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   6 ++
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |   6 ++
 drivers/scsi/isci/init.c               |   6 ++
 drivers/scsi/libsas/sas_ata.c          |  94 +++++++++++++++++
 drivers/scsi/mvsas/mv_init.c           |   7 ++
 drivers/scsi/pm8001/pm8001_ctl.c       |   5 +
 drivers/scsi/pm8001/pm8001_init.c      |   1 +
 drivers/scsi/pm8001/pm8001_sas.h       |   1 +
 include/linux/libata.h                 |   6 ++
 include/scsi/sas_ata.h                 |   6 ++
 12 files changed, 247 insertions(+), 39 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


