Return-Path: <linux-kernel+bounces-110330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C87D0885D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8321F250ED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A432A12CDA4;
	Thu, 21 Mar 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="KdFetqKA"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FE112BF29
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038054; cv=none; b=f8yiYyHedmYPTwcDOlM0UpqM/lwJe6WRa+/Kar3eEzDlYqWOPLDKRFIPqohxf6AolK37VoIueBywi1TlcW1pNhPYkSNlgNDpieDFOQbuYOI2ej5ph56gjgiJty90OCdgKo8rsIeIVT3JxwkQXjjp/eErJfijwipwRCGevfrxaQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038054; c=relaxed/simple;
	bh=D4jSbAa5qDyRtjvFkBpdVOFtA4/fqkK9tzVFMkXQBnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyQD88AjHuq+1h6Y66R4Qogr/a4nafXLd5ub5P4g0CT07y0VZ5QU7fQGxrgT5D5Ds2Ad5w3hMeTotG92KBe3TfoNwGNoxJ+DOOSHEwvBOuw5YkmWbx+BfFHivWRYwIk70CyPQ0LShV07VDE2QfkZyEVLiGKdWsaVItZyY6/+C9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=KdFetqKA; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-69664c7f716so170996d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711038052; x=1711642852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=it17QbxuEQq2A73zBdTC8BNNGib79KppL7WF83RYbZE=;
        b=KdFetqKA8Kl++F0NjEegAiLMSydkkc9DEtUei+uZCZ5hZFRxu/MjpW6xgV0npzKPne
         VeSlbDnHO4ZqnhKNxyqgTBCYH5oh14UDNlJsIB83BrMGIaxkQPWRXFvYuKcnup1sf/Js
         0NbmUAKiI+z6oSUTME7z+bwXC7yucP++DLJ85txMVWO6BT54eLsEvQHfdlDRipirpGrm
         CgZsiMjN/yR7hgTIBAbtQfzaeRWlNGz7vqeRFPtotF677uObySqSEd7BfFs7VsH6mAId
         1TiWQhjQpt6Cu4rBXZojUXP4g5nVC+0Xv98uPFblaaKHBl9Lgju2EfcKghY+/sU0wdLe
         +VfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711038052; x=1711642852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=it17QbxuEQq2A73zBdTC8BNNGib79KppL7WF83RYbZE=;
        b=qiJElCeNXMo8517Ge3wES/yHoqDz8yMhaClThV3JRfv4UCL00343z2+7yRUpae61sW
         nBBXPgFwapa8HQLHtsbh6yw6ehtFYcNdkNZijPPytzaMTaDJazisyMVD56dTf9XEjSYL
         we/DRyPxKguOcjdJtqcEKuU5FYuj6unGX1W8vVcaieKMBwzsToWGk+vkVJOI+ebXd6gi
         4z5GhRZvrKZJBJ4B2Vo77M7ZLxyrTFJl34W1USNdunbp0S+mSfTrWs9Bn+xJCcVl2qN5
         MfAQiXAb/lUri4u7LkCzNBY6pRAtqkxif5PV/jb/OJGOf62HboPtqZISmi3RCr5ZJIV5
         /VBA==
X-Forwarded-Encrypted: i=1; AJvYcCUEHtzaReVonpu7elDJxhZI1NlMk2BKhCGT/Gy3AKgJElGGwltjSy2Y/0CHCgL9oFLRs5kBwPSkGY/3oxZABHi7D9ptNkR1tZALNDpY
X-Gm-Message-State: AOJu0YykLU9HuKZs7PriRnMwgcJPO1vjmGZcIDgQVIF5NTF4iHVJkSHI
	kiLhZcCTPbzOj2oxOWlW0N6QhRAqLRC5FfeSVY4FMVj6hwXDg3MJdofR6UVYPE8=
X-Google-Smtp-Source: AGHT+IG1k7G5G+Z3OJ5q+BW7ZYSU8X/25UCC4pKS1DVD0DbYAJnhDPD/YdY/eD/wzMDuseFNnZWYew==
X-Received: by 2002:a05:6214:486:b0:690:dc3b:179d with SMTP id pt6-20020a056214048600b00690dc3b179dmr5090647qvb.20.1711038051785;
        Thu, 21 Mar 2024 09:20:51 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id ke7-20020a056214300700b00692bd4905c9sm49822qvb.15.2024.03.21.09.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 09:20:50 -0700 (PDT)
Date: Thu, 21 Mar 2024 12:20:49 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: control: fix memory leak in
 snd_ctl_elem_read_user()
Message-ID: <20240321162049.GA3379@cmpxchg.org>
References: <20240321161700.2926-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321161700.2926-1-hannes@cmpxchg.org>

On Thu, Mar 21, 2024 at 12:17:00PM -0400, Johannes Weiner wrote:
> With 6.9, I noticed kmalloc-2k blowing up to tens of gigabytes over
> several days. Kmemleak shows a long string of these:
> 
> unreferenced object 0xffff8f1bddbce800 (size 2048):
>   comm "wireplumber", pid 1058, jiffies 4294690193
>   hex dump (first 32 bytes):
>     14 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
>     4d 61 73 74 65 72 20 50 6c 61 79 62 61 63 6b 20  Master Playback
>   backtrace (crc bd965d91):
>     [<ffffffff85ac328b>] __kmalloc_node_track_caller+0x25b/0x370
>     [<ffffffff85a79375>] memdup_user+0x25/0x80
>     [<ffffffff85fa5d63>] snd_ctl_ioctl+0x753/0x880
>     [<ffffffff85b18119>] __x64_sys_ioctl+0x89/0xb0
>     [<ffffffff861ee190>] do_syscall_64+0x80/0x170
>     [<ffffffff862000ab>] entry_SYSCALL_64_after_hwframe+0x46/0x4e
> 
> When 1052d9882269 ("ALSA: control: Use automatic cleanup of kfree()")
> converted a few sites to automatic freeing, it removed the kfree from
> snd_ctl_elem_read_user() but forgot to add the __free hook.
> 
> Fixes: 1052d9882269 ("ALSA: control: Use automatic cleanup of kfree()")
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Oh, I just noticed there is a pending fix at

https://lore.kernel.org/linux-sound/20240320062722.31325-1-tiwai@suse.de/

Sorry about the noise!

