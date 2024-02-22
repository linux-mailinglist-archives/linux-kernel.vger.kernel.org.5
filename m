Return-Path: <linux-kernel+bounces-76279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0649385F51E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A6E1F22491
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C8B39843;
	Thu, 22 Feb 2024 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkG9Vez+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECC738FA0
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708595910; cv=none; b=qLAPDaCJiwR2C+lltj83iIosPiD7V0gUExKJZiiOB35xfLzTDqAIxrtbT8af89Hn3XumYQkSb+z6V3kWyYMz7tKKQVYYoFSGCBJwaruFJE4bYhpywnrbbk3/O6W9OCuSYFcT3kNxBJgrljXU2FiyozETctBE0Q283E/KeeQyNK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708595910; c=relaxed/simple;
	bh=AxoYB3PmsIkkNKlrpu2E103t28717vyfSDHxr1tzJdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuQzt/pNrReId5kYrCZJkiHNd/qs/9Z5k2Cnxz99Fd5RbTrCbbEv/tsWxt4gpvZNHcZwHFzl/BHt7j2sWi9lZr1LiNtnToEy+/x+Zga2Hq1EMgBXJE9MU++tFfI+XMzfJVSAODn9qTm06dGPAxWI5kbUYR1ikg90t+U5FBV4Nis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FkG9Vez+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708595907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cm2eoQax5JTUWKq/17TB4iIwHxGgN+JUgVg7yscjd0U=;
	b=FkG9Vez+z73DoCG7+DR9cp32ALhnSXK0WvJHMCfzNdqRPcqKIjl8y6CxuDrVzUr4LSnTeR
	6aVMB2zGsfvzgzWGY/9AXMBdGEwEzZNjsDqKNbZHXaagr8o6kkjhPeIsctqZx55v0Ug02l
	2VHsni0eWX6MLSuOhrStieecpBHvxIQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-jZ-JjzD_PZmgeH518rKdvA-1; Thu, 22 Feb 2024 04:58:25 -0500
X-MC-Unique: jZ-JjzD_PZmgeH518rKdvA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a357c92f241so313861966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:58:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708595904; x=1709200704;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cm2eoQax5JTUWKq/17TB4iIwHxGgN+JUgVg7yscjd0U=;
        b=UZBNgxegVCn+z6W58tigvA8b5hsbkDbKUObWdMUqWQBP++t8X86gOqxhl98mC/28nh
         SBiiZjU+V9DKIOEBd4zIPxA2ifuAANfymNPJiIIN5WnILBSQ7kpwNQ54mU/PCzT/fJT/
         z6MOrhDGtum1MMyNMenDHTp/yAV4XeSXNFPlAkOjvzEHyf7jC4rnONWGBXsYP9HRpjuN
         dpB5IvyugbCE2kkH1zycQyyYlEUqD+fsL1oTZ7xTwPQFPxU5SeMZ4b6lnp7PQbMPhK5B
         ygLsieWVQAezZJRrTYrBtLGDjm3LAVvtf0eZSDVrIPTC7XY1I0rpzSF0+PqHF9qTHLH/
         ySiw==
X-Forwarded-Encrypted: i=1; AJvYcCWSgtSOfXSoyXUHBm97Cy6USeAeMb91uatXZcPQ+Go577wfI4yu6z7PMWWWag5JpFmYyg4/2GRTiqvLz7nA/kJWGT9plVV63j9DlB7T
X-Gm-Message-State: AOJu0YyLJdFdi8rfR3SFvkDZfoyYH7rflD5Z3xcsVJcTvtGTP+ebrlML
	VHyWuosCDdio6ojfdyzQCqPlxbxRT3Dplzby0dYxv3xJC8mlyw93TACsPK6AYmq+GYiPV/GFbUm
	J1M1YuGlL3cDmyVSVz40Q3js7w22eakV8W0sU78HO8pw8fO/6BfnfZFLaSvWGpw==
X-Received: by 2002:a17:906:a1cd:b0:a3c:f0ec:cff9 with SMTP id bx13-20020a170906a1cd00b00a3cf0eccff9mr12197417ejb.7.1708595904416;
        Thu, 22 Feb 2024 01:58:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGD+hd9VNhFvj9XtfKP9CerUpHNIGsdSeUfImlyLZBWrxvesscaX2PmAgLmHfPpITGqF9J7Rw==
X-Received: by 2002:a17:906:a1cd:b0:a3c:f0ec:cff9 with SMTP id bx13-20020a170906a1cd00b00a3cf0eccff9mr12197409ejb.7.1708595904019;
        Thu, 22 Feb 2024 01:58:24 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id vg8-20020a170907d30800b00a3d70dc4337sm5766309ejc.102.2024.02.22.01.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 01:58:23 -0800 (PST)
Message-ID: <288132ea-87cf-4b56-908e-2263b6c6b67f@redhat.com>
Date: Thu, 22 Feb 2024 10:58:22 +0100
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
References: <7ae646b3-28e4-4344-a7a4-730a0d6e3f38@redhat.com>
 <CABgObfYDcFPRNpGtsY=UbstXbqVCMcxy3LPS_xJ65aFcByC=Nw@mail.gmail.com>
 <ZdXt09vL4GJy6PbP@sashalap> <0e8675e0-165d-4cf7-9755-666278868ab8@redhat.com>
 <ZdX2LcAWR6wyvYC5@sashalap> <bec7c1db-c13e-4b00-a968-4ae69539d7ac@redhat.com>
 <ZdYKSkqRckOc5aRO@sashalap> <a9652aa2-e79b-4144-b3b7-746587af9eca@redhat.com>
 <ZdYSmdUKzQAYpprc@sashalap> <3ebbc121-8cb8-4b8d-ad5d-fb5c576e5171@redhat.com>
 <2024022129-expiring-resurface-146c@gregkh>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <2024022129-expiring-resurface-146c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 19:21, Greg Kroah-Hartman wrote:
> On Wed, Feb 21, 2024 at 04:56:31PM +0100, Paolo Bonzini wrote:
>> To recap:
>>
>> - the CVE description comes from was upstream commit bed9e27baf52
>>
>> - neither the CVE mitigation section nor the mentioned kernel releases
>> fix the bug mentioned in the upstream commit, because the mitigation
>> section also includes commits that _revert_ commit bed9e27baf52
>>
>> - this second revert is not mentioned anywhere, so the CVE description
>> is at best misleading; or perhaps more accurately described as
>> "completely f***ed up".
>>
>> I'm sure it's just a bug in the scripts, but it's worrisome that you
>> don't acknowledge this.
> 
> Yes, this is a bug in the scripts, but it wasn't obvious what you were
> objecting to here honestly.  Reverts were not anything I tested the
> scripts with before now, and I'm sure there are going to be more cases
> that fail in odd ways too.  We'll fix them when they show up, that's the
> best we can do. [...]
>
> If you want to replace the wording in the description here with anything
> else better, PLEASE let us know and we will be glad to do so.

But there's not even a documented way to do it.

All that the document says is "the authority to dispute or modify an 
assigned CVE for a specific kernel change lies solely with the 
maintainers of the relevant subsystem affected".  But it doesn't say:

* how the maintainer would ask for such a modification or dispute

* if and how anyone else could propose them

* whether the CVE team can also do them unilaterally

Perhaps since there's no archive for cve@kernel.org, there should be a 
public discussion mailing list (e.g. linux-cve@vger) that maintainers 
can reply to?  The private cve@kernel.org alias would then be just for 
the request of embargoed CVEs.

It would be great if modifications or disputes could simply be sent as 
patches to the vulns.git repo.  You guys can have push hooks or 
something like that that take care of sending messages to 
linux-cve-announce etc.

Another underspecified part is the early request of CVEs.  Some 
questions I have:

* what information is needed

* is there a limit on embargo length similar to security@kernel.org

* should it be acked by the subsystem maintainer

More in general, I think you're underestimating the extra work for the 
"listeners" of CVEs, that will come from bugs in the script or other 
not-so-well-defined aspects of the process.  I really think it would be 
a good idea to behave "as if" you were already creating CVE, but for now 
just send out the announcements and publish the JSON in a git repo.

As we run the experiment for a while, we can get input from interested 
maintainers and third parties.  I am sure I can find someone from the 
Red Hat product security team to explain their desires, clarify how they 
consume CVE announcements, and what simplifies/complicates their job. 
Their needs are probably not that unique.

In the meanwhile, you already have the benefit of coordinating the 
creation of CVEs, avoiding surprises like CVE-2024-0562 and allowing the 
modifications.

> That's the benifit of being a CNA, we can ACTUALLY MODIFY the CVE
> records, previously it was almost impossible to ever do so.

Agreed.  There is potential to do much better than before.

Paolo


