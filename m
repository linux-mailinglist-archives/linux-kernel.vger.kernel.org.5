Return-Path: <linux-kernel+bounces-35993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDB88399DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E3128DB6D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B5282D75;
	Tue, 23 Jan 2024 19:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XT0aZAWW"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D457982D6B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706039363; cv=none; b=hNwWjUJfnvyu45JmBiVKOv4uhwZfhkLPTTkILFbs1E/GTrImjRFlpgwOxXiBU1/4sQrlIlBaXUN2946T0tsvpR3zJqOnAidLpvlsJ327he2rscfi95Ks7vNc55A1R0o+MtoyPl5k3JJnPUb2cDw9qH6cAAFnlCYgDzGpUCB1YJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706039363; c=relaxed/simple;
	bh=wKzLJlmJ9DrBMTIzNS0BSASQESObvzqf9HfbrxJIKWQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=UiJtYTqlKM02OxWBj4ciYN1zOA8nHoY23sVOYid5833LyEqRMeTEugP0D8na5eOv9pRStcbO5qQ7oemkTYKUP9jIrm3QeQ0nyqaGmLmcGyrGlTn3yCxg6MRyZPXr7IeLb3kc9EjBA7nN3de9KqhygSgyGxuKoOLDBOYjsDGwP24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XT0aZAWW; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7bed82030faso61674339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706039359; x=1706644159; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIiaxUg7lmzEU6IeydKuSzqoKYZYHCX3fmUuQkUoc1o=;
        b=XT0aZAWW/XicNY8zTZ3y83qIwEp9c5Domy8ri5PlUAMuxrCyvREv3s3rpE/MiCP//C
         hepRnvqSx0xxlvsUNAPMCWgNQYOJLUy1SAocN6v/sTmzCEwuYh5nEoaNqfIYBUbkQZfu
         tMfGAVgx6aWDEVn5rZrHhn+bt+6oRXPVRZIZaYdD1uGY1hwvV9lvv8yk5hFKhmFnDjF/
         cGq0tuISwG9yfWCnCLzdL1fEczgS8qzNqTvjqN1sDOluj/jrgBHK74p8dkoNEkFQo+Jg
         G4mzspcIH8Nj5cEl+eIAW7aGbkGLRHLIXeEm+DoRb/3MXXtFscC1GkDLh9i439uadwcg
         +17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706039359; x=1706644159;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jIiaxUg7lmzEU6IeydKuSzqoKYZYHCX3fmUuQkUoc1o=;
        b=C7B1/JUnzHEsQ53TfP6Mfb2/dACdVQMmhOIVVrVFsevK9OQmYXY2MxSz4owTpSevT4
         yteOXsltRgWNvjP9BT2Sev3y5zE5n1kcOYoYUpSJUk1Y+TOfGk7brtwPOglDLVGkwGll
         fEgpCuo6CmtCo8pGAFIXdxCZgDfXUYRa4Vo5mzv6mgBOqppVCLI6KnHKi4c83WfLjpuS
         EpquhO2y4TFRUV05H95Wgd00hJTu9ho2I4ecn+TT+JKp3ay5SlNvOe/ryUyWAWb4nJSD
         pFspIk5tEn6TBlkehBmIZ51MjS1K/lRYQU5pMLbPiY7nmCV6bQFXg8wrak4Sf5+hM2GI
         XldQ==
X-Gm-Message-State: AOJu0YwBm4q+QJogH6hZcrDKVjtH9D0ZpTAr3TpNo/+TgyL98uVYkbp1
	3WI6zeJQNMiesIcBWVBoDmU9nMJCDia5DuNhuQ8vzdNLZwnMuq7nnFfu9fhfgXX/HF9w6X3tFlM
	A0d4=
X-Google-Smtp-Source: AGHT+IGGkfgEIQQBiFHjOL+UJuRq6hqiz2jeUvJzzayd0JaCwVXlwMoDVew6XW773Tl7ZE1qtXZKzg==
X-Received: by 2002:a5d:9b8d:0:b0:7bf:4758:2a12 with SMTP id r13-20020a5d9b8d000000b007bf47582a12mr232935iom.0.1706039359308;
        Tue, 23 Jan 2024 11:49:19 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b20-20020a056602331400b007befbe595e6sm6750154ioz.23.2024.01.23.11.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 11:49:18 -0800 (PST)
Message-ID: <bd2f28ab-78cf-4ae0-a62a-d23a94fb3839@kernel.dk>
Date: Tue, 23 Jan 2024 12:49:18 -0700
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
 Christian Brauner <brauner@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] iov_iter: streamline iovec/bvec alignment iteration
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Rewrite iov_iter_aligned_iovec() and iov_iter_aligned_bvec() to be both
easier to read, and also significantly more compact in terms of
generated code. This saves 178 bytes of text on x86-64 for me (with
clang-18) and 136 bytes on arm64 (with gcc-13).

In profiles, also saves a bit of time as well for the same workload:

     0.81%     -0.18%  [kernel.vmlinux]  [k] iov_iter_aligned_bvec
     0.48%     -0.09%  [kernel.vmlinux]  [k] iov_iter_is_aligned

which is a nice side benefit as well.

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index e0aa6b440ca5..2fcc47d822e3 100644
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
 
-- 
Jens Axboe


