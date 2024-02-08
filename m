Return-Path: <linux-kernel+bounces-57646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59FB84DBC5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD7D1C24DC6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFDA6BFB4;
	Thu,  8 Feb 2024 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLAK48lT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11A66BB5B;
	Thu,  8 Feb 2024 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381922; cv=none; b=hyUPz4GvfA/XWrP6CSnu6+oBzJVPHg4LiKV8jHfk8h2midHG0lmAD94hME7+QVgm4E/eHPxej21gWy8mMujFG0xpMOtre/Eabj8taCI3TiH4o9ciIaZhtZoKmtjQWodOurSR5pxWOEpypukTDDzv7E/5frZmKabhuJJXHv7dszM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381922; c=relaxed/simple;
	bh=hlDlwkcxeivGM241tQtpGe1Fz1cUI3T9CvMucHwZtrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Euxiz5jFniBomMI9mc4iWyqTfPavmiZ8fri/gktCR9brFYgHwPHb5S5WeA92BNyFIBfQlYq4hV7NjpNBjCTcQDCYsc0q2bvhvA/2IVbFWPEcQIcWl7o+dddyGhsudA6hCY1/DxgZ3qpgAyy79UUB5R9PzlORqQWw7BTogI/hsDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLAK48lT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1173AC433C7;
	Thu,  8 Feb 2024 08:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707381922;
	bh=hlDlwkcxeivGM241tQtpGe1Fz1cUI3T9CvMucHwZtrU=;
	h=From:To:Cc:Subject:Date:From;
	b=lLAK48lTn9HBU7EKLqxBBkVilxBGT8aUPXY7Lp9U2eQRFF16qffg+Kqu9a16n4lGH
	 jv896prmv57q+H/JcowzvDAkY1QgBS7Y7wCQGrO0QidbqWtzlZ5KmnOxMfUCYbLbVS
	 yWqpv6MEVRiU/FUwynJLA8G6k8hYkTibW3ptJyex2WRxHGj7E1plEu724a4q6LCeNo
	 enXZD26uqRH1Y4VbpuG3OtRTWzn/OPHXHlbz6Qhe/d5Az31Qj+q8pB7i68YpqJ6jmr
	 j75FCxj3/rNpl2eGLEZTvAqZ8cfxyYMOMty0X2HPws4Ed1DVIQn1RfZ2ZOpA+blgbj
	 1GOD1si6YMj6A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Adam Radford <aradford@gmail.com>,
	Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
	Andre Hedrick <andre@suse.com>,
	de Melo <acme@conectiva.com.br>,
	drew@colorado.edu,
	Finn Thain <fthain@linux-m68k.org>,
	Hannes Reinecke <hare@suse.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Joel Jacobson <linux@3ware.com>,
	John Garry <john.g.garry@oracle.com>,
	linux-scsi@vger.kernel.org,
	Luben Tuikov <luben_tuikov@adaptec.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Michael Schmitz <schmitzmic@gmail.com>,
	"PMC-Sierra, Inc" <aacraid@pmc-sierra.com>,
	Richard Hirst <rhirst@linuxcare.com>,
	support@areca.com.tw,
	Tnx to <Thomas_Roesch@m2.maus.de>
Subject: [PATCH 00/10] scsi: Replace {v}snprintf() variants with safer alternatives
Date: Thu,  8 Feb 2024 08:44:12 +0000
Message-ID: <20240208084512.3803250-1-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Note: We're also taking the time to obay our new .editorconfig overlord!

For a far better description of the problem than I could author, see
Jon's write-up on LWN [1] and/or Alex's on the Kernel Self Protection
Project [1].

[0] https://lwn.net/Articles/69419/
[1] https://github.com/KSPP/linux/issues/105

Lee Jones (10):
  scsi: 3w-xxxx: Trivial: Remove trailing whitespace
  scsi: 53c700: Trivial: Remove trailing whitespace
  scsi: NCR5380: Replace snprintf() with the safer scnprintf() variant
  scsi: aacraid: linit: Remove snprintf() from sysfs call-backs and
    replace with sysfs_emit()
  scsi: aacraid: linit: Replace snprintf() with the safer scnprintf()
    variant
  scsi: aha1542: Replace snprintf() with the safer scnprintf() variant
  scsi: aic7xxx: aicasm: Trivial: Remove trailing whitespace
  scsi: aic7xxx: aicasm: Replace snprintf() with the safer scnprintf()
    variant
  scsi: aic94xx: Remove snprintf() from sysfs call-backs and replace
    with sysfs_emit()
  scsi: arcmsr: Remove snprintf() from sysfs call-backs and replace with
    sysfs_emit()

 drivers/scsi/3w-xxxx.c               |   2 +-
 drivers/scsi/53c700.c                | 102 +++++++++++++--------------
 drivers/scsi/NCR5380.c               |  16 ++---
 drivers/scsi/aacraid/linit.c         |  40 +++++------
 drivers/scsi/aha1542.c               |   2 +-
 drivers/scsi/aic7xxx/aicasm/aicasm.c |  16 ++---
 drivers/scsi/aic94xx/aic94xx_init.c  |  11 ++-
 drivers/scsi/arcmsr/arcmsr_attr.c    |  40 +++--------
 8 files changed, 101 insertions(+), 128 deletions(-)

Cc: Adam Radford <aradford@gmail.com>
Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: Andre Hedrick <andre@suse.com>
Cc: de Melo <acme@conectiva.com.br>
Cc: drew@colorado.edu
Cc: Finn Thain <fthain@linux-m68k.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: Joel Jacobson <linux@3ware.com>
Cc: John Garry <john.g.garry@oracle.com>
Cc: Lee Jones <lee@kernel.org>
Cc: linux-scsi@vger.kernel.org
Cc: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Cc: Richard Hirst <rhirst@linuxcare.com>
Cc: support@areca.com.tw
Cc: Tnx to <Thomas_Roesch@m2.maus.de>
-- 
2.43.0.594.gd9cf4e227d-goog


