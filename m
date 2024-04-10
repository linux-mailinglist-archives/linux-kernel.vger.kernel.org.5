Return-Path: <linux-kernel+bounces-138089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C06089EC94
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EEDD1C2104A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDFA13D281;
	Wed, 10 Apr 2024 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8FxC2sN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA2513A405
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735165; cv=none; b=g7i1C0WxE8UJOm7u1ecrZ+R6cWfLQ3AW76pY6tcVVx8LcviVhNG60GqgiJlS6Mv4imVffZeJp30OB77FnNnawqU110hebVSOIYz4ydHjh20YhCnFWl8rzQU95Cs0AwVzYnf3YhlLSk1WdTIBsD2Fd6gqSachhU5FLbJ1p4vdJv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735165; c=relaxed/simple;
	bh=pjDq7pEPuVOjmyW5giX/WNNLn6uvL697/MMq1rIW1cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RNvSN+y/BNl6ha/xEU9kBpIYtc7Vmp4FvVhrHECY+HhDTbQVr2B759UmKcxCP6uzuq1VjTO7+hHLJDbcP2lHEHe1+zjr3K/5Ns95Ws63KkqblxYxn0J/U1NzQidftIJy75+M5qx6RpDDDEQ4RRmqxfH8+XbX7k8eJBEdMCOvjbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A8FxC2sN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712735161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2dqk71Qs0a3TsZjttzZvmqtj0IIVRk7bEEL3C0VI2m8=;
	b=A8FxC2sNAMQs+b6BerovjDCih7nKJHUR0RTS7448EacsU+mV5pdD8zcZMbzlI0A+i3fzpF
	g+wb55wSDDxx3LdD+Xqy46rgeb5cR6GnbYQgGE7mTRdOTVmYeddWz6BqxAGMxGeS4uib5w
	PpQiVRXJQBYkvY2G8JtDYXuh+cgbH80=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-C8rIg1cROFCnuzGqWELi9w-1; Wed, 10 Apr 2024 03:45:59 -0400
X-MC-Unique: C8rIg1cROFCnuzGqWELi9w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343da0a889dso4158539f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712735159; x=1713339959;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2dqk71Qs0a3TsZjttzZvmqtj0IIVRk7bEEL3C0VI2m8=;
        b=KzUKSnCJxU3tH4PDE29iyXFM9mcGS8euWGsXacuIsEVBhyP9rm+hyMtlBb0KHEbQt7
         AyuV1Ij+iCtcO6vCqsRbQFcXkVtPrmoateiHcFmsY9EDD8w4umLqn3VEKliVRfDcpTT8
         7YgIpyvvhqbBzBJ6wx3if3tM+0xVcxwq4asMFCZOTbbrXELhKfcpwcbhJNfJhnFmkTVM
         VHFO9mKzVPJfLcgLdSUG5MZtPrTXreh1RNdfvWPF2dMYi9+axrj3sVVjm4xbONRoYER5
         IthG78dXiGX82Loiw+y1rCeHSRB84uT+0ApDp8lEB2IHsDMtWXxNpYgaH5RZCI7c0Edk
         oH6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5k1YuX4M+iD7+61RXfbxYQJfEgV/9H1o2HBMdN+kuXfwNL35AkBC3sIOgAELqnfEYrLxJWR4Wn4WGEv5+46i9gld7cp+n+Sh90QwX
X-Gm-Message-State: AOJu0Yy9TxYmOLg27p8Y41sD0sTjfdkIlo5Wm4RlkJ3DS4krktVNy3Dg
	STeXC//3YHzKCbwirif4q/TMCWZvSpvS9kCdS0zUGL6MR5nayfUefSE1eWem5P6RZt6Fze49H9A
	vK+UEZRXskYSUlj+ta1NlbaObEs7QcB4631O0jqcclwqhZX4wKls4baH0TJcc1Q==
X-Received: by 2002:a7b:c412:0:b0:416:3762:cea0 with SMTP id k18-20020a7bc412000000b004163762cea0mr1591565wmi.13.1712735158666;
        Wed, 10 Apr 2024 00:45:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGh56lYnIVYlrDfhwGXRAYHVEa6GRqhyj2Bx7wqIcwzx9hoXY6i5+a/obfACxARUxC7zI2DQ==
X-Received: by 2002:a7b:c412:0:b0:416:3762:cea0 with SMTP id k18-20020a7bc412000000b004163762cea0mr1591543wmi.13.1712735158085;
        Wed, 10 Apr 2024 00:45:58 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c60c1.dip0.t-ipconnect.de. [91.12.96.193])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c4fc400b004170e0aff7asm1061719wmq.35.2024.04.10.00.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 00:45:57 -0700 (PDT)
Message-ID: <ed61ead5-5468-4c75-a355-1308c8cb6fb4@redhat.com>
Date: Wed, 10 Apr 2024 09:45:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Speed up boot with faster linear map creation
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <Mark.Rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240404143308.2224141-1-ryan.roberts@arm.com>
 <Zg+qwooaWFNL7KIg@vm3> <fd4aed3a-42be-44e0-b3bb-12f77c5911a1@arm.com>
 <ZhEkif45F0aVvKPx@vm3> <533adb77-8c2b-40db-84cb-88de77ab92bb@arm.com>
 <FCDCBCEE-7D97-4769-AB95-7294A9CE18E0@linux.dev>
 <1d5abb48-08a8-4d83-a681-6915bc7b6907@arm.com>
 <268FBD1C-B102-4726-A7F4-1125123BDA7A@linux.dev>
 <5e4dc2fe-2945-4fc5-a533-c8b2d04668a0@redhat.com>
 <d02959bc-84d8-4c74-a0da-9ad1159502e1@redhat.com>
 <c0d66e0d-f492-49ba-b79a-9215317bd65f@redhat.com>
 <b5e68f81-f917-4f82-8e86-a691a0721291@arm.com>
 <d1aca51c-2433-4e06-a3ef-842e27371db6@redhat.com>
 <e7af023f-39cd-4aa4-aa13-dd6aabea4cdf@arm.com>
 <156cf812-a2de-4480-80dc-31c38ca0eb57@redhat.com>
 <8AA82C6E-F7E7-40A3-952D-392735E1405A@linux.dev>
 <1E3DBD5D-0EF2-472B-8164-DBC1368C22B4@linux.dev>
 <c2ab8854-66f9-4b26-bcbc-c138918f0e91@redhat.com>
 <B6FCB750-9DE1-478A-97CD-9310A4A1A9F0@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <B6FCB750-9DE1-478A-97CD-9310A4A1A9F0@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.04.24 09:37, Itaru Kitayama wrote:
> 
> 
>> On Apr 10, 2024, at 16:10, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 10.04.24 08:47, Itaru Kitayama wrote:
>>>> On Apr 10, 2024, at 8:30, Itaru Kitayama <itaru.kitayama@linux.dev> wrote:
>>>>
>>>> Hi David,
>>>>
>>>>> On Apr 9, 2024, at 23:45, David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>> On 09.04.24 16:39, Ryan Roberts wrote:
>>>>>> On 09/04/2024 15:29, David Hildenbrand wrote:
>>>>>>> On 09.04.24 16:13, Ryan Roberts wrote:
>>>>>>>> On 09/04/2024 12:51, David Hildenbrand wrote:
>>>>>>>>> On 09.04.24 13:29, David Hildenbrand wrote:
>>>>>>>>>> On 09.04.24 13:22, David Hildenbrand wrote:
>>>>>>>>>>> On 09.04.24 12:13, Itaru Kitayama wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>> On Apr 9, 2024, at 19:04, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 09/04/2024 01:10, Itaru Kitayama wrote:
>>>>>>>>>>>>>> Hi Ryan,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On Apr 8, 2024, at 16:30, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On 06/04/2024 11:31, Itaru Kitayama wrote:
>>>>>>>>>>>>>>>> Hi Ryan,
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On Sat, Apr 06, 2024 at 09:32:34AM +0100, Ryan Roberts wrote:
>>>>>>>>>>>>>>>>> Hi Itaru,
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On 05/04/2024 08:39, Itaru Kitayama wrote:
>>>>>>>>>>>>>>>>>> On Thu, Apr 04, 2024 at 03:33:04PM +0100, Ryan Roberts wrote:
>>>>>>>>>>>>>>>>>>> Hi All,
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> It turns out that creating the linear map can take a significant
>>>>>>>>>>>>>>>>>>> proportion of
>>>>>>>>>>>>>>>>>>> the total boot time, especially when rodata=full. And most of the
>>>>>>>>>>>>>>>>>>> time is spent
>>>>>>>>>>>>>>>>>>> waiting on superfluous tlb invalidation and memory barriers. This
>>>>>>>>>>>>>>>>>>> series reworks
>>>>>>>>>>>>>>>>>>> the kernel pgtable generation code to significantly reduce the number
>>>>>>>>>>>>>>>>>>> of those
>>>>>>>>>>>>>>>>>>> TLBIs, ISBs and DSBs. See each patch for details.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> The below shows the execution time of map_mem() across a couple of
>>>>>>>>>>>>>>>>>>> different
>>>>>>>>>>>>>>>>>>> systems with different RAM configurations. We measure after applying
>>>>>>>>>>>>>>>>>>> each patch
>>>>>>>>>>>>>>>>>>> and show the improvement relative to base (v6.9-rc2):
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>                    | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere
>>>>>>>>>>>>>>>>>>> Altra
>>>>>>>>>>>>>>>>>>>                    | VM, 16G     | VM, 64G     | VM, 256G    | Metal,
>>>>>>>>>>>>>>>>>>> 512G
>>>>>>>>>>>>>>>>>>> ---------------|-------------|-------------|-------------|-------------
>>>>>>>>>>>>>>>>>>>                    |   ms    (%) |   ms    (%) |   ms    (%) |
>>>>>>>>>>>>>>>>>>> ms    (%)
>>>>>>>>>>>>>>>>>>> ---------------|-------------|-------------|-------------|-------------
>>>>>>>>>>>>>>>>>>> base           |  153   (0%) | 2227   (0%) | 8798   (0%) | 17442
>>>>>>>>>>>>>>>>>>> (0%)
>>>>>>>>>>>>>>>>>>> no-cont-remap  |   77 (-49%) |  431 (-81%) | 1727 (-80%) |  3796
>>>>>>>>>>>>>>>>>>> (-78%)
>>>>>>>>>>>>>>>>>>> batch-barriers |   13 (-92%) |  162 (-93%) |  655 (-93%) |  1656
>>>>>>>>>>>>>>>>>>> (-91%)
>>>>>>>>>>>>>>>>>>> no-alloc-remap |   11 (-93%) |  109 (-95%) |  449 (-95%) |  1257
>>>>>>>>>>>>>>>>>>> (-93%)
>>>>>>>>>>>>>>>>>>> lazy-unmap     |    6 (-96%) |   61 (-97%) |  257 (-97%) |   838
>>>>>>>>>>>>>>>>>>> (-95%)
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> This series applies on top of v6.9-rc2. All mm selftests pass. I've
>>>>>>>>>>>>>>>>>>> compile and
>>>>>>>>>>>>>>>>>>> boot tested various PAGE_SIZE and VA size configs.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Changes since v1 [1]
>>>>>>>>>>>>>>>>>>> ====================
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>       - Added Tested-by tags (thanks to Eric and Itaru)
>>>>>>>>>>>>>>>>>>>       - Renamed ___set_pte() -> __set_pte_nosync() (per Ard)
>>>>>>>>>>>>>>>>>>>       - Reordered patches (biggest impact & least controversial first)
>>>>>>>>>>>>>>>>>>>       - Reordered alloc/map/unmap functions in mmu.c to aid reader
>>>>>>>>>>>>>>>>>>>       - pte_clear() -> __pte_clear() in clear_fixmap_nosync()
>>>>>>>>>>>>>>>>>>>       - Reverted generic p4d_index() which caused x86 build error.
>>>>>>>>>>>>>>>>>>> Replaced with
>>>>>>>>>>>>>>>>>>>         unconditional p4d_index() define under arm64.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> [1]
>>>>>>>>>>>>>>>>>>> https://lore.kernel.org/linux-arm-kernel/20240326101448.3453626-1-ryan.roberts@arm.com/<https://lore.kernel.org/linux-arm-kernel/20240326101448.3453626-1-ryan.roberts@arm.com/>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>>>>> Ryan
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Ryan Roberts (4):
>>>>>>>>>>>>>>>>>>>       arm64: mm: Don't remap pgtables per-cont(pte|pmd) block
>>>>>>>>>>>>>>>>>>>       arm64: mm: Batch dsb and isb when populating pgtables
>>>>>>>>>>>>>>>>>>>       arm64: mm: Don't remap pgtables for allocate vs populate
>>>>>>>>>>>>>>>>>>>       arm64: mm: Lazily clear pte table mappings from fixmap
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> arch/arm64/include/asm/fixmap.h  |   5 +-
>>>>>>>>>>>>>>>>>>> arch/arm64/include/asm/mmu.h     |   8 +
>>>>>>>>>>>>>>>>>>> arch/arm64/include/asm/pgtable.h |  13 +-
>>>>>>>>>>>>>>>>>>> arch/arm64/kernel/cpufeature.c   |  10 +-
>>>>>>>>>>>>>>>>>>> arch/arm64/mm/fixmap.c           |  11 +
>>>>>>>>>>>>>>>>>>> arch/arm64/mm/mmu.c              | 377 +++++++++++++++++++++++--------
>>>>>>>>>>>>>>>>>>> 6 files changed, 319 insertions(+), 105 deletions(-)
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> -- 
>>>>>>>>>>>>>>>>>>> 2.25.1
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> I've build and boot tested the v2 on FVP, base is taken from your
>>>>>>>>>>>>>>>>>> linux-rr repo. Running run_vmtests.sh on v2 left some gup longterm not
>>>>>>>>>>>>>>>>>> oks, would you take a look at it? The mm ksefltests used is from your
>>>>>>>>>>>>>>>>>> linux-rr repo too.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Thanks for taking a look at this.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> I can't reproduce your issue unfortunately; steps as follows on Apple
>>>>>>>>>>>>>>>>> M2 VM:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Config: arm64 defconfig + the following:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> # Squashfs for snaps, xfs for large file folios.
>>>>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_SQUASHFS_LZ4
>>>>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_SQUASHFS_LZO
>>>>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_SQUASHFS_XZ
>>>>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_SQUASHFS_ZSTD
>>>>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_XFS_FS
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> # For general mm debug.
>>>>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_DEBUG_VM
>>>>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_DEBUG_VM_MAPLE_TREE
>>>>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_DEBUG_VM_RB
>>>>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_DEBUG_VM_PGFLAGS
>>>>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_DEBUG_VM_PGTABLE
>>>>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_PAGE_TABLE_CHECK
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> # For mm selftests.
>>>>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_USERFAULTFD
>>>>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_TEST_VMALLOC
>>>>>>>>>>>>>>>>> ./scripts/config --enable CONFIG_GUP_TEST
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Running on VM with 12G memory, split across 2 (emulated) NUMA nodes
>>>>>>>>>>>>>>>>> (needed by
>>>>>>>>>>>>>>>>> some mm selftests), with kernel command line to reserve hugetlbs and
>>>>>>>>>>>>>>>>> other
>>>>>>>>>>>>>>>>> features required by some mm selftests:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> "
>>>>>>>>>>>>>>>>> transparent_hugepage=madvise earlycon root=/dev/vda2 secretmem.enable
>>>>>>>>>>>>>>>>> hugepagesz=1G hugepages=0:2,1:2 hugepagesz=32M hugepages=0:2,1:2
>>>>>>>>>>>>>>>>> default_hugepagesz=2M hugepages=0:64,1:64 hugepagesz=64K
>>>>>>>>>>>>>>>>> hugepages=0:2,1:2
>>>>>>>>>>>>>>>>> "
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Ubuntu userspace running off XFS rootfs. Build and run mm selftests
>>>>>>>>>>>>>>>>> from same
>>>>>>>>>>>>>>>>> git tree.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Although I don't think any of this config should make a difference to
>>>>>>>>>>>>>>>>> gup_longterm.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Looks like your errors are all "ftruncate() failed". I've seen this
>>>>>>>>>>>>>>>>> problem on
>>>>>>>>>>>>>>>>> our CI system. There it is due to running the tests from NFS file
>>>>>>>>>>>>>>>>> system. What
>>>>>>>>>>>>>>>>> filesystem are you using? Perhaps you are sharing into the FVP using
>>>>>>>>>>>>>>>>> 9p? That
>>>>>>>>>>>>>>>>> might also be problematic.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> That was it. This time I booted up the kernel including your series on
>>>>>>>>>>>>>>>> QEMU on my M1 and executed the gup_longterm program without the ftruncate
>>>>>>>>>>>>>>>> failures. When testing your kernel on FVP, I was executing the script
>>>>>>>>>>>>>>>> from the FVP's host filesystem using 9p.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I'm not sure exactly what the root cause is. Perhaps there isn't enough
>>>>>>>>>>>>>>> space on
>>>>>>>>>>>>>>> the disk? It might be worth enhancing the error log to provide the
>>>>>>>>>>>>>>> errno in
>>>>>>>>>>>>>>> tools/testing/selftests/mm/gup_longterm.c.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Attached is the strace’d gup_longterm executiong log on your
>>>>>>>>>>>>>> pgtable-boot-speedup-v2 kernel.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Sorry are you saying that it only fails with the pgtable-boot-speedup-v2
>>>>>>>>>>>>> patch
>>>>>>>>>>>>> set applied? I thought we previously concluded that it was independent of
>>>>>>>>>>>>> that?
>>>>>>>>>>>>> I was under the impression that it was filesystem related and not something
>>>>>>>>>>>>> that
>>>>>>>>>>>>> I was planning to investigate.
>>>>>>>>>>>>
>>>>>>>>>>>> No, irrespective of the kernel, if using 9p on FVP the test program fails.
>>>>>>>>>>>> It is indeed 9p filesystem related, as I switched to using NFS all the
>>>>>>>>>>>> issues are gone.
>>>>>>>>>>>
>>>>>>>>>>> Did it never work on 9p? If so, we might have to SKIP that test.
>>>>>>>>>>>
>>>>>>>>>>> openat(AT_FDCWD, "gup_longterm.c_tmpfile_BLboOt", O_RDWR|O_CREAT|O_EXCL,
>>>>>>>>>>> 0600) = 3
>>>>>>>>>>> unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_BLboOt", 0) = 0
>>>>>>>>>>> fstatfs(3, 0xffffe505a840)              = -1 EOPNOTSUPP (Operation not
>>>>>>>>>>> supported)
>>>>>>>>>>> ftruncate(3, 4096)                      = -1 ENOENT (No such file or
>>>>>>>>>>> directory)
>>>>>>>>>>
>>>>>>>>>> Note: I'm wondering if the unlinkat here is the problem that makes
>>>>>>>>>> ftruncate() with 9p result in weird errors (e.g., the hypervisor
>>>>>>>>>> unlinked the file and cannot reopen it for the fstatfs/ftruncate. ...
>>>>>>>>>> which gives us weird errors here).
>>>>>>>>>>
>>>>>>>>>> Then, we should lookup the fs type in run_with_local_tmpfile() before
>>>>>>>>>> the unlink() and simply skip the test if it is 9p.
>>>>>>>>>
>>>>>>>>> The unlink with 9p most certainly was a known issue in the past:
>>>>>>>>>
>>>>>>>>> https://gitlab.com/qemu-project/qemu/-/issues/103
>>>>>>>>>
>>>>>>>>> Maybe it's still an issue with older hypervisors (QEMU?)? Or it was never
>>>>>>>>> completely resolved?
>>>>>>>>
>>>>>>>> I believe Itaru is running on FVP (Fixed Virtual Platform - "fast model" -
>>>>>>>> Arm's architecture emulator). So QEMU won't be involved here. The FVP emulates
>>>>>>>> a 9p device, so perhaps the bug is in there.
>>>>>>>
>>>>>>> Very likely.
>>>>>>>
>>>>>>>>
>>>>>>>> Note that I see lots of "fallocate() failed" failures in gup_longterm when
>>>>>>>> running on our CI system. This is a completely different setup; Real HW with
>>>>>>>> Linux running bare metal using an NFS rootfs. I'm not sure if this is related.
>>>>>>>> Logs show it failing consistently for the "tmpfile" and "local tmpfile" test
>>>>>>>> configs. I also see a couple of these fails in the cow tests.
>>>>>>>
>>>>>>> What is the fallocate() errno you are getting? strace log would help (to see if
>>>>>>> statfs also fails already)! Likely a similar NFS issue.
>>>>>> Unfortunately this is a system I don't have access to. I've requested some of
>>>>>> this triage to be done, but its fairly low priority unfortunately.
>>>>>
>>>>> To work around these BUGs (?) elsewhere, we could simply skip the test if get_fs_type() is not able to detect the FS type. Likely that's an early indicator that the unlink() messed something up.
>>>>>
>>>>> ... doesn't feel right, though.
>>>>
>>>> I think it’s a good idea so that the mm kselftests results look reasonable.
>>
>> Yeah, but this will hide BUGs elsewhere. I suspect that in Ryan's NFS setup is
>> also a BUG lurking somewhere in the NFS implementation. But that's just a guess
>> until we have more details.
>>
> 
> Ok.
> 
>>>> Since you’re an expert on GUP-fast (or fast-GUP?), when you update the code, could you print out errno as well like the split_huge_page_test.c does
>>
>> While we could, I don't see much value in that for selftests. strace log is of much
>> more valuable to understand what is actually happening (e.g., fstatfs failing), and
>> quite easy to obtain.
> 
> Ok.
> 
>>
>>>> Thanks,
>>>> Itaru.
>>> David, attached is the straced execution log of the gup_longterm kselftest over the NFS case.
>>> I’m running the program on FVP, let me know if you need other logs or test results.
>>
>> For your run, it all looks good:
>>
>> openat(AT_FDCWD, "/tmp", O_RDWR|O_EXCL|O_TMPFILE, 0600) = 3
>> fcntl(3, F_GETFL)                       = 0x424002 (flags O_RDWR|O_LARGEFILE|O_TMPFILE)
>> fstatfs(3, {f_type=TMPFS_MAGIC, f_bsize=4096, f_blocks=416015, f_bfree=415997, f_bavail=415997, f_files=416015, f_ffree=416009, f_fsid={val=[0x8e6b7ce6, 0xe1737440]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID|ST_RELATIME}) = 0
>> ftruncate(3, 4096)                      = 0
>> fallocate(3, 0, 0, 4096)                = 0
>>
>> -> TMPFS/SHMEM, works as expected
>>
>> openat(AT_FDCWD, "gup_longterm.c_tmpfile_WMLTNf", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
>> unlinkat(AT_FDCWD, "gup_longterm.c_tmpfile_WMLTNf", 0) = 0
>> fstatfs(3, {f_type=NFS_SUPER_MAGIC, f_bsize=1048576, f_blocks=112200, f_bfree=27954, f_bavail=23296, f_files=7307264, f_ffree=4724815, f_fsid={val=[0, 0]}, f_namelen=255, f_frsize=1048576, f_flags=ST_VALID|ST_RELATIME}) = 0
>> ftruncate(3, 4096)                      = 0
>> fallocate(3, 0, 0, 4096)                = 0
>>
>> -> NFS, works as expected
>>
>> Note that you get all skips (not fails), because your kernel is not compiled with CONFIG_GUP_TEST.
>>
>> ok 1 # SKIP gup_test not available
> 
> I rebuilt the v6.9-rc3 kernel with that option enabled. This time SKIPs are due to “need more free huge pages”, I’ll check even on a limited memory size system preparing enough huge pages is possible.

That's expected, you have to reserve hugetlb pages before running the 
test. But the important thing is that tmpfs/nfs works for you.

-- 
Cheers,

David / dhildenb


