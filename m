Return-Path: <linux-kernel+bounces-79249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 468D5861F8E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0AAE1F23BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948E414DFC4;
	Fri, 23 Feb 2024 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hY1blRTU"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6C01493B4
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708726994; cv=none; b=Rv2Bh94BmTPA8yIuYi7Q0bz5XM7W2iR2/EaeUCCCe5iPTT20Aosfj3788CeDdwdcSBAgmO3LGqTh5vUE1sDQdoOx49c3ANfxdt4qhL0rARQ1ggw/oAJAkb4s1jNxiKbVH5ZVGKSyy6q9damN11qhe3q8u6nhzlp3hpxOzZyckJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708726994; c=relaxed/simple;
	bh=jZLUyLw+PYly8jkRw97FHtiAlxLeYw/ruqpi5XPfw0s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HHC/TRXnTpbAB0pDdxmFeAWiErn/iXuNcRJANT6GH4kS9keT8Q1XDgRLCsA3YzXxAJWOXo1mlVTeRnWxX/ruXq6OnqU0afiYeA+KzQOQmu1x0v6i1/l1pmH8hZJvCW3uaszsjOvRMOWyPHb1Jv82URnD18aS3feruoGDCFNqyxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hY1blRTU; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6083fbe9923so25905327b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708726992; x=1709331792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D+qlm5aO/aQ4uIkmSxxKlZZ/tyfKC6M+ie/SGRsUmdY=;
        b=hY1blRTUIu/7qOkJO+c+Mx8xrzFy8m3C4BfImk4ERUZLeBrmqReZ4BKI6Sd+j650CK
         pTuDfL+n/SWYEB3Qrps1id7GSCoIc/74zw5ziizUb9w6JcSFTQKsWVbEZG7gaXmPXgcl
         gxEfueKbdrdzKoQwOT4ndWRR0XV7vO39pquNcqo8fJEOe5TJM6juQsxChOf3sArCIVkH
         QC0JVFIQoLycFBQ6wXaAu8RrfX9mAy65gr6EKryWk2Ui2D4CPzTMu5YMb5LH3cY9FPFB
         ZSNLyJGsW6Gb8mo11uwCvQw51+UIi80x2QH8pT4TUMJZMdh01TFl0djdBidcm9P7/NdY
         J/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708726992; x=1709331792;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+qlm5aO/aQ4uIkmSxxKlZZ/tyfKC6M+ie/SGRsUmdY=;
        b=ifkZKaE56FlhL/Qg40hxuVPkHvDKfpXeNoubsNUemMZDLUGuxHaXWXg0tk3ojeH1/j
         Z5ypAh6thgrQrJE0PgoF+vKAUY7JoYyx0qY2mL93CwqwDjlQFng9xZBaMj73eKK/56tC
         AVZaJsuD22R9XXL4W8szHGqt/Mjisd675eAMqcA3yFhQ0GGJF6xH/RiasclWe4RR29lE
         RVc4zDBE68BeO1zj+WTOw1Qc8Qdtxgp9JrSJUsFE/KkkOrGuu6gL8yKGFJWLiOCrwOOu
         +Q1QgVLGQaYLOAjgV7LSen9CbeRaeExAS2BAVIHjaNwfrnN5fnUYVNrYnBNd/eVVho3X
         oOVw==
X-Forwarded-Encrypted: i=1; AJvYcCUlpzjGcHuhbTXoi3ktDQPXxaUCkgw3KcMUBXUXLvAmUtP8lvmYR5SKhZ3xMIYUfi6rdUMSw+ex2gIFs4LpCHz0Ly+bHBGfUCS6cskF
X-Gm-Message-State: AOJu0YyW126j5cQ8FJ7ECdl5y15epIQPVSEejdGVd080HJGx0zX4KHs3
	5VA9dM25NqPOFNAHCbyqx8sPA/0aL9Y8Kkxsk1BSIKCTGlugWI3ma9ZQ3O4TdF1xNr9j15JzjP3
	x5ILZUYDawuZjcqAsz/Hp/w==
X-Google-Smtp-Source: AGHT+IG0uQbPxc1yyNgunzayUFgBE0inCJgcThk//nbvp5YWKlRWOsmqTc7k8Sg+UNpvKbR9RzLmjRurmL8xIB+Cxw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:188a:b0:dcc:6065:2b3d with
 SMTP id cj10-20020a056902188a00b00dcc60652b3dmr305504ybb.8.1708726992262;
 Fri, 23 Feb 2024 14:23:12 -0800 (PST)
Date: Fri, 23 Feb 2024 22:23:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMka2WUC/y2NQQqDQAwAvyI5N7Ab9eJXpJSajTUHt0tSbIv49
 y7S0zCXmR1cTMVhaHYw2dT1mavESwO83PNDUFN1oEBdICL0l2UuX0ymm5ijsyuuRdvV/rjNb2S MU2xD6uOUmKHWismsn/M0Xo/jBwE0zgZ5AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708726990; l=1611;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=jZLUyLw+PYly8jkRw97FHtiAlxLeYw/ruqpi5XPfw0s=; b=wIzkR9ttslj+b0wOPreTc5A7WUjUtgLZ2xJXIkoRRFJsTFFrBDRhsGJXQELHXar8zcNXJPLEG
 QWJPhdh/60KA1FJbeNXbShCZBnrhP5rvNT8yLUyTqCnRH04Xdhxj2KG
X-Mailer: b4 0.12.3
Message-ID: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
Subject: [PATCH 0/7] scsi: replace deprecated strncpy
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
Justin Stitt (7):
      scsi: mpi3mr: replace deprecated strncpy with strscpy
      scsi: mpt3sas: replace deprecated strncpy with strscpy
      scsi: qedf: replace deprecated strncpy with strscpy
      scsi: qla4xxx: replace deprecated strncpy with strscpy
      scsi: devinfo: replace strncpy and manual pad
      scsi: smartpqi: replace deprecated strncpy with strscpy
      scsi: wd33c93: replace deprecated strncpy with strscpy

 drivers/net/ethernet/qlogic/qed/qed_main.c |  2 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c            |  8 ++++----
 drivers/scsi/mpt3sas/mpt3sas_base.c        |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c   | 18 +++++++++---------
 drivers/scsi/qedf/qedf_main.c              |  2 +-
 drivers/scsi/qla4xxx/ql4_mbx.c             | 17 ++++++++++++-----
 drivers/scsi/qla4xxx/ql4_os.c              | 14 +++++++-------
 drivers/scsi/scsi_devinfo.c                | 18 ++++++++++--------
 drivers/scsi/smartpqi/smartpqi_init.c      |  5 ++---
 drivers/scsi/wd33c93.c                     |  4 +---
 10 files changed, 48 insertions(+), 42 deletions(-)
---
base-commit: 39133352cbed6626956d38ed72012f49b0421e7b
change-id: 20240222-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-1b130d51bdcc

Best regards,
--
Justin Stitt <justinstitt@google.com>


