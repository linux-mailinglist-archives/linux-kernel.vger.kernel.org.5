Return-Path: <linux-kernel+bounces-85534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAD286B72C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C264286DD2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A354085A;
	Wed, 28 Feb 2024 18:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MikMP4IN"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9580579B70
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144963; cv=none; b=SrZe9DlnE5Fmr/fs04VotHL1LPGhhn3rIsFkS5HbtxF8JiJmV4Hmk8pepRYlLOHkgFQoafWqSOAa31IFShESTk+fMwuqXC+DOsimBbAX8KzEFCxyGNUFADe7C+XkZRLYYO2d9WaOmXwYvr0zPI2pgiWJOOjFHOzG0zq2aXrkS04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144963; c=relaxed/simple;
	bh=MdA8+4QUymfCHVKe0K1EYHVaU3HSAX3ub09oN1E5DpI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rMiv79sx1Jnppw1FqYdlcC8xRVABZ/NIKpSy8YDw49IbU2XyS4INuNx+DbLgOr4jq+P8wsB2/X2NqW6OMxYH69SKfj1aTlZVYvRXXqWrjkCX6PvuucjK36er0iYfEGJwQw6FN8FKKRv+oFxchoU67WWuo3/w+7EzSWUxGbhVx7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MikMP4IN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from smtpclient.apple (d66-183-91-182.bchsia.telus.net [66.183.91.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 33DB220B74C0;
	Wed, 28 Feb 2024 10:29:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 33DB220B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709144962;
	bh=Chw8fDCFwBt5A2/SvvRPqfWy1mLEboN1K9MXEuYd6OI=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=MikMP4IN9+2kuC8k57Ae1slPMHZ7L1RSuUPkQzhMTBifzEHDXWUHvFJUY8ZGQW6+5
	 xNLDMNkQl2wxtCK/R697sSOg5taA+3fcEH3GM2px+oSr9+Bb6aZYWYk30EibooJFFJ
	 XH8i5oFXmPWBXSXBZh3YM1yKMiixpTt67KkGjdpc=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH] kernel: Introduce enable_and_queue_work() convenience
 function
From: Allen Pais <apais@linux.microsoft.com>
In-Reply-To: <Zd96XzRHI_jMOCip@slm.duckdns.org>
Date: Wed, 28 Feb 2024 10:29:11 -0800
Cc: jiangshanlai@gmail.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <630C383C-1A60-4929-9E04-39135EB9AC90@linux.microsoft.com>
References: <20240228181850.5895-1-apais@linux.microsoft.com>
 <Zd96XzRHI_jMOCip@slm.duckdns.org>
To: Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3774.400.31)


>> The enable_and_queue_work() function is introduced to streamline
>> the process of enabling and queuing a work item on a specific
>> workqueue. This function combines the functionalities of
>> enable_work() and queue_work() in a single call, providing a
>> concise and convenient API for enabling and queuing work items.
>> 
>> The function accepts a target workqueue and a work item as parameters.
>> It first attempts to enable the work item using enable_work(). If the
>> enable operation is successful, the work item is then queued on the
>> specified workqueue using queue_work(). The function returns true if
>> the work item was successfully enabled and queued, and false otherwise.
>> 
>> This addition aims to enhance code readability and maintainability by
>> providing a unified interface for the common use case of enabling and
>> queuing work items on a workqueue.
>> 
>> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> 
> I'll apply this together with the rest of the series once v6.10-rc1 opens.

 Thank you. Meanwhile, I will go ahead and prepare the conversion with
Based on this change.

Thanks.
> 
> Thanks.
> 
> -- 
> tejun


