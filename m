Return-Path: <linux-kernel+bounces-75248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DE785E535
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A373B219F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B618526E;
	Wed, 21 Feb 2024 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/ClZ7wM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E18085261
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538999; cv=none; b=atoyvzFW8Bli9VoP8wdseqXrpSQ+X/GYkUUaale+EtOuz8slWPZ6zl6HnHQ+A2/3xWCMqcdGKIfNz3g6ezEOTsRQ4dHrLStBsI5/LBcJgvIeVmzPBTnwjqtfwZynC1vPyCm67I2XPBUZBVkCl5Ai8TSYgwZzAMkDxc0EQZe5cck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538999; c=relaxed/simple;
	bh=uBgXPp2nw3R0CBR3psLfp2JoIGyRAdvy/DKBqFAMVqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQb64Tgickeb40XZNvrUjTj0nrHmmsCnzc6hs90xL5t1mYreEa8nCuwykMyEuuPH7RAq4NiTd4LBQ4PaJi3z/o1+VpNJ7+Ccj41Hk+XIk7yc2OF7ioLwg+npW3cln+ydx66uD007WV2FC+tKhN0M0ejUqX1ye6wNRLeLmdT2fHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/ClZ7wM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708538996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dcr5H3tjuckJb6uOZDjn9d00bNBMWKtaccBRwAluRN4=;
	b=Z/ClZ7wMcYCrjzRV8qfZM+77FQRKuJ6Cgu7DVhGKKr8m3oMJ9lvkM3Yx3rLBc1//T/LfUu
	X89FkCI7Es7EMO9d68kh71IBpH6N+stEcBidkhOM9jYcCGgtDDs5gKMngm51xwG1hn3MdZ
	m70Czvkc9U1unfjjsV/Cq/hCwb9H/Ys=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-8M5uCSCaM5SXbNHT_zCkeA-1; Wed, 21 Feb 2024 13:09:55 -0500
X-MC-Unique: 8M5uCSCaM5SXbNHT_zCkeA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4102b934ba0so37201245e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:09:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708538994; x=1709143794;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcr5H3tjuckJb6uOZDjn9d00bNBMWKtaccBRwAluRN4=;
        b=Yhm/RRpS5NwF4qmvxZJ12iXyLT+/qLa4m+NIfxV31ArDmt29VW0sKzHIGPgLitbzHv
         C8ZAK8jfJt6O1IDPQCpsCAK3FzDeZt5fUmm68K+CaUks+8pRA7KIjGGpVT4k7WLywddy
         Blhur6rjGV6bJROGzcpefxu7li3GEnKE2EPb0yEMUtEyoROtSF9sbu205p7Inu1xkzf+
         LVDvYDyn0boQZfIOgz+wTUCRiLi7GTHzEq0pFH9SiHkr7Oj96NUO+IbvwKnHFvzdn+hs
         FDcuplmxiiZR7PsXf2Tb7tx2K/9pf+38sPzrW+LKtaDdRC7YzWMutkjdgYs28sruxiWE
         m/tQ==
X-Gm-Message-State: AOJu0YxXL1VliEkouFQ23mRziWlkWGuivQXjo5UFRxpAOEmN1dDohjuk
	OK4P3Wi+4VR6sBy52FSiMaz0IDQLnX86ki5Lb7uLbgV2Bhqu78xvOP0Ts23EqdCBpTRIkxe08hr
	ig2Eon3HCcHa7tOfjrq5eBwugjOX2MXQT+8FWpdhT2TYIyykEuYe6sXmbaANa0Q==
X-Received: by 2002:a05:600c:5486:b0:411:eb73:243b with SMTP id iv6-20020a05600c548600b00411eb73243bmr14841701wmb.5.1708538994027;
        Wed, 21 Feb 2024 10:09:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9ABq91PjEMNWc5mwCXopIYS0k59GbV+qgyIwpV+k1NLcTpVFe43OUNvU2Rdw5MZXyz0tWfg==
X-Received: by 2002:a05:600c:5486:b0:411:eb73:243b with SMTP id iv6-20020a05600c548600b00411eb73243bmr14841690wmb.5.1708538993677;
        Wed, 21 Feb 2024 10:09:53 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id m6-20020a5d56c6000000b0033d56aa4f45sm9255481wrw.112.2024.02.21.10.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 10:09:53 -0800 (PST)
Message-ID: <5ab460b4-91fb-429b-aa41-cdbb2b1a8e32@redhat.com>
Date: Wed, 21 Feb 2024 19:09:52 +0100
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
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, cve@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Kosina <jkosina@suse.cz>
References: <7ae646b3-28e4-4344-a7a4-730a0d6e3f38@redhat.com>
 <CABgObfYDcFPRNpGtsY=UbstXbqVCMcxy3LPS_xJ65aFcByC=Nw@mail.gmail.com>
 <ZdXt09vL4GJy6PbP@sashalap> <0e8675e0-165d-4cf7-9755-666278868ab8@redhat.com>
 <ZdX2LcAWR6wyvYC5@sashalap> <bec7c1db-c13e-4b00-a968-4ae69539d7ac@redhat.com>
 <ZdYKSkqRckOc5aRO@sashalap> <a9652aa2-e79b-4144-b3b7-746587af9eca@redhat.com>
 <ZdYSmdUKzQAYpprc@sashalap> <3ebbc121-8cb8-4b8d-ad5d-fb5c576e5171@redhat.com>
 <ZdYjXmA_1OvcS_CZ@sashalap>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZdYjXmA_1OvcS_CZ@sashalap>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/21/24 17:22, Sasha Levin wrote:
> On Wed, Feb 21, 2024 at 04:56:31PM +0100, Paolo Bonzini wrote:
>>> So now you're asking us to drop this additional work on them by
>>> reviewing CVE requests?
>>
>> It doesn't have to be mandatory.  But for people that _do_ want to do
>> the work, they might as well do it before the CVE is publicly announced,
>> rather than after.  At least give us the possibility of doing it without
>> bureaucracy.
> 
> [...]
> 
>>> How were you aware until a few weeks ago where CVE assignments were
>>> handled by different entities?
>>
>> They more often than not CC'd me before the patch was committed and
>> provided me the CVE id, and I was able to provide input or dispute the
>> assignment beforehand.  This is exactly what I'm suggesting that the
>> kernel should do.
> 
> This is fascinating to know, because when multiple members of the
> community asked to review CVEs before they are assigned, certain few
> CNAs blatantly ignored such requests.
>
> Would you want to expand on why you got the courtesy of being able to
> review these assignments, while the rest of us had to jump through the
> hoops of becoming our own CNA just to stop from this crap from happening
> to us?

Probably because I generally get CVEs myself ahead of time for 
corruption or use-after-free bugs (in arch-independent or x86 KVM code). 
  So when somebody comes with a CVE it's usually Project Zero stuff and 
not something like CVE-2024-0562, and we work together.

If you can tell me (even privately) what CNAs these were, I can check. 
But probably the answer is simply that either they have never touched 
KVM, or the issues were under some kind of embargo.

>>> So yes, I disagree with your "all of them" statement. For that matter,
>>> I'd argue that the number of users who need massaged messages are the
>>> vast minority.
>>
>> They don't need massaged messages.  They need correct and complete ones.
>> You're completely removing the human part of the work and expecting
>> the result to be of comparable quality.  That's not going to happen, and
>> this CVE is an example of this.
> 
> I definitely agree that it would be nice to have better messages in
> CVEs, and I'd welcome interested parties to follow the process that was
> in place up until two weeks ago, and request an amendment to a CVE with
> a better description (or dispute an invalid one) with the CNA.
> This is exactly the same process that most of us had to follow in the
> past to address crappy CVE descriptions or bogus CVEs.

And what I am saying is that we need to do better.  Give the maintainer 
an opportunity to say at least yes or no.

>>>> 2) how are you going to handle patch dependencies?  Are they going to
>>>> be rolled into a single entry or split into multiple announcements?
>>>
>>> Likely multiple different entries.
>>
>> So, looking at
>> https://git.kernel.org/pub/scm/linux/security/vulns.git/tree/cve/review/6.7.proposed
>> I see
>>
>> aeb686a98a9e usb: gadget: uvc: Allocate uvc_requests one at a time
>> da324ffce34c usb: gadget: uvc: Fix use-after-free for inflight 
>> usb_requests
>>
>> What vulnerability is the first one fixing?  Looking at your GSD
> 
> Well, if you look at the first patch, it says "This patch is 1 of 2
> patches addressing the use-after-free issue.".

Right, it's *the* issue.  It's one CVE, not two.  The first patch is a 
dependency of the actual fix, it's not its own vulnerability.

>> entries, will there even be CVEs purporting that renaming a variable
>> from "foo" to "bar" is fixing a vulnerability?
> 
> Maybe? Hopefully not if it's not a real security issue.

What if it's a dependency of the actual issue/fix?

>> I like to assume the best of people, so I'll assume that this is just
>> naïveté rather than an intentional attempt at burning everything down.
>> But please, let's take a step back and understand what the proposed
>> workflow fixes and breaks for everyone (especially maintainers and
>> distros).  Then make a proper solution.  In the meanwhile you can keep
>> sending test announcements to linux-cve-announce, and those can be used
>> to debug the process and the scripts.
> 
> No objections on future improvements, right now we're still trying to
> get the basics working which is where the strong pushback on "feature
> requests" is coming from.

Got it.  But multiple commits per CVE is not a feature request, it's 
basic acknowledgement of how Linux is developed.

>> In fact it would be nice if bippy included at the end the command line
>> that was used, to aid the reproduction and fixing of bugs.
> 
> Bippy just maps commits to trees and formats the json, or did I
> misunderstand what you meant?

I would like to run bippy myself to understand how the commits in 
CVE-2023-52437 were chosen.

Paolo


