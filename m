Return-Path: <linux-kernel+bounces-142565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860808A2D35
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 265701F230E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC68548E7;
	Fri, 12 Apr 2024 11:21:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E5053811
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712920888; cv=none; b=Vy6ooktvI6EjAwYgGlx9ZWFVe6UHJRSzPxczmOLZrk4XVgCd0VCaeMKfKBVZt5+RlIaboR/3ixOmrMUOi6IVXmJCyYNkz2Pph7gORmGIffy7Y+X+iJVrzmfO5MvvpG/3kPVqJVqY8NJDGml0HsRr2n0ZAQEuIJjBZbWPu8xqoV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712920888; c=relaxed/simple;
	bh=3jQRIBvYfDbKJtXMkzHPOwlwO+7J4akUAJcrsQK44FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLvhZDBY5RC3s6ibOx2kF/2Dix0a40YNqvYWazNz6U5UizRE6nyXBVZkOEGc+XJXtFQGZfFi1kWzuRYgsCWTyPt9J4uzxob8pwU9gtEaOPbYV0xKutS8IDUrHl/E5Nrb6Ot1JyQM1lulRLKP+Lj2ZTPcviTYF/cqtJrdS917a3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 632ED339;
	Fri, 12 Apr 2024 04:21:55 -0700 (PDT)
Received: from [10.57.73.208] (unknown [10.57.73.208])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27AB83F766;
	Fri, 12 Apr 2024 04:21:24 -0700 (PDT)
Message-ID: <84eca849-5da3-4272-ade6-dc0f2b3dc4b2@arm.com>
Date: Fri, 12 Apr 2024 12:21:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] mm/arm64: override mkold_clean_ptes() batch helper
Content-Language: en-GB
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, 21cnbao@gmail.com,
 mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com,
 shy828301@gmail.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240408042437.10951-1-ioworker0@gmail.com>
 <20240408042437.10951-3-ioworker0@gmail.com>
 <3cd1036d-3814-4a10-b6d2-099937ceabc8@arm.com>
 <CAK1f24m=nC=ecuOZesQvytnxJms2d-wONKT4_7GUfvz0PJz+oQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAK1f24m=nC=ecuOZesQvytnxJms2d-wONKT4_7GUfvz0PJz+oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/04/2024 03:09, Lance Yang wrote:
> On Thu, Apr 11, 2024 at 9:17 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 08/04/2024 05:24, Lance Yang wrote:
>>> The per-pte get_and_clear/modify/set approach would result in
>>> unfolding/refolding for contpte mappings on arm64. So we need
>>> to override mkold_clean_ptes() for arm64 to avoid it.
>>
>> IIRC, in the last version, I suggested copying the wrprotect_ptes() pattern to
>> correctly iterate over contpte blocks. I meant for you to take it as inspiration
>> but looks like you have done a carbon copy, including lots of things that are
>> unneeded here. That's my fault for not being clear - sorry!
> 
> My bad. I must have misunderstood your intention.

Not at all - it was my bad. wrprotect_ptes() is nothing like what I eventually
suggested below, so sorry for the bad steer.


