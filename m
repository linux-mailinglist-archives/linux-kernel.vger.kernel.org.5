Return-Path: <linux-kernel+bounces-145598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007008A5855
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B9A1F21AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D16A839F8;
	Mon, 15 Apr 2024 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kGOBxSNu"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E9C82862;
	Mon, 15 Apr 2024 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200365; cv=none; b=CVxFyTGDFn6HppUryIIgwUfFkUlzIUWA9H4PixcN+iiDcZR6c6ZP6S7WulvHAvPPce3xgW87NosOUoP+L80ig+dXCfnYQ3G0FGIThmdwF6tcpDhXAhX/+xpf2TwWEm+laVdFLCJyS7yrg9KEsil/snGRC77+EYfQcUKh4yNELOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200365; c=relaxed/simple;
	bh=O13GvU5BCT9jBH2CEsNd+5l0EKswBWOItdeZUFAgs4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UyQVBiHY9h+KR3LV7WkVsHOD1YcvRsp0F0dg7T5fNQSk9ph8ln7N69GmETO44Td9UixpzSHleN14q5RKkCkR/De1ZLyb+izbqnv8CPwCj01dDWDHaTyjQVSf9w4wBOqomOIh1ozAh0NaV9qw0uh0O9s5FxApbfFBx+koXZod69w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kGOBxSNu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.192.9.210] (unknown [167.220.77.82])
	by linux.microsoft.com (Postfix) with ESMTPSA id 02C1420FC5F5;
	Mon, 15 Apr 2024 09:59:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 02C1420FC5F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713200364;
	bh=1Y2iT+1AtzHxLD8oGSnFz0RaJt75iNC/M01LDDuCiXU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kGOBxSNuV/o15hSqeF5PJ0lBvo8x+fVs2dbyo8CrVulShFF2vS/mthOrmcJvjHtjO
	 0AZ4lG+6O6MkiQv0SctQQAYlnmht3vLQn9AJx2ZRpzZuSj7mPHwj1Cz7qRQnyAVn9Z
	 /I8HWxTuxfiI6lchkF9g9Z1gY0bilcHDxg6nbAUg=
Message-ID: <6081eadb-0879-4a7f-93a2-18a8132c0f83@linux.microsoft.com>
Date: Mon, 15 Apr 2024 09:59:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ACPI: CPPC: Fix access width used for PCC registers
To: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 "5 . 15+" <stable@vger.kernel.org>
References: <20240411231844.3306037-1-vanshikonda@os.amperecomputing.com>
Content-Language: en-CA
From: Jarred White <jarredwhite@linux.microsoft.com>
In-Reply-To: <20240411231844.3306037-1-vanshikonda@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/2024 4:18 PM, Vanshidhar Konda wrote:
> commit 2f4a4d63a193be6fd530d180bb13c3592052904c modified
> cpc_read/cpc_write to use access_width to read CPC registers. For PCC
> registers the access width field in the ACPI register macro specifies
> the PCC subspace id. For non-zero PCC subspace id the access width is
> incorrectly treated as access width. This causes errors when reading
> from PCC registers in the CPPC driver.
> 
> For PCC registers base the size of read/write on the bit width field.
> The debug message in cpc_read/cpc_write is updated to print relevant
> information for the address space type used to read the register.
> 
> Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> Tested-by: Jarred White <jarredwhite@linux.microsoft.com>
> Reviewed-by: Jarred White <jarredwhite@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> Cc: 5.15+ <stable@vger.kernel.org> # 5.15+

Hi Vanshi,

v3 changes are good. Thanks again for catching this!


Thanks,
Jarred

