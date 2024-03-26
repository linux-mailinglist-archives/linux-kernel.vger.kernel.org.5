Return-Path: <linux-kernel+bounces-118376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2438888B9DD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EDFF2C2FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E046A12A17D;
	Tue, 26 Mar 2024 05:41:32 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 0B9C7446BA;
	Tue, 26 Mar 2024 05:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711431692; cv=none; b=Hv/o6UYFgeaoAYV6ddf6kxGBaBZWhW2t5FSJtNwVwix4NYPvln4URUKjxeSkAQu/YMmJQfLSmqMB8/SHMZ9XA+OcU+gP2Q8lziH2uoAC02m7nYbn0n56kjEqOskz3QaNSOWV3xfPubsCjsdmWocv5FRZc0eEaiQZ7q921TxCXK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711431692; c=relaxed/simple;
	bh=zdIoSYl0H+cZnP925/Fbsw4JQQ8i2NFXq9a2yvqMDBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=sipIIV8M83PKCXc2cmMTzXiVUMbb8nBOqt7OcLOfK4Wa47dZU/vZfclku+WQ2I12dXNtDSA966d+pAczAC7lpKMYVzxuWFHhTDGjLZjKVJDCQyc9VvHYcJZD0lsmCxC+AdFKgi9sTDTBLzsYgOJmVcLBuwS8NUcR3h73lqJonaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.11.106] (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id B8C3C6075D669;
	Tue, 26 Mar 2024 13:41:25 +0800 (CST)
Message-ID: <0e719692-a166-1f56-4226-e71f7503aa94@nfschina.com>
Date: Tue, 26 Mar 2024 13:41:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/amdkfd: return negative error code in svm_ioctl()
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, Felix.Kuehling@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch
Cc: Philip.Yang@amd.com, alex.sierra@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <b4af9fda-8685-d486-95aa-ca46c11a2cc5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/3/25 22:09, Philip Yang wrote:
>
>
> On 2024-03-25 02:31, Su Hui wrote:
>
> Good catch, ioctl should return -errno. I will apply it to drm-next.
>
> Reviewed-by: Philip Yang<philip.yang@amd.com>
>
>> ---
>> Ps: When I try to compile this file, there is a error :
>> drivers/gpu/drm/amd/amdkfd/kfd_migrate.c:28:10: fatal error: amdgpu_sync.h:
>> No such file or directory.
>>
>> Maybe there are some steps I missed or this place need to be corrected?
>
> Don't know how you compile the driver, amdgpu_sync.h is located under 
> amdgpu folder, amdkfd/Makefile is included from amdgpu/Makefile, which 
> set ccflag-y -I correctly.
>
Got it,  I should using 'make 
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.o'
rather than 'make drivers/gpu/drm/amd/amdkfd/kfd_migrate.o'.

Thanks a lot!

Regards,
Su Hui

