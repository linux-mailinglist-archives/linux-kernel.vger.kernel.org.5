Return-Path: <linux-kernel+bounces-111923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1098872B2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3621C21EB4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B19162A19;
	Fri, 22 Mar 2024 18:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mjTgzcPa"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF238629E1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711131146; cv=none; b=EbqYhe74UT6HxFqMVjhjmaFqsB3doNJ+zp+1y4ElkJIW54HJDk0GakQnjD/DPXSV+kk0Vte2IuWuXGQwsPiuGwaltjFEdgbqSkigbqnxRcShro0StC6lSVoe8fJ/iKsJQLVFQ/a/qabrO+WApRlT2HG2439Mwo+fNNae9L44+uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711131146; c=relaxed/simple;
	bh=W+fx4MS4or2BP/f0GWe+w1c2YvtMTPRiTmEWfMajIFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jX7gJMda+bwOsSX2ITZazfW/UgpLIeHFWbp+3gqiRY9RtnkdqfjKHBTxg3Bv+JQiKtSR+Bq9Yy98Vw/Qur71LUV0prHFafS8QFvmXiSdeNN2YG/3RNl0SLHVi8RzNKgbyl3VJZFyztcO+9LGoaPrOlYzeF2tjre1W+5fbfepb8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mjTgzcPa; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8afe3f27-fc8e-4c20-ba28-74a0a2937e55@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711131142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZ1o/opYgIzUM1VjnrIvbzSw8b5obvxKpmvvVITsLf8=;
	b=mjTgzcPaCGTKrFIbb5VFUgckqJQPFwF4J2IqEZlCeLZ4YdntK5hU3jzMtZzeKeYxEweGHg
	aXZKlfPzifwlDEypUEeySV6VeTgrLUqUSJLwx1RW+FBSJoUymkNiFjVn57GFE4Pw5XtgbV
	ixbap/jrFX5VGq9mcPiZ7UO5RBKlj9g=
Date: Sat, 23 Mar 2024 02:12:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] software node: Implement device_get_match_data fwnode
 callback
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20240318234222.1278882-1-sui.jingfeng@linux.dev>
 <Zfq85f-Dp1S3CKuG@smile.fi.intel.com>
 <9ced20e0-dfbd-4337-b5df-223b7baffd9e@linux.dev>
 <ZftG6Q5AaG71dhWq@smile.fi.intel.com>
 <9644da91-f367-4083-a3e4-4d0677c8cbca@linux.dev>
 <Zf2uUwcMgIpo6rVh@smile.fi.intel.com>
 <6bf102a4-6419-4083-8918-4f7c76cfa9a1@linux.dev>
 <Zf3IWyrW8IZLTg4x@smile.fi.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <Zf3IWyrW8IZLTg4x@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/3/23 02:05, Andy Shevchenko wrote:
>   Besides that, the kernel project rule is "we do not add
> the dead (unused) code".


This rule is good an correct and I admit.

But the problem is that it is chicken-and-egg problem,
it probably have at least two user now.
it's possible that it will gain more users in the future.

But if you reject everybody from now, then it is zero.


-- 
Best regards,
Sui


