Return-Path: <linux-kernel+bounces-91470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7752C871201
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169651F2406C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37758C10;
	Tue,  5 Mar 2024 00:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H5TsZbXv"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEF13201
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 00:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599871; cv=none; b=j4GYtZZA8Mw48nLYvKPDA94/xiIQcE1OaI5JKa3+kmxIffTeOcjWVIUVV9qF+uAVffaJhAHeM6gSG9XHB2ebzvtYvIMq8Gupgv5zMrUCUO3wu/SnzyIm2cVpl+T+QzR57jrjDzjhjGLjrkycaxdsan9BUzLXh84lUScQjwk6t1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599871; c=relaxed/simple;
	bh=c7VvByvOC7tfDYPpD5rikxgiV2vj9KaVUYvTVAm6iTU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Txfj+q4ggc0OcUN7OWuN2iNAyEyXpuNJXgrA3GZfYZyYq8+Tnfib4xkVd8bWfUEcuPyXF++LKpMjDvXS7Lh+KTHy+vqNj+8V7eASG5bDsjxcn2JTJKyqHBxvmRc38YjErjqiKF3ItEz8J4cpKFjAFuQnhAZCHBm1u7KOmMtlqQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H5TsZbXv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc05887ee9so6966447276.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 16:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709599867; x=1710204667; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Dz6bIFDjYrjt2FfKLKRbryH1lom4wKlrzD0Ykh/AME=;
        b=H5TsZbXv0KkBVntIUtSVPeocuAtmU7JDUDPD4U+VDrTNRo5bhZ77cGIx2gUWdvIUuB
         IKvnyQxcSEbZEtcsM+ghKfvCWp+5opTmAmvrIA167rkqZkCx3U03Cgrv2nxEOfOIDZ2t
         D388+ZE5X6+SPRx3HqpYFm9b4SxMxXGMRX9ZbPZnGRDRI8V84/82udRKdI02JGUK+/o7
         WRrrqRpvz4oGjctMZtE4dR1dMeqEY7GB19MtlYdvb9frm6U1kyEUVc1N1MbwYAucUz7L
         FLwJ/3Yo2xY8BuDPg/MM52UsCUAACeSPWxUQh0ZKwsH8H571rKkTTU8NUifD6kvPI/9s
         8arQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709599867; x=1710204667;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Dz6bIFDjYrjt2FfKLKRbryH1lom4wKlrzD0Ykh/AME=;
        b=FBiB35bqwfsY752gsZhkXHnDDPC2lhh0IH8TQeICeQf7uVvlMhIPY/E3hL3UYdQVZB
         +wiUT6+PrEb6nKzWPW0Z48AHk3b86tt4aBRAlefGqaXoKzKE8D98luaN5bXlmnVP+wWC
         s0CX02myxB9qWoExCB/SvBIoIFPVMx2yWTYO56zCUlb6/0aPyEzLqInQnYqnf6MWgpEq
         6fxR3I4/GHHjv1D1h9dOL9drDNtjKQCh9t+HqZS4mI39Wc4ZGZhL25pzi5KDlCCt44oj
         CbGVaoMJfrFiyy9Lfak3362/oK33U2zjJ6IkIG6DFY5Q/hwovvlpO0NgKActj3lU6y+U
         WKvA==
X-Forwarded-Encrypted: i=1; AJvYcCUn08sAdm3VGUhoHMaeynYdsv2aKmwzgUcN71e4ZILkR7hS9tM3jkDsS812AgNid0U4gQaCrhPaWXksyeJGHgWGisP430mMFiWH94dt
X-Gm-Message-State: AOJu0YzCGesZVQu+fZiIU1ds5s3hcAjPd/7KK91wJvsiIhPKfi+0hyHV
	D/MBZs0ZU8AIwNW7lgrMJJRHdSTyqrlhq8ECl5sMGjV57i9JoKXGni0ugQlMgnfK6UHSMdRnxGi
	VKuTA/Z23YA==
X-Google-Smtp-Source: AGHT+IFKugHXd46vYjaUeYPD/JVegITh5FKDEpQt0sfvZ41FZraeLm+aFzqCj0VvPjztu2fMnxcbKR3ZeaO02w==
X-Received: from ipylypiv.svl.corp.google.com ([2620:15c:2c5:13:e901:e760:20cd:d870])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:1009:b0:dbe:387d:a8ef with SMTP
 id w9-20020a056902100900b00dbe387da8efmr363828ybt.1.1709599867293; Mon, 04
 Mar 2024 16:51:07 -0800 (PST)
Date: Mon,  4 Mar 2024 16:50:56 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305005103.1849325-1-ipylypiv@google.com>
Subject: [PATCH v5 0/7] NCQ Priority sysfs sttributes for libsas
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

Changes since v4:
- Updated sas_ncq_prio_* sysfs functions to use WARN_ON_ONCE() instead
  of WARN_ON().

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


