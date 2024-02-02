Return-Path: <linux-kernel+bounces-50691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74632847CE7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC4F1C22467
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846FD12C7E7;
	Fri,  2 Feb 2024 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ek9puBpt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0503B85626;
	Fri,  2 Feb 2024 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706915261; cv=none; b=AagmConz+4OYOgtET9XRbpGjwsmr7G7WhqI8sT/lFRqiNtcUGujBXLE3gr/d7ZzoyqGlBNHvFfyjQ0neWX+3+tFuVAhUlrUYEwO/mFVxhic4ufSGv/enDhxF3VsenrPrNEqZtxrcy1uJuZ+c+F8d71tPQoPJ15KbKVB9jIujBxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706915261; c=relaxed/simple;
	bh=I4kgLC3tSksK++ityeMyPTC5f5gRQSkqZH6Pa8WTjlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cu4Nl/wIsBGEXGcSYBeNKdL34JmZ61Au8Y7Bh4UpdLkqmG2BhBX3j2/kLCf75iaXyHenacjCYowd2i9N68v3r+BxmFHvCaRW3jzvUNP701FtqvnQkoyb9xdWAGoynD19H0ky3qxBZYRhiODE0RmLO9vC9sC4cpe1hzV91u/o+yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ek9puBpt; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706915260; x=1738451260;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I4kgLC3tSksK++ityeMyPTC5f5gRQSkqZH6Pa8WTjlk=;
  b=ek9puBpt6DTFNskqJUKALFVx2NSJaxtblSJhEGNETN4htqvRBaN7saQB
   LKNacQuayRNgIst3Tv+YjyQ87783v0csrG+vpKQEvMKUNpkwoObHSG0eU
   XgU53uPKhOTh1+dPyBQeGak/6VWm/W2Mx9oM7E6UV7tyac/AR1PO8UKpw
   GjUG88TafV6AxSkLxp4qOs76GoSC6z//8k9Ibm8cgJLe03AQOBEw/qyoA
   lGsaBf7vAba+8e0YE24pQxBy/nfAc7BzlG1j4TZjB6gXubIDwMbASxVbA
   eRcRAFMyQEUijKOISuy4Cg1jb98+lBlNMnuEqoLLUFAi+vMVVxt4MCADC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="17672583"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="17672583"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 15:07:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4795159"
Received: from mfzarate-mobl.amr.corp.intel.com (HELO [10.92.4.37]) ([10.92.4.37])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 15:07:37 -0800
Message-ID: <a255bc36-2438-41b7-b304-bcf7a6628bef@linux.intel.com>
Date: Fri, 2 Feb 2024 17:07:35 -0600
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
 Samuel Ortiz <sameo@rivosinc.com>, Dan Williams <dan.j.williams@intel.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Qinkun Bao <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>,
 "Xing, Cedric" <cedric.xing@intel.com>,
 Dionna Amalie Glaze <dionnaglaze@google.com>, biao.lu@intel.com,
 linux-coco@lists.linux.dev, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240128212532.2754325-1-sameo@rivosinc.com>
 <c17a31e4fb30f5f9d4a337e5bd8d54cc6f99eef7.camel@HansenPartnership.com>
From: Dan Middleton <dan.middleton@linux.intel.com>
In-Reply-To: <c17a31e4fb30f5f9d4a337e5bd8d54cc6f99eef7.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/2/24 12:24 AM, James Bottomley wrote:
> On Sun, 2024-01-28 at 22:25 +0100, Samuel Ortiz wrote:
>> All architectures supporting RTMRs expose a similar interface to
>> their TVMs: An extension command/call that takes a measurement value
>> and an RTMR index to extend it with, and a readback command for
>> reading an RTMR value back (taking an RTMR index as an argument as
>> well). This patch series builds an architecture agnostic, configfs-
>> based ABI for userspace to extend and read RTMR values back. It
>> extends the current TSM ops structure and each confidential computing
>> architecture can implement this extension to provide RTMR support.
> What's the actual use case for this?  At the moment the TPM PCRs only
> provide a read interface to userspace (via /sys/class/tpm/tpmX/pcr-
> shaY/Z) and don't have any extension ability becuase nothing in
> userspace currently extends them.
>
> The only current runtime use for TPM PCRs is IMA, which is in-kernel
> (and which this patch doesn't enable).
>
> Without the ability to log, this interface is unusable anyway, but even
> with that it's not clear that you need the ability separately to extend
> PCRs because the extension and log entry should be done atomically to
> prevent the log going out of sync with the PCRs, so it would seem a log
> first interface would be the correct way of doing this rather than a
> PCR first one.
>
> James
>
>

While we clearly need to cover PCR-like usages, I think Confidential
Computing affords usages that go beyond TPM.

For example, Attested Containers [1] (and similar explorations in CNCF
Confidential Containers [2]) extends the measurement chain into the guest.
There, a trusted agent measures container images, and extends an RTMR
with those measurements. Particularly in the case of containers, the 
existing
runtime infrastructure is user mode oriented. However the generalization
here is in providing a mechanism to strongly identify an application or
behavior provided by the TVM.

Less concretely, I think this is an area for developer creativity.
Attestation is one of the main APIs that CC gives application developers and
these runtime extendable fields provide a further degree of creativity.

[1] ACON https://github.com/intel/acon
[2] CoCo 
https://github.com/confidential-containers/guest-components/commit/3c75201a8ba0327fb41b68b7e1521ff517e3ca9f

Regards,
Dan


