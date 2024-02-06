Return-Path: <linux-kernel+bounces-55141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F41D84B856
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5317C1C21E04
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CC2132C04;
	Tue,  6 Feb 2024 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sRhZztcS"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0A213246A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230967; cv=none; b=KGq45/sT2uMpufshs7P7uyv25dGCyeCKzRc11ES2JKchid/KTwimlc4oeT/5mWlw4WqEp3swaB9ulWuQlrrscZ+KejuvUTusCsdfvgW1/TUUiBLYVzeiJCV+oiFkK8Ww3uRtQXK139fU33pzyskc9GgC47FPkqbWcmE+UVAUGRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230967; c=relaxed/simple;
	bh=9KCB8Hx5QNfYZmy1/EWGWqjbKOP8RtUYBO3wt9arjSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFa7Wwg0Q3QKHaQCHCg8sB+zchg77K5bbCSin3S1D+OhH/MRPVtXc2qqfznSeK7yuTGpbQ/KHWb3iQp05Z53/9WcnYM1WRSshiwroJzyQiZz3ZYZvYUBA5ibAF93m0EhX+xiFWFrI2Y7WggPiDvEBX20X/HYpHGo1xDxu8qOh8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sRhZztcS; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c00a2cbcf6so36107439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 06:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707230964; x=1707835764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1t/hKAiFqtL+lPwbgASx7TYdQNkZjBmlEgZi1+BCdIs=;
        b=sRhZztcSThgczDriXjLVgHOBhwxr+gUmgZiePXxvXynIh7VF1gpCeQ4RopstT01oAy
         lnkH1bpRZUUGJrerMXZ67NXQoNxs9l0rRx2FQIU1f9KL+1NGidtvjIgZk7VebK611TrV
         IiuznD1cEFJexKYsZHHsGWXTun9nAyxCSUqvHqpsp+gkzUCeTxzSGasjzVmhavxF8zmT
         z0/hFkz8VjNfBxxHqYJKl9JNG7jbwXgaagJ+UbZzfnrSq3T+nymMHQHtETsImJ8bfSHA
         zIQBJFSdi2g6Y4Cnv6VNteNkg45r5TjlffemXSzXZG/yEWw4Y/frYO8yWOhgAaEJspHq
         2ctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230964; x=1707835764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1t/hKAiFqtL+lPwbgASx7TYdQNkZjBmlEgZi1+BCdIs=;
        b=gWQ7onaQ+BHANQyKKwNhev+vOYG60kxdgcBGDIqtry/422aEOeycUH/28K6nput9L5
         ipOgGM5ojAOZLaEmRaNFrzkr2286gjOAEj+/kzWwVBSTiLrhFwIoxkgfpdT4peYC0C2B
         dheSnsIrRwQWbob7kblyANb28cujWwz9T5YjEOHhspXj49Ir2s/vjF/BzuQd1+gCXT6D
         9FDZ0rvZgzkqsqVNH5fXjQdgMOxXwYj0X/uxyAcYJ3Qu/cVyqpjEZhbij8H4sbcwwRO4
         vx4F7yauvKsQQts0yjB23XL9HvMEiTjRC3HZG8Qf82Hsj4Xika2vE6hL7DVh2A3vYntM
         3U7A==
X-Gm-Message-State: AOJu0YxSbJ7mBjcNJNYBV6VjImi1hZXYbm/aWZPYNjssFO2JwIbWiHSe
	M8upKI1DfIJDwcnQG9LUZPd/6z1haudi2RdL2ROn7ic0ET0Sm6QEHCR+kg8atA5glblZykeM5zY
	gH+Q=
X-Google-Smtp-Source: AGHT+IFVrzNeubMz2FBC4NWw/M4XGDxqGGoR1DI6NTjRypcn+e/DR8ioxEishs/bbvU/hXKzbEtfRg==
X-Received: by 2002:a92:c54e:0:b0:363:c919:eee3 with SMTP id a14-20020a92c54e000000b00363c919eee3mr3434565ilj.0.1707230963776;
        Tue, 06 Feb 2024 06:49:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW3hs7PvgTeoB4qLRLZOsRUNRp9FbBI85KFaec4QQCp1E/qwRVogBZGZQawOoPsqJ4cA1X6zA0AeqAXhLNI1FWbmF/9tS7MZHL0xA==
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y3-20020a920903000000b003639cce3083sm570939ilg.20.2024.02.06.06.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 06:49:23 -0800 (PST)
Message-ID: <1ca1e83e-8283-4f64-b5fa-0d0a07dbdb7f@kernel.dk>
Date: Tue, 6 Feb 2024 07:49:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warnings after merge of the block tree
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240206131050.0e86d882@canb.auug.org.au>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240206131050.0e86d882@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/24 7:10 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (arm
> multi_v7_defconfig) produced these warnings:
> 
> In file included from /home/sfr/next/next/include/linux/bits.h:6,
>                  from /home/sfr/next/next/include/linux/bitops.h:6,
>                  from /home/sfr/next/next/include/linux/kernel.h:23,
>                  from /home/sfr/next/next/io_uring/nop.c:2:
> /home/sfr/next/next/include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
>     7 | #define BIT(nr)                 (UL(1) << (nr))
>       |                                        ^~
> /home/sfr/next/next/include/linux/io_uring_types.h:538:35: note: in expansion of macro 'BIT'
>   538 |         REQ_F_CAN_POLL          = BIT(REQ_F_CAN_POLL_BIT),
>       |                                   ^~~
> 
> (and mny more similar)
> 
> Introduced by commit
> 
>   d964e8440442 ("io_uring: add io_file_can_poll() helper")
> 
> REQ_F_CAN_POLL_BIT is 32.

Oops yes, didn't get around to 32-bit compiles just yet. I'll fix it
up, thanks.

-- 
Jens Axboe



