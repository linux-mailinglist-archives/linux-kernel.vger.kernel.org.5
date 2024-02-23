Return-Path: <linux-kernel+bounces-79250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A93D861F90
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF341C231C2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E2E14DFEC;
	Fri, 23 Feb 2024 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HMnXYrza"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDD114CAC8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708726995; cv=none; b=jREu3uHfFbpjY2c0QEkroteeJq+/KSJDswJlSuiA8mmfTvKjyv/SOYQZcSnrJS+PnoVKctcrUhFwPO+iF9VIP6M+00LHVYGSzTKpIA9Qi8BGo//UY58i5OpqZiXswrSJ1mK0+8Y15Bv6SlFztovshIIe45JyPQi5lav909tdwUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708726995; c=relaxed/simple;
	bh=atw28RqPC1GSaqT/dfgmT16ohbY/e8gGhibx8N7VvH8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kLoTz81sZJlyirjQdw8VgpJmrcXShRd06leNZ7RALwNPWqvkD0V8DQoSoSIcbvgeLdSpK5HDfwrAK6nbV0FuudwBlbP+JJnN6wDe/woGzktua3RKhqLv9MtlR1SXuCMkuqJZEayE1yVzF3H9Beh6RpFCTjYEnlVzD7mG0QQrCc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HMnXYrza; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7bad62322f0so129513439f.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708726993; x=1709331793; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DSqA4FNr+Yd3pWgWiaXUbZeiapBDt2cwHD2dL9aqpno=;
        b=HMnXYrza7hdCWxoOUTuuhQ+EPJPfVtOKayFMEwzRR40+hkAuDlXWsoanL+cn5rHElq
         OV+ASA600QgY0omymT9XI0naiPL5pNBFZSQM3Ml0Dzyj71nO7KNGdnGzGIp9QysVNRcE
         eGWyvdT5H3Gf/L+vNF1saHfFz4Oaf+HIoA/dIRa3ahkiB9RXssiJ2s+2A+jqz2w89DQk
         GeB2jXyZUKHE9nreDRGx69RrCYiY8rxffm8E94ZR0LhvkE81Z2FEHLeLAytZUKCe61ZR
         Dj1aR/aCTKrlmJgVj3Qs647fh+I22DMifW16LbP41UlTxsXBy+Oubp8kavxPNb3FYDwt
         e9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708726993; x=1709331793;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSqA4FNr+Yd3pWgWiaXUbZeiapBDt2cwHD2dL9aqpno=;
        b=fAqOe8HuYU0U8L+R23y6x1SFOzo2FrsiBmbIYSE9Vywd2T7RccBhbRJC73Hg1G1lMP
         i8AmylQrNtUstR8qrWC3xiMz7tEgjHX8+oIgDfv2DqvYGxUFb9rbQyzu4Y2oG1kAsCG+
         A5d5C20En8qm/6iadAvm2kRrwxiBmjRP3v9tj1hjNMyZPWnCECDfowJiYbydMhkgzDeJ
         CI0M4kpHzR5qxGL3rhy8OqiJrOoK2fEnCIgmup7gMNYbzwrsahJpBs9hwZssBF5SGrdN
         ofBCkdlaZEU8SlTwql7nb12Cy0UwSfSATnEzbREMGz0VcuCqdw5DhB4Bl9SvVdlf3jwP
         Babg==
X-Forwarded-Encrypted: i=1; AJvYcCVWeoyoWc7UyIekpo31lXH6gCNRonj1KFN9lbLIAhoVkntzCsJMfIKcF/Ztm697Lz7aYmAZ9sEfIEOaRwkIizANwFLG2wEBUMzLWMg1
X-Gm-Message-State: AOJu0Yy+M6GJV2IA/NL8VyGYlU1Q/7AY4R01BGePPRz8sPwJwJwjxMjD
	cCTzsn3iRMRijd7XmeyQbftD5Lk6KKAU2jqWhU7g3+N0vioUVYSRjDEfUSS5zUEXKVgOK4ItbUp
	7GSoPbsZLrj7oOhK8ahitew==
X-Google-Smtp-Source: AGHT+IE9+d0DRwTaeVewC0YykYc/HcpVSbDdP6/Eix18NC4jUXTr9YGVPfn/8i6i1Pk/1PXYSNhu/wipCxOavTAnOA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6638:13d5:b0:474:64f0:7943 with
 SMTP id i21-20020a05663813d500b0047464f07943mr49078jaj.4.1708726993338; Fri,
 23 Feb 2024 14:23:13 -0800 (PST)
Date: Fri, 23 Feb 2024 22:23:06 +0000
In-Reply-To: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708726990; l=1723;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=atw28RqPC1GSaqT/dfgmT16ohbY/e8gGhibx8N7VvH8=; b=Zvl4/th/GfAIwNdwiIACuAJKgQj0NY3dOqOorRPnpe6UqpqYi8UI5Uf+3a555kNtR3f7/JOik
 kCs0S6g0ulQBscaFHM5dfq7WwUlqC7LU6SbX2NPjr4u4+A/pWw2bD8G
X-Mailer: b4 0.12.3
Message-ID: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-1-9cd3882f0700@google.com>
Subject: [PATCH 1/7] scsi: mpi3mr: replace deprecated strncpy with strscpy
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

Really, there's no bug with the current code. Let's just ditch strncpy()
all together.

Since strscpy() will not NUL-pad the destination buffer let's
NUL-initialize @personality; just like the others.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 528f19f782f2..c3e55eedfa5e 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -3685,20 +3685,20 @@ static void
 mpi3mr_print_ioc_info(struct mpi3mr_ioc *mrioc)
 {
 	int i = 0, bytes_written = 0;
-	char personality[16];
+	char personality[16] = {0};
 	char protocol[50] = {0};
 	char capabilities[100] = {0};
 	struct mpi3mr_compimg_ver *fwver = &mrioc->facts.fw_ver;
 
 	switch (mrioc->facts.personality) {
 	case MPI3_IOCFACTS_FLAGS_PERSONALITY_EHBA:
-		strncpy(personality, "Enhanced HBA", sizeof(personality));
+		strscpy(personality, "Enhanced HBA", sizeof(personality));
 		break;
 	case MPI3_IOCFACTS_FLAGS_PERSONALITY_RAID_DDR:
-		strncpy(personality, "RAID", sizeof(personality));
+		strscpy(personality, "RAID", sizeof(personality));
 		break;
 	default:
-		strncpy(personality, "Unknown", sizeof(personality));
+		strscpy(personality, "Unknown", sizeof(personality));
 		break;
 	}
 

-- 
2.44.0.rc0.258.g7320e95886-goog


