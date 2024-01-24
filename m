Return-Path: <linux-kernel+bounces-37205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C4983AC86
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F271C22840
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EDA7A729;
	Wed, 24 Jan 2024 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jlM8NqEj"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E2C77656
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706107801; cv=none; b=rAywnRrbB0YNlnxM4mJDKEyITa5ItTyzn234EtG39z15BwWjyzkN1iln+NxsNMuQKKwCKtI9dDZfLnAUmbEJ9QWhzDu7ypIGNuKsUsOxTGajuDyXdBOIGqf4Nx2XiAiPRcGwAr3ksmJ1jjQYYNTq8y+jJIC92glKhYlQNeFjid0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706107801; c=relaxed/simple;
	bh=cg2x3kiPaiLPeSSGJpnohOZYf+YIgP1iHarhGR64V6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmgj7dYZwRby5ZSNNm05CWZ6qajxeDNo6YZRZR0vYrcYYbFGT8mp2IaI2KS5TDtE/IPwvrKK9gaOVttN/mqVpqD10iIMnR6VURbyHSPFRUsIdJrpcaf+IWJp/aCJrfqwqLMfFRmq4sFIron3wK/YPPRfn8TG0n9wyUf9Tso2XXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jlM8NqEj; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so64630039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 06:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706107797; x=1706712597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mOYIlDrM1fPoCbXofl74IMyTSxnlXM/nUzwB8nUiQJs=;
        b=jlM8NqEjCa0YfpawTRszzutS1cZzsl0pDKOhAqbeMtfyKpQ8J/13Z4UTTmxFWpyznW
         AG+ltlP/NRtDR44as1unIPpnl7xJyGqHTKOEPMfGwI45kBQ9xJ6WqGMhmAp0G23FkT3H
         dKD/Z3Fy+xARYU+IZ5AUpMexbFnfCfO4cwUBPA87CszoSMI2m2Qm262fe01bShAHogtR
         GLnPhlLbg+P5YI3TVTWTU7Y9bs2N6iYLWB+s4B3TgnELpbihYiSnPr9Yl2e/+rUSKdkc
         x12Xh2OlIqpyUw7O9kOuQdfFtkoW0bR1X07OGG7SFuSlDtPqgJ4JahODbM8ShhZ0mM7k
         x9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706107797; x=1706712597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOYIlDrM1fPoCbXofl74IMyTSxnlXM/nUzwB8nUiQJs=;
        b=KFln1KSHP6/tlNEea/X3Bk6As4RsbDGyLQaLt5bEpdHIVU88s9nqGmzyb9j0iKsm2c
         YxMfOt2NuM4nltPbFz170u8g9oHy6R8+H7fHzTa7BJFdnOf2kmQzDZMlsea6sqqiQ95i
         srPhQo7ie24brBm5J+8JnoE+s8oIttxN8n/8gco1tACKZi/0qKpFQ0In8M7Nlx8FpemG
         D36KgOoIvTeYNa9C2xjKjuPstdzvKnkJFCXUVViC1BZTRt3CmnjBhMyfUaSQtSo4jxTf
         9iDQvdZ5I2V+7Sm7mFunOgMCYQL2RIAEpO5Jf+nRMz2ieqjASgAh6z1j/BeMPBMImJh5
         3yLw==
X-Gm-Message-State: AOJu0YyItbW+BVCHV96oZoM3+F5fPaLn+6Mik0qWUBy1vZ9WG2aSXr1v
	ZzCzz2NKxlanjvy80KNytut3lmw6iyUuirXey72qqL/AHNvvkxOwKFLkCuoHdunG1+pq+9ieXza
	5J2I=
X-Google-Smtp-Source: AGHT+IHFS0HF1xPNeZIJlxWyOL4exNyi+jE+ZN5lIbXvX5t4yXCqm9Tj6wshMgaexNmur12rhlOCvg==
X-Received: by 2002:a5d:8c8f:0:b0:7be:edbc:629f with SMTP id g15-20020a5d8c8f000000b007beedbc629fmr2844632ion.0.1706107796882;
        Wed, 24 Jan 2024 06:49:56 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id et24-20020a0566382a1800b0046e509dd7a1sm4038191jab.118.2024.01.24.06.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 06:49:56 -0800 (PST)
Message-ID: <229ccad8-c8e5-46d5-8587-2d64182b5d68@kernel.dk>
Date: Wed, 24 Jan 2024 07:49:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iov_iter: streamline iovec/bvec alignment iteration
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
References: <bd2f28ab-78cf-4ae0-a62a-d23a94fb3839@kernel.dk>
 <9b43b9f3a32642e5a6388f3b1c8b114d@AcuMS.aculab.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <9b43b9f3a32642e5a6388f3b1c8b114d@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 5:07 AM, David Laight wrote:
> From: Jens Axboe
>> Sent: 23 January 2024 19:49
>>
>> Rewrite iov_iter_aligned_iovec() and iov_iter_aligned_bvec() to be both
>> easier to read, and also significantly more compact in terms of
>> generated code. This saves 178 bytes of text on x86-64 for me (with
>> clang-18) and 136 bytes on arm64 (with gcc-13).
>>
> ...
>> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>> index e0aa6b440ca5..2fcc47d822e3 100644
>> --- a/lib/iov_iter.c
>> +++ b/lib/iov_iter.c
>> @@ -714,12 +714,11 @@ EXPORT_SYMBOL(iov_iter_discard);
> ...
>> -	for (k = 0; k < i->nr_segs; k++, skip = 0) {
>> -		const struct iovec *iov = iter_iov(i) + k;
>> +	do {
>>  		size_t len = iov->iov_len - skip;
> 
> Is i->nr_segs allowed to be zero?

Not if size is not zero.

> The old code (seemed to) check for zero.
> The new version will go horribly wrong.

In other spots we do check both segments and size, but not that
nr_segments is non-zero to begin with. So I think this revised version
may be better. Saves 176 bytes of text on arm64 for me, and 126 bytes on
x86-64. I'll send out a v3.


diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index e0aa6b440ca5..5e34639c5d1e 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -714,12 +714,12 @@ EXPORT_SYMBOL(iov_iter_discard);
 static bool iov_iter_aligned_iovec(const struct iov_iter *i, unsigned addr_mask,
 				   unsigned len_mask)
 {
+	const struct iovec *iov = iter_iov(i);
 	size_t size = i->count;
 	size_t skip = i->iov_offset;
-	unsigned k;
+	unsigned long nr_segs = i->nr_segs;
 
-	for (k = 0; k < i->nr_segs; k++, skip = 0) {
-		const struct iovec *iov = iter_iov(i) + k;
+	do {
 		size_t len = iov->iov_len - skip;
 
 		if (len > size)
@@ -729,34 +729,37 @@ static bool iov_iter_aligned_iovec(const struct iov_iter *i, unsigned addr_mask,
 		if ((unsigned long)(iov->iov_base + skip) & addr_mask)
 			return false;
 
+		iov++;
 		size -= len;
-		if (!size)
-			break;
-	}
+		skip = 0;
+	} while (size && --nr_segs);
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
+	unsigned long nr_segs = i->nr_segs;
 
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
+	} while (size && --nr_segs);
+
 	return true;
 }
 
@@ -800,13 +803,13 @@ EXPORT_SYMBOL_GPL(iov_iter_is_aligned);
 
 static unsigned long iov_iter_alignment_iovec(const struct iov_iter *i)
 {
+	const struct iovec *iov = iter_iov(i);
 	unsigned long res = 0;
 	size_t size = i->count;
 	size_t skip = i->iov_offset;
-	unsigned k;
+	unsigned long nr_segs = i->nr_segs;
 
-	for (k = 0; k < i->nr_segs; k++, skip = 0) {
-		const struct iovec *iov = iter_iov(i) + k;
+	do {
 		size_t len = iov->iov_len - skip;
 		if (len) {
 			res |= (unsigned long)iov->iov_base + skip;
@@ -814,30 +817,33 @@ static unsigned long iov_iter_alignment_iovec(const struct iov_iter *i)
 				len = size;
 			res |= len;
 			size -= len;
-			if (!size)
-				break;
 		}
-	}
+		iov++;
+		skip = 0;
+	} while (size && --nr_segs);
+
 	return res;
 }
 
 static unsigned long iov_iter_alignment_bvec(const struct iov_iter *i)
 {
+	const struct bio_vec *bvec = i->bvec;
 	unsigned res = 0;
 	size_t size = i->count;
 	unsigned skip = i->iov_offset;
-	unsigned k;
+	unsigned long nr_segs = i->nr_segs;
 
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
+	} while (size && --nr_segs);
+
 	return res;
 }
 

-- 
Jens Axboe


