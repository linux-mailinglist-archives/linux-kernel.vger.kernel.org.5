Return-Path: <linux-kernel+bounces-20831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4649B8285CC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2DC1C23EC8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582A8381AB;
	Tue,  9 Jan 2024 12:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCok9Ksf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A544A374C4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 12:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C51FC433F1;
	Tue,  9 Jan 2024 12:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704802145;
	bh=0UXA96UITGWVTAyTTVFwYwM+/KwQBWRpkuMjMf/eaV8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=kCok9KsfO7rcLq/0hIE/NCKa8R2iD09O6pRntZ0Eq9ezvOY2oh55OHJHRkThTToL2
	 a2TQd2viRFJd1ath/QX1U8zep33v7kC+/ZncqG1eCyDH8VaAM6FdBnJTuXm8SwgWHb
	 hka4zL/ZsO69MPimwUbqp4JfkMTpJ9MxmLX33VrD3Hda1dJOcy6Nzt69vzOgAFootp
	 060ZV1opsJSOCAr1ZjNoFNdO3QkN4iwo1hBlrsyl6IOMF/vCZrkNMrJABC4vSJ3I8F
	 ZHHgS9e+0m1l9nUj3kZlaCb7+chr5BYEb3CSggkDHNmw7BnC+6F7hoV5dtupUdbE6f
	 /tOUAzu1e3F6w==
From: Kalle Valo <kvalo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jirislaby@gmail.com>,  David Laight
 <David.Laight@aculab.com>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,  Christoph Hellwig <hch@infradead.org>,  "Jason A.
 Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH next v4 0/5] minmax: Relax type checks in min() and max().
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
	<18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com>
	<CAHk-=wjvM5KiQFpbPMPXH-DcvheNcPGj+ThNEJVm+QL6n05A8A@mail.gmail.com>
Date: Tue, 09 Jan 2024 14:09:01 +0200
In-Reply-To: <CAHk-=wjvM5KiQFpbPMPXH-DcvheNcPGj+ThNEJVm+QL6n05A8A@mail.gmail.com>
	(Linus Torvalds's message of "Mon, 8 Jan 2024 10:19:07 -0800")
Message-ID: <877ckizp2a.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 8 Jan 2024 at 03:46, Jiri Slaby <jirislaby@gmail.com> wrote:
>>
>>    CPP [M] drivers/media/pci/solo6x10/solo6x10-p2m.i
>> real    0m45,002s
>>
>> $ git revert 867046cc7027703f60a46339ffde91a1970f2901
>>    CPP [M] drivers/media/pci/solo6x10/solo6x10-p2m.i
>> real    0m11,132s
>>
>> $ git revert 4ead534fba42fc4fd41163297528d2aa731cd121
>>    CPP [M] drivers/media/pci/solo6x10/solo6x10-p2m.i
>> real    0m3,711s
>
> Ouch. Yeah, that's unfortunate. There's a lot of nested nasty macro
> expansion there, but that timing is excessive.
>
> Sparse actually complains about that file:
>
>   drivers/media/pci/solo6x10/solo6x10-p2m.c:309:13: error: too long
> token expansion
>   drivers/media/pci/solo6x10/solo6x10-p2m.c:310:17: error: too long
> token expansion
>
> and while that is a sparse limitation, it's still interesting. Having
> that file expand to 122M is not ok.
>
> In this case, I suspect the right thing to do is to simply not use
> min()/max() in that header at all, but do something like
>
>   --- a/drivers/media/pci/solo6x10/solo6x10-offsets.h
>   +++ b/drivers/media/pci/solo6x10/solo6x10-offsets.h
>   @@ -56,2 +56,5 @@
>
>   +#define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
>   +#define MAX(X, Y) ((X) > (Y) ? (X) : (Y))
>   +
>    #define SOLO_MP4E_EXT_ADDR(__solo) \
>   @@ -59,4 +62,4 @@
>    #define SOLO_MP4E_EXT_SIZE(__solo) \
>   -     max((..),                               \
>   -         min(((..) - \
>   +     MAX((..),                               \
>   +         MIN(((..) - \
>                  ..), 0x00ff0000))
>   @@ -67,4 +70,4 @@
>    #define SOLO_JPEG_EXT_SIZE(__solo) \
>   -     max(..,                         \
>   -         min(..)
>   +     MAX(..,                         \
>   +         MIN(..)
>
> and avoid this issue.
>
> That said, I'm sure this thing exists to a smaller degree elsewhere. I
> wonder if we could simplify our min/max type tests..

FWIW we had similar sparse warnings in ath11k for which I added a
workaround:

https://git.kernel.org/netdev/net-next/c/fd6ed1772b2c

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

