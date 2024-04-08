Return-Path: <linux-kernel+bounces-135902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A693489CCE4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E811F234C5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7390E146A70;
	Mon,  8 Apr 2024 20:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gDabHaWJ"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7588738DD6;
	Mon,  8 Apr 2024 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712607542; cv=none; b=q33G/nEjzPUp9aua9xF160/EUtEEBE6u6vDQoCD/ti7i1Zikgijp5BmAZImFIVf2ME8wl9vAI2eri9njwvN0RI6EMEwtFkJxBD7xT228fTfnEwxwlUlGVNRYIv6ovtfdAAYTk73IBEqtCknOthodzJIcJhUZfH2MY4kMrxchng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712607542; c=relaxed/simple;
	bh=NyGs5314UvkFHv1BlockzhAUPYtZOtClRMMt7esdDqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVV3NoVZiLTK2MmyY93Uj8EeHA66QSrGYKnz8ansq8WoGBV7DXeR2i460av/RONOWiFu3UqBh1O5xMeyXn9cTjZULEiZl/qOUxOMu+RhLGRcywnNuSKqBFfYo3dcoIqwf6CNWAtRN7+WoRoncXOx9Y8Ak31R77wrO0OHydOLXx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gDabHaWJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.192.9.210] (unknown [167.220.77.82])
	by linux.microsoft.com (Postfix) with ESMTPSA id 263C420EA446;
	Mon,  8 Apr 2024 13:19:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 263C420EA446
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712607541;
	bh=9CF14shWGmvFsYBJo5BENhzax76hIR6cw6nC81BBl28=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gDabHaWJXTKV4YaGT3f+cIScqkWv1ydP++c3PyNvWXyg9ElLEh78f7AzvkTlRrLHz
	 hJowEX//MygT3PwRWBh1mip8XfJAb/3g4QFDMZNFh/ERQegcIUwCU4ZD7TVgk06nSK
	 9WF8lvgAyA8WqV6AIWm62PIvvU9YEnzT+bKoR+bc=
Message-ID: <365b430b-d91c-4391-bfc4-ea6a3444cb43@linux.microsoft.com>
Date: Mon, 8 Apr 2024 13:19:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] ACPI: CPPC: Fix access width used for PCC
 registers
To: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240329220054.1205596-1-vanshikonda@os.amperecomputing.com>
 <eecf5b00-0b61-46a8-82d9-a3c113f2d956@linux.microsoft.com>
 <m2m7qytrlhdvht7ro6hee2msi2bd5j733yagdakyjfxi2su46i@nj77lj3ulqp7>
Content-Language: en-CA
From: Jarred White <jarredwhite@linux.microsoft.com>
In-Reply-To: <m2m7qytrlhdvht7ro6hee2msi2bd5j733yagdakyjfxi2su46i@nj77lj3ulqp7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/2024 10:45 AM, Vanshidhar Konda wrote:
> On Mon, Apr 01, 2024 at 09:48:28AM -0700, Easwar Hariharan wrote:
>> Hi Vanshi,
>>
>> Thanks for testing and catching this. One comment below, but Jarred is 
>> OOF for a couple days so
>> we'll get back again after testing on our platform.
>>
>> On 3/29/2024 3:00 PM, Vanshidhar Konda wrote:
>>> Commit 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for
>>> system memory accesses") modified cpc_read/cpc_write to use 
>>> access_width to
>>> read CPC registers. For PCC registers the access width field in the ACPI
>>> register macro specifies the PCC subspace id. For non-zero PCC 
>>> subspace id
>>> the access width is incorrectly treated as access width. This causes 
>>> errors
>>> when reading from PCC registers in the CPPC driver.
>>>
>>> For PCC registers base the size of read/write on the bit width field.
>>> The debug message in cpc_read/cpc_write is updated to print relevant
>>> information for the address space type used to read the register.
>>>
>>> Fixes: 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for 
>>> system memory accesses")
>>> Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
>>> ---

Hi Vanshi,

The patch is good.

You can add,
Reviewed-by: Jarred White <jarredwhite@linux.microsoft.com>
Tested-by: Jarred White <jarredwhite@linux.microsoft.com>

We also found another bug in the process of testing, which we will 
submitting a patch for.


Thanks,
Jarred


