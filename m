Return-Path: <linux-kernel+bounces-38874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B76B83C7A4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0231C25397
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7511292F1;
	Thu, 25 Jan 2024 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="11kTOu+h"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205ED6EB57
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199221; cv=none; b=hgHYp/wv5U7oNfPawHL9NyCbYxq4ntvjEm3ZPwdEqf5Ui/Ypxkay11ujaGeYWfpW8KaOKkPQWucQodFcU6GMipiwCJOYg6mFg+xkZNEO0EZIonat9ewwD8ue/jwViItrEO3Wg3WPALmrexflMt5ItCJBoBw0rMC/SMv9eZrMRvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199221; c=relaxed/simple;
	bh=2WKa9upsU01rKQEE3pfd64lsMOLUYKGGxXVIj2owvow=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LhgE+V3yjY+0YR5EPRuL543XICM5qW11YmAgtB6Jnpbm1KOkR/U9GIAGHTSj/CZDGr0+Qk//vy5tEAQcPG2oYaCn6qlyg8UZ6cS4sfTr1Yaz6CDw50rGJCkhw8wmTsfkD6ydMn3/fvdLMHinlPdJ1iwj9k1NS/jDzWVOGoBGz0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=11kTOu+h; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso86993239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706199219; x=1706804019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HAkOTZIz5lxs8HKEuq4313296H/ZzDgpO7vgoAQKpT4=;
        b=11kTOu+hnxRlX0lrfdDWgNFudIP9CKRbQgDf+pvqFsI6Ne8Q3sc9SgDI2ur9jgd62N
         fBw0HQexZwccDopIyk8nq+VbQtGgdLbWzD3eLu4O31OzyqBIo3blJnNu8oEaeZvi4DAj
         Bp7X+6cDcvlSQhdGms95boHV+tAL62OF4AWiccmImeMfHR3ItnvKh3t9LX+uI5BwNMyO
         mVNeoVdJjRgzZ0z0H1X3vLSFuJftSGKJq3GcsVa3284h7Av+mGiaxVJ98g3fP3TTitsh
         nHk6JrjULIyFWcjsfTUbYym035DogfkOV13eAFPFfT5IdnjHFnjCq4FdjLCuk+JlZgy9
         rA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706199219; x=1706804019;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAkOTZIz5lxs8HKEuq4313296H/ZzDgpO7vgoAQKpT4=;
        b=YNCo2ENgSFxf/pGgYdaDTRmfGSJpsjcc0vSOs8JlaGHMkJbWLGQkAh+XPjx2U/688x
         0rFNl46V3Ey2C16tLfsNbv5FMeW9cCuhS3KbVhhy4kTmWeSaQ0aMJ+oQUo8i8E+O+q3z
         Cigr9B5oK8zx8sxsiZ1Gualj2j6RryJbgivM0hNbmaZfMYbcpSf6mOJs6DosbdMyTxhb
         RzmAkvlgYtea7kxHJ4jJmZkKQJY0ahupdX9abu/hMxZvkuMJqpVJyC10L8zHupSnCaf3
         ovO2xLN1DDYP21HBgPmZnXpTgymvyfSA5Ijepqb8PgZ+Er1kWq203t9Ez2I05fssiY1h
         1JTA==
X-Forwarded-Encrypted: i=0; AJvYcCXhgW4Muq/AS8vqQ8aEIVqSRArE7CudumnLxoO+i9mcF2ZolwozaYEf0q51GvexObarFVL0XsvfpgSui28ZYVnG4EPTvNYibwOoww+7
X-Gm-Message-State: AOJu0YwLjc3zZZfk71f8PNjSXfGVW+dhtVk9zAjBurNCeJc+AzsdpY1Z
	I8r1b04Oavs8sytFxIkssEYKNJRLAMVZpSQz3vPku2Y8v903UDtJ7hlVGac2B5s=
X-Google-Smtp-Source: AGHT+IGxmHdLcWxr2mQPouIDjWNx7Kev4k3u8IORuaWbpZv1GYb8yieuqEh/afnZO7lUdPnu5h+QoQ==
X-Received: by 2002:a5e:d714:0:b0:7bf:b770:d4ed with SMTP id v20-20020a5ed714000000b007bfb770d4edmr10280iom.0.1706199219230;
        Thu, 25 Jan 2024 08:13:39 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y13-20020a5ec80d000000b007bf4f95cf85sm5785870iol.37.2024.01.25.08.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 08:13:38 -0800 (PST)
Message-ID: <6c4a4cf3-c5ed-4236-a6b2-9d53e927f979@kernel.dk>
Date: Thu, 25 Jan 2024 09:13:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH, RFC] block: set noio context in submit_bio_noacct_nocheck
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 tj@kernel.org, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240124093941.2259199-1-hch@lst.de>
 <be690355-03c6-42e2-a13f-b593ad1c0edd@kernel.dk>
 <20240125081050.GA21006@lst.de>
 <07de550c-2048-4b2f-8127-e20de352ffde@kernel.dk>
 <ZbKIN5tn4MqHzw6U@casper.infradead.org>
Content-Language: en-US
In-Reply-To: <ZbKIN5tn4MqHzw6U@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, Jan 25, 2024 at 9:11?AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Jan 25, 2024 at 09:09:44AM -0700, Jens Axboe wrote:
> > On 1/25/24 1:10 AM, Christoph Hellwig wrote:
> > > On Wed, Jan 24, 2024 at 08:40:28AM -0700, Jens Axboe wrote:
> > >> On 1/24/24 2:39 AM, Christoph Hellwig wrote:
> > >>> Make sure all in-line block layer submission runs in noio reclaim
> > >>> context.  This is a big step towards allowing GFP_NOIO, the other
> > >>> one would be to have noio (and nofs for that matter) workqueues for
> > >>> kblockd and driver internal workqueues.
> > >>
> > >> I really don't like adding this for no good reason. Who's doing non NOIO
> > >> allocations down from this path?
> > >
> > > If there is a non-NOIO allocation right now that would be a bug,
> > > although I would not be surprised if we had a few of them.
> > >
> > > The reason to add this is a different one:  The MM folks want to
> > > get rid of GFP_NOIO and GFP_NOFS and replace them by these context.
> > >
> > > And doing this in the submission path and kblockd will cover almost
> > > all of the noio context, with the rest probably covered by other
> > > workqueues.  And this feels a lot less error prone than requiring
> > > every driver to annotate the context in their submission routines.
> >
> > I think it'd be much better to add a DEBUG protected aid that checks for
> > violating allocations. Nothing that isn't buggy should trigger this,
> > right now, and then we could catch problems if there are any. If we do
> > the save/restore there and call it good, then we're going to be stuck
> > with that forever. Regardless of whether it's actually needed or not.
>
> Nono, you don't understand.  The plan is to remove GFP_NOIO
> entirely.  Allocations should be done with GFP_KERNEL while under a
> memalloc_noio_save().

I do understand, but thanks for the vote of confidence. Place the
save/restore higher up, most likely actual IO submission isn't going to
be the only (or even major) allocation potentially needed for the IO.

-- 
Jens Axboe


