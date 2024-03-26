Return-Path: <linux-kernel+bounces-118239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F9788B698
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C781C2F88C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949101F605;
	Tue, 26 Mar 2024 01:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYmWNdgi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5809B1CFBD
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711415468; cv=none; b=M5RPWxiIysyS8uQgzWWfuFO0czDSyE6Oefvgi+M06C3tnkRULKWskuaQl1c29z2itL9bsU/bGfnR121xf0fiqjNKQUllgnv17jW22u1XmliaoO69lXT8aMMec9xLCmb0GRKeYdJwIG5WLdTGQ+DTqq5BH7ilmPsULMvXTHTn3nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711415468; c=relaxed/simple;
	bh=po7QgAJL8TbIbWqpwn3Gkewj57D6ZlA18m7B7+zjkQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DVErziAZcwO/LW6XfpWD2TG4iYYN6NgBQJQ5DS7Pv366HPpGJnIzaCNqyeVdXsu5bT9UcUcPLS0J9vzpW38rBZoi8g+a6S6AYAElHpqp4T2FrNQa3V9AwupNkSgCL6mlT7pHRnEzR+AbTpfphb1M/Er/HIjlilC88TbVTl4TLLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYmWNdgi; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711415467; x=1742951467;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=po7QgAJL8TbIbWqpwn3Gkewj57D6ZlA18m7B7+zjkQw=;
  b=bYmWNdgiIACb/gMvAafpISt8MdLy3kOsvS9/3iqiBjKSVKArnpIXkeBb
   9LGpLSeZrFs8B1iD8QcoZUIV2e1ML0I20YqtuuUn+k1sKAgpZLnBBbd5C
   vMVYLd30cRbE3YM/4zfFcXhggVoNCDgK/G35SKBQ770XKJvmyH5/u9lBQ
   sCgQuI7rzLYrblhTgrtFwk2y6yS97Y0dCgNJrDH249Q6meFgGX/Gwth+E
   IeQnENMhxoWX89U0QSmnmbxeIqCeKPLG2/yxGsPi/bMZN/FEwjcDm1ErH
   79Ve7RGIGXZ+4JLLrtGhzY3bkCwnzTAs+nAHnOYYs122cWcAD2YZyo64K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="10226480"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="10226480"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 18:11:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="20520340"
Received: from dvidmant-mobl.amr.corp.intel.com (HELO [10.209.80.233]) ([10.209.80.233])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 18:10:59 -0700
Message-ID: <6b90b223-46e0-4e6d-a17c-5caf72e3c949@linux.intel.com>
Date: Mon, 25 Mar 2024 18:10:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] x86/sev: Hide SVSM attestation entries if not
 running under an SVSM
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
References: <cover.1709922929.git.thomas.lendacky@amd.com>
 <fabdf811d27a2539d1d016f75d95910b9bca24c4.1709922929.git.thomas.lendacky@amd.com>
 <fff67373-9c46-4023-8af9-70e62b9ab97c@intel.com>
 <112a1681-70d4-4826-b0b4-a0ff84750f9a@amd.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <112a1681-70d4-4826-b0b4-a0ff84750f9a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/25/24 7:05 AM, Tom Lendacky wrote:
> On 3/23/24 12:24, Kuppuswamy, Sathyanarayanan wrote:
>>
>> On 3/8/24 10:35 AM, Tom Lendacky wrote:
>>> Config-fs provides support to hide individual attribute entries. Using
>>> this support, base the display of the SVSM related entries on the presence
>>> of an SVSM.
>>>
>>> Cc: Joel Becker <jlbec@evilplan.org>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>>> ---
>>>   arch/x86/coco/core.c        |  4 ++++
>>>   drivers/virt/coco/tsm.c     | 13 +++++++++----
>>>   include/linux/cc_platform.h |  8 ++++++++
>>>   3 files changed, 21 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
>>> index d07be9d05cd0..efa0f648f754 100644
>>> --- a/arch/x86/coco/core.c
>>> +++ b/arch/x86/coco/core.c
>>> @@ -12,6 +12,7 @@
>>>     #include <asm/coco.h>
>>>   #include <asm/processor.h>
>>> +#include <asm/sev.h>
>>>     enum cc_vendor cc_vendor __ro_after_init = CC_VENDOR_NONE;
>>>   u64 cc_mask __ro_after_init;
>>> @@ -78,6 +79,9 @@ static bool noinstr amd_cc_platform_has(enum cc_attr attr)
>>>       case CC_ATTR_GUEST_STATE_ENCRYPT:
>>>           return sev_status & MSR_AMD64_SEV_ES_ENABLED;
>>>   +    case CC_ATTR_GUEST_SVSM_PRESENT:
>>> +        return snp_get_vmpl();
>>> +
>>>       /*
>>>        * With SEV, the rep string I/O instructions need to be unrolled
>>>        * but SEV-ES supports them through the #VC handler.
>>> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
>>> index 07b4c95ce704..2efa6e578477 100644
>>> --- a/drivers/virt/coco/tsm.c
>>> +++ b/drivers/virt/coco/tsm.c
>>> @@ -64,6 +64,11 @@ static struct tsm_report_state *to_state(struct tsm_report *report)
>>>       return container_of(report, struct tsm_report_state, report);
>>>   }
>>>   +static umode_t svsm_visibility(const struct config_item *item, const struct configfs_attribute *attr)
>>> +{
>>> +    return cc_platform_has(CC_ATTR_GUEST_SVSM_PRESENT) ? attr->ca_mode : 0;
>>> +}
>>> +
>>
>> Instead of directly checking for CC flags here, I am wondering if it would make
>> sense to add a callback to vendor drivers and let the callback decide whether
>> the attribute is valid or not? We can't add a CC flag for every ConfigFS attribute,
>> right? For example, privlevel is not used by TDX. If there is a callback, then
>> TDX driver can make this attribute invalid for it.
>
> I think that's something that can be looked at after this series.
>

Ok. Lets see what Dan also thinks about it.

IMO, CC flag is generally added when there is common code that can be shared
across multiple vendors.  And this particular use case is specific to SEV for now.
if we move this check to the vendor driver, you can use vendor specific call to
check for SVSM and don't require a new CC flag.

> Thanks,
> Tom
>
>>
>>>   static int try_advance_write_generation(struct tsm_report *report)
>>>   {
>>>       struct tsm_report_state *state = to_state(report);
>>> @@ -139,7 +144,7 @@ static ssize_t tsm_report_svsm_store(struct config_item *cfg,
>>>         return len;
>>>   }
>>> -CONFIGFS_ATTR_WO(tsm_report_, svsm);
>>> +CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, svsm, svsm_visibility);
>>>     static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
>>>                            const char *buf, size_t len)
>>> @@ -168,7 +173,7 @@ static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
>>>         return len;
>>>   }
>>> -CONFIGFS_ATTR_WO(tsm_report_, service_guid);
>>> +CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_guid, svsm_visibility);
>>>     static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg,
>>>                                const char *buf, size_t len)
>>> @@ -189,7 +194,7 @@ static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg
>>>         return len;
>>>   }
>>> -CONFIGFS_ATTR_WO(tsm_report_, service_manifest_version);
>>> +CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_manifest_version, svsm_visibility);
>>>     static ssize_t tsm_report_inblob_write(struct config_item *cfg,
>>>                          const void *buf, size_t count)
>>> @@ -336,7 +341,7 @@ static ssize_t tsm_report_manifestblob_read(struct config_item *cfg, void *buf,
>>>         return tsm_report_read(report, buf, count, TSM_MANIFEST);
>>>   }
>>> -CONFIGFS_BIN_ATTR_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX);
>>> +CONFIGFS_BIN_ATTR_VISIBLE_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX, svsm_visibility);
>>>     #define TSM_DEFAULT_ATTRS() \
>>>       &tsm_report_attr_generation, \
>>> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
>>> index cb0d6cd1c12f..f1b4266c1484 100644
>>> --- a/include/linux/cc_platform.h
>>> +++ b/include/linux/cc_platform.h
>>> @@ -90,6 +90,14 @@ enum cc_attr {
>>>        * Examples include TDX Guest.
>>>        */
>>>       CC_ATTR_HOTPLUG_DISABLED,
>>> +
>>> +    /**
>>> +     * @CC_ATTR_GUEST_SVSM_PRESENT: Guest is running under an SVSM
>>> +     *
>>> +     * The platform/OS is running as a guest/virtual machine and is
>>> +     * running under a Secure VM Service Module (SVSM).
>>> +     */
>>> +    CC_ATTR_GUEST_SVSM_PRESENT,
>>>   };
>>>     #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
>>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


