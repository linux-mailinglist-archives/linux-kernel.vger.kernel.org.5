Return-Path: <linux-kernel+bounces-80066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712C0862A65
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B901C209E3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EBD11C94;
	Sun, 25 Feb 2024 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OTmqVR/d"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9D710A3C
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708866214; cv=none; b=Y7T7BnxOOVANtbEgWs9Q83FwyRiKBZSip72IDb2alhvD91L09XCNI3gjwtSxxbWv2u9InBvap8YkxH3uyn2ogaTJw2ToW6KEk1CB/lXxfMU38sq0GMyqNONwjO7ZMXHSRUb0hbMHrCmfdXLks8Mre0/UeMBKqZKz3Gmxg2c8jWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708866214; c=relaxed/simple;
	bh=/SpsNiogYFqG5r7VDjXkjcW6vVlToL80VRO+IS2kI0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NsRed0XqwGBpi4Hhr12esKa3RkI6+zQxsWENI2HMrK6A10z/8v/7ctvPnhuA+x9sBgsjKPbIgaH0Gz+qcC2HeCLfZLCk0LDViYWC1+TwCIBnP8KgK71DP0qMJRtrvHI+5mDf/COsDDxaoRVoXRzI1yQsaVu++/a0oB8ogIF71ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OTmqVR/d; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <34678776-859a-42f2-802b-0c7bc90bdfdc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708866210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBS/vqv7//g5T5JLfCN0p+agffab/kEhJFeyvy8o3i4=;
	b=OTmqVR/dWHrbxfIU/KRVKI+7ES2nTdRD3QMuHRXgzdpdBIZaPfEMRGCfZFpESwpu6msP4F
	TdNgon4mhMa4q0P5Tf57uVQ/+AkGYLdfxPfcU056iFQ5sxbYoSKioTqmHvnK64lp+85I8V
	T9DKnjQJekdUQpHzfXciJgH5YNx2wjs=
Date: Sun, 25 Feb 2024 21:02:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ocfs2: remove SLAB_MEM_SPREAD flag usage
Content-Language: en-US
To: Joseph Qi <joseph.qi@linux.alibaba.com>, mark@fasheh.com,
 jlbec@evilplan.org, brauner@kernel.org, jlayton@kernel.org,
 keescook@chromium.org
Cc: jack@suse.cz, zhouchengming@bytedance.com, azeemshaikh38@gmail.com,
 ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, vbabka@suse.cz, roman.gushchin@linux.dev,
 Xiongwei.Song@windriver.com
References: <20240224135008.829878-1-chengming.zhou@linux.dev>
 <aee616f4-40fc-4d24-9010-d0589d59f664@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <aee616f4-40fc-4d24-9010-d0589d59f664@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/25 20:20, Joseph Qi wrote:
> 
> 
> On 2/24/24 9:50 PM, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
>> its usage so we can delete it from slab. No functional change.
>>
> If I understand correctly, you are referring the following patch:
> https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/
> 
> But it seems that the above patch is not included in mainline yet.
> Or am I missing something?

I realize my commit message should explain more why it's a no-op, my bad.

The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
removed so it became a dead flag as of v6.8-rc1. That series[1]
mark it obsolete to avoid confusion for users. So here we can just
remove all its users, which has no functional changes.

[1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

Thanks!

> 
> Joseph
> 

