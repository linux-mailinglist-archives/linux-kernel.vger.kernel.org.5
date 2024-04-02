Return-Path: <linux-kernel+bounces-127657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45763894F00
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA54E1F23FE8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF2C58AD6;
	Tue,  2 Apr 2024 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N98pBEIG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D199358AC0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051304; cv=none; b=GLvmPLfoTn0tKEJ9FveOlydG5HinaCdvsNGSkeezSPm4Kox/yj+DXE2eLNnMzdFN8ayIzUzJAJdgCGn5Pv0crsOCnfkXv5lo8gH71FYzQwpbyAiFAL03CIPLm3LupYZzplnhUJYAdaLfS+WB2l6ekggHo8asw5rp56AMXuLoR6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051304; c=relaxed/simple;
	bh=WGnlDg/2lzphW7QtK1gHOwrVxjlofgUKiaJvO9FpzJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbE1uZofwlWJvYQ4LTnPD1AlKau5NQ2xa41IUChfzhX2iMbb0PUNs7EXP7jvTjiOoX6N3GKDff8R65QiXHVUAKbDaBG26rdQcNgwheqDTaU/gat0Bolvzr9Sa9okUXsxaFFncIlN/W8wp6a01GhS9Ep/Czysag7IgZTLwkIwNrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N98pBEIG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712051301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QSV79mnLWBoOYetvsrDuevhstPMzt7CaHwjlaxF6010=;
	b=N98pBEIGqZ5Jk1H7NxtY+7LSOP3d37aEitvzSVL6fFzI8c6f4YO4pbKPzvD8YXxuqdq4Wu
	C+Hezjffa+IgyjnKK1xAP9a1bLiULFz3hljqG2ZGa/M4Bw3ZgaiPvyqDTc+tpLXaQJiXAY
	BdM/7Ab8jcrZ7X4PVRv9ZMLLaR883V0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657--i2bm6GNMmW9O8oKB566Dw-1; Tue, 02 Apr 2024 05:48:19 -0400
X-MC-Unique: -i2bm6GNMmW9O8oKB566Dw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-415591b1500so11759935e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 02:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712051298; x=1712656098;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSV79mnLWBoOYetvsrDuevhstPMzt7CaHwjlaxF6010=;
        b=TDoRfeAxMdFDeKsvquy85OHutDC0PrbXNEThFW2vt6Bm8gznomFxtm/A7j7jSwtwqT
         PulmkL3Drxysy9dB/Ev42TWFHdHoSTEeR/3WJUltrjEFRgfEnRvf/VlurE9ZTu3dcmle
         goiEbhkNJz/tovAsSIhJQC0A5g5IVoRtEqRzcEMT205ApA9G7prUhpPFQGLUyODJJfNi
         6XdG6fA933ixAG5qzu1E5xMQFD14JremUeEqAVPcDA927c1a8SlFNVYvjENWStxjhHhs
         QZswFoiSx4x4egqrGKjMRDS2R4LcaN3awuN7nuamfaXDqjNFvh3pKqD+kAqjWvyHC8Jv
         pyoA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ6z1kUU9le3NGH8AKN0m0DANc/PuJ2aWzn14FGR585hwSLRCYBLq/c89nGLnPb7eStngAiqjUythib910SsmhEfBIbJHTGiUkfh+U
X-Gm-Message-State: AOJu0Yzi/YRPZvwVDid0Q0CGSk2mQiP+Ef3r7d2eKDYS3JxxoyIKTk39
	i+SuuXWRzpTEsB56ZXFhF5BvPFprmvJuEaD6iBs8LhDQUWfP32rX/NWiU70G/HJjDXhMqJKXK7+
	frxYymUExXKc/QojTFEDaa3WQsBDCSUlnUv+JXcA9gKitl3uk0tPNQ6cU+YHA+w==
X-Received: by 2002:a05:600c:1f94:b0:415:540e:74e7 with SMTP id je20-20020a05600c1f9400b00415540e74e7mr6944771wmb.16.1712051298215;
        Tue, 02 Apr 2024 02:48:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOzfQTtXS+MX3pvlp2uYzO6vnNACGF94wZgnpc9t08xb3hUKsQMsbxFuZ5NvUIKzmOsAb6Pw==
X-Received: by 2002:a05:600c:1f94:b0:415:540e:74e7 with SMTP id je20-20020a05600c1f9400b00415540e74e7mr6944757wmb.16.1712051297796;
        Tue, 02 Apr 2024 02:48:17 -0700 (PDT)
Received: from [192.168.3.108] (p4ff239ef.dip0.t-ipconnect.de. [79.242.57.239])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c351100b00414854cd257sm17315209wmq.20.2024.04.02.02.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 02:48:17 -0700 (PDT)
Message-ID: <1a91e772-4150-4d28-9c67-cb6d0478af79@redhat.com>
Date: Tue, 2 Apr 2024 11:48:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Increase Default vm_max_map_count to Improve Compatibility with
 Modern Games
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
 linux-kernel@vger.kernel.org
Cc: vincentdelor@free.fr, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org
References: <566168554.272637693.1710968734203.JavaMail.root@zimbra54-e10.priv.proxad.net>
 <13499186.uLZWGnKmhe@natalenko.name>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <13499186.uLZWGnKmhe@natalenko.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.04.24 09:34, Oleksandr Natalenko wrote:
> Hello.
> 
> On středa 20. března 2024 22:05:34, CEST vincentdelor@free.fr wrote:
>> Hello,
>>
>> I am writing to highlight an issue impacting many Linux users, especially those who enjoy modern gaming. The current default setting of `vm_max_map_count` at 65530 has been linked to crashes or launch failures in several contemporary games.
>>
>> To address this, I have opened a detailed bug report (218616 – Increase Default vm_max_map_count to Improve Gaming Experience on Linux) available at: 218616 – Increase Default vm_max_map_count to Improve Gaming Experience on Linux (kernel.org) .
>>
>>
>> We have identified that several modern games such as Hogwarts Legacy, Star Citizen, and others experience crashes or fail to start on Linux due to the default `vm_max_map_count` being set to 65530. These issues can be mitigated by increasing the `vm_max_map_count` value to over 1048576, which has been confirmed to resolve the crashes without introducing additional bugs related to map handling.
>>
>> This issue affects a wide range of users and has been noted in distributions like Fedora and Pop!_OS, which have already adjusted this value to accommodate modern gaming requirements.
>>
>> For reference, here is the change for Fedora:
>> https://fedoraproject.org/wiki/Changes/IncreaseVmMaxMapCount
>>
>> Here is a list of games affected by this low value in vm_max_map_count as reported to Valve:
>>
>> THE FINALS
>> https://github.com/ValveSoftware/Proton/issues/7317#issuecomment-1974837850
>>
>> Hogwarts Legacy
>> https://github.com/ValveSoftware/Proton/issues/6510#issuecomment-1422781100
>>
>> DayZ
>> https://github.com/ValveSoftware/Proton/issues/3899#issuecomment-1304397069
>>
>> Counter-Strike 2
>> https://github.com/ValveSoftware/Proton/issues/2704#issuecomment-1705199788
>>
>>
>> **Steps to Reproduce:**
>> 1. Install Ubuntu or other distribution with `vm_max_map_count` being set to 65530 and attempt to run affected games such as Hogwarts Legacy or Star Citizen.
>> 2. Observe that the games crash or fail to start with the default `vm_max_map_count` setting.
>> 3. Modify `/etc/sysctl.conf` to include `vm.max_map_count=1048576` (or another sufficiently high value).
>> 4. Reboot the system and observe that the games now run without issue.
>>
>> **Expected Result:**
>> Games should run without crashing or failing to start due to `vm_max_map_count` limitations.
>>
>> **Actual Result:**
>> Games crash or fail to start unless `vm_max_map_count` is manually increased.
>>
>> **Suggested Fix:**
>> Increase the default `vm_max_map_count` value in Linux to a value greater than 1048576 to accommodate modern gaming software requirements.
>>
>> **Affected Games:**
>> - Hogwarts Legacy
>> - Star Citizen
>> - THE FINALS
>> - DayZ
>> - Counter-Strike 2
>> - Payday 2
>> - (and potentially others)
>>
>> **References:**
>> - Fedora's change documentation: https://fedoraproject.org/wiki/Changes/IncreaseVmMaxMapCount
>> - Various user reports and confirmations on gaming performance improvement with increased `vm_max_map_count`.
>>
>> I appreciate your time and consideration and welcome any feedback or suggestions on this matter.
>>
>> Best regards,
>>
>> Vincent DELOR
>>
>>
> 
> Adding more lists and people to Cc. This email was sent to LKML only meaning it is highly likely no one really saw it.
> 
> Andrew et al., what do you think?

Using a high VMA count usually implies that the application is doing 
something suboptimal. Having many VMAs can degrade performance of MM 
operations and result in memory waste.

Running into VMA limits usually implies that the application is not 
optimized and should handle things differently. Likely, the memory 
allocator is doing something "bad" (e.g., mmap()+munmap() instead of 
MADV_DONTNEED) and should be optimized.

I don't think we should be raising the limit for everybody out there.

-- 
Cheers,

David / dhildenb


