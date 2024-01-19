Return-Path: <linux-kernel+bounces-30899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE888325AF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22991C2260D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C54219E8;
	Fri, 19 Jan 2024 08:23:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C1E28DA1;
	Fri, 19 Jan 2024 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705652639; cv=none; b=H4y1IyvTcnr8qESV1ZleZkIcvb4yi1HZ154bpjv6N+3y5cItJCaYXDzWXDRK+JjkCXd/o6THP4XKepUf+XiqSVYFaOKSlYRyzkAL0JIBnKVZnepZ6TtlnyySTV3TO64v9Om0+nfAlVwrTrNJ53inwb9O/EDhP/UuZGQ9T/YvAXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705652639; c=relaxed/simple;
	bh=oxLHI2Fxb2xW9QYzUQqyOsGxScIpG5doLBa6JQmhwkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcJpfAQRSm+BITBs/mPgaVnp7PpRbu5MB6io8feWnTsYaLm0wFB9uLCCJ4Ri1tcZTtyoMzcthTDIxCqjb6ZkBcCjttmQf308ym2U4NrNZFogMKauKy0XECE1Q7MV39qMICL/5APnRcYvJNq/d/CxTSIjt7K0HYPbl0JLi1rDM7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD18C433F1;
	Fri, 19 Jan 2024 08:23:56 +0000 (UTC)
Message-ID: <597292b3-8ef4-4202-a63f-a17ffb4bdd10@xs4all.nl>
Date: Fri, 19 Jan 2024 09:23:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v4 0/5] minmax: Relax type checks in min() and max().
Content-Language: en-US, nl
To: Jiri Slaby <jirislaby@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <David.Laight@aculab.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>, "Jason A. Donenfeld"
 <Jason@zx2c4.com>, linux-media <linux-media@vger.kernel.org>
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
 <18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com>
 <CAHk-=wjvM5KiQFpbPMPXH-DcvheNcPGj+ThNEJVm+QL6n05A8A@mail.gmail.com>
 <650bdb23-0875-4e19-9e3e-82337da6da00@kernel.org>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 xsFNBFQ84W0BEAC7EF1iL4s3tY8cRTVkJT/297h0Hz0ypA+ByVM4CdU9sN6ua/YoFlr9k0K4
 BFUlg7JzJoUuRbKxkYb8mmqOe722j7N3HO8+ofnio5cAP5W0WwDpM0kM84BeHU0aPSTsWiGR
 yw55SOK2JBSq7hueotWLfJLobMWhQii0Zd83hGT9SIt9uHaHjgwmtTH7MSTIiaY6N14nw2Ud
 C6Uykc1va0Wqqc2ov5ihgk/2k2SKa02ookQI3e79laOrbZl5BOXNKR9LguuOZdX4XYR3Zi6/
 BsJ7pVCK9xkiVf8svlEl94IHb+sa1KrlgGv3fn5xgzDw8Z222TfFceDL/2EzUyTdWc4GaPMC
 E/c1B4UOle6ZHg02+I8tZicjzj5+yffv1lB5A1btG+AmoZrgf0X2O1B96fqgHx8w9PIpVERN
 YsmkfxvhfP3MO3oHh8UY1OLKdlKamMneCLk2up1Zlli347KMjHAVjBAiy8qOguKF9k7HOjif
 JCLYTkggrRiEiE1xg4tblBNj8WGyKH+u/hwwwBqCd/Px2HvhAsJQ7DwuuB3vBAp845BJYUU3
 06kRihFqbO0vEt4QmcQDcbWINeZ2zX5TK7QQ91ldHdqJn6MhXulPKcM8tCkdD8YNXXKyKqNl
 UVqXnarz8m2JCbHgjEkUlAJCNd6m3pfESLZwSWsLYL49R5yxIwARAQABzSFIYW5zIFZlcmt1
 aWwgPGh2ZXJrdWlsQHhzNGFsbC5ubD7CwZUEEwECACgFAlQ84W0CGwMFCRLMAwAGCwkIBwMC
 BhUIAgkKCwQWAgMBAh4BAheAACEJEL0tYUhmFDtMFiEEBSzee8IVBTtonxvKvS1hSGYUO0wT
 7w//frEmPBAwu3OdvAk9VDkH7X+7RcFpiuUcJxs3Xl6jpaA+SdwtZra6W1uMrs2RW8eXXiq/
 80HXJtYnal1Y8MKUBoUVhT/+5+KcMyfVQK3VFRHnNxCmC9HZV+qdyxAGwIscUd4hSlweuU6L
 6tI7Dls6NzKRSTFbbGNZCRgl8OrF01TBH+CZrcFIoDgpcJA5Pw84mxo+wd2BZjPA4TNyq1od
 +slSRbDqFug1EqQaMVtUOdgaUgdlmjV0+GfBHoyCGedDE0knv+tRb8v5gNgv7M3hJO3Nrl+O
 OJVoiW0G6OWVyq92NNCKJeDy8XCB1yHCKpBd4evO2bkJNV9xcgHtLrVqozqxZAiCRKN1elWF
 1fyG8KNquqItYedUr+wZZacqW+uzpVr9pZmUqpVCk9s92fzTzDZcGAxnyqkaO2QTgdhPJT2m
 wpG2UwIKzzi13tmwakY7OAbXm76bGWVZCO3QTHVnNV8ku9wgeMc/ZGSLUT8hMDZlwEsW7u/D
 qt+NlTKiOIQsSW7u7h3SFm7sMQo03X/taK9PJhS2BhhgnXg8mOa6U+yNaJy+eU0Lf5hEUiDC
 vDOI5x++LD3pdrJVr/6ZB0Qg3/YzZ0dk+phQ+KlP6HyeO4LG662toMbFbeLcBjcC/ceEclII
 90QNEFSZKM6NVloM+NaZRYVO3ApxWkFu+1mrVTXOwU0EVDzhbQEQANzLiI6gHkIhBQKeQaYs
 p2SSqF9c++9LOy5x6nbQ4s0X3oTKaMGfBZuiKkkU6NnHCSa0Az5ScRWLaRGu1PzjgcVwzl5O
 sDawR1BtOG/XoPRNB2351PRp++W8TWo2viYYY0uJHKFHML+ku9q0P+NkdTzFGJLP+hn7x0RT
 DMbhKTHO3H2xJz5TXNE9zTJuIfGAz3ShDpijvzYieY330BzZYfpgvCllDVM5E4XgfF4F/N90
 wWKu50fMA01ufwu+99GEwTFVG2az5T9SXd7vfSgRSkzXy7hcnxj4IhOfM6Ts85/BjMeIpeqy
 TDdsuetBgX9DMMWxMWl7BLeiMzMGrfkJ4tvlof0sVjurXibTibZyfyGR2ricg8iTbHyFaAzX
 2uFVoZaPxrp7udDfQ96sfz0hesF9Zi8d7NnNnMYbUmUtaS083L/l2EDKvCIkhSjd48XF+aO8
 VhrCfbXWpGRaLcY/gxi2TXRYG9xCa7PINgz9SyO34sL6TeFPSZn4bPQV5O1j85Dj4jBecB1k
 z2arzwlWWKMZUbR04HTeAuuvYvCKEMnfW3ABzdonh70QdqJbpQGfAF2p4/iCETKWuqefiOYn
 pR8PqoQA1DYv3t7y9DIN5Jw/8Oj5wOeEybw6vTMB0rrnx+JaXvxeHSlFzHiD6il/ChDDkJ9J
 /ejCHUQIl40wLSDRABEBAAHCwXwEGAECAA8FAlQ84W0CGwwFCRLMAwAAIQkQvS1hSGYUO0wW
 IQQFLN57whUFO2ifG8q9LWFIZhQ7TA1WD/9yxJvQrpf6LcNrr8uMlQWCg2iz2q1LGt1Itkuu
 KaavEF9nqHmoqhSfZeAIKAPn6xuYbGxXDrpN7dXCOH92fscLodZqZtK5FtbLvO572EPfxneY
 UT7JzDc/5LT9cFFugTMOhq1BG62vUm/F6V91+unyp4dRlyryAeqEuISykhvjZCVHk/woaMZv
 c1Dm4Uvkv0Ilelt3Pb9J7zhcx6sm5T7v16VceF96jG61bnJ2GFS+QZerZp3PY27XgtPxRxYj
 AmFUeF486PHx/2Yi4u1rQpIpC5inPxIgR1+ZFvQrAV36SvLFfuMhyCAxV6WBlQc85ArOiQZB
 Wm7L0repwr7zEJFEkdy8C81WRhMdPvHkAIh3RoY1SGcdB7rB3wCzfYkAuCBqaF7Zgfw8xkad
 KEiQTexRbM1sc/I8ACpla3N26SfQwrfg6V7TIoweP0RwDrcf5PVvwSWsRQp2LxFCkwnCXOra
 gYmkrmv0duG1FStpY+IIQn1TOkuXrciTVfZY1cZD0aVxwlxXBnUNZZNslldvXFtndxR0SFat
 sflovhDxKyhFwXOP0Rv8H378/+14TaykknRBIKEc0+lcr+EMOSUR5eg4aURb8Gc3Uc7fgQ6q
 UssTXzHPyj1hAyDpfu8DzAwlh4kKFTodxSsKAjI45SLjadSc94/5Gy8645Y1KgBzBPTH7Q==
In-Reply-To: <650bdb23-0875-4e19-9e3e-82337da6da00@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/01/2024 08:14, Jiri Slaby wrote:
> On 08. 01. 24, 19:19, Linus Torvalds wrote:
>> On Mon, 8 Jan 2024 at 03:46, Jiri Slaby <jirislaby@gmail.com> wrote:
>>>
>>>     CPP [M] drivers/media/pci/solo6x10/solo6x10-p2m.i
>>> real    0m45,002s
>>>
>>> $ git revert 867046cc7027703f60a46339ffde91a1970f2901
>>>     CPP [M] drivers/media/pci/solo6x10/solo6x10-p2m.i
>>> real    0m11,132s
>>>
>>> $ git revert 4ead534fba42fc4fd41163297528d2aa731cd121
>>>     CPP [M] drivers/media/pci/solo6x10/solo6x10-p2m.i
>>> real    0m3,711s
>>
>> Ouch. Yeah, that's unfortunate. There's a lot of nested nasty macro
>> expansion there, but that timing is excessive.
>>
>> Sparse actually complains about that file:
>>
>>    drivers/media/pci/solo6x10/solo6x10-p2m.c:309:13: error: too long
>> token expansion
>>    drivers/media/pci/solo6x10/solo6x10-p2m.c:310:17: error: too long
>> token expansion
>>
>> and while that is a sparse limitation, it's still interesting. Having
>> that file expand to 122M is not ok.
>>
>> In this case, I suspect the right thing to do is to simply not use
>> min()/max() in that header at all, but do something like
>>
>>    --- a/drivers/media/pci/solo6x10/solo6x10-offsets.h
>>    +++ b/drivers/media/pci/solo6x10/solo6x10-offsets.h
>>    @@ -56,2 +56,5 @@
>>
>>    +#define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
>>    +#define MAX(X, Y) ((X) > (Y) ? (X) : (Y))
>>    +
>>     #define SOLO_MP4E_EXT_ADDR(__solo) \
>>    @@ -59,4 +62,4 @@
>>     #define SOLO_MP4E_EXT_SIZE(__solo) \
>>    -     max((..),                               \
>>    -         min(((..) - \
>>    +     MAX((..),                               \
>>    +         MIN(((..) - \
>>                   ..), 0x00ff0000))
>>    @@ -67,4 +70,4 @@
>>     #define SOLO_JPEG_EXT_SIZE(__solo) \
>>    -     max(..,                         \
>>    -         min(..)
>>    +     MAX(..,                         \
>>    +         MIN(..)
>>
>> and avoid this issue.
> 
> So can someone pick up 20240113183334.1690740-1-aurelien@aurel32.net so that we are done with this? I see neither Hans, nor Linus got to take it yet.

I replied here:

https://lore.kernel.org/all/fd143cf8-5e3d-4d80-8b53-b05980558e45@xs4all.nl/

Either Linus can pick it up directly during the merge window, or it will
appear in a media fixes PR once rc1 is released.

Regards,

	Hans

> 
>> That said, I'm sure this thing exists to a smaller degree elsewhere. I
>> wonder if we could simplify our min/max type tests.
> I assume we don't care with solo fixed? Hans pointed out ath11k too. Even if there is size increase in the preproc file, I don't see much of compile time increase there.
> 
> thanks,


