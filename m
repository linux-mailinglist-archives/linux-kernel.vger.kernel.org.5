Return-Path: <linux-kernel+bounces-75294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A01285E5F8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F561F290CB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF8985C79;
	Wed, 21 Feb 2024 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QzZQzXzA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A107983CBB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540025; cv=none; b=o0zBM7RD9W+NjM7AFx1PZDLrCrgK/Gy2YVMpy1Haqh876UnMm9PylLW7jWbuXekO3i60Jvd4mMjqFX1Lu1NMJehjykOh5f3fom1UehiTNgm81vP6uagXZUZuwC+zky5JsLnMZMVGSajxZIJVEdojF+3rcD6QSfONMnZKcZa7e8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540025; c=relaxed/simple;
	bh=6VC1qcHGtWcfwYOSabJJ8ZSmJ/99a6jDL4crh0KLPVk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=asjZHMGlXtS5Y/hDgOiBLR3kScLLmlS7qorQwCCJTfgHcesGA+fWbHsOuqMIWn/qMki46UD/nWa1vVJDQc5+hsp8TtephhgZot/6p/OEqiJ+qpOKVivB9C/VVHopYyQq23fWC4kl1IOQ3RgjsoI8RnzR6BvTvGKp4TjK3dQCuKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QzZQzXzA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708540022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEojIl750TYVuyYtzldN9G7sEW6mfeIF1z8MGEw+SFo=;
	b=QzZQzXzAwLXf/120yxOQVLm7OM/TuIldGVj+4kfDTQGhiupWIgFXcdNju2ZzsFmGbtG6kB
	huII6B54ljCZOu+YQ8KSMox1pfjPO2yW5js0ArJ9/OA07vOhDZw9icdJuzxhfrwIDbLkWL
	BlPNYGUV6Sfql32dE5X0DVUS+o/kZNc=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-mfMGRaNmOPuQoHH1xVTCDw-1; Wed, 21 Feb 2024 13:27:00 -0500
X-MC-Unique: mfMGRaNmOPuQoHH1xVTCDw-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4c78b0c7579so979868e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:27:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708540019; x=1709144819;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEojIl750TYVuyYtzldN9G7sEW6mfeIF1z8MGEw+SFo=;
        b=TSMvFZ29RxEFfauvMhm08C1e+R4mxqkT6tCXOs5ASlhdQwN5eDcesKKGK3kJOnJ8P3
         iBJYwuo3oncNUMrPqljjKpMwU67h4Fbzqgof+t3qIQRVHRty8Ivct2JrpygPMrQocLNi
         gRVokRqu5QuJ80fStWEQMedAp7ovAris/Fii7ToAzg7flfVMfTXCmBBiyP9QK3msrhIL
         OVb3Lzc46cpcPRPw4jqnQ6E9395AgKpHM1wpbUGrAj7mLlt2fshkZkt0hZb/TFy61wEP
         381pq0DFoYSg8lD/iqCZN/W5hN9drQLXWRvCiTw7iSFxcFIH9gUbB6jFTQrsZScZWECw
         5S1w==
X-Forwarded-Encrypted: i=1; AJvYcCWzvD4/vsDQgSXLKfywBtKEzaQQQa1Wwup2S+600n4v2fNgu3LsbD1TJB6PFNiJeRO44tZ0WKIydTm5M3Yr8h1BZWuDnpanq9hZSwbz
X-Gm-Message-State: AOJu0YyNMJ/oDsU6S7kNG6QYx5l20IsJVTvaiiyho27qWqd0gKz1yh18
	/WapOtXWr0Q/RXyeluG9+WkVBvJydx8nCGuoIcPIeBLMHz/+dMvNNS3Lpd7rFrj5dOG/SxOy7Mh
	VO+ZeC/oGQosRSdqTA2fCKeGItMKqknmAEfuS+7Y4Gianf8rHhAUUEUO3+bxNNg7LShKCAQ==
X-Received: by 2002:a05:6122:4f05:b0:4d1:34a1:c887 with SMTP id gh5-20020a0561224f0500b004d134a1c887mr3318944vkb.9.1708540019326;
        Wed, 21 Feb 2024 10:26:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVeAkg3MpsRAS/vobA8hq7pIispK+lnPkq/9Wp7nPrxR6fPAfqKmvjqwfiX/cWcrVq6/8GSQ==
X-Received: by 2002:a05:6122:4f05:b0:4d1:34a1:c887 with SMTP id gh5-20020a0561224f0500b004d134a1c887mr3318929vkb.9.1708540018987;
        Wed, 21 Feb 2024 10:26:58 -0800 (PST)
Received: from [192.168.1.35] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id ny13-20020a056214398d00b006862b537412sm5803551qvb.123.2024.02.21.10.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 10:26:58 -0800 (PST)
Message-ID: <88672d5a-1b12-a6f2-bf7b-8670eeddc711@redhat.com>
Date: Wed, 21 Feb 2024 13:26:57 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Nicolai Stange <nstange@suse.de>,
 Shresth Prasad <shresthprasad7@gmail.com>
Cc: zhangwarden@gmail.com, jikos@kernel.org, jpoimboe@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 live-patching@vger.kernel.org, mbenes@suse.cz, mpdesouza@suse.com,
 pmladek@suse.com, shuah@kernel.org, skhan@linuxfoundation.org
References: <ff1078b2-447d-4ae7-8287-d0affd23588d@gmail.com>
 <22981.124022107441100115@us-mta-655.us.mimecast.lan>
From: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH] Fix implicit cast warning in test_klp_state.c
In-Reply-To: <22981.124022107441100115@us-mta-655.us.mimecast.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/21/24 07:44, Nicolai Stange wrote:
> Shresth Prasad <shresthprasad7@gmail.com> writes:
> 
>> I checked the source code and yes I am on the latest Linux next repo.
>>
>> Here's the warning:
>> /home/shresthp/dev/linux_work/linux_next/tools/testing/selftests/livepatch/test_modules/test_klp_state.c:38:24: warning: assignment to ‘struct klp_state *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
>>    38 |         loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
>>       |                        ^
> 
> 
> Is the declaration of klp_get_state() visible at that point, i.e. is
> there perhaps any warning about missing declarations above that?
> 
> Otherwise C rules would default to assume an 'int' return type.
> 

This is an interesting clue.  I thought I might be able to reproduce the
build error by modifying include/livepatch.h and running `make -j15 -C
tools/testing/selftests/livepatch` ... but that seemed to work fine on
my system.  I even removed the entire include/ subdir from my tree and
it still built the test module.  Huh?

Then I moved /lib/modules/$(uname -r)/build out of the way and saw that
the compilation failed.  Ah hah -- that's right, it's using the system
build tree.  That version of livepatch.h may have a missing or
completely different definition of klp_get_state().

How does this sequence work for you, Shresth:

  # Verify that kernel livepatching is turned on
  $ grep LIVEPATCH .config
  CONFIG_HAVE_LIVEPATCH=y
  CONFIG_LIVEPATCH=y

  # Build linux-next kernel tree and then the livepatch selftests,
  # pointing KDIR to this tree
  $ make -j$(nproc) vmlinux && \
    make -j$(nproc) KDIR=$(pwd) -C tools/testing/selftests/livepatch

-- 
Joe


