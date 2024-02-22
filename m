Return-Path: <linux-kernel+bounces-76192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4E985F407
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC55F28725C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612403839A;
	Thu, 22 Feb 2024 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Shrc99by"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C94381DF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593031; cv=none; b=KN3KM2+VpFwvoCtfS29MDnkkESQvsvJSlwPb/ovSPl332e6L4yYkvqC0RmCpOcP+WdMszVnPlovPnxPiTDw4uhxwhfFxQKR+3VeMrjySFyB2l3p5+vWF3Z8xfy00wQzl42FY0YwfcyiGkoRNg29jqESIcd83h2TOQ/9BxFFFdCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593031; c=relaxed/simple;
	bh=RFalUYkBmcGTV3GPMXC8E8juBdZB+mNdbxu4e+7Hxyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cz7UGW6n7D+PS/jj3mDeD/gWTpkGq03xpQNetpk/gcayElMzyFMZxNjb4tmtN7ekuiXj2U6TUwmkwZiQV1V+6zTz/LC0ClAsxfJfNoCD3w/RDFDf47KXUVgBHUKP6sWyM6PUGPNa87Ibo6deYVN7ZhWhoL+24Z5s07NJKk6GvDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Shrc99by; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4F6C433C7;
	Thu, 22 Feb 2024 09:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708593031;
	bh=RFalUYkBmcGTV3GPMXC8E8juBdZB+mNdbxu4e+7Hxyw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Shrc99by/J6jsJD8H9x3QKQ6EdYH1gmWrP/HSD0/w1TvyWKdtV4wkr5QZW/0vX5HC
	 rGVfgPj7puHAfPPplbPdc2YMcuD82aysSmh0AbrjZNQxeokeA1ps+RW+4dqq2rlaHG
	 wILxeVsklCgLzIDSGGmmPeSUNKzz/AAfsUNrX5Bxhg8m0rKG65oMQqfEM2pT5c6u5T
	 Iw1z2EamV7TQLmTFEdp/9AyRbyd9i3No48oZl9u+Am2b+YwFfzrq9wldjC2zBIO4c9
	 IHTO2sbviRLTPK+bQoC9rWO/aZxblo1HdjslFDQ5YnegGCD6xTsVqSbN/aLLX4E4MX
	 4yx5Sbj+qO1Aw==
Message-ID: <c037eb03-430b-4a64-a8ba-2a02da18dc4d@kernel.org>
Date: Thu, 22 Feb 2024 17:10:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] f2fs: support SEEK_DATA and SEEK_HOLE for
 compression files
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
References: <20240215201633.2365333-1-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240215201633.2365333-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/16 4:16, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Fix to support SEEK_DATA and SEEK_HOLE for compression files
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

