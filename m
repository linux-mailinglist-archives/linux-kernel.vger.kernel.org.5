Return-Path: <linux-kernel+bounces-75052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F232A85E235
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 699C3B255D4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648ED81AA7;
	Wed, 21 Feb 2024 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EA9eUfOy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFC581AA2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531000; cv=none; b=KDekpd0Inj1rzFagU/gK+v2ABZa0i3ss5I1IU9y5kHJqmpIflj7KtQrMebiekifu3qzXRMYn/fE1I6Hr29EpQBDXlD7U2g3DKGCKUY74fenRdtrjLRI4CR3IW5hHwhprmctkW3/yYdgJyEVlfexe5yqz7nQ+pTHzhGw7iF9d5xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531000; c=relaxed/simple;
	bh=ulD5WWOK1b3WZJQfg9+GQN18mdNOovOIEJ84c2xdC8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZxfqB8pLb+UkfEzfivd5yUelBfvBE/z31y5VmKzOO9irPE7+oZZuHIxeK+i2nkWgjLHAikbr94IXQYt5e4Cf4ZNr5WbG/WOtbHqN8x4GgQD3yGEt8p6R42hgR0Nfo/51Hp2e0W2XVH+yG2bxeGdAcX15qQymA0RUVseSZInZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EA9eUfOy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708530996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ulD5WWOK1b3WZJQfg9+GQN18mdNOovOIEJ84c2xdC8c=;
	b=EA9eUfOyQNCu4/+blf6ul1D0niGhzZ8X6d1zVjsei+4NzCB383MKGVw/GnY1J1gTKat8J0
	JGZUl+CM1T5Ey7pJ7NyZ/vBNMjGuxQXK2Kz/1gMcmBAtbX+thDPaP5olozRFosKkwOfwpn
	3DyxFPBo42kdD0QM11ZcDjTb3OlHRdA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-RdRKNLNCM6alZvjHNW1QrA-1; Wed, 21 Feb 2024 10:56:34 -0500
X-MC-Unique: RdRKNLNCM6alZvjHNW1QrA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4126d660f01so11325465e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708530993; x=1709135793;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ulD5WWOK1b3WZJQfg9+GQN18mdNOovOIEJ84c2xdC8c=;
        b=QGv3gXXNBBzHIwUiT5+uZ3jt++cMxFbT8x+NJkZNQGHWO4B56k75YiD0xytJqikVuP
         tzaXPnLtVr7gicDKxLVpmc6UjINtEe59gyoiExeNinlrMrlVm0sxtQx/A3h2yegppH0C
         4j7Pvh1payyTFVg9hrcZDdjeJSVKSaZx4di6Spq5+P4/etvf4DVP5BSNbejLS4T6v6DI
         jeDKY0lV6fOsbabsVcOBsmKTj092u+2AYGxNZQ2YY2QyXlx3HcDQ1U47rgipyvYmnkLh
         A5tJ4NERKDTHpwt6X5AUd/Zg0KZr0RvME8/uRGJuf8d5UrWL0Fwr+JdwPUjtOoajUCJj
         i8mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdACihc+FDH0YuK99SvU8ufY48x6ObWjQlTWR14JDR7Fqg7LYHQeseSNGF0IrkIAPJwaQai9ilk1TVczFfka/hE8Q5nIs64ME2Pl8v
X-Gm-Message-State: AOJu0YymL7DBxHDBDLo+iut+JnuWlxvNdYRAQ+Tpg6O5up5K6XcUAa2s
	3IAMz3hGSCkSjjvZposVVFb0JgS90O5N58VO3N7TlirqD6geRiorY+oDAhV97uZnzEH5kl9CQ+m
	J7Sa3fQRpEwyn+XsezKyYOSzpLAaKV5EfHPPwj9Ll+1ON62JU9SOgQdAmbHm88Q==
X-Received: by 2002:a05:600c:3150:b0:412:77a4:d7c with SMTP id h16-20020a05600c315000b0041277a40d7cmr1343416wmo.9.1708530992945;
        Wed, 21 Feb 2024 07:56:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENhwGI/OqlGGM4Bt5/559uhCYgMCuDU309QG/j12uHy6R1JO9T62vLyGeJ/Gjs9rnK6G8isQ==
X-Received: by 2002:a05:600c:3150:b0:412:77a4:d7c with SMTP id h16-20020a05600c315000b0041277a40d7cmr1343395wmo.9.1708530992520;
        Wed, 21 Feb 2024 07:56:32 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id n22-20020a05600c4f9600b00411a6ce0f99sm18905210wmq.24.2024.02.21.07.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 07:56:31 -0800 (PST)
Message-ID: <3ebbc121-8cb8-4b8d-ad5d-fb5c576e5171@redhat.com>
Date: Wed, 21 Feb 2024 16:56:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2023-52437: Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING
 in raid5d"
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org
Cc: cve@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Kosina <jkosina@suse.cz>
References: <2024022009-subsoil-halt-4b28@gregkh>
 <7ae646b3-28e4-4344-a7a4-730a0d6e3f38@redhat.com>
 <CABgObfYDcFPRNpGtsY=UbstXbqVCMcxy3LPS_xJ65aFcByC=Nw@mail.gmail.com>
 <ZdXt09vL4GJy6PbP@sashalap> <0e8675e0-165d-4cf7-9755-666278868ab8@redhat.com>
 <ZdX2LcAWR6wyvYC5@sashalap> <bec7c1db-c13e-4b00-a968-4ae69539d7ac@redhat.com>
 <ZdYKSkqRckOc5aRO@sashalap> <a9652aa2-e79b-4144-b3b7-746587af9eca@redhat.com>
 <ZdYSmdUKzQAYpprc@sashalap>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZdYSmdUKzQAYpprc@sashalap>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/21/24 16:11, Sasha Levin wrote:
> Please do. Sorry - trying to do this before my morning coffee...

Thanks.

On 2/21/24 14:10, Sasha Levin wrote:
> On Wed, Feb 21, 2024 at 10:01:26AM +0100, Paolo Bonzini wrote:
>> On 2/21/24 13:34, Sasha Levin wrote:
>>> On Wed, Feb 21, 2024 at 2/21/24 13:34, Sasha Levin wrote:
>>>> There are dozens of distros, both commercial and non-commercial, whose
>>>> users need a *real* description of what is being fixed.  By writing
>>>> CVE descriptions that make no sense, you're creating more work for
>>>> everyone involved, without putting in place a process to clarify these
>>>> things except through "the maintainers of the relevant subsystem
>>>> affected"---who are not CC'd to these messages and therefore might not
>>>> even know that the CVE announcement exists. [...] My suggestion is
>>>> to CC the author of the fix and the maintainer
>>>
>>> This whole process didn't exist up until this point, and distros as well
>>> as individuals were creating CVEs without a useful messages nor without
>>> acks from the relevant authors/maintainers. What changed now?
>>
>> First, that _when_ a CVE was created, there was a human in the loop
>> deciding who to write.  Here we have scripts that clearly got
>> confused, pulling patches that were not included in the description.
>
> Commit messages make the most sense when the need is to relay technical
> information about an issue.

No doubt, but here only one commit message was included and it's hiding
information about the bug it introduced.

To recap:

- the CVE description comes from was upstream commit bed9e27baf52

- neither the CVE mitigation section nor the mentioned kernel releases
fix the bug mentioned in the upstream commit, because the mitigation
section also includes commits that _revert_ commit bed9e27baf52

- this second revert is not mentioned anywhere, so the CVE description
is at best misleading; or perhaps more accurately described as
"completely f***ed up".

I'm sure it's just a bug in the scripts, but it's worrisome that you
don't acknowledge this.

>> Second, that there is going to be thousands more occurrences of this
>> work overall.
>>
>> Third, that the relevant maintainers were not on the hook as the sole
>> "authority to dispute or modify an assigned CVE".  Maintainers were
>> given this additional work without, as far as I know, anybody telling
>> us, and I'd like to be able to do it efficiently and without adding
>> more bureaucracy to an already-thankless work.
>
> So now you're asking us to drop this additional work on them by
> reviewing CVE requests?

It doesn't have to be mandatory.  But for people that _do_ want to do
the work, they might as well do it before the CVE is publicly announced,
rather than after.  At least give us the possibility of doing it without
bureaucracy.

>>> Looking at CVE-2024-0562, which we've previously discussed as an
>>> example, were the maintainers of the relevant subsystem consulted before
>>> the CVE was assigned?
>>
>> CVE-2024-0562 matches perfectly what you're doing: create a CVE only
>> after the bug is fixed, to improve communication on how to update.  Of
>> course the timing was off by a year, but hey "a bug is a bug" no?
>>
>> Early communication of these issues is indeed an improvement that can
>> be made by having the kernel CNA.  But if everything is automated and
>> on day one you have already such garbage, it's not going to go well.
>
> The timing is off, but my point is that the maintainers were never
> consulted whether this issue is really a security issue or a dud.
> Is it really a security issue?

It is a use-after-free so, going by the recent announcements on
linux-cve-announce, it deserves a CVE.

>>> I'd also note that the if a certain user/distro requires massaged
>>> explanations to be "user readable" and dumbed down to layman terms, then
>>> it is on that user/distro to provide it to them (heck, I was doing this
>>> exact work while making Ksplice updates years ago).
>>
>> It's not "a certain user/distro", it's all of them---whether
>> commercial or not.  And again, by removing any human vetting of what
>> goes into CVEs, you're pushing work on N distros thousands of times
>> per year instead of having it done only once upstream.
>
> So I've worked in quite a few places in the past decade or so (Oracle,
> Microsoft, Google, ...) and let me tell you from experience that all
> those companies deeply care about security and CVEs, and the best CVE
> description was one that simply pointed to the upstream commit.

I agree, but you're talking about commit references that were already
validated by a human.  Something like this CVE, which says "the last
patch will fix the bug", or a variable rename with "no functional change
intended", certainly isn't a great CVE description.

> So yes, I disagree with your "all of them" statement. For that matter,
> I'd argue that the number of users who need massaged messages are the
> vast minority.

They don't need massaged messages.  They need correct and complete ones.
   You're completely removing the human part of the work and expecting
the result to be of comparable quality.  That's not going to happen, and
this CVE is an example of this.

All of them will read "The issue reverted commit fixing is fixed by last
patch in a new way" in the description and think what crap is this.

Some of them will see

         Issue introduced in 6.1 with commit 5e2cf333b7bd and fixed in 6.7.1
with commit 0de40f76d567
         Issue introduced in 6.1 with commit 5e2cf333b7bd and fixed in 6.7.2
with commit 87165c64fe1a

and will wonder which release actually fixes the bug.

A few of them will also notice that the suggested mitigation is to
absolutely do nothing, and will check if it's already April 1st.

This CVE is an order of magnitude worse than CVE-2024-0562 in terms of
confusion and wasted time for everyone involved.

>> I'll also note that you're not answering any of my questions:
>>
>> 1) as KVM maintainer (who is not allowed to post linux-cve-announce)
>> how can I be aware of all CVEs that are created and affect my subsystem?
>
> How were you aware until a few weeks ago where CVE assignments were
> handled by different entities?

They more often than not CC'd me before the patch was committed and
provided me the CVE id, and I was able to provide input or dispute the
assignment beforehand.  This is exactly what I'm suggesting that the
kernel should do.

I don't recall anything like CVE-2024-0562 happening for KVM, but it's a
small subsystem.

>> 2) how are you going to handle patch dependencies?  Are they going to
>> be rolled into a single entry or split into multiple announcements?
>
> Likely multiple different entries.

So, looking at
https://git.kernel.org/pub/scm/linux/security/vulns.git/tree/cve/review/6.7.proposed
I see

aeb686a98a9e usb: gadget: uvc: Allocate uvc_requests one at a time
da324ffce34c usb: gadget: uvc: Fix use-after-free for inflight usb_requests

What vulnerability is the first one fixing?  Looking at your GSD
entries, will there even be CVEs purporting that renaming a variable
from "foo" to "bar" is fixing a vulnerability?

>> 3) are the scripts used to generate the CVEs public?  Can fixes to the
>> scripts be developed in the open?
>
> Yup - https://git.kernel.org/pub/scm/linux/security/vulns.git/ .

What about the detection part?

I like to assume the best of people, so I'll assume that this is just
naïveté rather than an intentional attempt at burning everything down.
But please, let's take a step back and understand what the proposed
workflow fixes and breaks for everyone (especially maintainers and
distros).  Then make a proper solution.  In the meanwhile you can keep
sending test announcements to linux-cve-announce, and those can be used
to debug the process and the scripts.

In fact it would be nice if bippy included at the end the command line
that was used, to aid the reproduction and fixing of bugs.

Again: I'm optimistic that this process can be an improvement over what
various CNAs were doing before.  But right now you're pushing out crap
that simply doesn't live up to the standards of how Linux operates, so
please stop.

Paolo

>> 4) what happened with 5.15 having only the revert but not the
>> revert-of-revert?  Does this mean that it has the bug fixed by commit
>> 87165c64fe1a9, and does this contradict the fact that updating to the
>> latest release of a given LTS branch is the best course of action?
>
> It is always best to run the latest released kernel.


