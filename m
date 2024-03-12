Return-Path: <linux-kernel+bounces-99852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 747EE878E53
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78201F228A9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926BA2B2D7;
	Tue, 12 Mar 2024 05:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IrBY+nO3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB39FECC
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 05:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710223046; cv=none; b=HwZpiRsN1G6x20cNVB7Xnq35YDIG/Wq6J0oIHgsnZgWOTAKVR0BoR9kEtP55WjiMew7+6d69lZO3GpXZHT5lN8BGawyl4AxLd5voCGA2zB9V/aVbuFJYvvtP1njx9sTM1wuNECza4OoXU5PDPO5Zf2XXws8cfz9M5hoI6lXRXlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710223046; c=relaxed/simple;
	bh=BHVgi0sIBN+jZAkaSd+ERPJlhw4+5J9qwW41gm3rHdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXReS6F4de+1CvDkHa721xPOCJlMrTQZs+J3dZ/lgOfVsSq+0fNGu50vUX4ZllgFrwAYBPUvIQiaXwbU40TbSfa4N6Wz6J/bEDT6dp9nD0FCgr819RYHrlz/r8oE7OW7ugOFxCL/tMA+KhiWtyanrT6idWpaarZdcNGbwe6uriM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IrBY+nO3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710223045; x=1741759045;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BHVgi0sIBN+jZAkaSd+ERPJlhw4+5J9qwW41gm3rHdk=;
  b=IrBY+nO3qiJ2MzYroL/mkcBQ7T8jtF1rvLwnk8M+8jXZXEz+jaSpgt7n
   XptmcGrnaLJvSyh3iPbToMX4wyZJanQvcL2WTan1Su+A0Fq9vHoNbiq9m
   PIDc4W3SH2xz3bfZnnVL2kMDsgtgdsCb8zhB90N/tKP0ksXt+Xt0G3Q3c
   mmJRzcGsnWe06PRgYdcMiv3UUBVWSIfHZgPstZA2+GKOBft+OHiszk0qj
   DBEv7v3YQQZOUZYeabzUCa51TUSpbZimDK/5D9TmeBQGXf9DDuIq7B/vF
   8vhd4Ok5M7XCfBYd6iMWHRcABy8FXUSqtuL3hJgUmKENVM/V59ffwJ6P/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="5051669"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="5051669"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 22:57:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="16114065"
Received: from sbrowne-mobl.amr.corp.intel.com (HELO [10.209.68.239]) ([10.209.68.239])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 22:57:24 -0700
Message-ID: <fa7cee6f-954b-4acf-a438-17ae3d1e781a@linux.intel.com>
Date: Mon, 11 Mar 2024 22:57:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] x86/sev: Extend the config-fs attestation
 support for an SVSM
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1709922929.git.thomas.lendacky@amd.com>
 <a6d236e247c4a0258e5e28c7378350389997cc59.1709922929.git.thomas.lendacky@amd.com>
 <93f36ae1-35b3-4852-8b36-3277f250408e@intel.com>
 <805b863c-1631-477d-9faf-f7569a8d80e4@amd.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <805b863c-1631-477d-9faf-f7569a8d80e4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/11/24 9:16 AM, Tom Lendacky wrote:
> On 3/10/24 00:06, Kuppuswamy, Sathyanarayanan wrote:
>>
>> On 3/8/24 10:35 AM, Tom Lendacky wrote:
>>> When an SVSM is present, the guest can also request attestation reports
>>> from the SVSM. These SVSM attestation reports can be used to attest the
>>> SVSM and any services running within the SVSM.
>>>
>>> Extend the config-fs attestation support to allow for an SVSM attestation
>>> report. This involves creating four (4) new config-fs attributes:
>>>
>>>    - 'svsm' (input)
>>>      This attribute is used to determine whether the attestation request
>>>      should be sent to the SVSM or to the SEV firmware.
>>>
>>>    - 'service_guid' (input)
>>>      Used for requesting the attestation of a single service within the
>>>      SVSM. A null GUID implies that the SVSM_ATTEST_SERVICES call should
>>>      be used to request the attestation report. A non-null GUID implies
>>>      that the SVSM_ATTEST_SINGLE_SERVICE call should be used.
>>>
>>>    - 'service_manifest_version' (input)
>>>      Used with the SVSM_ATTEST_SINGLE_SERVICE call, the service version
>>>      represents a specific service manifest version be used for the
>>>      attestation report.
>>>
>>>    - 'manifestblob' (output)
>>>      Used to return the service manifest associated with the attestation
>>>      report.
>>>
>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>>> ---
>>>   Documentation/ABI/testing/configfs-tsm  |  59 ++++++++++
>>>   arch/x86/include/asm/sev.h              |  31 ++++-
>>>   arch/x86/kernel/sev.c                   |  50 ++++++++
>>>   drivers/virt/coco/sev-guest/sev-guest.c | 147 ++++++++++++++++++++++++
>>>   drivers/virt/coco/tsm.c                 |  95 ++++++++++++++-
>>>   include/linux/tsm.h                     |  11 ++
>>>   6 files changed, 390 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
>>> index dd24202b5ba5..a4663610bf7c 100644
>>> --- a/Documentation/ABI/testing/configfs-tsm
>>> +++ b/Documentation/ABI/testing/configfs-tsm
>
>>> +
>>> +What:        /sys/kernel/config/tsm/report/$name/svsm
>>> +Date:        January, 2024
>>> +KernelVersion:    v6.9
>>> +Contact:    linux-coco@lists.linux.dev
>>> +Description:
>>> +        (WO) Attribute is visible if a TSM implementation provider
>>> +        supports the concept of attestation reports for TVMs running
>>> +        under an SVSM, like SEV-SNP. Specifying a 1 (or other boolean
>>
>> Since service_guid can be used for non SVSM services as well, can we use
>> a generic term "service" here? And let user specify the service type
>> (like service=svsm)
>
> I suppose that's possible. I think we would need a better term than just service, though, since service_guid is specific to a service within the service provider... so maybe service_provider.

I am ok with service_provider

>
>>
>>> +        equivalent, e.g. "Y") implies that the attestation report
>>> +        should come from the SVSM.
>>> +        Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
>>> +        https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
>>> +
>>> +What:        /sys/kernel/config/tsm/report/$name/service_guid
>>> +Date:        January, 2024
>>> +KernelVersion:    v6.9
>>> +Contact:    linux-coco@lists.linux.dev
>>> +Description:
>>> +        (WO) Attribute is visible if a TSM implementation provider
>>> +        supports the concept of attestation reports for TVMs running
>>> +        under an SVSM, like SEV-SNP. Specifying a empty or null GUID
>>> +        (00000000-0000-0000-0000-000000) requests all active services
>>> +        within the SVSM be part of the attestation report. Specifying
>>> +        a non-null GUID requests an attestation report of just the
>>> +        specified service using the manifest form specified by the
>>> +        service_manifest_version attribute.
>>> +        Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
>>> +        https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
>>> +
>>
>> I think it will be useful to the user if there is a attribute to list the service GUIDs
>> supported. It can help prevent user using incorrect or unsupported GUIDs.
>
> A list of supported GUIDs can be obtained from the manifest of a all-services attestation request.

So they have to make a request twice? Once with a NULL GUID to get the
manifest with all service list, and another to make service-specific request?
There should be a fixed list of service GUIDs, right? Why not list them by
default?

>
>>  >> +    if (guid_is_null(&desc->service_guid)) {
>>> +        call_id = SVSM_ATTEST_CALL(SVSM_ATTEST_SERVICES);
>>> +    } else {
>>> +        export_guid(attest_call.service_guid, &desc->service_guid);
>>> +        attest_call.service_manifest_version = desc->service_manifest_version;
>>> +
>>> +        call_id = SVSM_ATTEST_CALL(SVSM_ATTEST_SINGLE_SERVICE);
>>> +    }
>>
>> Above initialization will not change during retry, right? Why not move it above
>> retry?
>
> True, will move it outside of the loop.
>
>>
>
>>> +
>>> +    /* Obtain the GUID string length */
>>> +    guid_len = (len && buf[len - 1] == '\n') ? len - 1 : len;
>>> +    if (guid_len && guid_len != UUID_STRING_LEN)
>>> +        return -EINVAL;
>>> +
>>
>> I don't think you need above checks. I think guid_parse will fail, if it is not
>> a valid GUID.
>
> Yes and no. The guid_parse() function will succeed if the string is longer than UUID_STRING_LEN as long as it is a valid UUID up to UUID_STRING_LEN. In other words, guid_parse() of:
>
>     aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee
>
> and
>     aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee-gg
>
> both succeed.
>
> I'm ok with eliminating the length calculation and check if everyone is in favor of doing that given the above behavior.

Got it. Existing callers of guid_parse() does not seem to care about it. But I am fine either way.

>
>>
>>> +    if (guid_len == UUID_STRING_LEN) {
>>> +        rc = guid_parse(buf, &report->desc.service_guid);
>>> +        if (rc)
>>> +            return rc;
>>> +    } else {
>>> +        report->desc.service_guid = guid_null;
>>
>> I think the default value will be guid_null right, why reset it to NULL for every failed attempt?
>
> Default, yes. But what if it is written once, then a second time with an invalid GUID. Should the previously written GUID still be used?
>

If the user write fails, why update the state? IMO, we can leave it at the old value. But, lets see what others think.

> Thanks,
> Tom
>
>>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


