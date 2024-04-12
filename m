Return-Path: <linux-kernel+bounces-142445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18E18A2BA6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914301F23257
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5797E5336D;
	Fri, 12 Apr 2024 09:57:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A3152F92;
	Fri, 12 Apr 2024 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915854; cv=none; b=D0eyPJFLG8V9jniwra8We3gMwW0Bps8Auj6gMWT6Wy7WK9Li0/X+PNS3SKCTfMcaL3EUfHOsUsgITtl6r+EelWlUrlPgaD6gjsSqnyBl94YYXn8wNHCrRL1YAG154QzEWXy8w1v7Jy1WubYayr8K9EJE+aqHEBEzaz73oqIdt7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915854; c=relaxed/simple;
	bh=9ta90R5dH9mhamLwVYs0q7+kUmW2cMPBIFTryHHTN/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oslGiXZsVBypZIXJKkIhHrBimaRuaecz/ddisbNZdD78EYJFx4ymm1pfwYoC3ncCwAwg1BLLuhKwDixjwzQYarK5Bq+ZeaL0a7n7sfxXGCdeTWjlIp5G3IlyzOkrGXIZLF235fdOYl4zZOrpXI7LbDzeiWMjbMFTshUh55PZ93A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9581339;
	Fri, 12 Apr 2024 02:58:01 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 092CB3F64C;
	Fri, 12 Apr 2024 02:57:30 -0700 (PDT)
Message-ID: <3c5c85d4-8657-4ee0-88fa-ee47dce4cc7c@arm.com>
Date: Fri, 12 Apr 2024 10:57:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/7] coresight: tmc-etr: Add support to use reserved
 trace memory
To: Linu Cherian <lcherian@marvell.com>, suzuki.poulose@arm.com
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com,
 Anil Kumar Reddy <areddy3@marvell.com>, mike.leach@linaro.org,
 leo.yan@linaro.org
References: <20240307033625.325058-1-lcherian@marvell.com>
 <20240307033625.325058-3-lcherian@marvell.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240307033625.325058-3-lcherian@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 07/03/2024 03:36, Linu Cherian wrote:
> Add support to use reserved memory for coresight ETR trace buffer.
> 
> Introduce a new ETR buffer mode called ETR_MODE_RESRV, which
> becomes available when ETR device tree node is supplied with a valid
> reserved memory region.
> 
> ETR_MODE_RESRV can be selected only by explicit user request.
> 
> $ echo resrv >/sys/bus/coresight/devices/tmc_etr<N>/buf_mode_preferred
> 
> Signed-off-by: Anil Kumar Reddy <areddy3@marvell.com>
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
> Changelog from v6:
> * Removed redundant goto statements
> * Setting of etr_buf->size to the reserved memory size is done
>   after successful dma map inside the alloc function
> * Removed the special casing for ETR_MODE_RESRV 
> * Fixed the tab spacing in struct tmc_drvdata 
> 
>  .../hwtracing/coresight/coresight-tmc-core.c  | 47 +++++++++++
>  .../hwtracing/coresight/coresight-tmc-etr.c   | 82 ++++++++++++++++++-
>  drivers/hwtracing/coresight/coresight-tmc.h   | 27 ++++++
>  3 files changed, 153 insertions(+), 3 deletions(-)
> 

[...]

>  static bool etr_can_use_flat_mode(struct etr_buf_hw *buf_hw, ssize_t etr_buf_size)
> @@ -874,13 +947,10 @@ static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
>  	if (!etr_buf)
>  		return ERR_PTR(-ENOMEM);
>  
> -	etr_buf->size = size;
> -

Hi Linu,

Not sure if this was left in by mistake? It's not mentioned in the
commit message and it doesn't seem to match the description.

Please make sure the current tests pass both with and without a reserved
buffer defined in the DT. I get lots of failures with this patchset
applied on N1SDP. ETF seems to work but ETR doesn't:

  $ sudo perf test -vvv "arm coresight"

  Recording trace (only user mode) with path: CPU1 => tmc_etf0
  CoreSight path testing (CPU1 -> tmc_etf0): PASS

  Recording trace (only user mode) with path: CPU1 => tmc_etr0
  CoreSight path testing (CPU1 -> tmc_etr0): FAIL
  ...

Dmesg:
  [ 1938.622091] coresight tmc_etr0: Unable to allocate ETR buffer

>  	/* If there is user directive for buffer mode, try that first */
>  	if (drvdata->etr_mode != ETR_MODE_AUTO)
>  		rc = tmc_etr_mode_alloc_buf(drvdata->etr_mode, drvdata,
>  					    etr_buf, node, pages);
> -

Whitespace change.


