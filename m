Return-Path: <linux-kernel+bounces-166420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675BC8B9A65
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FEFD1C21075
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD7075817;
	Thu,  2 May 2024 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="F/GUMhBr"
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9D16CDCC
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 12:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714651280; cv=none; b=n3oj79ZXT1NPqUMvJpruwDsMKJlWQ9NuACUDpsc+kn4s78YFpzhageYOxdZHPJbN/Rnpd4nBDtet7SGVcFtqyhk4nU28Sv1y7nAmx+kxLVHCKIr6MheE/5EcaAm4GGqiKmKL6LCRDl219x5JcVdNZ5ueCet0y8TnMHGWrm1GGDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714651280; c=relaxed/simple;
	bh=U6BWz0nJPEgHH7b0DgjM0MSWQOGPd3vZX/l4RXo5JfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OVszRzU18oDDSQYkquiUfqEnTJpcxHPHel2nmT/4SfTTG+AGNTnEDK3ArINcohOmNnVZ3el60tjbE3bxyNaEVA+O2702njegrpxdkic96s47THdi08srlJOx9XEZ4oaiYFmIp9aODksrmgnIpg7xzFAQm36DRGcGigF8YhWJNNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=F/GUMhBr; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714651280; x=1746187280;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e7tDSC9p8oy5ChHErHE1oCbmu4OKOhTaSgDmPzR2GlY=;
  b=F/GUMhBrY63dO3QywpNrIVzDYlHhO9jATSqmu8sOoDzHjVfF8aFRIe2k
   ecUmelW4qAMDWHKK625YE0+1ObCWUF6JrPlwE5LqVBnXuoaLiG+hc3YTo
   KqNU+xEQVqbUdRcxbjz3wRgz0M4AiMkC9Q4nMWW2wQW6AAo83MoQIw+Ef
   8=;
X-IronPort-AV: E=Sophos;i="6.07,247,1708387200"; 
   d="scan'208";a="292197737"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 12:01:18 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:1724]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.7:2525] with esmtp (Farcaster)
 id 74eaa98e-3cdf-42c3-987a-590178113d5b; Thu, 2 May 2024 12:01:17 +0000 (UTC)
X-Farcaster-Flow-ID: 74eaa98e-3cdf-42c3-987a-590178113d5b
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 2 May 2024 12:01:16 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Thu, 2 May
 2024 12:01:11 +0000
Message-ID: <26b3b3b5-548d-4ebd-9d21-19580a41e799@amazon.com>
Date: Thu, 2 May 2024 14:01:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] x86/snp: Add kexec support
To: Ashish Kalra <Ashish.Kalra@amd.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: <rafael@kernel.org>, <peterz@infradead.org>, <adrian.hunter@intel.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <jun.nakajima@intel.com>,
	<rick.p.edgecombe@intel.com>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <seanjc@google.com>, <kai.huang@intel.com>,
	<bhe@redhat.com>, <kirill.shutemov@linux.intel.com>, <bdas@redhat.com>,
	<vkuznets@redhat.com>, <dionnaglaze@google.com>, <anisinha@redhat.com>,
	<jroedel@suse.de>, <ardb@kernel.org>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <cover.1712694667.git.ashish.kalra@amd.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <cover.1712694667.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)

Hey Ashish,

On 09.04.24 22:42, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
>
> The patchset adds bits and pieces to get kexec (and crashkernel) work on
> SNP guest.


With this patch set (and similar for the TDX one), you enable the 
typical kdump case, which is great!

However, if a user is running with direct kernel boot - which is very 
typical in SEV-SNP setup, especially for Kata Containers and similar - 
the initial launch measurement is a natural indicator of the target 
environment. Kexec basically allows them to completely bypass that: You 
would be able to run a completely different environment than the one you 
measure through the launch digest. I'm not sure it's a good idea to even 
allow that by default in CoCo environments - at least not if the kernel 
is locked down.

Do you have any plans to build a CoCo native kexec where you allow a VM 
to create a new VM context with a guest provided seed? The new context 
could rerun all of the attestation and so enable users to generate a new 
launch digest. If you then atomically swap into the new context, it 
would in turn enable them to natively "kexec" into a completely new VM 
context including measurements.

I understand that an SVSM + TPM implementation may help to some extent 
here by integrating with IMA and adding the new kernel into the IMA log. 
But that quickly becomes very convoluted (hence difficult to assess 
correctness for) and the same measurement question arises just one level 
up then: How do you update your SVSM while maintaining a full 
measurement and trust chain?


Thanks,

Alex


