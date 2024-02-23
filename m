Return-Path: <linux-kernel+bounces-78193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3301B861001
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA38281CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D1B6518F;
	Fri, 23 Feb 2024 11:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RiI3s1RY"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369F15C8FB
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708686130; cv=none; b=ThEgJqDABCCxHKLtnBlp7p9H82c/E+SFHfgwEIrV8yv2SU77KET8VOKPkZO/D0hTnZi7vQfIFI76wlg7zeXABaqFr80FYRXyU22Bq5BvLdTZokrSv+fCK39/le3iefELuVpnWF6XuYbjb0uwcfLDc5c77KrRHUzipjOWveGDsD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708686130; c=relaxed/simple;
	bh=Hfxzy3m3rgoQVAi2T6JlKhsaZWQmRoflxQMoVxc8DW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/QpIGG2d1ucm+tma2Sp9dAwNwqrFNaz/hct8jUdnVTNvJyD0mtXFug1S/BpTOsalufbU5rIzxrXuhHF6tIMKNRib12aw2yc8k/9E+Lp1c8+pfcciHGPFtejf9zVh/wTpkuXmM5AvW4cJIYZMVF5NNcGjQS0iPaeehN9Ncb091w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RiI3s1RY; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708686120; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Gl112MpuWzCihqKFsR6Lqg9e1BT7tdysa1K7nxLWwoU=;
	b=RiI3s1RYtnt+gUyeF7j3H8qiLEiWVvIxstg4LK2QvioMWfjJ+7Yy06HhSipeGWc6Y8krtwFJn9vzYA+LIVTkSmaAzKgI39ZJOEk9+dy8CFOu+z1dd2FEv1hppC4Cq3R7TIDV26UO2nNcrxFpyJESU8j4h1xTLFswHDfZ9xr3EdU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W148c6n_1708686118;
Received: from 30.178.80.102(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0W148c6n_1708686118)
          by smtp.aliyun-inc.com;
          Fri, 23 Feb 2024 19:02:00 +0800
Message-ID: <d9eb6672-788e-414d-8138-37a3038e3c47@linux.alibaba.com>
Date: Fri, 23 Feb 2024 19:01:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, thp: display [never] for defrag when THP is set to
 never
To: David Hildenbrand <david@redhat.com>,
 Yuanhe Shu <xiangzao@linux.alibaba.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240222115323.4925-1-xiangzao@linux.alibaba.com>
 <ec6f2c48-3010-4a02-8f42-fc6b912039cf@redhat.com>
From: Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <ec6f2c48-3010-4a02-8f42-fc6b912039cf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/2/22 20:14, David Hildenbrand 写道:
> On 22.02.24 12:53, Yuanhe Shu wrote:
>> When transparent_hugepage is set to never by cmdline or echo, defrag
>> still show what it used to be and can be modified which makes user
>> confusing whether defrag would take effect.
>>
>> Actually if transparent_hugepage is set to never, defrag will not take
>> effect. Just Display never and remain unchangeable to for defrag when
>> transparent_hugepage is set to never.
>>
>> Suggested-by: Liu Song <liusong@linux.alibaba.com>
>> Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
>> ---
>
> No, I don't think we want such a dependency between both options.
>
> You might just end up breaking existing scripts (enable defrag before 
> enabling THP) for no good reason.
>
In certain situations where khugepaged_thread is NULL, it would be more
reasonable for the value of
/sys/kernel/mm/transparent_hugepage/khugepaged/defrag to be 0. The patch
should include a fix for this case.

Thanks




