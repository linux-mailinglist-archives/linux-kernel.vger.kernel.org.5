Return-Path: <linux-kernel+bounces-74300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A9985D284
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73CF0B23DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991DA3BB55;
	Wed, 21 Feb 2024 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="J19s0fuo"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9FD3BB20
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708504040; cv=none; b=qVikEDyDLXuZnwiZ5309c6SFMhuOFSx59NPHSY3du7JvmxqA45C4fpDsGG8qKdHhjD2rmImZqaEReFkUhbn8MFM36a7kt9lHDMVtM+4mQ7ridISsTB45UloIlua+zG7LEid2oq0WmiHvZSN8AX+VAFUd9uqWqaUEt91RVrb99Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708504040; c=relaxed/simple;
	bh=WShScRfKCAMbK9N+nYtjqbc7hhSfVv0GTSMuCGk1egc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AQBql3zEVN/ZPt7sw9h8yUg7PMF4FrjnaxmRSds6wM4muqgsKezTEq87W1Pt3ZfJ2s169s+PqO0i7aOtpRP+/e+tl3ziQSjoqplxH9DiEqrg0EHiULh1DGVNknAuq0Ptg7sZCkVmoovpdbBLiID+7lGTzHVfMuuvlRH7kspmaRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=J19s0fuo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4125e435b38so32709625e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708504037; x=1709108837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PDEMz9AvW6dwxDy0dCPi0/PDlhOWSUsnwtdsTxUMNW4=;
        b=J19s0fuoxmmerzMLBLfeW4508IFXMD/w/tgeWCUNUdtYWsnx5BxGy4D+SiymibBJhx
         MsiWjxtdowYZaSbrt03sdxET1DWZ7luzysdMkTxOE309f9xHPJcyOv5txdLpRtQutsxx
         jupsXhUBZ0OTy2XPNvjPVyNOdAFwr63u0KUGw3AMxG8LZUDpEixVUCFc9vghdI3qiU22
         x1oPmXNkTpi24+ng39yfsfEzwZZgjaglSg4tmOXwWh8aAx6tO80h4JK3ip7gFBqK1J7g
         9hc0MGls7AKgFUuHwMVkHdlcOptOosxD6K4XLJwaLcutoVrTQOZHf37d065pC4S1jr6c
         nYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708504037; x=1709108837;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDEMz9AvW6dwxDy0dCPi0/PDlhOWSUsnwtdsTxUMNW4=;
        b=Pgu5huePrn0DPD+ceIUOtCtfXrTSuVXloqu+jdM2UMBIik1hTllUsPNY3Cokn5D9ps
         SLVWZhy6t0qU0gSvZwhfKrbzNxdmEwxBZfaDhz6ZVVWMJn/LZSbv58urZ6zjDpm50yGe
         gtOHIq1u2I1gBVMzUK1fR8N7E+GUmHbrRDMkiN7S40iwKQFE2TbSfcdUOaH4SEvln4RU
         VL2wdPYXB+dW9o3WeztkWtBEEFhmwIgCaPHgx9SVSQ8srmoCQ48Ced2UzyUAAycOj1Is
         iPuZ9md0+O9a9DX9xtofm6uKiFPaUO2HpF15nNWCTkoHdzI/4oBnqj0ZXTQ6Todk0amz
         nowA==
X-Forwarded-Encrypted: i=1; AJvYcCU/x7uV5sGUrpidyaG3lF3CcRE9gz/dwcK+L+0U+x6E2+Zw16hKexIIboZRYvvMQU3LDJjZ00vkMUB4WY/y6/bFkUtvVcqvjFqvhbnU
X-Gm-Message-State: AOJu0YzX/IFFNbxjFnmF7bGNSZXeMHoD8lS7U7oEqUqDckJuOT26ivl+
	hEzRurJq1sfZF29fbbviDJKfOTHu2gKYOCvjRcbB8W5GZBZtKxN5
X-Google-Smtp-Source: AGHT+IEYYfrFXg/ko+0JmsE0adl4AVug1KDi6YXpKG3r9GT/SbYMtc4YoDgpP/Dm2X9CGsdnN9VYNg==
X-Received: by 2002:a05:600c:3b9a:b0:411:50aa:1106 with SMTP id n26-20020a05600c3b9a00b0041150aa1106mr13101901wms.24.1708504037347;
        Wed, 21 Feb 2024 00:27:17 -0800 (PST)
Received: from [192.168.1.10] ([94.9.209.181])
        by smtp.googlemail.com with ESMTPSA id f8-20020a05600c4e8800b0040f0219c371sm17480318wmq.19.2024.02.21.00.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 00:27:16 -0800 (PST)
Message-ID: <0f3542a4-d558-447c-9dd7-cbb410c88e23@googlemail.com>
Date: Wed, 21 Feb 2024 08:27:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] fs/ntfs3: fix build without CONFIG_NTFS3_LZX_XPRESS
From: Chris Clayton <chris2553@googlemail.com>
To: Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc: ntfs3@lists.linux.dev, almaz.alexandrovich@paragon-software.com,
 regressions@leemhuis.in
References: <20240214224500.811609-1-shiftee@posteo.net>
 <89630027-f93c-4e1d-a9c0-a120b8f0bc9e@googlemail.com>
Content-Language: en-GB
In-Reply-To: <89630027-f93c-4e1d-a9c0-a120b8f0bc9e@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi

This build regression also shows up, along with other problems, in a report to the ntfs3 list by the kernel test robot.[1]

Also, as this patch seems not to have been picked up by the NTFS3 maintainer I've added Thorsten Leemhuis so he can
consider adding this egression to the tracker.

[1] https://lore.kernel.org/ntfs3/202402211322.4GbTCzp8-lkp@intel.com/T/#u

Chris



On 19/02/2024 07:21, Chris Clayton wrote:
> Hi.
> 
> On 14/02/2024 22:45, Mark O'Donovan wrote:
>> When CONFIG_NTFS3_LZX_XPRESS is not set then we get the following:
>> fs/ntfs3/frecord.c:2460:16: error: unused variable ‘i_size’
>>
>> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
>> ---
>>  fs/ntfs3/frecord.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
>> index 3b42938a9d3b..7f27382e0ce2 100644
>> --- a/fs/ntfs3/frecord.c
>> +++ b/fs/ntfs3/frecord.c
>> @@ -2457,7 +2457,6 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
>>  	struct ATTR_LIST_ENTRY *le = NULL;
>>  	struct runs_tree *run = &ni->file.run;
>>  	u64 valid_size = ni->i_valid;
>> -	loff_t i_size = i_size_read(&ni->vfs_inode);
>>  	u64 vbo_disk;
>>  	size_t unc_size;
>>  	u32 frame_size, i, npages_disk, ondisk_size;
>> @@ -2509,6 +2508,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
>>  		err = -EOPNOTSUPP;
>>  		goto out1;
>>  #else
>> +		loff_t i_size = i_size_read(&ni->vfs_inode);
>>  		u32 frame_bits = ni_ext_compress_bits(ni);
>>  		u64 frame64 = frame_vbo >> frame_bits;
>>  		u64 frames, vbo_data;
>>
>> base-commit: 7e90b5c295ec1e47c8ad865429f046970c549a66
> 
> Mark - Thanks for the patch.
> Alex - Fixes a build bug introduced by 4fd6c08a16d7f1ba10212c9ef7bc73218144b463.
> 
> Tested-by: Chris Clayton <chris2553@googlemail.com>

