Return-Path: <linux-kernel+bounces-145918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B358B8A5CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D781B1C2107A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F99156993;
	Mon, 15 Apr 2024 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jlo20hKE"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF85C82D93
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 21:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215777; cv=none; b=gOTJabSJxCDVKJD/BlspLT7EhspGUKIZeLbZ5k6y/pRKx8QkVSDRWEWzk0/RMFYMakYZ8SNlPlTtPZgWvIvslSZ1imlvRM55wjdf6t8Eh788CuPmjSILWSaYQTTJ5v6RG8diO8o0+E9LhsqNE1sBDG8ZmXNTwCjJLmMaW9ByxXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215777; c=relaxed/simple;
	bh=xoLaJGmjQcgkTnzAgsA/seITc/Y6ILIFZGdfmyscPfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsCjeBX3VImLs8wwsE7Tv6mB2ZC2lNTAPZfVyf/AuTNVKm+nVh+RFcoggvj5kmkXblr64vwhFPTuYRAt9kr43b0yOKWJPTSTYmfJYa6UOO5Dif/WQNeF62jYcW1/qRob77fFCVVALpTOXZGx76Ic0ePQG1qugg6Jw+iPtCf8a5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jlo20hKE; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d9a64f140dso4912839f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713215774; x=1713820574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Ypra/wKNoZBy4J2SPqn2RJs4l+Rqlu5EcwF8XxE/0w=;
        b=jlo20hKEA0m6gc8e5Dn0ha4WTBF+uEtRyl8koRAQzS/gGCkbXSQOy4oe9S5iX9bluS
         457YMUsDbC3LUpMMRnuepAfxPKojuhhoMzkXRl54kfqQOyFlsTtXrUR2jmNijxiqUdBx
         AV5dy71PMKYj2vHV88JnrdQdHWBPiUZuZ288iNLR/MRz+AtpVUF6rbs/oa9LjL6fSN28
         uzaT6uqJavhLFTFxv+7ocC+uzqe67x+DZSdPMnFWN2KQTiL98P5cQ3MduFHeLneMDaG2
         nkqqi6z6PuN9FFc6pnVu4XE4AE09OMJw5EY9aCCPYXg4EZ5SmCHzjc5BxWn9udwNzHOb
         /NRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713215774; x=1713820574;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ypra/wKNoZBy4J2SPqn2RJs4l+Rqlu5EcwF8XxE/0w=;
        b=txcb0D+P4zm80YAbzBcctV9E3WEGijo+LgQQJcMXf37yWNNJvoS2AJw6AIegczL0N+
         3IX7ZDsI4i4psL3PXIvLLRHaHDMYZeAewQZxURhOoLOD+DdNgILXMBFxl+mrYcbLP+Pa
         7T+yhbbtElhYH/UMU456w36bu86p3epLWUSSf1/ApDg+azn2gvH5+pDpU123ZnemwOcM
         UZf7x8jRqVBSd4PaE1/ep6gGR9h2wANMzhZzv6eepxdc/0YpyfeGPIJqUk5MthTvmgSV
         FGsErb+itXflBTBfs3EJvtKCUW88f9MY7W69vt32GUYUOYIAlrAlCgc6mLX+nS9H/uHK
         cgKA==
X-Gm-Message-State: AOJu0YzurWXtBA6ixWKSpkHvQj8hgOR7zjizVgGt4yLQMCofhWNotZv8
	8Pul/a83jz+GzYCog95fer9BVov7baVvdmU5yYakZKheIM0UV/O3TqOVUXHNil7OrbA9IgE4HVQ
	I
X-Google-Smtp-Source: AGHT+IHpcc+WmnAU+kwVSJb9WefBAeGIt/4Q2HwSkYVSGK8jnaZALFTRg/XQaf+rL3LvNdyy7uSfsQ==
X-Received: by 2002:a05:6602:448:b0:7d6:b07e:2126 with SMTP id e8-20020a056602044800b007d6b07e2126mr10143148iov.2.1713215774082;
        Mon, 15 Apr 2024 14:16:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m40-20020a05663840a800b00482b8b12872sm3294477jam.174.2024.04.15.14.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 14:16:13 -0700 (PDT)
Message-ID: <de942b9c-6e91-4dcc-a386-9d1317e0e0b4@kernel.dk>
Date: Mon, 15 Apr 2024 15:16:12 -0600
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
 <898afc09-428f-4da2-a620-d7ca9f37133c@kernel.dk>
 <20240415210827.GX2118490@ZenIV>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240415210827.GX2118490@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/24 3:08 PM, Al Viro wrote:
> On Mon, Apr 15, 2024 at 02:11:56PM -0600, Jens Axboe wrote:
> 
>> do_loop_{readv,writev} need to look like the one io_uring had, which was
>> just an augmented version of the fs/ version. At least for handling
>> anything that is IOVEC/UBUF/BVEC.
> 
> IOVEC and UBUF: pointer will be __user one; copy_from_user() works.
> KVEC: kernel pointer.  Try copy_from_user() on that on x86 with SMAP (or
> on e.g. sparc64, etc.) and you'll get an oops.
> BVEC: page + offset, page quite possibly not mapped anywhere in kernel page
> tables.  And "just kmap() around the call of your callback" is not a good
> idea either, for even more reason that for KVEC.

The old read/write path only handled user pointers, with the exception
being bvecs mapped on the io_uring side (which the io_uring version
dealt with) which also originally came from user pointers. So just user
memory. Why would we need to expand that now? Who would be doing
->read_iter() or ->write_iter() with something that isn't either UBUF or
IOVEC? Because that would break horrible as it is in the current kernel.

-- 
Jens Axboe


