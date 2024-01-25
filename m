Return-Path: <linux-kernel+bounces-38869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C588783C790
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705DE1F27296
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12AA129A65;
	Thu, 25 Jan 2024 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PSBvhXYp"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E62A1292E7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198989; cv=none; b=ckdEGrVXhlzVCZzaPXL/yt4b8S/naGnK3Tm2X65ROKSixF/8zcbrqOYbcbHK/w/Vv7oCvMRkcZDP4vMH+pX6cawt6sn4gbTQGvDB3gPhwAnxhYjm5gO1sVtNNSa0rTEbg3EK044rA4mB7Bhp8znjnVuaUaj+tfsr4S9Q/7nycAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198989; c=relaxed/simple;
	bh=tbH3ZcfEZi1hTyHe1rC+rgg4mr+vvSHAw05EM4mwVZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jePLq2CErweWt4FSgtQHwcse9oCbUljQ4evGSeFIV/+rgNQxp9NkTYpJDocxsNdna/LMxKt2dPCGBwax+PMNdnQfDbGT81R4Kjz2SQ/xATkstOqOM/4w+9XRwR5Vv6FiRZntp91qzatvq//3OcWwLZPNdBL8XOJsio6U3ylMsYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PSBvhXYp; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-361a8f20e22so633175ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706198985; x=1706803785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WyHxjKtVXGSwGC6zU0Wll0qpN4a6mMfynNab9F2/w+A=;
        b=PSBvhXYpNkFCyR7iGOAemGEYqQ5+s1kqmfy9SH7e7fCf9TnRN6c3qDxJhmkyoAmMJz
         bP/h1TcjdcHjG5sW0L/BubkqzKkUzpvs7Zh2lXOlVB3Q0e1R/UP+IEqNnBYY3jSrXu0L
         /KkJGWfhBDxuCfzQxl4AoCqu1HBNjZtFgEF1mRCMhnsD8SlvxMSH8s8VT+3zl+oIEaKo
         mSjJPEcHD8ug9QiZhwJ+k2BQPyEEjlhxxtEuW3+ugm/lU26OXNAgpoyf4+A43vaI5VKV
         rMkA+hsexEbhk2NnV746wgMAqllVMzCIe86CIFvsZYZs2246yxWpROQ5qpdIb81pIlBt
         vmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706198985; x=1706803785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WyHxjKtVXGSwGC6zU0Wll0qpN4a6mMfynNab9F2/w+A=;
        b=rYDU/TPqLWpfALpyH3eiDMRnkV2jdbOmjqhhPXVVlmPo5hGsI+5NKocY1FBIbE4R3B
         uafbBCQGiwN0u5bvA2VMZzOMBeMxSyxGnkHLBOxlhNcW/93iE9bspBMca2BJBU7f/Ted
         M/XzyJ6vJ+n8jNPnf0uO5XX4mmt1qKcU4mLaeqWZbybR75HTNfrYaf7VRBFquoA/oodT
         782yEXcO6wniil+oITSyxQtHqHfitvHILCqw/0VOx+pfz8gqA90TR1ltHf0sq3UBqy3V
         3z2Nmek4xqQkjlW9zwoyWoUZHvZ8GeNec5CJQCIeA+a4AR7QdeXQaAl3cVymibNXaKnG
         gTuA==
X-Gm-Message-State: AOJu0YzVOPU0Kj4rkoCaf8iUh4oYUFymjTLoUn4XjBwX1tihZ4grSUKn
	7w6p5pAiXMZc6zWVnDuiQiKMY3sbz74dkrsIx2J//64pYz26QXfNxauIFoEZbdg=
X-Google-Smtp-Source: AGHT+IFCFF1erf4MT7gNzcrY0j99+IrW8aynC/2V1tHd5SfWQOYOTsc0TDco8BBXVgJlZq753TCFpQ==
X-Received: by 2002:a92:cd83:0:b0:361:9667:9390 with SMTP id r3-20020a92cd83000000b0036196679390mr2721223ilb.1.1706198985222;
        Thu, 25 Jan 2024 08:09:45 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id s2-20020a02c502000000b0046df6e19b9csm4572238jam.34.2024.01.25.08.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 08:09:44 -0800 (PST)
Message-ID: <07de550c-2048-4b2f-8127-e20de352ffde@kernel.dk>
Date: Thu, 25 Jan 2024 09:09:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH, RFC] block: set noio context in submit_bio_noacct_nocheck
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, tj@kernel.org, jiangshanlai@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240124093941.2259199-1-hch@lst.de>
 <be690355-03c6-42e2-a13f-b593ad1c0edd@kernel.dk>
 <20240125081050.GA21006@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240125081050.GA21006@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/24 1:10 AM, Christoph Hellwig wrote:
> On Wed, Jan 24, 2024 at 08:40:28AM -0700, Jens Axboe wrote:
>> On 1/24/24 2:39 AM, Christoph Hellwig wrote:
>>> Make sure all in-line block layer submission runs in noio reclaim
>>> context.  This is a big step towards allowing GFP_NOIO, the other
>>> one would be to have noio (and nofs for that matter) workqueues for
>>> kblockd and driver internal workqueues.
>>
>> I really don't like adding this for no good reason. Who's doing non NOIO
>> allocations down from this path?
> 
> If there is a non-NOIO allocation right now that would be a bug,
> although I would not be surprised if we had a few of them.
> 
> The reason to add this is a different one:  The MM folks want to
> get rid of GFP_NOIO and GFP_NOFS and replace them by these context.
> 
> And doing this in the submission path and kblockd will cover almost
> all of the noio context, with the rest probably covered by other
> workqueues.  And this feels a lot less error prone than requiring
> every driver to annotate the context in their submission routines.

I think it'd be much better to add a DEBUG protected aid that checks for
violating allocations. Nothing that isn't buggy should trigger this,
right now, and then we could catch problems if there are any. If we do
the save/restore there and call it good, then we're going to be stuck
with that forever. Regardless of whether it's actually needed or not.

-- 
Jens Axboe


