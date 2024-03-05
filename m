Return-Path: <linux-kernel+bounces-93107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63C0872B1E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2D91F25C0D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EF812F591;
	Tue,  5 Mar 2024 23:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YxAaMzU7"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B1012DD85
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 23:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681685; cv=none; b=WVjhIY0UzE6nG4WtbLnqiyjmvOc8Aj1zHypRf/nHBezePPkkFN/exIXKAqVDFt2ArumykpkrZOuS23Oi5pRSxXt/ldRHIPR9clfvv5m2hyskkVGDzfPKEPgSv4NBxGHgR9jvLK02xUOtuMe9yKaUM+DEjjtvaTi2d9KC/gB19Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681685; c=relaxed/simple;
	bh=mjGXUPscyzpVG3/YOto1FjCGkFQQDTE0gGonriHY98w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nMf3RQOZ6Q8yH7ASv+3rEH7eawNflxc237maXsbHXvs/4Z5PvarNXbDSTkAOj8fW/bHfbAYtTEEscmZyrTAtrjdnULAVXlLl23mhLtlJeVU8h6bfYJBQDpvhvXN5g40ZnwvoTQPLlypEqdhzpQqQTqqJP2oMN3RrFwoqdKd4rJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YxAaMzU7; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso9555904276.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 15:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709681683; x=1710286483; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1gASbbpl9VKufW/p1eS9vopJ2flHWgODS8RPQYfJDec=;
        b=YxAaMzU7fzDLbVZY/bUoeW8wicv1vVQiDOMmwKSo6tazFLD/BETZZ5MLU6MMFzOtXE
         a/YoMWENXrastmFTbcArIzkRlbGZVuKVC3zuDig2S/nyFUPt3wUqKLSBEzl31pf8Kd+k
         ZBT+tJEmk97NVYt7Wl1lUya4t6bF2pDvMdZEC9ZFHUlJDMeiUh82UffLrcLqrFgTjPWu
         mnsmDq0qyJ1UfXMyIY+TAJ+ITdlnj2MoHV08YfpPT+oUf1vxBh0f9u45VCrTIwA+oxqz
         F0yHsykELtc9+yBYvJ3tRK67n94F802GwU44Mkzm4epExbyeaBDMclqvqfK2tjml9AFv
         E2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709681683; x=1710286483;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gASbbpl9VKufW/p1eS9vopJ2flHWgODS8RPQYfJDec=;
        b=NXciPl3i6Edu36B1dv8EKV1L1V0f6YALzr0GHBBGT9RjjSw9h9d4KtPm2PKgFVSY7T
         90nWvQsbhHCvGJE6ZdHvoH66is5b6Zn3JlKYKKF6HNF+MOY4EHLz3979x7BVV6vmCc4c
         pMm1zs7oWzTSR1SjlZxcr7EbjOI0feAbVPhT4zsBNttkNaDSsAx8T9Ydub1T5NZejXt9
         AixzUWIb/qBQvqHB6rdaQMRSneRQCZCYdM+W0imkv8cK5ToTzP9gZ9qLoP9r+cmcr6bR
         ri1x2Zc91cci/cNgd0nEPfs7WWUJUJVifp/l2r6ylVsBZwcSXzcfXL83c16Lz/J9Nh7Q
         acqw==
X-Forwarded-Encrypted: i=1; AJvYcCVHSztl8umv2oM9ZVS8QYemLZqAmcjFT2lOeh2SAkXi2AnTtyQh4bCI2yK5/qcnCDz+jLPd9UNmcNCSpLGFARHV7esSqrlGEXRG6e3j
X-Gm-Message-State: AOJu0YzuUD8OvRYK8cjJ1ltoti4/kMqM2NBKD1TeKSq30JIr2LxZPvU3
	ZtB5YnAuCx/IOy1Db44hrAADlH2IXSpQ8MD1gIf7gDxc199BDrkWh0Gkr7nafDw6eOoqFLmf4wh
	mE/MNF+REBLuMqUXifYFFBg==
X-Google-Smtp-Source: AGHT+IGJFBT6ZMDA0dEeZzTBzmKy73noTis25Zy8vUrUgJBFhRjua/3NOgVhMlB7JHdd5gSR/MoWCpWVy9rzF1YapA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:dbc9:0:b0:dc6:dfc6:4207 with SMTP
 id g192-20020a25dbc9000000b00dc6dfc64207mr3308643ybf.10.1709681683257; Tue,
 05 Mar 2024 15:34:43 -0800 (PST)
Date: Tue, 05 Mar 2024 23:34:37 +0000
In-Reply-To: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-0-5b78a13ff984@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-0-5b78a13ff984@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709681680; l=2775;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=mjGXUPscyzpVG3/YOto1FjCGkFQQDTE0gGonriHY98w=; b=TMLnCvjFVMOwkdWXvxNNyfUCUsW2BsfpzmfuS/mjEg68OQGl6XD54ss0HA47iLLTV8RsqqduT
 qpps1Q+twCxDAMKk4tqCF9naIPIg6ZUUIkn8VVDTVqEiwCve9jn4uml
X-Mailer: b4 0.12.3
Message-ID: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-2-5b78a13ff984@google.com>
Subject: [PATCH v3 2/7] scsi: mpt3sas: replace deprecated strncpy with strscpy
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

The replacement in mpt3sas_base.c is a trivial one because desc is
already zero-initialized meaning there is no functional change here.

For mpt3sas_transport.c, we know edev is zero-initialized as well while
manufacture_reply comes from dma_alloc_coherent(). No functional change
here either.

For all cases, use the more idiomatic strscpy() usage of:
strscpy(dest, src, sizeof(dest))

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c      |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 8761bc58d965..c1e421cb8533 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -4774,7 +4774,7 @@ _base_display_ioc_capabilities(struct MPT3SAS_ADAPTER *ioc)
 	char desc[17] = {0};
 	u32 iounit_pg1_flags;
 
-	strncpy(desc, ioc->manu_pg0.ChipName, 16);
+	strscpy(desc, ioc->manu_pg0.ChipName, sizeof(desc));
 	ioc_info(ioc, "%s: FWVersion(%02d.%02d.%02d.%02d), ChipRevision(0x%02x)\n",
 		 desc,
 		 (ioc->facts.FWVersion.Word & 0xFF000000) >> 24,
diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index 421ea511b664..76f9a9177198 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -458,17 +458,17 @@ _transport_expander_report_manufacture(struct MPT3SAS_ADAPTER *ioc,
 			goto out;
 
 		manufacture_reply = data_out + sizeof(struct rep_manu_request);
-		strncpy(edev->vendor_id, manufacture_reply->vendor_id,
-		     SAS_EXPANDER_VENDOR_ID_LEN);
-		strncpy(edev->product_id, manufacture_reply->product_id,
-		     SAS_EXPANDER_PRODUCT_ID_LEN);
-		strncpy(edev->product_rev, manufacture_reply->product_rev,
-		     SAS_EXPANDER_PRODUCT_REV_LEN);
+		strscpy(edev->vendor_id, manufacture_reply->vendor_id,
+			sizeof(edev->vendor_id));
+		strscpy(edev->product_id, manufacture_reply->product_id,
+			sizeof(edev->product_id));
+		strscpy(edev->product_rev, manufacture_reply->product_rev,
+			sizeof(edev->product_rev));
 		edev->level = manufacture_reply->sas_format & 1;
 		if (edev->level) {
-			strncpy(edev->component_vendor_id,
-			    manufacture_reply->component_vendor_id,
-			     SAS_EXPANDER_COMPONENT_VENDOR_ID_LEN);
+			strscpy(edev->component_vendor_id,
+				manufacture_reply->component_vendor_id,
+				sizeof(edev->component_vendor_id));
 			tmp = (u8 *)&manufacture_reply->component_id;
 			edev->component_id = tmp[0] << 8 | tmp[1];
 			edev->component_revision_id =

-- 
2.44.0.278.ge034bb2e1d-goog


