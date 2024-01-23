Return-Path: <linux-kernel+bounces-36131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 730D3839C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2324E285CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD36D4F211;
	Tue, 23 Jan 2024 22:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NU70CkKx"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA604F203
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706048691; cv=none; b=VI+H1cGN3ABUXj8TQbxRluLWh3leSFwHhfCP7DU6ITYuYr1XDsyOPiUzDzr+iqCFn5OQ//UUDq6a9vjuqFNbO0W+RUICQlLgSUZmvBb+MxjEvoInxWNOm3eGhdzTKIy+SBEuvlK02KLoMt1oHXd7LJVeKa96M717nwUrOIBvLvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706048691; c=relaxed/simple;
	bh=5YYFDZ+xiElaGnGPhbxpqpjoZIWsYsSg9bPLddTdmS4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=LYMreRBh3B4SHxSakkoyaaF3iMvHC/9WwkLE++eZkKd3lDiCycb/QuPANZEWKRrVQkazoetDJEBuEdCch2Y92ldffJD+gBfNH2i6jquQtyG6dXhbjRnIhu5V/rdJp/bdZ7X9ZToDWl1mDrYPOMdW0i0j/FHHYdQuY1ISlC64imY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NU70CkKx; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6dd7e6995c5so179754b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706048688; x=1706653488; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RZfatfnoDsLB5epaAMogBycqq4FCqlGmgqzUhE1mFQ=;
        b=NU70CkKxIEYY1bCIuWFxGAYOmZzdBqaFCxfaWqH2rghUF33F9S8kRbPPCxf0+S0KJu
         og3cFydKxQ59iakO3O979htF5fdFXg29lcYXrLEcBlt03EQlNbmSGtzHCG63s1IYbsZr
         bVIttCYTFy6v1iO6yUFKaD4YohxR3288HTmcWufau2YQsno+9MSYKvrjp32thOMEVeoL
         Pqcu9WtQWSv5G6LmZM5q2kuTiqpBNu2wlCAsILefuLJGENXdWq2Vcdtx8iInGDZJa422
         92l35UjZtQVnu4bOYRQepeYVptzwDBooVPKlca1dI0PZbDZe/o8kXzyaWxw06NW6hrqm
         ywKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706048688; x=1706653488;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7RZfatfnoDsLB5epaAMogBycqq4FCqlGmgqzUhE1mFQ=;
        b=AP99Dsqnvdnzm+YyT/VnhzMSo5XsXm8HZbeAM6ZQ4GoIT64eFt9qn2+UH37KVdNaA2
         61VHB1cYI2y72jl2YNlOZQtdPqhcCCqtZhS2RkZP4swVTXt5i/fpTvKMPRFLLkemr/Eg
         yedvog1gOV6kgdj7G7StkSjxwGwy18yb8RGdH5MaH7jML8H1oqXnXfNd3SISCe/AScTI
         jlZKpxx5AOVoxvf3oC6/bRg3CC7m6hP8ijFekBn9Fos5GBV+r6nZ64yr3znT95GtyDND
         +vHSIZv17EEDeiJt2cIM/1iT1i7qm1SV1ietRwsw9YegbB944yaQH3xu+vZeVQaNE8TC
         mo5g==
X-Gm-Message-State: AOJu0YyIKVmjZNTQlwvQUEWFiy0ZG69wB7YzWA5fru5Mm9QVMWEYKNUp
	HU1YPdZh9HKZcPn+KadQ2Aj0g4TffsAhJ9H+v3gV2X82+uXRXYuLLP2X7p8MzelloHrgpZnlwo6
	0u38=
X-Google-Smtp-Source: AGHT+IHM2yfg8XpoA/FXW3Uu+cevk/6sOjZZCe3QgV4LKRd8bBY4QIOtYj8UFiOG0qIbxvalBIpIUQ==
X-Received: by 2002:a05:6a21:3994:b0:199:d591:9a5a with SMTP id ad20-20020a056a21399400b00199d5919a5amr512556pzc.4.1706048688528;
        Tue, 23 Jan 2024 14:24:48 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id x2-20020aa784c2000000b006dd82bf4c1esm1217126pfn.62.2024.01.23.14.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 14:24:47 -0800 (PST)
Message-ID: <544b31f7-6d4b-42f5-a544-1420501f081f@kernel.dk>
Date: Tue, 23 Jan 2024 15:24:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: LKML <linux-kernel@vger.kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] iov_iter: streamline iovec/bvec alignment iteration
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Rewrite the alignment checking iterators for iovec and bvec to be easier
to read, and also significantly more compact in terms of generated code.
This saves 270 bytes of text on x86-64 for me (with clang-18) and 224
bytes on arm64 (with gcc-13).

In profiles, also saves a bit of time as well for the same workload:

     0.81%     -0.18%  [kernel.vmlinux]  [k] iov_iter_aligned_bvec
     0.48%     -0.09%  [kernel.vmlinux]  [k] iov_iter_is_aligned

which is a nice side benefit as well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

v2: do the other half of the iterators too, as suggested by Keith.
    This further saves some text.

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index e0aa6b440ca5..15f5040709c3 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -714,12 +714,11 @@ EXPORT_SYMBOL(iov_iter_discard);
 static bool iov_iter_aligned_iovec(const struct iov_iter *i, unsigned addr_mask,
 				   unsigned len_mask)
 {
+	const struct iovec *iov = iter_iov(i);
 	size_t size = i->count;
 	size_t skip = i->iov_offset;
-	unsigned k;
 
-	for (k = 0; k < i->nr_segs; k++, skip = 0) {
-		const struct iovec *iov = iter_iov(i) + k;
+	do {
 		size_t len = iov->iov_len - skip;
 
 		if (len > size)
@@ -729,34 +728,36 @@ static bool iov_iter_aligned_iovec(const struct iov_iter *i, unsigned addr_mask,
 		if ((unsigned long)(iov->iov_base + skip) & addr_mask)
 			return false;
 
+		iov++;
 		size -= len;
-		if (!size)
-			break;
-	}
+		skip = 0;
+	} while (size);
+
 	return true;
 }
 
 static bool iov_iter_aligned_bvec(const struct iov_iter *i, unsigned addr_mask,
 				  unsigned len_mask)
 {
-	size_t size = i->count;
+	const struct bio_vec *bvec = i->bvec;
 	unsigned skip = i->iov_offset;
-	unsigned k;
+	size_t size = i->count;
 
-	for (k = 0; k < i->nr_segs; k++, skip = 0) {
-		size_t len = i->bvec[k].bv_len - skip;
+	do {
+		size_t len = bvec->bv_len;
 
 		if (len > size)
 			len = size;
 		if (len & len_mask)
 			return false;
-		if ((unsigned long)(i->bvec[k].bv_offset + skip) & addr_mask)
+		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
 			return false;
 
+		bvec++;
 		size -= len;
-		if (!size)
-			break;
-	}
+		skip = 0;
+	} while (size);
+
 	return true;
 }
 
@@ -800,13 +801,12 @@ EXPORT_SYMBOL_GPL(iov_iter_is_aligned);
 
 static unsigned long iov_iter_alignment_iovec(const struct iov_iter *i)
 {
+	const struct iovec *iov = iter_iov(i);
 	unsigned long res = 0;
 	size_t size = i->count;
 	size_t skip = i->iov_offset;
-	unsigned k;
 
-	for (k = 0; k < i->nr_segs; k++, skip = 0) {
-		const struct iovec *iov = iter_iov(i) + k;
+	do {
 		size_t len = iov->iov_len - skip;
 		if (len) {
 			res |= (unsigned long)iov->iov_base + skip;
@@ -814,30 +814,31 @@ static unsigned long iov_iter_alignment_iovec(const struct iov_iter *i)
 				len = size;
 			res |= len;
 			size -= len;
-			if (!size)
-				break;
 		}
-	}
+		iov++;
+		skip = 0;
+	} while (size);
 	return res;
 }
 
 static unsigned long iov_iter_alignment_bvec(const struct iov_iter *i)
 {
+	const struct bio_vec *bvec = i->bvec;
 	unsigned res = 0;
 	size_t size = i->count;
 	unsigned skip = i->iov_offset;
-	unsigned k;
 
-	for (k = 0; k < i->nr_segs; k++, skip = 0) {
-		size_t len = i->bvec[k].bv_len - skip;
-		res |= (unsigned long)i->bvec[k].bv_offset + skip;
+	do {
+		size_t len = bvec->bv_len - skip;
+		res |= (unsigned long)bvec->bv_offset + skip;
 		if (len > size)
 			len = size;
 		res |= len;
+		bvec++;
 		size -= len;
-		if (!size)
-			break;
-	}
+		skip = 0;
+	} while (size);
+
 	return res;
 }
 
-- 
Jens Axboe


