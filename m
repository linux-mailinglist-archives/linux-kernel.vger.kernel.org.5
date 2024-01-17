Return-Path: <linux-kernel+bounces-29439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A088A830E48
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6231F233D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA032554C;
	Wed, 17 Jan 2024 20:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCStkUz/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C2F250F8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705524771; cv=none; b=URue7seMIREYs7ApTgJx4PgAhQ0aaUQ5dvdqLj1mP0RaQCtJo/IzZWYPCUlU7UBWUfk+Hark85vDIumQfTV4uQDO9HRfrtX6oI+NSTKq9vkdMogf1axjKzsRVXryxMVIEJ6nXdP2zvBkU+nqIIMOLcUkmVBsdfzAdTRUMlcrlR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705524771; c=relaxed/simple;
	bh=w1N/9RdTF0m28U7wl6PudqhvZgMkjJKIwyVvGQrpzEc=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding; b=dk/yO1vBQrIMYFFkjVwa3KFvREOTM2I9Y6aqY1tggsVnvVUDS47gF8HJzebBbI67kive3aUTDMgeFoOUbawk23uTw5mwIdWOMF60+BOyMqE6kBgRrd88CoexrLIOJgjumZCRfMnwIdb+DMEdBexdqEmwyx27DgKtFrN/KkCTTQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aCStkUz/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705524769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYYQA8EYqNhKzjt8PAGzhasaQqUEd+G0AxBXGuM/SjY=;
	b=aCStkUz/mMvjkfR3CNF/MNrt6dD/0owwKvRFxoonn7A1uc8nXJXT3hpTDgLaN9Ib/Ut9ID
	Rjhk8jpR5XFpMWdvo0pmEiYgJtTwaCwvf2L5K91qfESNFC1y/h5oWYsu7XryMFTRxmTI3W
	Dh75aJQ9YW+QPD8GWZQfS8nNMVsh3CY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-lzPVyB5tPRW6EgE0p8zIwg-1; Wed, 17 Jan 2024 15:52:48 -0500
X-MC-Unique: lzPVyB5tPRW6EgE0p8zIwg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6805a03aeaeso216109096d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 12:52:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705524767; x=1706129567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gYYQA8EYqNhKzjt8PAGzhasaQqUEd+G0AxBXGuM/SjY=;
        b=hxhzk/0HCVGwrtTNpJAUdpnpUCTX4VGddx6Ad4ZFyzm3Ge+8LJo8u2JoWNqFq3/3vz
         GK4N+aZW9u6a9Xb4uZWMh7qTzXFlKQ29dxX2e73n7EUn9fkGMAf3O53dfiQ4hVQCmrt2
         eHmgzv+ZvYx0FA0tD21y4eY19KKXcfw0NcD7UvqML0p+MwnbKj0uvAUfHLNGjKrmx3kC
         iUTZeLyz+mbUPHjKgSJJ5POqSGT627m02dLPG3NiNWj6ejRp9TPN7PiU+qJmV/QXBoYX
         V023TP19Le0JNUKUTOwjWE6JEbnkPpVpQ/sjkdb8LEyCScZtWItl/LJfQneHpfym+FnK
         /wTw==
X-Gm-Message-State: AOJu0YwSPDoF4wwEvoWXRyI055SnHsQHBYnylhYCkcVxLJaN/oQpLWSl
	JOG7vI2rB/u7/g+4C8kQebBtgVuTmUfu4tfvMRWQfsO8z51rA3VwXXU1bqOz+Czbwa4fOAJ9KOA
	oyRcDe8XQPwGDFG5u6Mp0CpMQJsIDJqpw
X-Received: by 2002:a05:6214:d4d:b0:681:7d2f:cdb5 with SMTP id 13-20020a0562140d4d00b006817d2fcdb5mr1550356qvr.127.1705524765995;
        Wed, 17 Jan 2024 12:52:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUh6P3+8KmBAZrT8Wmzqh7ukh87inI3PyD5QxK8+Chw6ns3jb9wnb8vdxCgU3iMf4csVtstg==
X-Received: by 2002:a05:6214:d4d:b0:681:7d2f:cdb5 with SMTP id 13-20020a0562140d4d00b006817d2fcdb5mr1550338qvr.127.1705524765686;
        Wed, 17 Jan 2024 12:52:45 -0800 (PST)
Received: from [192.168.1.32] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id kr20-20020a0562142b9400b0068188eee9eesm228501qvb.113.2024.01.17.12.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 12:52:45 -0800 (PST)
Message-ID: <3c4f6faf-e19e-6de5-e479-3b3893a3499f@redhat.com>
Date: Wed, 17 Jan 2024 15:52:43 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 0/3] livepatch: Move modules to selftests and add a new
 test
Content-Language: en-US
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Shuah Khan
 <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>
Cc: linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 live-patching@vger.kernel.org
References: <20240112-send-lp-kselftests-v6-0-79f3e9a46717@suse.com>
From: Joe Lawrence <joe.lawrence@redhat.com>
In-Reply-To: <20240112-send-lp-kselftests-v6-0-79f3e9a46717@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/24 12:43, Marcos Paulo de Souza wrote:
> Changes in v6:
> - Rebased on top of 70d201a40823 (thanks Alexander Gordeev!)
> - Resolved a conflict because of 43e8832fed08 being reverted
> - Resolved a missing static declaration for lp_sys_getpid, since
>   -Wmissing-prototypes warning was enabled.
> - Retested everything, from running the livepatch selftests from kernel
>   source, running from a directory here the testes were installed (Joe's
>   usecase), and running from a gen_tar'ed directory. All of them
>   executed correctly.
> - Added Petr review tags (Thanks!)
> - Link to v5: https://lore.kernel.org/r/20240109-send-lp-kselftests-v5-0-364d59a69f12@suse.com
> 
> Changes in v5:
> * Fixed an issue found by Joe that copied Kbuild files along with the
>   test modules to the installation directory.
> * Added Joe Lawrense review tags.
> 
> Changes in v4:
> * Documented how to compile the livepatch selftests without running the
>   tests (Joe)
> * Removed the mention to lib/livepatch on MAINTAINERS file, reported by
>   checkpatch.
> 
> Changes in v3:
> * Rebased on top of v6.6-rc5
> * The commits messages were improved (Thanks Petr!)
> * Created TEST_GEN_MODS_DIR variable to point to a directly that contains kernel
>   modules, and adapt selftests to build it before running the test.
> * Moved test_klp-call_getpid out of test_programs, since the gen_tar
>   would just copy the generated test programs to the livepatches dir,
>   and so scripts relying on test_programs/test_klp-call_getpid will fail.
> * Added a module_param for klp_pids, describing it's usage.
> * Simplified the call_getpid program to ignore the return of getpid syscall,
>   since we only want to make sure the process transitions correctly to the
>   patched stated
> * The test-syscall.sh not prints a log message showing the number of remaining
>   processes to transition into to livepatched state, and check_output expects it
>   to be 0.
> * Added MODULE_AUTHOR and MODULE_DESCRIPTION to test_klp_syscall.c
> 
> - Link to v3: https://lore.kernel.org/r/20231031-send-lp-kselftests-v3-0-2b1655c2605f@suse.com
> - Link to v2: https://lore.kernel.org/linux-kselftest/20220630141226.2802-1-mpdesouza@suse.com/
> 
> This patchset moves the current kernel testing livepatch modules from
> lib/livepatches to tools/testing/selftest/livepatch/test_modules, and compiles
> them as out-of-tree modules before testing.
> 
> There is also a new test being added. This new test exercises multiple processes
> calling a syscall, while a livepatch patched the syscall.
> 
> Why this move is an improvement:
> * The modules are now compiled as out-of-tree modules against the current
>   running kernel, making them capable of being tested on different systems with
>   newer or older kernels.
> * Such approach now needs kernel-devel package to be installed, since they are
>   out-of-tree modules. These can be generated by running "make rpm-pkg" in the
>   kernel source.
> 
> What needs to be solved:
> * Currently gen_tar only packages the resulting binaries of the tests, and not
>   the sources. For the current approach, the newly added modules would be
>   compiled and then packaged. It works when testing on a system with the same
>   kernel version. But it will fail when running on a machine with different kernel
>   version, since module was compiled against the kernel currently running.
> 
>   This is not a new problem, just aligning the expectations. For the current
>   approach to be truly system agnostic gen_tar would need to include the module
>   and program sources to be compiled in the target systems.
> 
> Thanks in advance!
>   Marcos
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> Marcos Paulo de Souza (3):
>       kselftests: lib.mk: Add TEST_GEN_MODS_DIR variable
>       livepatch: Move tests from lib/livepatch to selftests/livepatch
>       selftests: livepatch: Test livepatching a heavily called syscall
> 
>  Documentation/dev-tools/kselftest.rst              |   4 +
>  MAINTAINERS                                        |   1 -
>  arch/s390/configs/debug_defconfig                  |   1 -
>  arch/s390/configs/defconfig                        |   1 -
>  lib/Kconfig.debug                                  |  22 ----
>  lib/Makefile                                       |   2 -
>  lib/livepatch/Makefile                             |  14 ---
>  tools/testing/selftests/lib.mk                     |  26 ++++-
>  tools/testing/selftests/livepatch/Makefile         |   5 +-
>  tools/testing/selftests/livepatch/README           |  25 +++--
>  tools/testing/selftests/livepatch/config           |   1 -
>  tools/testing/selftests/livepatch/functions.sh     |  34 +++---
>  .../testing/selftests/livepatch/test-callbacks.sh  |  50 ++++-----
>  tools/testing/selftests/livepatch/test-ftrace.sh   |   6 +-
>  .../testing/selftests/livepatch/test-livepatch.sh  |  10 +-
>  .../selftests/livepatch/test-shadow-vars.sh        |   2 +-
>  tools/testing/selftests/livepatch/test-state.sh    |  18 ++--
>  tools/testing/selftests/livepatch/test-syscall.sh  |  53 ++++++++++
>  tools/testing/selftests/livepatch/test-sysfs.sh    |   6 +-
>  .../selftests/livepatch/test_klp-call_getpid.c     |  44 ++++++++
>  .../selftests/livepatch/test_modules/Makefile      |  20 ++++
>  .../test_modules}/test_klp_atomic_replace.c        |   0
>  .../test_modules}/test_klp_callbacks_busy.c        |   0
>  .../test_modules}/test_klp_callbacks_demo.c        |   0
>  .../test_modules}/test_klp_callbacks_demo2.c       |   0
>  .../test_modules}/test_klp_callbacks_mod.c         |   0
>  .../livepatch/test_modules}/test_klp_livepatch.c   |   0
>  .../livepatch/test_modules}/test_klp_shadow_vars.c |   0
>  .../livepatch/test_modules}/test_klp_state.c       |   0
>  .../livepatch/test_modules}/test_klp_state2.c      |   0
>  .../livepatch/test_modules}/test_klp_state3.c      |   0
>  .../livepatch/test_modules/test_klp_syscall.c      | 116 +++++++++++++++++++++
>  32 files changed, 340 insertions(+), 121 deletions(-)
> ---
> base-commit: 70d201a40823acba23899342d62bc2644051ad2e
> change-id: 20231031-send-lp-kselftests-4c917dcd4565
> 

LGTM.  FWIW, my kernel-ark testing [1] for prototyping a future CentOS
Stream backport (ie, building the selftests alongside the kernel for rpm
packaging) plays well with v6.  Just ignore the ppc64le build failure,
that appears to be an unrelated bpftool build glitch. :)

[1] https://gitlab.com/cki-project/kernel-ark/-/merge_requests/2844

-- 
Joe


