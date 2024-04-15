Return-Path: <linux-kernel+bounces-145865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D338A5C16
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959E61F229AC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B76156675;
	Mon, 15 Apr 2024 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nDtiKEuf"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A5D811E7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713211922; cv=none; b=Y95FbtVq/0pYRugrbfF5J3Q0Osv8uIMHdt1JsKUwRZMTBIxl0zksDDt1B+12TyDHg5KzOYa/svkdfMjr9pVXITo6FXdF/Qpr90i9NcHbFYkynPeJlDc3v9my6IsMvX2sPLG5B3Kle1AkBjul/lJZRXIBF4DAvhdvu6gbL5T62/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713211922; c=relaxed/simple;
	bh=LPqppHb1O7p7E9X/dU+VV0dAGADt1nStLitMbvldbZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+NDaM5+1vWEWtq3QiaZZ2pQDBIwyni4/d4P51rx0BRMIa3JkEqAAqlpnzxydoSZbiFYOGTWNvw6815TQCNJM3Ysp62rm5zkieColJKm612H3ppJPoS4cMXQQohmsHpOTfrAM2Yq+nEro+7CrdkpuchZlV0VNFJxs+k1+EU7R9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nDtiKEuf; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so10816139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713211918; x=1713816718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L289PLVicNTtrl0nY8oRaDJ2XMnR0nkCspScxglzmU4=;
        b=nDtiKEuf+DLyOwnK0eI03VItXPymRHbVIqbKDQDPofjSfTUcxbmyfVIGc1Df/5COWQ
         Cr8gsA/H22tbnR93VLOX2bE4SRQfoYpSnnj5cPkGlclFhgiaDGr1ed44ZLb/dx5ThmKh
         hL61ttrHS7t4n9zV7tWU83tz5iaL2Tg2ke5QYTg2ldFbi9u/DZi+242sMtrMrO1lO32r
         lFrbjaGLnbqQ5rjEKC0tcRcyc/7qW1bB8qdCcP7YVNm9ekwvG36c5oIjDuyYf73NnGFW
         Pm9DE10sC+Q68G36/wyNrKv9CqSV+Fjn0/IgmK6G4LDL7sslxisSgFw2I2Bqf54ZWyAP
         TBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713211918; x=1713816718;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L289PLVicNTtrl0nY8oRaDJ2XMnR0nkCspScxglzmU4=;
        b=whFIG8tbHET12ABndnGXOT1V9BZTomjH2tMONqnroJreWakNG2vH75RdKXuJDgBl1Q
         rslWYrESCiRj40sWtDIy1XCjnmdfV3WW9yXSmu5A++N6ebtaqHqwfByZrAMu9erRxKdd
         MzYVfehMpdURLk5zILeDXO8ldnOJdAwsqSwOwD+y4Sye9ZUtGMpPB9RGqMGSdwR5kZii
         hQj44CocujpN25njqXA4ppd8VoJ2fBhVSclQOuJmI/Wp8Dg2O7b/xcEadE8NUZEcwE9N
         cythHgO0myqiuePCy1SF+usIKRvTofsaodbJ2XIDDBEO7U0VN/zaTftLjJfhl/WQaqpu
         f7kA==
X-Gm-Message-State: AOJu0Yy6s7uWoh4LUXk7yXI2CIpDPMj02R3Bod21jqGuLmxbwkMbkMmD
	yDLC+f2C/AhYB/PLdHetP7DIlCpMsLlveqh1h7GJUCgt30IhChiwQqElXF+FKeFZyMXWiredyc/
	0
X-Google-Smtp-Source: AGHT+IHW+X8ftBqjv+MekE34Ny5ocp8uF8iREXL0lLJPVGigLLag1m5tKedZhfA794T4kNqAnm+z2g==
X-Received: by 2002:a6b:c848:0:b0:7d9:9523:513f with SMTP id y69-20020a6bc848000000b007d99523513fmr2705945iof.1.1713211917947;
        Mon, 15 Apr 2024 13:11:57 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x11-20020a056638248b00b00482b484af1asm3328920jat.67.2024.04.15.13.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 13:11:57 -0700 (PDT)
Message-ID: <898afc09-428f-4da2-a620-d7ca9f37133c@kernel.dk>
Date: Mon, 15 Apr 2024 14:11:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 002/437] fs: add generic read/write iterator helpers
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
References: <20240411153126.16201-1-axboe@kernel.dk>
 <20240411153126.16201-3-axboe@kernel.dk> <20240415195504.GU2118490@ZenIV>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240415195504.GU2118490@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/24 1:55 PM, Al Viro wrote:
> On Thu, Apr 11, 2024 at 09:12:22AM -0600, Jens Axboe wrote:
> 
>> +/* generic read side helper for drivers converting to ->read_iter() */
>> +ssize_t vfs_read_iter(struct kiocb *iocb, struct iov_iter *to,
>> +		      ssize_t (*read)(struct file *, char __user *,
>> +				     size_t, loff_t *))
>> +{
>> +	return do_loop_readv(iocb->ki_filp, to, &iocb->ki_pos, 0, read);
>> +}
>> +EXPORT_SYMBOL(vfs_read_iter);
>> +
>> +/* generic write side helper for drivers converting to ->write_iter() */
>> +ssize_t vfs_write_iter(struct kiocb *iocb, struct iov_iter *from,
>> +		       ssize_t (*write)(struct file *, const char __user *,
>> +				       size_t, loff_t *))
>> +{
>> +	return do_loop_writev(iocb->ki_filp, from, &iocb->ki_pos, 0, write);
>> +}
>> +EXPORT_SYMBOL(vfs_write_iter);
> 
> Wait a minute; just what do you expect to happen if that ever gets called
> for ITER_BVEC or ITER_XARRAY?

do_loop_{readv,writev} need to look like the one io_uring had, which was
just an augmented version of the fs/ version. At least for handling
anything that is IOVEC/UBUF/BVEC. Outside of that, should not be
callable for eg ITER_XARRAY, who would do that? We should probably add a
check at the top of each just to vet the iter type and -EINVAL if it's
not one of the supported ones. With a WARN_ON_ONCE(), I suspect.

I'll be posting the first patches separately again, I've made some local
tweaks, with some drivers that can support it as-is. Just haven't gotten
around to doing this weeks iteration on it yet.

-- 
Jens Axboe


