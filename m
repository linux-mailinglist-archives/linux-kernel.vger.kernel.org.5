Return-Path: <linux-kernel+bounces-85815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E512186BB67
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106B31C23D27
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8361976F0E;
	Wed, 28 Feb 2024 22:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iraPFeRH"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D3672901
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161152; cv=none; b=HL9dwpqRg8TltjLnoErKZEUIS17zvPUD5h+LHMkjjE0B3TkV8+ohmlZ/OTRLd3FFrcaSE23DLEwaqQB6ww0jcaP74I1RVbg59IPt4uzT43oST89kcCEfllAgt5oDJRw+S7R2ZXfe4m34MOT7lOE4MP7sWKoNk3Y7NpjC1I2i+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161152; c=relaxed/simple;
	bh=Fzxw3B7E/9cimGnCcB1YYMSbhwnEqsP1/yKx00gcrAU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kkxsAhoOhJyoJdsH0vynHw3jejv2177lP4Ev2ax4vOsW/V2kt29sxXfOZOMEH5TEqgXl1bEP78s3PSOKJGcCT2DMO7AHyWBVyFr9sK2cgV8H/IgBZ3Q64/32AapHTGxAb/vlaN7HWPOIG6paSNilNI7QhdH0StLlMJfd916hQAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iraPFeRH; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6093f75fc81so5456957b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709161150; x=1709765950; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bwcBf6VTN7kSbKJ8Vs5Gx4XAVHKYHpXJ1cRKxEXuKj0=;
        b=iraPFeRHZCaDwmnufgGQMKC41vAlkljMD5aEZMbtocoBv0Oqc0xIVZjm4gowenrOfq
         UzXVcdXnqwL/MncaNbLZTbeklu5dDLf80smf8YI6udNkK/LG7Uxdoh7ynA7lJBlidBnu
         IhVn8pBl4pl4yhu363XqrKONLUcoJi1/NeH76ss8vUTbg4W/BZow+iWHVb0BbpNsEqix
         Ulk2PixO5GLdSdPSRWM++ew1HeQijNxc9sATkfKxMPhQRuUNIHFu26+6kYOIhE+Etswk
         vk4NdG0Fb9eNmywN2J9sDHQAqvnu7oMJ6ws/18WI1+A1mj5VwVK0pxIh+aR8M6jgaLVT
         aXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709161150; x=1709765950;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bwcBf6VTN7kSbKJ8Vs5Gx4XAVHKYHpXJ1cRKxEXuKj0=;
        b=pLXInKVXJS2Jf5u+nl2XZ8wu8Hs9OGGoLR258CvvZ2lo7c/U9ifWilQVVpPPsqkbVN
         bmhcP067m34bRJ0PIDyLkynMaOVt0HBfN8hk55uCybS6B6Ba79gphXQVWxwD7zBJ68Ma
         HEbSdJntgx6Qhe9YAK9QdIAG4WYTQqFKW7jW/+iuphQh4YGo+8TFR6lVbLxYmnonjspS
         +4u921RMLUJ4E/s5ljJHNqGfEDwT4LrQG2unSXC1Cpwt78v4d6ujIcw3ZZWYFNUOsGhJ
         CF8ovDFgxwmVQ/fwI67/qXKWPn5tjiCboB1SDmQF4AamtCmuY7MQYpF+pBbUmpOG2ucK
         DuOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH55A+4l9gdHr1KyVh2axGVQIhRGgPtWKbSlq0NsUPUXo7KaetEZTu/csR+pNJGIeCh1I4bbk84UkMFwMJa9LW3qa00uU67DjsO1/y
X-Gm-Message-State: AOJu0Yz5GE1OH9X5Z+OoxptbF0dV8rs+Cf7HRMV9xmrQ8HBCrzpV9ko2
	9jqiW91TVhZfaMb33siWGwZkTsoFucSHap8zswNCQE1wrCEsK+Okiu9P0SB2P4X14hGrUEqavpT
	cii+C622w4C0KVG1HABQtYA==
X-Google-Smtp-Source: AGHT+IGJSn1iIdhaFuCaAXBuR+oBBkpFnJulYbWTNsBkTp28hN6EtDT8YP5YgukKH/p/y7d8tFeKIDow5NNW+rcMBw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:3744:b0:608:ce23:638c with
 SMTP id fw4-20020a05690c374400b00608ce23638cmr117431ywb.4.1709161150059; Wed,
 28 Feb 2024 14:59:10 -0800 (PST)
Date: Wed, 28 Feb 2024 22:59:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALS632UC/43NTQrCQAyG4avIrI3Mj2J15T2kiM1M24DtlKSMl
 tK7OxbduwpvFt8zKwlMQdR5MysOiYRin8NuNwrbe98EIJ9bWW332loLMnKPwwSeKQUWEBSCbiD
 X8ffc6icgmMo47Q+m8ogqrw0canqt0rXM3ZKMkacVTubz/RnubyMZ0HBC74rC1vqo9aWJsXmEH cZOlcuyvAHoIOgv3wAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709161149; l=1822;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Fzxw3B7E/9cimGnCcB1YYMSbhwnEqsP1/yKx00gcrAU=; b=+xX1p9F5acPGhLQnOC0ZvGYgBGCYCRPUuIWu0ALKmc/Irx/7euLxtpBb0vFctrt3pFBFzOk26
 qMxJqYSZlYPB+nRKJdxH1TPJ7iPps8Q9EjX7l5U6axtxrVXXb6PK2aN
X-Mailer: b4 0.12.3
Message-ID: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-0-dacebd3fcfa0@google.com>
Subject: [PATCH v2 0/7] scsi: replace deprecated strncpy
From: Justin Stitt <justinstitt@google.com>
To: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, Kashyap Desai <kashyap.desai@broadcom.com>, 
	Sumit Saxena <sumit.saxena@broadcom.com>, Sreekanth Reddy <sreekanth.reddy@broadcom.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, Ariel Elior <aelior@marvell.com>, 
	Manish Chopra <manishc@marvell.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Saurav Kashyap <skashyap@marvell.com>, Javed Hasan <jhasan@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, Nilesh Javali <njavali@marvell.com>, 
	Manish Rangankar <mrangankar@marvell.com>, Don Brace <don.brace@microchip.com>
Cc: mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, MPT-FusionLinux.pdl@broadcom.com, 
	netdev@vger.kernel.org, storagedev@microchip.com, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

This series contains multiple replacements of strncpy throughout the
scsi subsystem.

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces. The details of each replacement will be in their respective
patch.

---
Changes in v2:
- for (1/7): change strscpy to simple const char* assignments
- Link to v1: https://lore.kernel.org/r/20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com

---
Justin Stitt (7):
      scsi: mpi3mr: replace deprecated strncpy with assignments
      scsi: mpt3sas: replace deprecated strncpy with strscpy
      scsi: qedf: replace deprecated strncpy with strscpy
      scsi: qla4xxx: replace deprecated strncpy with strscpy
      scsi: devinfo: replace strncpy and manual pad
      scsi: smartpqi: replace deprecated strncpy with strscpy
      scsi: wd33c93: replace deprecated strncpy with strscpy

 drivers/net/ethernet/qlogic/qed/qed_main.c |  2 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c            | 10 +++++-----
 drivers/scsi/mpt3sas/mpt3sas_base.c        |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c   | 18 +++++++++---------
 drivers/scsi/qedf/qedf_main.c              |  2 +-
 drivers/scsi/qla4xxx/ql4_mbx.c             | 17 ++++++++++++-----
 drivers/scsi/qla4xxx/ql4_os.c              | 14 +++++++-------
 drivers/scsi/scsi_devinfo.c                | 18 ++++++++++--------
 drivers/scsi/smartpqi/smartpqi_init.c      |  5 ++---
 drivers/scsi/wd33c93.c                     |  4 +---
 10 files changed, 49 insertions(+), 43 deletions(-)
---
base-commit: 39133352cbed6626956d38ed72012f49b0421e7b
change-id: 20240222-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-1b130d51bdcc

Best regards,
--
Justin Stitt <justinstitt@google.com>


