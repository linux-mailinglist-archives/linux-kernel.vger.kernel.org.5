Return-Path: <linux-kernel+bounces-100709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A46ED879C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A901F24768
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2599714264A;
	Tue, 12 Mar 2024 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdmEiMOK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EE6433A3
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710271577; cv=none; b=A1m0/HTeDyk7O9HGGyYgNar+zpBifOEG7hrMOuzh+d+W3ak57HaMDlBKvU5FTgvHYoG+j9kJnwJfhp6K73ScB4JW6zNmSMyNgHcAdfCsSVlk+LcpYp6031WCmQFe3QHDJ5GpaQNPdAyJyJG0o3ETKnWhkwcL8ZVExQAVRXBZ/84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710271577; c=relaxed/simple;
	bh=IivJOZBB2MtaeRaLeVT6fs5YQYyHw/h5fmPaKlZ9uLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UDTit7RNyC24njHrGOo7bp40N9Am4yseleZY9FjTOvGF0wTSQrwVhpkpGLHgPovj1NXmt1Q/lF1K5PsIX66gpHd6dxtILbs7AWx1KsTWl4beWSl3mvLK6CwcQ+G7izjnKosqU6V7XXNfV5JmScg8b+6m93LAsQ+SaWtjux0fcI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdmEiMOK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710271574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Oz2qVJeR8P/t5gkpN9uuC5NgVFfU7PHUQymX5ePmpvw=;
	b=UdmEiMOKIAICuNKOc07q1b8/4eO7lxJbQMWYLB9nffcHrSV9V+yBiy9tejxxttzV7RN5Xm
	9CmOOU7GN3rai8NvkLlFF7JR1Yny9pn5o+KMF5kGtMrA4kAKpXU5eQYZnqe/dWtyKxp73l
	QQGTmvAvAZGc7GJ23o0K4qmTSHGJkdU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-m46TgRarN1Wyc5utxBemjw-1; Tue, 12 Mar 2024 15:26:12 -0400
X-MC-Unique: m46TgRarN1Wyc5utxBemjw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33e8b93b4efso1715434f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710271571; x=1710876371;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oz2qVJeR8P/t5gkpN9uuC5NgVFfU7PHUQymX5ePmpvw=;
        b=Cg1n31/a4O0abBDs72O7Em/TWmz5Drp3+8g7aZ45NYPHGM3bug7EQE/lv0XVHbSLod
         RrtSt5B/AGOVFbCOOqzAzPdSfawHY+JVwWQWdP3QSYeq1YO8kdBdhcdLSpkDoTnD9LtM
         nn4HoDZGZRk1wsIzm6vIU4Ku3+qkLExr/iwoolom9rQttlxPjjfkHCPv3o4y6EyrBLsE
         n6MXry4O3ReELjJyuZGYWsMgtpDShRjoPXaoPUrGCAUKY5LaRkC5Zm6PHwG6/CJmmd7F
         9P6da0jo691Z3j+KWteZ8feQmYWWlQD4B7M5eZqd2HuEPfx5TgCJbfSZAklKjA5ljkXi
         6gLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtRNwN+s4Ky45ChunRu6jDTCqBJdsdeqrZrw2NMYTlLzCZ+Vq2ZujBDe1EC0Ry18kz8bMsYKqezRfPgepcgECPU7m+/MhEhSXG24SF
X-Gm-Message-State: AOJu0YxbTCufHxj36uSTx1uw0s7xLNz637StD5HhPiCAmTtPsttogEbp
	fVv3q0Kzy3fU3p5W1ND/4sMLksTKheNLgJUqbqccjPPUZpkXF6YCHNGCSQomyTFPS4Yk0iuQxaE
	gyvL9RgT7Z4Y3dQRmJDMN5nY+WNgoYhYmbrskEacttF61JyGe/pQREdjOXfo7Cw==
X-Received: by 2002:a05:600c:314e:b0:413:e4cf:fdcc with SMTP id h14-20020a05600c314e00b00413e4cffdccmr928504wmo.15.1710271570708;
        Tue, 12 Mar 2024 12:26:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPiSTi/EDTQrudTKysWLuocYjThqCOoqk082xzM21XAqh2z+x0xtNVWx5LJEVJOqYSe5QTEA==
X-Received: by 2002:a05:600c:314e:b0:413:e4cf:fdcc with SMTP id h14-20020a05600c314e00b00413e4cffdccmr928487wmo.15.1710271570277;
        Tue, 12 Mar 2024 12:26:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:4f00:a44a:5ad6:765a:635? (p200300cbc7074f00a44a5ad6765a0635.dip0.t-ipconnect.de. [2003:cb:c707:4f00:a44a:5ad6:765a:635])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c501000b00413331845a6sm3268702wmr.13.2024.03.12.12.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 12:26:09 -0700 (PDT)
Message-ID: <f959c4c4-8118-436c-83fd-d299689f753a@redhat.com>
Date: Tue, 12 Mar 2024 20:26:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/15] Fast kernel headers: split linux/mm.h
Content-Language: en-US
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, willy@infradead.org, sfr@canb.auug.org.au
References: <20240312094133.2084996-1-max.kellermann@ionos.com>
 <58fbe42a-3051-46bf-a3f9-d59da28a9cd7@redhat.com>
 <CAKPOu+8AQ8g_bEOBRoLiiO6eYBGj09YiUx=U0QPnB0Csifa6xw@mail.gmail.com>
 <37ed1ddd-f1d0-4582-b6c5-2f4091dc8335@redhat.com>
 <CAKPOu+_EwyQEEVV9ULEkncp3727eLGvqD5aswpkG5CtaZ=oJBQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAKPOu+_EwyQEEVV9ULEkncp3727eLGvqD5aswpkG5CtaZ=oJBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.03.24 19:11, Max Kellermann wrote:
> On Tue, Mar 12, 2024 at 5:33 PM David Hildenbrand <david@redhat.com> wrote:
>> Just curious: why? Usually build time, do you have some numbers?
> 
> (This has been discussed so often and I thought having smaller header
> dependencies was already established as general consensus among kernel
> devs, and everybody agreed that mm.h and kernel.h are a big mess that
> needs cleanup.)

It's always a good idea to include at least some sentences about 
history+motivation in the cover letter.

> 
> Why: Correctness, less namespace pollution, and the least important
> aspect is reduced build times. However, the gains by this patch set
> are very small; each optimization gains very little.
> 
> Some time ago, I posted a much larger patch set with a few numbers:
> https://lore.kernel.org/lkml/20240131145008.1345531-1-max.kellermann@ionos.com/
> - the speedup was measurable, but not amazing, because even after that
> patch set, everybody still includes everything, and much more cleanup
> is needed to make a bigger difference. Once the big knots like
> kernel.h and mm.h are broken up, we will have better results. And as I
> said: build times are nice, but the lesser advantage.

Okay, so "Fast kernel headers:" is a bit misleading :P

I'm asking these stupid questions because I remember some header splitup 
(from Christoph?) that really did make a significant build-time difference.

Reading all that, I would have written something like this in the cover 
letter:

"There is an agreement that we want to split up some of the big kernel 
headers, such as kernel.h and mm.h. While not delivering immediate 
build-time gains, it's one step into the desired direction. Besides 
build-time, smaller headers promise less namespace pollution and 
correctness."

(although I don't immediately understand what correctness means in this 
context)

> 
> Anyway, this first patch set was so extremely large that nobody was
> able to review it. So this patch contains just the parts that deal
> with mm.h; later, when this patch set is merged, I can continue with
> other headers. (I already have a branch that splits kernel.h and I'll
> submit it eventually, after the mm.h cleanup.)

I'd have continued with

"Some of these changes were part of a previous, bigger patchset [1]. I'm 
now sending out smaller, reviewable pieces. Splitting up mm.h is the 
first step."

[1] 
https://lore.kernel.org/lkml/20240131145008.1345531-1-max.kellermann@ionos.com/


> 
>> I'm not against splitting out stuff. But one function per header is a
>> bit excessive IMHO.
> 
> One function per header is certainly not my goal and I agree it's
> excessive; but folio_next() in its own header made sense, just in this
> special case, because it allowed removing the mm.h dependency from
> bio.h. Removing this dependency was the goal, and folio_next.h was the
> solution for this particular problem.

Okay, I see. I still wonder if merging some of the new folio headers in 
"folio.h" wouldn't have achieved something close to that. Sure, they 
bring in some other dependencies, but hopefully not mm.h

Anyhow, what you are describing here would also have been reasonable to 
describe somewhere in few words. IOW, which approach did you chose to 
decide when a new header was reasonable.

> 
>> Ideally, we'd have some MM guideline that we'll be
>> able to follow in the future. So we don't need "personal taste".
> 
> Agree. But lacking such a guideline, all I can do is make suggestions
> and submit patches for review, trying to follow what seemed to be
> consensus in previous cleanups and what had previously been merged.

Possibly it makes sense to have some rough guideline. The problem I see 
is that once your stuff is merged, it will start getting messed up again 
over time. But maybe that's just the way it works.

> 
>> For example, if I were to write a folio_prev(), should I put it in
>> include/linux/mm/folio_prev.h ? Likely we'd put it into folio_next.h,
>> but then the name doesn't make any sense.
> 
> True. But since no folio_prev() function exists, the only name that
> made sense for this header was folio_next.h. If folio_prev() gets
> added, I'd say put it in that header, but rename it to, let's say,
> "folio_iterator.h". But right now, with just this one function (and
> nothing else like it that could be added here), I decided to suggest
> naming it "folio_next.h". If you think "folio_iterator.h" or something
> else is better, I'll rename and resubmit; names don't matter so much
> to me; the general idea of cleaning up the headers is what's
> important.
> 
>> The point I am trying to make: if there was a single folio_ops.h, it
>> would be clearer where it would go.
> 
> Maybe, but IMO this wouldn't be a good place to add folio_next(),
> because folio_next() doesn't "operate" on a folio, but on a folio
> pointer (or "iterator"). Again, names don't matter to me -
> ideas/concepts matter. I'm only explaining why I decided to submit my
> patches that way, but I'll change them any way you people want.

Thanks for the details.

-- 
Cheers,

David / dhildenb


