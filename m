Return-Path: <linux-kernel+bounces-79252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8045861F98
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CAF41F2432F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE5714F986;
	Fri, 23 Feb 2024 22:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="VICrc6At"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E5E14CACB
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727000; cv=none; b=gJ2mS5/oLLXNg0Yx/Wr+qgX36lDyRkT6irV32OJgF2PsMAQPucSDUIgMa5gezEuHbocEcIgrE3c6vNZLWwtIc6dYu4iB1ZruZSeoUcrUNwY1RS+QGqFbIMIZ6HhvQ0tz6sMLR0a6DHfo57DzthhBDTb8RA7N2Dwz78m4O40gNd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727000; c=relaxed/simple;
	bh=9560acJIy7ilDx1QzS1StF1QMg0Kq73ghv/oyVS13Qc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fNowmdZkplrWvrqLCdUDezAodvS/rqer5Fp8BtcSMuIqSCIUH4M58pjtZt/T3oRLPVTuT/TAYMK0+9ektF15Q2DEhSg2XTPCZo4J/tNmO+ZIGr/xc1AMhvSlKatgRuQBpoHnDjMO/F9yUCeR70hinp48B3CGLRkUtzk6MgCbheM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VICrc6At; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7c0088dc494so96113239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708726997; x=1709331797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=czV3hjPDZ+WaGRN3o07ieRDipwYvLnthyFOF9HxLgvA=;
        b=VICrc6AtEDTjQxZKaHeBljszCR35alpTskumo4N3kjNEgmfVr9PbLgZicRhibWPSAt
         5jXv0KfEAFov/yhpNS00hT1fmlGE4RSwKN/gzY3y72ca2UrNF7fIfWQB8AX1zGc2PrwW
         3JsPDtPuSj4tHVXkPecVt3UgybzS2omxwpZZuAY1SHEXHOQJvIMpqdM49+GTtcevPybr
         +EJL2s3fQ5r5LpaTQ2ZM1gxTgPLX2bouHg6mTgLqjGYa8jTQZZRrN4fF+NGv4pc/ldMD
         gLbCOAHp7+z9dIbRZ6bVuOdizfKKG71qYyLI7NvZBPSUFj3R3YbDIXkuVeZhubgNKtqA
         AOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708726997; x=1709331797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czV3hjPDZ+WaGRN3o07ieRDipwYvLnthyFOF9HxLgvA=;
        b=R0TAKXQwFLT7K0sdiBNr0KRWvfOX9mrj3z3iKX/JxCrlFqqHSz5aFx6hJk1+I/9m+0
         tOwb5xidplyfRAM8xTgB0msfADTBcXCvOha3XaMa4tGHkcsQlpaoPzJWYWZ5mR5SDT0q
         W8nIjLlv2ehwd5Pttu5WVMOynVlSrhkmX2nAXACrsiN0ZbFa20hmkAtCR5RBLYfA5ylx
         Fj4kux6n+MSlqqrJ7VVDScTTeKyt9iMDkVKuHCDyX5LRRdPhCSd/xi6y+DNWVX+KF8Ar
         gatCf1KweeILsiyKDUYOmaKJ8I+cpGfuNMmee5xEY+S2tMO+tk9OyUr8gb8eaivzgJ5s
         Q9AA==
X-Forwarded-Encrypted: i=1; AJvYcCXB3ANKWz7l/TVnp+z0w7pm298Ns4NGABxgTMX3B7uYc5AbmuIXck8K0Y8E0nL0eAAs5J1IneY/b5fd+yFr81Box5gkOQ9PbwS65wfg
X-Gm-Message-State: AOJu0YzW5E19sm5mKszVnUWJ02vFGDQGFrAacvhEPaNVtUlLAaOYBLTf
	XadbLI0uKVPdbnxi2hhl5yG7L8TS9r+MuJ5liyT7dEx44UYxFG1uNAvbDGcNwowZ7S9QriejC4k
	lNgnL4vd6W1C7iAan6s1Jpg==
X-Google-Smtp-Source: AGHT+IElqjzzne5BNIqhnkcUtA6nWavUz3w2rbpNTXjtK97/dsw2QwmyE74rvpS4+T0D2cnfj8mpCZOXkAqdOJHhRg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6638:62a4:b0:473:f943:24f0 with
 SMTP id fh36-20020a05663862a400b00473f94324f0mr52093jab.1.1708726996738; Fri,
 23 Feb 2024 14:23:16 -0800 (PST)
Date: Fri, 23 Feb 2024 22:23:08 +0000
In-Reply-To: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708726991; l=2289;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=9560acJIy7ilDx1QzS1StF1QMg0Kq73ghv/oyVS13Qc=; b=hqIGDXAVb+Q1HbrJj2lv2pqekNzNxAZYfLcLsSsVx2XaIZcVOsiYweO2RMpCkdyK2SKo+0MG5
 x5+lMM88Tf3DsEi32Cj7SabZ09D1iK3QVAlerCCDAnnUQSch6ituF78
X-Mailer: b4 0.12.3
Message-ID: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-3-9cd3882f0700@google.com>
Subject: [PATCH 3/7] scsi: qedf: replace deprecated strncpy with strscpy
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

We expect slowpath_params.name to be NUL-terminated based on its future
usage with other string APIs:

|	static int qed_slowpath_start(struct qed_dev *cdev,
|				      struct qed_slowpath_params *params)
..
|	strscpy(drv_version.name, params->name,
|		MCP_DRV_VER_STR_SIZE - 4);

Moreover, NUL-padding is not necessary as the only use for this slowpath
name parameter is to copy into the drv_version.name field.

Also, let's prefer using strscpy(src, dest, sizeof(src)) in two
instances (one of which is outside of the scsi system but it is trivial
and related to this patch).

We can see the drv_version.name size here:
|	struct qed_mcp_drv_version {
|		u32	version;
|		u8	name[MCP_DRV_VER_STR_SIZE - 4];
|	};

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/net/ethernet/qlogic/qed/qed_main.c | 2 +-
 drivers/scsi/qedf/qedf_main.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index c278f8893042..d39e198fe8db 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -1351,7 +1351,7 @@ static int qed_slowpath_start(struct qed_dev *cdev,
 				      (params->drv_rev << 8) |
 				      (params->drv_eng);
 		strscpy(drv_version.name, params->name,
-			MCP_DRV_VER_STR_SIZE - 4);
+			sizeof(drv_version.name));
 		rc = qed_mcp_send_drv_version(hwfn, hwfn->p_main_ptt,
 					      &drv_version);
 		if (rc) {
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index a58353b7b4e8..fd12439cbaab 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -3468,7 +3468,7 @@ static int __qedf_probe(struct pci_dev *pdev, int mode)
 	slowpath_params.drv_minor = QEDF_DRIVER_MINOR_VER;
 	slowpath_params.drv_rev = QEDF_DRIVER_REV_VER;
 	slowpath_params.drv_eng = QEDF_DRIVER_ENG_VER;
-	strncpy(slowpath_params.name, "qedf", QED_DRV_VER_STR_SIZE);
+	strscpy(slowpath_params.name, "qedf", sizeof(slowpath_params.name));
 	rc = qed_ops->common->slowpath_start(qedf->cdev, &slowpath_params);
 	if (rc) {
 		QEDF_ERR(&(qedf->dbg_ctx), "Cannot start slowpath.\n");

-- 
2.44.0.rc0.258.g7320e95886-goog


