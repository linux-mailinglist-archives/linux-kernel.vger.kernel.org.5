Return-Path: <linux-kernel+bounces-87846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8300C86D9E6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1584E286B45
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B418A405FE;
	Fri,  1 Mar 2024 02:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ObMS8wAZ"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B74442A87;
	Fri,  1 Mar 2024 02:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709261815; cv=none; b=Ajo2p7F4HN9x/O/S2bINy/zNV/sHaFpSjTocKb5rj+xHlIklS2B54N9iEUHcoaCWfVg10qm0887jjqGLr/pYFlq+jTUXBhBq5XZUIdry3X+DALnldlT+bRRcdvC7WM15YFUbGvSXW/ITfyOMbqordXCrq20FYRKobavyL2SMYcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709261815; c=relaxed/simple;
	bh=Pqh+NpCuWum5dqlqbMUL3TqqnHP2lEiT2fIxy9FzlNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOnt4oCFKtpGd5VsgU6SGMqslvwtzXm7DUBsHmke1gmEdR5Q/tajcQkJ2wNS04ZCB2usRUkRkad6w2jt/xLm0MdX6wHG3rDRRBaCmwkoTCOuUgrsTifYBiq+Fp8asMcowJrNdaow1AbpNPrCm12AYSNH1KeGB/V8ZunEh7/Uzhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ObMS8wAZ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Qgts2Hmu+UjCHCfkiwx/Y2ncBIM0RZp13+yxLu7uyHk=;
	b=ObMS8wAZgi2E9Lk4dw8w0gKbkYgaFTJNhQeRiLY3rdtM0g3qs1kmxpch2xFwhQ
	KGglM8VehwRt28PYyTuWpbMRikrzoesdueziAEzavbs1tnc3vZnu2nrH49xQY57w
	tjWr29ERHX/sMJPU5ar29tsEeHTle+PoEMbh3c2CJYZyk=
Received: from [192.168.174.19] (unknown [223.147.65.76])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wDn122QQ+FlpIeKDg--.55921S2;
	Fri, 01 Mar 2024 10:55:13 +0800 (CST)
Message-ID: <1a5aed22-63ec-4445-b449-39659f414e79@163.com>
Date: Fri, 1 Mar 2024 10:55:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: hibernate: Fix level3 translation fault in
 swsusp_save()
To: Mike Rapoport <rppt@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, rafael@kernel.org, pavel@ucw.cz,
 len.brown@intel.com, keescook@chromium.org, tony.luck@intel.com,
 gpiccoli@igalia.com, akpm@linux-foundation.org, ardb@kernel.org,
 wangkefeng.wang@huawei.com, catalin.marinas@arm.com, will@kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Yaxiong Tian <tianyaxiong@kylinos.cn>,
 xiongxin <xiongxin@kylinos.cn>
References: <20240226034225.48689-1-13327272236@163.com>
 <8d70939f-ca14-4167-9647-b8f44ddcbb98@redhat.com>
 <ZdxWcG2XCqBum3_R@kernel.org> <3399d2af-3d42-4ac1-9b74-8475bec25f7f@163.com>
 <ZeBRfxQ8WTEVzpfL@kernel.org>
Content-Language: en-US
From: Yaxiong Tian <13327272236@163.com>
In-Reply-To: <ZeBRfxQ8WTEVzpfL@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn122QQ+FlpIeKDg--.55921S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar13Zr15uw1kWF1UXw1DJrb_yoW8uw47pF
	yfWayFkw1kAryvgrs2v3yfAF4av3yfJFW0qr1UAr97Aan09FZFgr4jk3WY9Fyqqrn5CF1a
	qrZxK3ZxZ3WUta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jtL05UUUUU=
X-CM-SenderInfo: jprtjjaxsxjjitw6il2tof0z/1tbiRROUJWXAkskyHQAAs2


在 2024/2/29 17:42, Mike Rapoport 写道:
> On Tue, Feb 27, 2024 at 03:51:25PM +0800, Yaxiong Tian wrote:
>> 在 2024/2/26 17:14, Mike Rapoport 写道:
>>> On Mon, Feb 26, 2024 at 09:37:06AM +0100, David Hildenbrand wrote:
>>>> On 26.02.24 04:42, Yaxiong Tian wrote:
>>>>> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
>>>>>
>>>>> On ARM64 machines using UEFI, if the linear map is not set (can_set_direct_map()
>>>>> return false), swsusp_save() will fail due to can't finding the map table
>>>>> under the nomap memory.such as:
>>> can_set_direct_map() has nothing to do with presence or absence of the
>>> linear map.
>>>
>>> Do you mean that kernel_page_present() presumes that a page is present when
>>> can_set_direct_map() returns false even for NOMAP ranges?
>> Yes， in swsusp_save()->copy_data_pages()->page_is_saveable(),
>> kernel_page_present() presumes that a page is present when
>> can_set_direct_map()
>> returns false even for NOMAP ranges.So NOMAP pages will saved in after,and
>> then
>> cause level3 translation fault in this pages.
> So this should be the description of the problem in the changelog rather
> than saying "if the linear map is not set (can_set_direct_map() return
> false)"
>
>>>>> QEMU ARM64 using UEFI also has the problem by setting can_set_direct_map()
>>>>> return false.
>>> Huh?
>>> Why would you do that?
>>>
>> I discovered this problem when upgrading from 5.4 to 6.6 using the 5.4
>> configuration.
>> So I using latest linux-next code,find the problem still exist.To rule out
>> the effects
>> of a particular machine，I also use qemu to check it.
> I believe this can be reproduced if you boot with rodata=off and then
> a better description would be something like
>
> 	This issue can be reproduced in QEMU when booting with rodata=off

Thanks, I opt commit messages,and move !pfn_is_map_memory() check from 
page_is_saveable()
to arm64::pfn_is_nosave().  The patch v2 is in:

https://lore.kernel.org/all/20240301021924.33210-1-13327272236@163.com/

I heard that if it is a single PATCH it should be placed under the 
original mailing list,
so please ignore the February 27 patch mailing.

>


