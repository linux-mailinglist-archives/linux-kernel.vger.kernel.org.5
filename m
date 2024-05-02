Return-Path: <linux-kernel+bounces-166431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EE58B9A9A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C62281C52
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DAC77F13;
	Thu,  2 May 2024 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8Tg0snC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C070E59B4B
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714652297; cv=none; b=tAB4NglojCubuOTnGJ109wku4OSB4JJNalayClZ0G+oAfCOTEuK6VeRh2wAb1vRk6Lu/W9WmdmPUON6IFA7Im3egcJqbpTboNejcEG8J5rg1bUAf+YF+pBlXkgUOjn2A13Bk5gFyFc85fqm3fT7ArU2j/cslscKs2YyPHxzMWVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714652297; c=relaxed/simple;
	bh=oHlWu0KoAb9qV0ZB7YAfCQg7BPYUCGVVgAfx1MhkU4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ghtPm9CF0arf6/ZkdUprmveFKRlUencam12kcXm8HZqtw99IRTu8ifWBvX1evbT321ClATXoXnu6f1XJSScoDfnb/42QvNT2GhLnStlr869/hYYv3YNcmrZjuOb7H99Irp/6gGTaXzdxQOMyumrOcuQ47KrCarEtxZ+roCMIL94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8Tg0snC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714652294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j0ouXWVXMSsia+jkf8WQfP89YFxtqAKEOm2AuOhT3gc=;
	b=E8Tg0snCqGSy6750rrW8ygczQ4i+Abs4w2E/J2rssdFABDym95YtJBfgVKf85q0V341y1W
	4HJRsPD/gzT1UFvUiSZQ+r/PjYGvVou52f36KjUbmolyYEdy4kPqYmB+88GCzOaqoHojsa
	EROzRbyKD3RD/CsnA+GlwZo/dEi7mD8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-FrhBjO1AOPO51KHrseaAOw-1; Thu, 02 May 2024 08:18:13 -0400
X-MC-Unique: FrhBjO1AOPO51KHrseaAOw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2decc7026a9so72121121fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 05:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714652292; x=1715257092;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0ouXWVXMSsia+jkf8WQfP89YFxtqAKEOm2AuOhT3gc=;
        b=M6vtxwncOXcamEQ0FaGfvSJI+5bIvqeacKS7vl1MSr3nUUr5oL9aLZw98vNjaZ7dwK
         cvANS3dPzsme0h03x8TDobBpIcgDaU+IHeGv2YUbLNgVDAfr+oC/H0968PR7yUZ7wots
         AFXrdRFJvK3vbdZbv1fErwgTThHcD7DyBTNRSYgbfnj9mvleEWoscpi+ohNope9vXOHg
         hjOihfXY5BjwhTfZzATr8hraYXgp3rauA7aBtCBy3WM76slcjwnDAbAvMMcH3NJVtvmL
         XMIis0/ZV8nuMW4ANwzyjhfa++aOMwMR6clnEUxYLmih7oUfUCPqCQjue3JrkGqrzb4L
         mlhg==
X-Forwarded-Encrypted: i=1; AJvYcCU9jQ5S7Raw57rTc1IzRJVb+NqM6G3fwNCpbjOAhwtnFFhNuMuSlxtThDn3ckYGZFBmuWa7QIRDXcBmB9QHA2IfTzlnSbxxY4NQb56w
X-Gm-Message-State: AOJu0YxiWIG0eqSMhpBQjXDxpSzro97N5T262NDiiNodfVkdJ5zBD5ij
	inTIE0D42qMMblN7aKzZJXVxQ1QVgqoSMKKCs8oWIjRp6Vqj5A6ZAExiBDCMwab3YAfMqGfCLQj
	hpUJDCZFGXd5AJchM+sqvoEXkaZ+sTUHKKE95dYPQhycPJeODlnWSVC7W2S6WDk0aLclUKhKE6g
	1ZqT9uUvbVJonpOM5buNmhtM6YbciZ9nzTdFaYHg7UENcMpA==
X-Received: by 2002:a05:651c:54b:b0:2df:8ce6:96ae with SMTP id q11-20020a05651c054b00b002df8ce696aemr1459372ljp.7.1714652292051;
        Thu, 02 May 2024 05:18:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHLEzhel3J+Iky5AXISUEMehzZpROpO7wE4GfujUAp2fZWvLcpFCcbsttf2lwNUdXPb4hkug==
X-Received: by 2002:a05:651c:54b:b0:2df:8ce6:96ae with SMTP id q11-20020a05651c054b00b002df8ce696aemr1459319ljp.7.1714652291458;
        Thu, 02 May 2024 05:18:11 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id s20-20020a05600c45d400b0041bde8ddce9sm5535635wmo.36.2024.05.02.05.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 05:18:10 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Alexander Graf <graf@amazon.com>, Ashish Kalra <Ashish.Kalra@amd.com>,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org
Cc: rafael@kernel.org, peterz@infradead.org, adrian.hunter@intel.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
 rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 seanjc@google.com, kai.huang@intel.com, bhe@redhat.com,
 kirill.shutemov@linux.intel.com, bdas@redhat.com, dionnaglaze@google.com,
 anisinha@redhat.com, jroedel@suse.de, ardb@kernel.org,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] x86/snp: Add kexec support
In-Reply-To: <26b3b3b5-548d-4ebd-9d21-19580a41e799@amazon.com>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <cover.1712694667.git.ashish.kalra@amd.com>
 <26b3b3b5-548d-4ebd-9d21-19580a41e799@amazon.com>
Date: Thu, 02 May 2024 14:18:09 +0200
Message-ID: <87msp8mmpq.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Graf <graf@amazon.com> writes:

> Hey Ashish,
>
> On 09.04.24 22:42, Ashish Kalra wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> The patchset adds bits and pieces to get kexec (and crashkernel) work on
>> SNP guest.
>
>
> With this patch set (and similar for the TDX one), you enable the 
> typical kdump case, which is great!
>
> However, if a user is running with direct kernel boot - which is very 
> typical in SEV-SNP setup, especially for Kata Containers and similar - 
> the initial launch measurement is a natural indicator of the target 
> environment. Kexec basically allows them to completely bypass that: You 
> would be able to run a completely different environment than the one you 
> measure through the launch digest. I'm not sure it's a good idea to even 
> allow that by default in CoCo environments - at least not if the kernel 
> is locked down.

Isn't it the same when we just allow loading kernel modules? I'm sure
you can also achieve a 'completely different environment' with that :-)
With SecureBoot / lockdown we normally require modules to pass signature
check, I guess we can employ the same mechanism for kexec. I.e. in
lockdown, we require signature check on the kexec-ed kernel. Also, it
may make sense to check initramfs too (with direct kernel boot it's also
part of launch measurements, right?) and there's UKI for that already).

Personally, I believe that if we simply forbid kexec for CoCo in
lockdown mode, the feature will become mostly useless in 'full stack'
(which boot through firmware) production envrironments.

-- 
Vitaly


