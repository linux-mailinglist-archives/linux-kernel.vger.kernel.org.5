Return-Path: <linux-kernel+bounces-76601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5898C85F9D7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D821B1F274F9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13651369B7;
	Thu, 22 Feb 2024 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNBR5mDI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBFA12FB02
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608678; cv=none; b=jgHgPBAkdG5Rot7S3S7fXi/4WJiKy06d4Pg5sHFmC3xn4b+EhGPtcJQt8+omlVzWCtSK/cUToTiSsmXpr4qIxvKgE9ISqumf43ck1dTSk5esoI/PxB25wyGpfGnmkeu+B1uLKREyEJe/d5Ia9g8NMuxZXnQ9p8t9Znk1gJaykWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608678; c=relaxed/simple;
	bh=hFg49FdtoOkTxHd5BCmbAe027QKoQRKkuPQvDJrwjhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbBc4OJj6IpSb1qnTo8Ay0j0OCPhEoESej3NcuceMmKYHiFdLC7fF2KibEDFy6vLnu4VmzMQVy2c8yf/NFyfRSRY1HcHeAR8UNQzH4gzhhhHmudI5D4tasq5eMX77K5okaNhLheJx1adF4eti+uPRPwxixnLIJhMdk+w81TQHZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNBR5mDI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708608672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LEvb25e/FOzspxq6cKHvWdxHhf0TdHpoSK5qJqE1dX0=;
	b=KNBR5mDIQ9JIiyHRT+AhyPejoOjne+zfH8xg/+Hm67iu/aGQ/BI1TZYmtVhjoI8au4Tij8
	LZQUM4Twd/axBb1ZtzSrpuBH3ALdnZKDh+uzUZq/8dpQC6RwpVHUZWqWQzQaOI5SpMcHb9
	+ODC6Q4sD5G5PH9/xlmBdXXob8ZXkAQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-tKC56GhMPu-e2L1FoC_yvw-1; Thu, 22 Feb 2024 08:31:11 -0500
X-MC-Unique: tKC56GhMPu-e2L1FoC_yvw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a3ede65e32bso170658466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708608669; x=1709213469;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LEvb25e/FOzspxq6cKHvWdxHhf0TdHpoSK5qJqE1dX0=;
        b=lpiv6dPNuTn/KwXJR6xKT3uv9tzcQd9+4mY0X9/NG5Hu8+pSDfy1oG+4obi5BfH3mE
         1xclF/PBSEJ1dTF3se/jPmulXnMDQcwJeSWEkTwpmlSjXSQk7ySxqMaUjRNGnD4RDNXq
         Fa12yo7e4I6LxFz16452b2nIZK7L2du3Lcky7NYZT55BFkQP86IqyQWah2rb3aMyECj7
         FDioKitnx/xd3s8FGx5+Rv6I7iB5Dt3r9Cql754X6OoHGIQ6/vQHa017jS2i1Oj6mE6H
         /JWgL+T8wk6OUiUtonpvRtJ3tmAcgdQa9kErwoM2GOjP/FEBxwal+rvbVoXr6XmH6iaN
         9cCA==
X-Forwarded-Encrypted: i=1; AJvYcCUMzKHYWRNaQdsa00fBgMdJPT1ZRksUO5a5tP7RNlcqRczsxE55GZp2bPAsX+H2Lnus0ynDGgzFZFfWgMSymQliIdGDpEQNFj1J2d+V
X-Gm-Message-State: AOJu0YyJZOTg+3m1aMjBnLtodWO8aN6kCm2OjhjZN1OB5bhZBpZ3lrDw
	tYqjBLymuhtGk2EcL3ka+eclQpgzJkaELVqBjb+2tAU2K5NtXCY0nvuKhpHeKqTaC0XkXJsEy8Z
	kq0afkwSyotAUkTAJw/XimicdIoVBQMWc9MJrxPXbIVX9FPyNsfviTCNnT3o7hw==
X-Received: by 2002:a17:906:1155:b0:a3e:6862:dc79 with SMTP id i21-20020a170906115500b00a3e6862dc79mr8679326eja.1.1708608669182;
        Thu, 22 Feb 2024 05:31:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNr8jdgSzhIF7oSbcEQL5EtcVDbQLcTWSJWZ2SDw9TCdzBPT4V0pNJRDOeZ2buusJIPwPVXg==
X-Received: by 2002:a17:906:1155:b0:a3e:6862:dc79 with SMTP id i21-20020a170906115500b00a3e6862dc79mr8679301eja.1.1708608668595;
        Thu, 22 Feb 2024 05:31:08 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id f21-20020a170906085500b00a3ea5a9ac15sm3835677ejd.88.2024.02.22.05.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 05:31:07 -0800 (PST)
Message-ID: <7be9ad00-1432-4a19-a954-32fa0f24fecd@redhat.com>
Date: Thu, 22 Feb 2024 14:31:06 +0100
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 cve@kernel.org, Jiri Kosina <jkosina@suse.cz>
References: <ZdXt09vL4GJy6PbP@sashalap>
 <0e8675e0-165d-4cf7-9755-666278868ab8@redhat.com> <ZdX2LcAWR6wyvYC5@sashalap>
 <bec7c1db-c13e-4b00-a968-4ae69539d7ac@redhat.com> <ZdYKSkqRckOc5aRO@sashalap>
 <a9652aa2-e79b-4144-b3b7-746587af9eca@redhat.com> <ZdYSmdUKzQAYpprc@sashalap>
 <3ebbc121-8cb8-4b8d-ad5d-fb5c576e5171@redhat.com>
 <2024022129-expiring-resurface-146c@gregkh>
 <288132ea-87cf-4b56-908e-2263b6c6b67f@redhat.com>
 <2024022236-stock-wielder-fcbc@gregkh>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <2024022236-stock-wielder-fcbc@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/22/24 13:55, Greg Kroah-Hartman wrote:
>> All that the document says is "the authority to dispute or modify an
>> assigned CVE for a specific kernel change lies solely with the maintainers
>> of the relevant subsystem affected".  But it doesn't say:
>>
>> * how the maintainer would ask for such a modification or dispute
> 
> Email.
> 
>> * if and how anyone else could propose them
> 
> Email.
> 
>> * whether the CVE team can also do them unilaterally
> 
> Yup, through email :)

Now we're talking. :)

>> Perhaps since there's no archive for cve@kernel.org, there should be a
>> public discussion mailing list (e.g. linux-cve@vger) that maintainers can
>> reply to?  The private cve@kernel.org alias would then be just for the
>> request of embargoed CVEs.
> 
> What's wrong with lkml for discussion?  I'll add a "reply-to" to point
> there as well so that it will properly redirect if you respond to a
> message sent to the -announce list.

Well, LKML is not the most searchable archive and subscribing to it puts 
measurable stress on the kernel.org servers (mostly due to gmail 
shenanigans, but still).

Plus (relatively) fine grained mailing lists are really cheap to 
subscribe to lore/NNTP.  So if the reply-to points to LKML + the 
subsystem mailing list for the maintainers + a new ML for the security 
folks (and these three are also CC'd on the announcements, at least the 
last two), that would be nice to have.  I can work on patches to 
vulns.git, for example to integrate with get_maintainer.pl, if you ack 
the idea.

The linux-cve@ mailing list would also be a natural place to send 
patches to vulns.git.

>> It would be great if modifications or disputes could simply be sent as
>> patches to the vulns.git repo.  You guys can have push hooks or something
>> like that that take care of sending messages to linux-cve-announce etc.
> 
> Yes, I'll gladly take that as well!

Would be nice to have that documented.  Again, I can put everything in 
words once we have some agreement.

>> Another underspecified part is the early request of CVEs.  Some questions I
>> have:
>>
>> * what information is needed
> 
> What ever information you feel is necessary.  What would you do if you
> had to make up your mind on this?
> 
> At the minimum, a git id :)
> 
>> * is there a limit on embargo length similar to security@kernel.org
> 
> We have no embargos here, you should NOT be emailing this alias about
> any unfixed security things, the document explicitly states this.

Wait that's not what the docs say:

+If anyone wishes to
+have a CVE assigned before an issue is resolved with a commit, please
+contact the kernel CVE assignment team at <cve@kernel.org> to get an
+identifier assigned from their batch of reserved identifiers.

>> * should it be acked by the subsystem maintainer
> 
> Not needed, but sure, if you want to.

Ok, then we should add something to that end in the docs as well, 
suggesting Cc of the maintainers.

>> More in general, I think you're underestimating the extra work for the
>> "listeners" of CVEs, that will come from bugs in the script or other
>> not-so-well-defined aspects of the process.  I really think it would be a
>> good idea to behave "as if" you were already creating CVE, but for now just
>> send out the announcements and publish the JSON in a git repo.
> 
> How is it any different from the existing "listeners" of CVEs today?  in
> fact, it's a world better as the meta-data we are now providing in the
> json files is so much better than all of the crud that all of the other
> CNAs were putting in there, it's not even a fair comparison.

Well, it's different in that it will at least double the CVEs processed 
every year (potentially more---if we go by the number of GSD entries, 
it's more like 5x), and the delta will be coming from one CNA only.

So it's just that it's a lot of new work.  So far the only thing for 
which I can say "this sucks" is having one CVE per commit in a 
multi-patch fix.  That's somewhat ingrained in the operation of the 
bippy script, but not unfixable (and BTW I wouldn't mind rewriting bippy 
in Python, but that's a different story).

> I've already had soo many threads from the "Red Hat product security
> team" including flow charts and other fun things to last me quite a
> while already, and that's just in the past few days.

Lol yeah I've seen some of those too (but only this morning---I'm not 
writing on their behalf, in case that was unclear).

Paolo

> Given that the "Red Hat product security team" was the #1 offender in
> creating CVEs against the kernel that caused us so much work and
> headaches that it pushed me over the edge to go through all of the extra
> work to actually become a CNA, I think it's worth considering what you
> are asking for here.
> 
> In other words, they know how to contact us, before, we could never
> contact them.  This is up to them to decide how to interact, not us.
> And remember, the number of RH systems that that team affects is pretty
> much in the rounding error of the other Linux systems out there, not
> that I'm counting or anything, just saying :)
>
>>> That's the benifit of being a CNA, we can ACTUALLY MODIFY the CVE
>>> records, previously it was almost impossible to ever do so.
>>
>> Agreed.  There is potential to do much better than before.
> 
> Totally agreed, thanks for the questions!
> 
> greg k-h
> 


