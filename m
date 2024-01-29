Return-Path: <linux-kernel+bounces-42137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BDA83FCF1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD313B22288
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DD310A03;
	Mon, 29 Jan 2024 03:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OLqBOTVi"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E541094E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 03:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499906; cv=none; b=E8ZF1714cvOhB/QdlVDq3mgdzW8UJUfAZP73+BSD2/dHc6MMlMX5371FWjxvc1EHUxRgTIQjTaVioNmomJNoAe7J8Cd77btq6w2Nc1QAEAXDOq+PTLAbW9fXKJElo2wZ8QpjQqWvBQTRzYyGPCUUb7Exnvc6zKzxXoXJCf7gmqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499906; c=relaxed/simple;
	bh=i8KdWcvHmRR7UCeqI6jmbuT1IuKUWANC0vVBstk9Egw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ISmnvzLSZqpgYnump7h2pm2/q1yUYk5IGLlbP8vKcXygOvxQRyC88Om2nUrOabYXCYZlJlsFAHvfjos+vbjHVt/J0w5U3+8hXTHkUyb8DWPD6+cM75tH1j94icx/NbjuD0sVMANWMk67UJFP359UQJfGgCMdHawJ+G/MQDR6H7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OLqBOTVi; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706499900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMLsdjMBZITBDKLs09iHhfI8Vsf6ylOtjpESrh4ylfY=;
	b=OLqBOTViJ+RV3CY2PWwhuU29tOdTOwosLtN+rOn7aFCud+WGNZ8fO9NlXxDsEYxBtR++LW
	fahHW5piB1AE1EOdP5/yRbf2ovzaSI7hrOxO8EUAEnQYUN1Lep3vXwj/zOmiF2cO18d0WG
	w/abbjSnxhyjCMGiBB/iUdPhQ1zHfe8=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v5 6/7] hugetlb: parallelize 2M hugetlb allocation and
 initialization
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240126152411.1238072-7-gang.li@linux.dev>
Date: Mon, 29 Jan 2024 11:44:12 +0800
Cc: David Hildenbrand <david@redhat.com>,
 David Rientjes <rientjes@google.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Linux-MM <linux-mm@kvack.org>,
 linux-kernel@vger.kernel.org,
 ligang.bdlg@bytedance.com
Content-Transfer-Encoding: 7bit
Message-Id: <34C3C358-7550-48D6-9421-EAD6C5ED3C35@linux.dev>
References: <20240126152411.1238072-1-gang.li@linux.dev>
 <20240126152411.1238072-7-gang.li@linux.dev>
To: Gang Li <gang.li@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Jan 26, 2024, at 23:24, Gang Li <gang.li@linux.dev> wrote:
> 
> By distributing both the allocation and the initialization tasks across
> multiple threads, the initialization of 2M hugetlb will be faster,
> thereby improving the boot speed.
> 
> Here are some test results:
>      test case        no patch(ms)   patched(ms)   saved
> ------------------- -------------- ------------- --------
>  256c2T(4 node) 2M           3336          1051   68.52%
>  128c1T(2 node) 2M           1943           716   63.15%
> 
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> Tested-by: David Rientjes <rientjes@google.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


