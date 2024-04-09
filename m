Return-Path: <linux-kernel+bounces-136251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1C189D1EB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2836CB2264D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872696EB5D;
	Tue,  9 Apr 2024 05:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RvE29wyt"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CFB57334;
	Tue,  9 Apr 2024 05:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712640517; cv=none; b=SgqcdXlP2Wr9uoPbJsNdIJJzf6QAY4HtPMSPH+yZ5j2Xu1tKUpQJubZUrL0Nu/PQxgiZkHCcqdIMBwjjlbL1oH//AkBwpXt/Y+5uyLEB9y2K169ghCE38TtEN2b38KS33tf3Ovi5FoYDRDioLwuhYZ//CssCEVYxSjtjk9beq48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712640517; c=relaxed/simple;
	bh=B0pJGBgPBVixNPy3sScpcMt39X7U/94nLsgy28kNzVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqBoXmTsJ+UnTLNk+6l5Wmemc5HL4wQyF4UgV3I3Cq6hvofIp7GCZak/4yTjczZfA3TJtk05BeaPgUXX1Khz5v23uKYeTnCARxT1u6fsRJzT8sZ0LmtmeY6jh2B3mlgry/tHudD115RwTWZ8MjuWIAo7K5ZmCYFvwxnMGT4US+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RvE29wyt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.208.45] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0938A20EA451;
	Mon,  8 Apr 2024 22:28:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0938A20EA451
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712640516;
	bh=B0pJGBgPBVixNPy3sScpcMt39X7U/94nLsgy28kNzVI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RvE29wyt8fCX7daJqWxVlv5ePuCEBu+uLrjfs3Hox1yMhRFURT7LSRTdjbo0IvLn8
	 3Va3pxAYA4pYAZUBo0G4MozP6iigrpMpug/rJNPYs/cmMgq19haKrAZUxVQHyl4pGP
	 admw9QNLNU4W8HTNtd4PfdCpRQth15C3W5eNUU6w=
Message-ID: <694fdd96-cc6e-4a4e-aff5-3284cd3ada4e@linux.microsoft.com>
Date: Mon, 8 Apr 2024 22:28:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] ACPI: CPPC: Fix access width used for PCC
 registers
To: Jarred White <jarredwhite@linux.microsoft.com>,
 Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240329220054.1205596-1-vanshikonda@os.amperecomputing.com>
 <eecf5b00-0b61-46a8-82d9-a3c113f2d956@linux.microsoft.com>
 <m2m7qytrlhdvht7ro6hee2msi2bd5j733yagdakyjfxi2su46i@nj77lj3ulqp7>
 <365b430b-d91c-4391-bfc4-ea6a3444cb43@linux.microsoft.com>
Content-Language: en-CA
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <365b430b-d91c-4391-bfc4-ea6a3444cb43@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/8/2024 1:19 PM, Jarred White wrote:
> On 4/1/2024 10:45 AM, Vanshidhar Konda wrote:
>> On Mon, Apr 01, 2024 at 09:48:28AM -0700, Easwar Hariharan wrote:
>>> Hi Vanshi,
>>>
>>> Thanks for testing and catching this. One comment below, but Jarred is OOF for a couple days so
>>> we'll get back again after testing on our platform.
>>>
>>> On 3/29/2024 3:00 PM, Vanshidhar Konda wrote:
>>>> Commit 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for
>>>> system memory accesses") modified cpc_read/cpc_write to use access_width to
>>>> read CPC registers. For PCC registers the access width field in the ACPI
>>>> register macro specifies the PCC subspace id. For non-zero PCC subspace id
>>>> the access width is incorrectly treated as access width. This causes errors
>>>> when reading from PCC registers in the CPPC driver.
>>>>
>>>> For PCC registers base the size of read/write on the bit width field.
>>>> The debug message in cpc_read/cpc_write is updated to print relevant
>>>> information for the address space type used to read the register.
>>>>
>>>> Fixes: 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
>>>> Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
>>>> ---

Hi Vanshi,

When you send v2 for the SystemMemory space fixes, could you add CC: stable@vger.kernel.org # 5.15+
to your commit message, since your patch fixes 2f4a4d63a193 that was marked for stable?

Thanks,
Easwar


