Return-Path: <linux-kernel+bounces-50963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AB0848458
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 08:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9041C26B44
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 07:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1777B4CB46;
	Sat,  3 Feb 2024 07:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eSV0czTl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E854B5C1;
	Sat,  3 Feb 2024 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706944417; cv=none; b=sZN25MFBDVozD6gjsoHU2I2/qT1VvGti9PtMNFOhjiwyFD1feq23tkK69a3o7b2wa4UPJTG0waDny2rApIX6Cn39AnP9VhtyY+qbY5uVPaEIB+jAVeQtbiiCQt4n73A/WNf68yFbD6GOR5Q7qWVDAQz9pPHpZgl07P5mGaDjQ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706944417; c=relaxed/simple;
	bh=FicCW69rF62g2VrQ+5UcTUBEh/cxkfw55Hhc0JdIl18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKc74PWFQjgp7TvvkyYaXTK6hiDpBJwEW/WPWcAsuTyYzWGhh/jM74clVl96GUjiQnE3QuXNB1NRrLIVtHAUTu5HoYC0HxSOI8tsEsub85fjT23z4vXVMq+EwdPH7CfQZ+FB3u1ytE1spKGj17+08xFy1O7rylHwIayLHY8IUvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eSV0czTl; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706944416; x=1738480416;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FicCW69rF62g2VrQ+5UcTUBEh/cxkfw55Hhc0JdIl18=;
  b=eSV0czTlws2nYvOHjDc9EfHrhlvsgGcqwOt4tYY4UaI2VR8/h+L650nz
   9xVPzRSs6+Kf7CjZscEdAIxmKCzucyGlcFvO2Pn9ewOMTdDLfC0bTypb3
   ehteVgCTcu72O1CEYE8aPzIXIUvsaR7HE7c4k17gdG1UjIi46NpCN+Ls2
   ej48hG9Welf1Qg8onl03ynwYp/W3lArR6kYXcyCkmB8n3oXW5iscI3U55
   fWmu2U0S8x7cDepj3+6/U0F6cIUaB9LrXS2IQrt6OiAnoozZLr2kfxHhB
   eZhTZqeNyTwbMSOPNPTteRcwv/fEBmrV2YY5fpLlovumvJCCp5/7sMrQj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10893440"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="10893440"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 23:13:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="274160"
Received: from ttroksa-mobl1.amr.corp.intel.com (HELO [10.251.2.3]) ([10.251.2.3])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 23:13:34 -0800
Message-ID: <1557f98a-3d52-4a02-992b-4401c7c85dd7@linux.intel.com>
Date: Fri, 2 Feb 2024 23:13:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
Content-Language: en-US
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Dan Middleton <dan.middleton@linux.intel.com>,
 Samuel Ortiz <sameo@rivosinc.com>, Dan Williams <dan.j.williams@intel.com>
Cc: Qinkun Bao <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>,
 "Xing, Cedric" <cedric.xing@intel.com>,
 Dionna Amalie Glaze <dionnaglaze@google.com>, biao.lu@intel.com,
 linux-coco@lists.linux.dev, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240128212532.2754325-1-sameo@rivosinc.com>
 <c17a31e4fb30f5f9d4a337e5bd8d54cc6f99eef7.camel@HansenPartnership.com>
 <a255bc36-2438-41b7-b304-bcf7a6628bef@linux.intel.com>
 <42e14f74d3819c95fdb97cd2e9b2829dcb1b1563.camel@HansenPartnership.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <42e14f74d3819c95fdb97cd2e9b2829dcb1b1563.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/2/24 10:03 PM, James Bottomley wrote:
> On Fri, 2024-02-02 at 17:07 -0600, Dan Middleton wrote:
>> On 2/2/24 12:24 AM, James Bottomley wrote:
>>> On Sun, 2024-01-28 at 22:25 +0100, Samuel Ortiz wrote:
>>>> All architectures supporting RTMRs expose a similar interface to
>>>> their TVMs: An extension command/call that takes a measurement
>>>> value and an RTMR index to extend it with, and a readback command
>>>> for reading an RTMR value back (taking an RTMR index as an
>>>> argument as well). This patch series builds an architecture
>>>> agnostic, configfs-based ABI for userspace to extend and read
>>>> RTMR values back. It extends the current TSM ops structure and
>>>> each confidential computing architecture can implement this
>>>> extension to provide RTMR support.
>>> What's the actual use case for this?  At the moment the TPM PCRs
>>> only provide a read interface to userspace (via
>>> /sys/class/tpm/tpmX/pcr-shaY/Z) and don't have any extension
>>> ability becuase nothing in userspace currently extends them.
>>>
>>> The only current runtime use for TPM PCRs is IMA, which is in-
>>> kernel (and which this patch doesn't enable).
>>>
>>> Without the ability to log, this interface is unusable anyway, but
>>> even with that it's not clear that you need the ability separately
>>> to extend PCRs because the extension and log entry should be done
>>> atomically to prevent the log going out of sync with the PCRs, so
>>> it would seem a log first interface would be the correct way of
>>> doing this rather than a PCR first one.
>>>
>>> James
>>>
>>>
>> While we clearly need to cover PCR-like usages, I think Confidential
>> Computing affords usages that go beyond TPM.
> Well, don't get me wrong, I think the ability to create non repudiable
> log entries from userspace is very useful.  However, I think the
> proposed ABI is wrong: it should take the log entry (which will contain
> the PCR number and the hash) then do the extension and add it to the
> log so we get the non-repudiable verifiability.  This should work
> equally with TPM and RTMR (and anything else).

Maybe I misunderstood your comments, but I am not sure why
the user ABI needs to change? I agree that logging after extension is
the right approach. But, IMO, it should be owned by the back end
TSM vendor drivers. The user ABI should just pass the digest and
RTMR index.

>
> The issue, I suppose, is what log format?  The TCG has one which is
> extensible and IMA uses a similar but different binary log format.

TDX uses EFI_TCG2_EVENT_LOG_FORMAT_TCG_2 log format. I think SEV is the
same.

https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#virtual-platform-cc-event-log

>
>> For example, Attested Containers [1] (and similar explorations in
>> CNCF Confidential Containers [2]) extends the measurement chain into
>> the guest. There, a trusted agent measures container images, and
>> extends an RTMR with those measurements. Particularly in the case of
>> containers, the  existing runtime infrastructure is user mode
>> oriented. However the generalization here is in providing a mechanism
>> to strongly identify an application or behavior provided by the TVM.
> There's a similar proposal for Keylime which was demo'd at Plumbers
> last year, except it uses IMA to measure the container so you only have
> to trust the kernel:
>
> https://lpc.events/event/17/contributions/1571/
>
>> Less concretely, I think this is an area for developer creativity.
>> Attestation is one of the main APIs that CC gives application
>> developers and
>> these runtime extendable fields provide a further degree of
>> creativity.
>>
>> [1] ACON https://github.com/intel/acon
> Just on this, lest we repeat the errors of the past (and believe me
> there was a time people thought that simply extending TPM PCRs without
> log entries was the way to do measurements), if you're extending a PCR
> like entity you also need a log entry to tell people who come after you
> what you've done.  Even in the one ephemeral VM per pod kata use case
> (with RTMRs local to the VM), you'll still likely be starting several
> sidecars and if you don't have a log to tell you the order you measured
> the containers deriving the RTMR value is a combinatoric explosion.
>
> James
>
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


