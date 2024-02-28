Return-Path: <linux-kernel+bounces-85820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFFD86BBC6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CEBC1F29380
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4105A161B7B;
	Wed, 28 Feb 2024 22:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Yy3oKL8p"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B056A14DFE0
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161159; cv=none; b=WUbHdptM1PVwrlKq8UN05aHyPcn4jBdL2Xaw3RhDBmZp5ChYychSvZTIwDj/WOPNkLmgrKxG5QuYqzasT3LREj0ZBYJapNTfv+RnqwnRl2itfexXwnlTdxmDIYQPipjBnUeNCIbtE2OC7MOnBSS8vzTY2TbXfjKMbnmTojrWYKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161159; c=relaxed/simple;
	bh=Lddxx/7+zTRDdPfPCQR3m48LNdlBsdHAfzX1ldXLmxg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OTls7dd2bI9zNCyMCH/+UPU/YeJlDpkOgXi1gAyX/H4bnLUxddEbfivnyjtLooi+b4Y+xZhGpTLLF0G+cN0lN86c3X7MXiqeQfzN1Gk8SI0Ikjb06DQAUaH7vOyiQ32M00P86B7HbFZ2FIpPOFj3kpll2/6YYWOht72C3pXHqWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yy3oKL8p; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608852fc324so4360207b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709161156; x=1709765956; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AEPqDrb3kuqBi4wlFiHmXpXFNsJMzopZPuYDXQBwtp8=;
        b=Yy3oKL8piYhFHPFq+2GugB5MRoqsGwybvABd8XdoQflltcrnx26GGxSAUj8Izbt1pJ
         bbClVAZJ8jx5fUkby51sufkjIlDVXNokgCtAtH6EaNNAd4KntkDzQLUTLDppCJA8piQB
         8PmnG6+CVD6TqR5p5NEoCTPs6YoMQKILiqg9LOY89cUjEe/glER1WydyBwpA8TK+nBlp
         RfASxJRdiEHq6Ja5r+PpKfQ/Rkua1zPAAvCZV1ir9Q08MSTCcDbwP5JRFnyPBRZqxaEt
         xWPLjP/ShFGvNwCOgRwkeVlZ0OxfIx5boFRHSQyNlBAVDb3gdxa6FPojbO1gAuRBfNPd
         q12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709161156; x=1709765956;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEPqDrb3kuqBi4wlFiHmXpXFNsJMzopZPuYDXQBwtp8=;
        b=iYs4R4JRNpmIwG5cvUTcMW+u7LM98a/R5xSTxoOvvt0uB/O5dGx7xbr3va6U602XPu
         kdLEcfA7WZVqKDtMlPrHfjj3zqvkVWGZOKn2l4U/58JtnMtWKW3Lcleg7XzPSi22jJ7R
         HSzUh9dHBNOcG3bVFjjoV6uBopOtFlDiaSwtGmp+KXs8zCNB6aAAF01nZbvizz8nG0AH
         xJcbhqnb6FJuNiGNKSyf0wyQGnHUN3ZFJg7A9Jnfj6lUsD0I3EWcH+y32ibt8g58bIiQ
         2hhGxaZPLrkUAor62vnhoAlRxJtxa19Hwp8GdyLHISkpz4sJrrhLocTlm7qokbd6avay
         CHFg==
X-Forwarded-Encrypted: i=1; AJvYcCVZGSmKGGm9whMRAFfBvVgNRTEbz/YrUe3sejmwdpNXjCuXNjRKmWrHyGl1qD6wqMPrBGteFilemb4isqWkDdMBjy5QD709VucLosT0
X-Gm-Message-State: AOJu0YyI/M9xnJsd2lCgbzSY1gxSW+8ETedRh9UjyFWzcNpNvkwuPJTZ
	wcSoBGFnvJQfOr2d7FvKvEkABNQI69zHr6RH9XVfogz+gokor92Os2I7pxul5fVz+K4xVjFszpj
	v+9MOvdpDXs/CXnqEdhkfxA==
X-Google-Smtp-Source: AGHT+IH+AYAEjmtd2HEeqQ8tauvpcfTSBaCfiTSyn0oA8Q1wOY4uNUBXxv4dwpdfs73rhiHAaOwNYfrscLpmjQUwhA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:7947:0:b0:609:3c14:b700 with SMTP
 id u68-20020a817947000000b006093c14b700mr99395ywc.5.1709161155734; Wed, 28
 Feb 2024 14:59:15 -0800 (PST)
Date: Wed, 28 Feb 2024 22:59:05 +0000
In-Reply-To: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-0-dacebd3fcfa0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-0-dacebd3fcfa0@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709161149; l=1839;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Lddxx/7+zTRDdPfPCQR3m48LNdlBsdHAfzX1ldXLmxg=; b=4RsSr+qnPfhdDTcGycu17RdkJmrh4DmmUkOdoQw9koC5UujHTwsgQh/Uhx6IjYaCNsiCcGPX6
 S20zo9iGEmOC/bLHTndhTRmKqABL888rxYhO1DTZe+hS+pjh43d3Vza
X-Mailer: b4 0.12.3
Message-ID: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-5-dacebd3fcfa0@google.com>
Subject: [PATCH v2 5/7] scsi: devinfo: replace strncpy and manual pad
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

Depending on the state of @compatible, we are going to do different
things with our @to buffer.

When @compatible is true we want a NUL-term'd and NUL-padded destination
buffer. Conversely, if @compatible is false we just want a space-padded
destination buffer (no NUL-term required).

As per:
/**
 * scsi_dev_info_list_add_keyed - add one dev_info list entry.
 * @compatible: if true, null terminate short strings.  Otherwise space pad.
..

Note that we can't easily use `strtomem_pad` here as the size of the @to
buffer is unknown to the compiler due to indirection layers.

Now, the intent of the code is more clear (I probably didn't even need
to add a comment -- that's how clear it is).

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/scsi/scsi_devinfo.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index 3fcaf10a9dfe..2d3dbce25629 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -293,14 +293,16 @@ static void scsi_strcpy_devinfo(char *name, char *to, size_t to_length,
 	size_t from_length;
 
 	from_length = strlen(from);
-	/* This zero-pads the destination */
-	strncpy(to, from, to_length);
-	if (from_length < to_length && !compatible) {
-		/*
-		 * space pad the string if it is short.
-		 */
-		memset(&to[from_length], ' ', to_length - from_length);
-	}
+
+	/*
+	 * null pad and null terminate if compatible
+	 * otherwise space pad
+	 */
+	if (compatible)
+		strscpy_pad(to, from, to_length);
+	else
+		memcpy_and_pad(to, to_length, from, from_length, ' ');
+
 	if (from_length > to_length)
 		 printk(KERN_WARNING "%s: %s string '%s' is too long\n",
 			__func__, name, from);

-- 
2.44.0.rc1.240.g4c46232300-goog


