Return-Path: <linux-kernel+bounces-160214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AD18B3AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5BF1F220D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D6C149C64;
	Fri, 26 Apr 2024 15:08:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCA9149018;
	Fri, 26 Apr 2024 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144084; cv=none; b=ltJzUWNJg35iTcvQIkuk5a7MR6s6nTZtLfAFGdL+omZtSFYu8sFXYCk+BFO6mrGUl0WAmVzZge5Cq4YFdeoMW7ADM3ekOXY8ooYNuQ/HFBH5ThryR5BOQG5wIG7w9KjoGRLtnGBxI1UKyEP/rHWYK7DoVkQJSiMIRnmMKQLuoEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144084; c=relaxed/simple;
	bh=uLgzTLdOyl35giOTcWBj09wMqWIlQXtQzl5b9SWWQ+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n11nyjJB//kh/72hcr2qHnOTN3U75iv5Yjan7iE83qlxvwEnGAf47rlbVqLwyEWBekmniaH2w0pn64sesC0xjrqgfXVuvZyTq9H5DJrOaMiBoobr655xjb+jeoY/g/cTmf6mcprR/xM3HPdOFPqQRgJadVfnKMRMJ0bpBxWAujY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59A241007;
	Fri, 26 Apr 2024 08:08:30 -0700 (PDT)
Received: from [192.168.1.216] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9811B3F73F;
	Fri, 26 Apr 2024 08:07:58 -0700 (PDT)
Message-ID: <b2c02eb9-0940-4770-a4b7-22d2af8078db@arm.com>
Date: Fri, 26 Apr 2024 16:07:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/2] Fix Coresight instruction synthesis logic
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Tanmay Jagdale <tanmay@marvell.com>
Cc: john.g.garry@oracle.com, will@kernel.org, mike.leach@linaro.org,
 leo.yan@linux.dev, suzuki.poulose@arm.com, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com
References: <20240404180731.7006-1-tanmay@marvell.com> <Ziqm0QYfGbYjF6xh@x1>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <Ziqm0QYfGbYjF6xh@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 25/04/2024 19:54, Arnaldo Carvalho de Melo wrote:
> On Thu, Apr 04, 2024 at 11:37:29PM +0530, Tanmay Jagdale wrote:
>> When we use perf to catpure Coresight trace and generate instruction
>> trace using 'perf script', we get the following output:
>>
>> # perf record -e cs_etm/@tmc_etr0/ -C 9 taskset -c 9 sleep 1
>> # perf script --itrace=i1ns --ns -Fcomm,tid,pid,time,cpu,event,ip,sym,addr,symoff,flags,callindent
> 
> Applies cleanly, can some Coresight people review this and provide a
> Reviewed-by?
> 
> Thanks!
> 

Reviewed-by: James Clark <james.clark@arm.com>

