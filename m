Return-Path: <linux-kernel+bounces-159039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 206008B2885
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5B851F23A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBA315382C;
	Thu, 25 Apr 2024 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJLZIrJ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F253C14D717;
	Thu, 25 Apr 2024 18:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071254; cv=none; b=mIH+QUNoMGygEibkY/6kz0SWXcxr5s4dwblhM503NpnPO/7uHR/gLXtJqFx3AGaSq8PiT7VZl2cMESIq5gMuPWVsSBjTXBRkYXiG0r22pDhr6Ul07B5lTDMGXIXP1LVN2NrbKgW0IcTwr1FQn/e3EvtCwRBamMP45Plapt1oKZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071254; c=relaxed/simple;
	bh=VHygvCCRWd06KRLxvoIjlwQSyIzeulJmYat5rXiYnos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHuwPIpzjanNMWsNJx5HQSM+0aLUn57M8EEMqdzNT92m3u3etJ1+DTQ+n1i8IipmR89+SfM2X9U+0lvwUZbavgE3NdtYwOJ0h4Fv6xBZzZO/PRi9ENcO6yh2g9FmjvUNFW+2eeoRypjlkXBYuuH5RXTguJo7Ew71798E64t+P6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJLZIrJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A85C113CE;
	Thu, 25 Apr 2024 18:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714071253;
	bh=VHygvCCRWd06KRLxvoIjlwQSyIzeulJmYat5rXiYnos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJLZIrJ2jOfVBxdZZO8Xu7HvIWntCKIen2xW2kNJjuky1RFpERio0vEOKQuOksRgM
	 rTocEtwIKjZWX7kVzdnsT28QCuXdPDbWB35cPTsMpabjNmF2f4xqbtbCUdeAtqoumO
	 ZwI2P3JJPcMdptlZwYPrujIUYyLT3YDq2EqCJoFTEPrsLFc4iEIpJJhk2TvoBkVt0i
	 m1qjvldXGPGEjXmH56nvYNP8wJLaLaYJuprTrgE8UYxpJGkr0BrU/u5RS1+CmIP0WN
	 5FcoyAbIbP0KMXMGmXdLoKcf+uDZofQ7rhX8ZIRSzO2G612vQTJ2iW3mcNvkzJ0NSt
	 nOpiVfpC6DAPg==
Date: Thu, 25 Apr 2024 15:54:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Tanmay Jagdale <tanmay@marvell.com>
Cc: john.g.garry@oracle.com, will@kernel.org, james.clark@arm.com,
	mike.leach@linaro.org, leo.yan@linux.dev, suzuki.poulose@arm.com,
	peterz@infradead.org, mingo@redhat.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com
Subject: Re: [PATCH V2 0/2] Fix Coresight instruction synthesis logic
Message-ID: <Ziqm0QYfGbYjF6xh@x1>
References: <20240404180731.7006-1-tanmay@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240404180731.7006-1-tanmay@marvell.com>

On Thu, Apr 04, 2024 at 11:37:29PM +0530, Tanmay Jagdale wrote:
> When we use perf to catpure Coresight trace and generate instruction
> trace using 'perf script', we get the following output:
> 
> # perf record -e cs_etm/@tmc_etr0/ -C 9 taskset -c 9 sleep 1
> # perf script --itrace=i1ns --ns -Fcomm,tid,pid,time,cpu,event,ip,sym,addr,symoff,flags,callindent

Applies cleanly, can some Coresight people review this and provide a
Reviewed-by?

Thanks!

- Arnaldo

⬢[acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers 20240404180731.7006-3-tanmay@marvell.com
Grabbing thread from lore.kernel.org/all/20240404180731.7006-3-tanmay@marvell.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 3 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH v2 1/2] perf: cs-etm: Fixes in instruction sample synthesis
    + Link: https://lore.kernel.org/r/20240404180731.7006-2-tanmay@marvell.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✓ [PATCH v2 2/2] perf: cs-etm: Store previous timestamp in packet queue
    + Link: https://lore.kernel.org/r/20240404180731.7006-3-tanmay@marvell.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ---
  ✓ Signed: DKIM/marvell.com
---
Total patches: 2
---
Cover: ./v2_20240404_tanmay_fix_coresight_instruction_synthesis_logic.cover
 Link: https://lore.kernel.org/r/20240404180731.7006-1-tanmay@marvell.com
 Base: applies clean to current tree
       git checkout -b v2_20240404_tanmay_marvell_com HEAD
       git am ./v2_20240404_tanmay_fix_coresight_instruction_synthesis_logic.mbx
⬢[acme@toolbox perf-tools-next]$

