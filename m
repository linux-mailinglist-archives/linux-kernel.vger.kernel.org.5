Return-Path: <linux-kernel+bounces-91744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2568715EF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EADE282FD8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B6C3CF6B;
	Tue,  5 Mar 2024 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cluv2n2W"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64CF1EB2A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709620832; cv=none; b=Lc+rK9lWaW4Y157TSwLZTGwN0B1OaQDvJyp6AT/GjA5VN2VA9U5lx5BCcBSe/+/nrLPF5mhtwfUAiQ5cT93ujise7e0ZsabFzMPfOg6qnjQIwFI2SqZf88DxObc/IP3ywq0Qv+O9XO/WfBREXKlQRMIhkEVW+6McZINdjAwNHY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709620832; c=relaxed/simple;
	bh=/zGsNOXv4+zfaOSRHm7OBxozNL0190WVf25gJGyLfQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=be9iZR8YjXPLb2kOYDTFmDeLB2nRuJW9te8S0urVqx4BGByfiBQcIPMG4TcztBtW3oj+Kl5IEGbc69EsZZoSD6gXd/V/0l+Z6Y1ZUwT5AmDvsrvkFFfLTYpBLTZYwv6DugH4oRST9YPLtP+btrMTHPmxe02NDEKs8nExRluF86A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cluv2n2W; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-58962bf3f89so1728632a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 22:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709620829; x=1710225629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0QgV3Zw3oY3YOJXru9uVmRpPo1J7BQyYNw4d22nBVEk=;
        b=cluv2n2Wz5zUjgfTeQwa7PQS8oEMIPydHF7MbTBZ3MfjxdWrUHFqgoGXjc+RzBsV5B
         DzxVqnHtq6kOCjJ2jj9QSz0CyYPtv8WKSh3meUT+s23k3sFQVF1I9ESVxIGb4vwtKlav
         kxJUVt6YZY/jYOBcMAhAZFwZpyeQfsc8H85QUn7eY4/uVojo9z+X3xkD9J0/5+pLa1le
         l4aPRLqJiD7CSZYXi+iZuNQTqErE284vmlysxe9k33Vqh+03JdvqzJfZcKYBcVpmI8nv
         jz6nMAqSEy8NhlOxibv0/GihTw9ZIPCyRQkXjffHrEO/kdOHS4ikwaysZbL+NLYGZssr
         J8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709620829; x=1710225629;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QgV3Zw3oY3YOJXru9uVmRpPo1J7BQyYNw4d22nBVEk=;
        b=NlY9n4Ca5WkK/pyjKZp1GNZEIH4WXd8amXFObxqzOvmgAfcdSVQqQq7IRNItLJ8ykY
         BpveCOfS0kXChBhcFbZ6SPxlS7h4kaX69hpOhpUnWBfowt/GcshQ7kaXh83GIjccGXtT
         /GCcHoLV0loyMDfWaBkDD8+YTOslQjXTSm8PpJryiAgPS7KSL50BESjfexdBNR79yTRr
         JtXWsXpP/iIsCbV+q1Lm1Ah8wc8KAhVkGLP2xE5HoPQ4AN4aMyQGVmb8Tik4b/6IRwMp
         uZsSIFl/Z41+4DpU/O40hOGWJTfp/Of1PUYMiKhhV5Tgk7ji7PcpUaAxDhEVh9ycaV9R
         AErw==
X-Gm-Message-State: AOJu0Yyv6SBYMaA0iFPyDOyY+sjlLZIy2rzp1uNbDPXXB+1gCJCfxPJl
	BpbRSasjeBGwajtyv221A/BVDRF7egYZApKW6JxUU7OgprU6EzEscj6WyxXWY1OpJpEHgiUJOMb
	m
X-Google-Smtp-Source: AGHT+IHZxiz0iMVb2fIg/cpgI3VI363VCQaJJXpZy603Jnq8UN3YQ4PhIpNCXhOui9S5s+OR9lpBlw==
X-Received: by 2002:a05:6a00:1704:b0:6e6:13ec:7170 with SMTP id h4-20020a056a00170400b006e613ec7170mr7623681pfc.0.1709620829075;
        Mon, 04 Mar 2024 22:40:29 -0800 (PST)
Received: from [10.84.154.17] ([203.208.167.155])
        by smtp.gmail.com with ESMTPSA id f6-20020a056a000b0600b006e3a69eb6c4sm8147094pfu.219.2024.03.04.22.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 22:40:28 -0800 (PST)
Message-ID: <e2b55630-170b-4269-9088-f226c7323ff5@bytedance.com>
Date: Tue, 5 Mar 2024 14:39:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the mm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240305152634.014058aa@canb.auug.org.au>
From: Qi Zheng <zhengqi.arch@bytedance.com>
Content-Language: en-US
In-Reply-To: <20240305152634.014058aa@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/5 12:26, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (s390 defconfig)
> failed like this:
> 
> In file included from include/linux/smp.h:12,
>                   from include/linux/lockdep.h:14,
>                   from include/linux/spinlock.h:63,
>                   from include/linux/mmzone.h:8,
>                   from include/linux/gfp.h:7,
>                   from include/linux/mm.h:7,
>                   from include/linux/pagewalk.h:5,
>                   from arch/s390/mm/gmap.c:12:
> arch/s390/mm/gmap.c: In function 'gmap_free':
> include/linux/list.h:866:19: error: assignment to 'struct page *' from incompatible pointer type 'struct ptdesc *' [-Werror=incompatible-pointer-types]
>    866 |                 n = list_next_entry(pos, member);                       \
>        |                   ^
> arch/s390/mm/gmap.c:212:17: note: in expansion of macro 'list_for_each_entry_safe'
>    212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_list, pt_list)
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/list.h:868:18: error: assignment to 'struct ptdesc *' from incompatible pointer type 'struct page *' [-Werror=incompatible-pointer-types]
>    868 |              pos = n, n = list_next_entry(n, member))
>        |                  ^
> arch/s390/mm/gmap.c:212:17: note: in expansion of macro 'list_for_each_entry_safe'
>    212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_list, pt_list)
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~
> In file included from include/linux/kernel.h:22,
>                   from arch/s390/mm/gmap.c:11:
> arch/s390/mm/gmap.c:212:72: error: 'struct page' has no member named 'pt_list'; did you mean 'pcp_list'?
>    212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_list, pt_list)
>        |                                                                        ^~~~~~~
> include/linux/container_of.h:19:33: note: in definition of macro 'container_of'
>     19 |         void *__mptr = (void *)(ptr);                                   \
>        |                                 ^~~
> include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
>    645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
>        |         ^~~~~~~~~~
> include/linux/list.h:868:27: note: in expansion of macro 'list_next_entry'
>    868 |              pos = n, n = list_next_entry(n, member))
>        |                           ^~~~~~~~~~~~~~~
> arch/s390/mm/gmap.c:212:17: note: in expansion of macro 'list_for_each_entry_safe'
>    212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_list, pt_list)
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~
> In file included from include/linux/container_of.h:5:
> arch/s390/mm/gmap.c:212:72: error: 'struct page' has no member named 'pt_list'; did you mean 'pcp_list'?
>    212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_list, pt_list)
>        |                                                                        ^~~~~~~
> include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
>     78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>        |                                                        ^~~~
> include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
>     20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>        |         ^~~~~~~~~~~~~
> include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
>     20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>        |                       ^~~~~~~~~~~
> include/linux/list.h:601:9: note: in expansion of macro 'container_of'
>    601 |         container_of(ptr, type, member)
>        |         ^~~~~~~~~~~~
> include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
>    645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
>        |         ^~~~~~~~~~
> include/linux/list.h:868:27: note: in expansion of macro 'list_next_entry'
>    868 |              pos = n, n = list_next_entry(n, member))
>        |                           ^~~~~~~~~~~~~~~
> arch/s390/mm/gmap.c:212:17: note: in expansion of macro 'list_for_each_entry_safe'
>    212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_list, pt_list)
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~
> arch/s390/mm/gmap.c:212:72: error: 'struct page' has no member named 'pt_list'; did you mean 'pcp_list'?
>    212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_list, pt_list)
>        |                                                                        ^~~~~~~
> include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
>     78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>        |                                                        ^~~~
> include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
>     20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>        |         ^~~~~~~~~~~~~
> include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
>     20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>        |                       ^~~~~~~~~~~
> include/linux/list.h:601:9: note: in expansion of macro 'container_of'
>    601 |         container_of(ptr, type, member)
>        |         ^~~~~~~~~~~~
> include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
>    645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
>        |         ^~~~~~~~~~
> include/linux/list.h:868:27: note: in expansion of macro 'list_next_entry'
>    868 |              pos = n, n = list_next_entry(n, member))
>        |                           ^~~~~~~~~~~~~~~
> arch/s390/mm/gmap.c:212:17: note: in expansion of macro 'list_for_each_entry_safe'
>    212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_list, pt_list)
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~
> arch/s390/mm/gmap.c:212:72: error: 'struct page' has no member named 'pt_list'; did you mean 'pcp_list'?
>    212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_list, pt_list)
>        |                                                                        ^~~~~~~
> include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
>     78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>        |                                                        ^~~~
> include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
>     20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>        |         ^~~~~~~~~~~~~
> include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
>     21 |                       __same_type(*(ptr), void),                        \
>        |                       ^~~~~~~~~~~
> include/linux/list.h:601:9: note: in expansion of macro 'container_of'
>    601 |         container_of(ptr, type, member)
>        |         ^~~~~~~~~~~~
> include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
>    645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
>        |         ^~~~~~~~~~
> include/linux/list.h:868:27: note: in expansion of macro 'list_next_entry'
>    868 |              pos = n, n = list_next_entry(n, member))
>        |                           ^~~~~~~~~~~~~~~
> arch/s390/mm/gmap.c:212:17: note: in expansion of macro 'list_for_each_entry_safe'
>    212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_list, pt_list)
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/compiler_types.h:390:27: error: expression in static assertion is not an integer
>    390 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>        |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
>     78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>        |                                                        ^~~~
> include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
>     20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>        |         ^~~~~~~~~~~~~
> include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
>     20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>        |                       ^~~~~~~~~~~
> include/linux/list.h:601:9: note: in expansion of macro 'container_of'
>    601 |         container_of(ptr, type, member)
>        |         ^~~~~~~~~~~~
> include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
>    645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
>        |         ^~~~~~~~~~
> include/linux/list.h:868:27: note: in expansion of macro 'list_next_entry'
>    868 |              pos = n, n = list_next_entry(n, member))
>        |                           ^~~~~~~~~~~~~~~
> arch/s390/mm/gmap.c:212:17: note: in expansion of macro 'list_for_each_entry_safe'
>    212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_list, pt_list)
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~
> In file included from include/uapi/linux/posix_types.h:5,
>                   from include/uapi/linux/types.h:14,
>                   from include/linux/types.h:6,
>                   from include/linux/kasan-checks.h:5,
>                   from include/asm-generic/rwonce.h:26,
>                   from arch/s390/include/asm/rwonce.h:29,
>                   from include/linux/compiler.h:299,
>                   from include/linux/array_size.h:5,
>                   from include/linux/kernel.h:16:
> arch/s390/mm/gmap.c:212:72: error: 'struct page' has no member named 'pt_list'; did you mean 'pcp_list'?
>    212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_list, pt_list)
>        |                                                                        ^~~~~~~
> include/linux/stddef.h:16:58: note: in definition of macro 'offsetof'
>     16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
>        |                                                          ^~~~~~
> include/linux/list.h:601:9: note: in expansion of macro 'container_of'
>    601 |         container_of(ptr, type, member)
>        |         ^~~~~~~~~~~~
> include/linux/list.h:645:9: note: in expansion of macro 'list_entry'
>    645 |         list_entry((pos)->member.next, typeof(*(pos)), member)
>        |         ^~~~~~~~~~
> include/linux/list.h:868:27: note: in expansion of macro 'list_next_entry'
>    868 |              pos = n, n = list_next_entry(n, member))
>        |                           ^~~~~~~~~~~~~~~
> arch/s390/mm/gmap.c:212:17: note: in expansion of macro 'list_for_each_entry_safe'
>    212 |                 list_for_each_entry_safe(ptdesc, next, &gmap->pt_list, pt_list)
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors

Thanks for reporting that, will fix it:

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 4d2674f89322..e43a5a3befd4 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -206,10 +206,10 @@ static void gmap_free(struct gmap *gmap)

         /* Free additional data for a shadow gmap */
         if (gmap_is_shadow(gmap)) {
-               struct ptdesc *ptdesc;
+               struct ptdesc *ptdesc, *n;

                 /* Free all page tables. */
-               list_for_each_entry_safe(ptdesc, next, &gmap->pt_list, 
pt_list)
+               list_for_each_entry_safe(ptdesc, n, &gmap->pt_list, pt_list)
                         page_table_free_pgste(ptdesc);
                 gmap_rmap_radix_tree_free(&gmap->host_to_rmap);
                 /* Release reference to the parent */

> 
> Caused by commit
> 
>    859584c3ddba ("s390: supplement for ptdesc conversion")
> 
> from the mm-unstable branch of the mm tree.
> 
> I have reverted that commit for today.

