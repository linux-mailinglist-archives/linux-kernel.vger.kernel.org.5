Return-Path: <linux-kernel+bounces-167388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F718BA8D4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3688B22848
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECBD14A0B1;
	Fri,  3 May 2024 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EZ6v2x2H"
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0734714F62
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725147; cv=none; b=e1iW3tr3uCIVOxAcrN+SgA8m/VmIPv9GJipdq1bQh8YuUPDipqkfG/EuNa/6ZdyRSqan7DRqOls3RwXKUK1ZzGZol2nW/VLsKDcQNQMemERXH/PsCRsmEtNTJXOKOiJSwVul7YxW8vzszU6JvpoaN1KK+km7vhI+7cLh3TNGA2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725147; c=relaxed/simple;
	bh=oetKWZhXbUP/ZBwxmBeFuev6aODxLGweeHR7GrdJFAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cwTnxE2Tol/A5O51QXSoyNmLNuepC8Ck13pS4Elxu/HrVcP7AjeHkdXl8tMsSvdHWSUpUAHj1glicTNqptss2RHQTKV5NVgMltTn+2pjKdJ0fQVjN/a61MgTbGFcqeGj0K7F5quB/mV95bEqJNHiD1CLhl8Qrbb482iswiOoiCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EZ6v2x2H; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714725146; x=1746261146;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vgSYT6fxfReVODTChlrLY1yTZjM/kZAB6PbQPgue2kA=;
  b=EZ6v2x2HJETu/MEzsOQY2VQ/bM6ZzYFz/i9g47i57LUNQzMWnbhC1ugP
   MR4y6FPv2iBa3Ra+dSKZvhOWWqWyDAaFfMfTjqI7eWjnPQjY6Ed5hvXlg
   7c17/N+E1NZDjTh/ftTeEtMcqeIfYn17SRKUJadN2DvYbhv3B1Ntn+Doq
   g=;
X-IronPort-AV: E=Sophos;i="6.07,247,1708387200"; 
   d="scan'208";a="398851930"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 08:32:22 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:9532]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.38:2525] with esmtp (Farcaster)
 id 26a7d38d-e059-4d36-a735-3275faea70a5; Fri, 3 May 2024 08:32:21 +0000 (UTC)
X-Farcaster-Flow-ID: 26a7d38d-e059-4d36-a735-3275faea70a5
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 3 May 2024 08:32:21 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 3 May
 2024 08:32:15 +0000
Message-ID: <c2732461-e768-4356-82ce-a80c73997f02@amazon.com>
Date: Fri, 3 May 2024 10:32:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] x86/snp: Add kexec support
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Ashish Kalra
	<Ashish.Kalra@amd.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: <rafael@kernel.org>, <peterz@infradead.org>, <adrian.hunter@intel.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <jun.nakajima@intel.com>,
	<rick.p.edgecombe@intel.com>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <seanjc@google.com>, <kai.huang@intel.com>,
	<bhe@redhat.com>, <kirill.shutemov@linux.intel.com>, <bdas@redhat.com>,
	<dionnaglaze@google.com>, <anisinha@redhat.com>, <jroedel@suse.de>,
	<ardb@kernel.org>, <kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <cover.1712694667.git.ashish.kalra@amd.com>
 <26b3b3b5-548d-4ebd-9d21-19580a41e799@amazon.com> <87msp8mmpq.fsf@redhat.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <87msp8mmpq.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)


On 02.05.24 14:18, Vitaly Kuznetsov wrote:
> Alexander Graf <graf@amazon.com> writes:
>
>> Hey Ashish,
>>
>> On 09.04.24 22:42, Ashish Kalra wrote:
>>> From: Ashish Kalra <ashish.kalra@amd.com>
>>>
>>> The patchset adds bits and pieces to get kexec (and crashkernel) work on
>>> SNP guest.
>>
>> With this patch set (and similar for the TDX one), you enable the
>> typical kdump case, which is great!
>>
>> However, if a user is running with direct kernel boot - which is very
>> typical in SEV-SNP setup, especially for Kata Containers and similar -
>> the initial launch measurement is a natural indicator of the target
>> environment. Kexec basically allows them to completely bypass that: You
>> would be able to run a completely different environment than the one you
>> measure through the launch digest. I'm not sure it's a good idea to even
>> allow that by default in CoCo environments - at least not if the kernel
>> is locked down.
> Isn't it the same when we just allow loading kernel modules? I'm sure
> you can also achieve a 'completely different environment' with that :-)
> With SecureBoot / lockdown we normally require modules to pass signature
> check, I guess we can employ the same mechanism for kexec. I.e. in
> lockdown, we require signature check on the kexec-ed kernel. Also, it
> may make sense to check initramfs too (with direct kernel boot it's also
> part of launch measurements, right?) and there's UKI for that already).


Correct. With IMA, you even do exactly that: Enforce a signature check 
of the next binary with kexec.

The problem is that you typically want to update the system because 
something is broken; most likely your original environment had a 
security issue somewhere. From a pure SEV-SNP attestation point of view, 
you can not distinguish between the patched and unpatched environment: 
Both look the same.

So while kexec isn't the problem, it's the fact that you can't tell 
anyone that you're now running a fixed version of the code :).


> Personally, I believe that if we simply forbid kexec for CoCo in
> lockdown mode, the feature will become mostly useless in 'full stack'
> (which boot through firmware) production envrironments.


I'm happy for CoCo to stay smoke and mirrors :). But I believe that if 
you want to genuinely draw a trust chain back to an AMD/Intel 
certificate, we need to come up with a good way of making updates work 
with a working trust chain so that whoever checks whether you're running 
sanctioned code is able to validate the claim.


Alex


