Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9FF789D0A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 12:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjH0KpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 06:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjH0Kox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 06:44:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B03186
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 03:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693133045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gd22ezUKcwqT1bZ9j87gCgLT1/C+MuJtb6TwFtS9oS8=;
        b=P0Kkc+OnY16/UwUX5waGCf/wEjihu3MbHLGfIWi1/KA7cbBBGLu63baKD6Osvz0C9dV98M
        Kh1O2UYxt8Nyf2LYULywJY5jURd521ayftL1UGhwnhKxIoXAthkFjiMsuw2D1IEaF8WhVv
        RCCJbr9NiUWgZk9fi8jG/vTNiYpvL50=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-0j7igmE5PcWQ_x4ZNxGPqw-1; Sun, 27 Aug 2023 06:44:01 -0400
X-MC-Unique: 0j7igmE5PcWQ_x4ZNxGPqw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEA5C380673A;
        Sun, 27 Aug 2023 10:44:00 +0000 (UTC)
Received: from localhost (unknown [10.72.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C2AE2C15E6A;
        Sun, 27 Aug 2023 10:43:58 +0000 (UTC)
Date:   Sun, 27 Aug 2023 18:43:55 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dave Young <dyoung@redhat.com>, Philipp Rudo <prudo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        horms@kernel.org, chenjiahao16@huawei.com,
        linux-riscv@lists.infradead.org, x86@kernel.org, bp@alien8.de
Subject: Re: [RFC PATCH 0/4] kdump: add generic functions to simplify
 crashkernel crashkernel in architecture
Message-ID: <ZOso66U0DIR9rfMW@MiWiFi-R3L-srv>
References: <20230619055951.45620-1-bhe@redhat.com>
 <ZKjG2R8RhWmJex53@darkstar.users.ipa.redhat.com>
 <20230710192018.031c9912@rotkaeppchen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710192018.031c9912@rotkaeppchen>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave, Philipp

On 07/10/23 at 07:20pm, Philipp Rudo wrote:
> Hi Baoquan,
> Hi Dave,
> 
> On Sat, 8 Jul 2023 10:15:53 +0800
> Dave Young <dyoung@redhat.com> wrote:
> 
> > On 06/19/23 at 01:59pm, Baoquan He wrote:
> > > In the current arm64, crashkernel=,high support has been finished after
> > > several rounds of posting and careful reviewing. The code in arm64 which
> > > parses crashkernel kernel parameters firstly, then reserve memory can be
> > > a good example for other ARCH to refer to.
> > > 
> > > Whereas in x86_64, the code mixing crashkernel parameter parsing and
> > > memory reserving is twisted, and looks messy. Refactoring the code to
> > > make it more readable maintainable is necessary.
> > > 
> > > Here, try to abstract the crashkernel parameter parsing code into a
> > > generic function parse_crashkernel_generic(), and the crashkernel memory
> > > reserving code into a generic function reserve_crashkernel_generic().
> > > Then, in ARCH which crashkernel=,high support is needed, a simple
> > > arch_reserve_crashkernel() can be added to call above two generic
> > > functions. This can remove the duplicated implmentation code in each
> > > ARCH, like arm64, x86_64.  
> > 
> > Hi Baoquan, the parse_crashkernel_common and parse_crashkernel_generic
> > are confusion to me.  Thanks for the effort though.
> 
> I agree, having both parse_crashkernel_common and
> parse_crashkernel_generic is pretty confusing.

Sorry for being late to respond, and thank both a lot for reviewing
and valuable suggestions on this patchset, and

I have made a new patchset to address your concern that the old 
parse_crashkernel_common() and parse_crashkernel_generic() are
confusing. Please see the new formal post which can be accessed from
below link. Within the new post, I integrated all kinds of crashkernel
parsing into parse_crashkernel().

https://lore.kernel.org/all/20230827101128.70931-1-bhe@redhat.com/T/#u 
[PATCH 0/8] kdump: use generic functions to simplify crashkernel reservation in architectures

As for introducing a new structure struct crashkernel and enum
crashkernel_type, after careful thinking, I think it may not be
appropriate in this place. The reason is that even though we have
several different grammers of crashkernel= specification, in fact
there's one being able to set in kernel parameters. Crashkernel=,high
support is special because it needs too, while we can ignore the
crashernel=,low since crashkernel=,low is not an independent one.
So a structure wrapper isn't helping much and will cause many code
change churn in all architectures where crashkernel=,high is not
supported. Besides, we have fallback mechanism for crashkernel=xM and
crashkernel=xM,high. So the switch case handling Phlipp suggested
doesn't fit in this case.

As you can see, with the v1 patchset, the code change is few and not
hard to understand.

> 
> > I'm not sure if it will be easy or not, but ideally I think the parse
> > function can be arch independent, something like a general funtion
> > parse_crashkernel() which can return the whole necessary infomation of
> > crashkenrel for arch code to use, for example return like
> > below pseudo stucture(just a concept, may need to think more):
> > 
> > structure crashkernel_range {
> > 	size,
> > 	range,
> > 	struct list_head list;
> > }
> > 
> > structure crashkernel{
> >   structure crashkernel_range *range_list;
> >   union {
> >   	offset,
> >   	low_high
> >   }
> > }
> > 
> > So the arch code can just get the data of crashkernel and then check
> > about the details, if it does not support low and high reservation then
> > it can just ignore the option.
> > 
> > Thoughts?
> 
> Sounds reasonable. The only thing I would make different is for the
> parser to take the systems ram into account and simply return the size
> that needs to be allocated in case multiple ranges are given.
> 
> I've played around a little on how this might look like (probably
> wasting way too much time on it) and came up with the patch below. With
> that patch parse_crashkernel_{common,high,low} and friends could be
> removed once all architectures are ported to the new parse_crashkernel
> function.
> 
> Please note that I never tested the patch. So it probably doesn't even
> compile. Nevertheless I hope it helps to get an idea on what I think
> should work :-)
> 
> Thanks
> Philipp
> 
> ----
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index fb904cc57ab1..fd5d01872c53 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -66,22 +66,12 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
>  
>  static void __init arch_reserve_crashkernel(void)
>  {
> -	unsigned long long low_size = 0;
> -	unsigned long long crash_base, crash_size;
>  	char *cmdline = boot_command_line;
> -	bool high = false;
> -	int ret;
>  
>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>  		return;
>  
> -	ret = parse_crashkernel_generic(cmdline, &crash_size, &crash_base,
> -					&low_size, &high);
> -	if (ret)
> -		return;
> -
> -	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
> -				    low_size, high);
> +	reserve_crashkernel_generic(cmdline);
>  }
>  
>  /*
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index b26221022283..4a78bf8ad494 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -486,28 +486,17 @@ unsigned long crash_low_size_default(void)
>  
>  static void __init arch_reserve_crashkernel(void)
>  {
> -	unsigned long long crash_base, crash_size, low_size = 0;
>  	char *cmdline = boot_command_line;
> -	bool high = false;
> -	int ret;
>  
>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>  		return;
>  
> -	ret = parse_crashkernel_generic(cmdline, &crash_size, &crash_base,
> -					&low_size, &high);
> -	if (ret)
> -		return;
> -
>  	if (xen_pv_domain()) {
>  		pr_info("Ignoring crashkernel for a Xen PV domain\n");
>  		return;
>  	}
>  
> -	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
> -				    low_size, high);
> -
> -	return;
> +	reserve_crashkernel_generic(cmdline);
>  }
>  
>  static struct resource standard_io_resources[] = {
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 1b12868cad1b..a1ebd6c47467 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -84,35 +84,25 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>  int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>  		unsigned long long *crash_size, unsigned long long *crash_base);
>  
> -#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> -int __init parse_crashkernel_generic(char *cmdline,
> -				 unsigned long long *crash_size,
> -				 unsigned long long *crash_base,
> -				 unsigned long long *low_size,
> -				 bool *high);
> -
> -void __init reserve_crashkernel_generic(char *cmdline,
> -		unsigned long long crash_size,
> -		unsigned long long crash_base,
> -		unsigned long long crash_low_size,
> -		bool high);
> -#else
> -
> -static inline int __init parse_crashkernel_generic(char *cmdline,
> -		unsigned long long *crash_size,
> -		unsigned long long *crash_base,
> -		unsigned long long *low_size,
> -		bool *high)
> -{
> -	return 0;
> +enum crashkernel_type {
> +	CRASHKERNEL_NORMAL,
> +	CRASHKERNEL_FIXED_OFFSET,
> +	CRASHKERNEL_HIGH,
> +	CRASHKERNEL_LOW
>  }
>  
> -static inline void __init reserve_crashkernel_generic(char *cmdline,
> -		unsigned long long crash_size,
> -		unsigned long long crash_base,
> -		unsigned long long crash_low_size,
> -		bool high)
> -{}
> +struct crashkernl {
> +	enum crashkernel_type type;
> +	unsigned long long size;
> +	unsigned long long offet;
> +};
> +
> +int __init parse_crashkernel(char *cmdline, struct crashkernel *ck);
> +
> +#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> +void __init reserve_crashkernel_generic(char *cmdline);
> +#else
> +void __init reserve_crashkernel_generic(char *cmdline) {}
>  #endif
>  
>  #endif /* LINUX_CRASH_CORE_H */
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index b82dc8c970de..c04a8675446b 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -203,8 +203,7 @@ static int __init parse_crashkernel_suffix(char *cmdline,
>  }
>  
>  static __init char *get_last_crashkernel(char *cmdline,
> -			     const char *name,
> -			     const char *suffix)
> +					 const char *name)
>  {
>  	char *p = cmdline, *ck_cmdline = NULL;
>  
> @@ -217,23 +216,6 @@ static __init char *get_last_crashkernel(char *cmdline,
>  		if (!end_p)
>  			end_p = p + strlen(p);
>  
> -		if (!suffix) {
> -			int i;
> -
> -			/* skip the one with any known suffix */
> -			for (i = 0; suffix_tbl[i]; i++) {
> -				q = end_p - strlen(suffix_tbl[i]);
> -				if (!strncmp(q, suffix_tbl[i],
> -					     strlen(suffix_tbl[i])))
> -					goto next;
> -			}
> -			ck_cmdline = p;
> -		} else {
> -			q = end_p - strlen(suffix);
> -			if (!strncmp(q, suffix, strlen(suffix)))
> -				ck_cmdline = p;
> -		}
> -next:
>  		p = strstr(p+1, name);
>  	}
>  
> @@ -314,42 +296,144 @@ static int __init parse_crashkernel_dummy(char *arg)
>  early_param("crashkernel", parse_crashkernel_dummy);
>  
>  
> -#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> -int __init parse_crashkernel_generic(char *cmdline,
> -			     unsigned long long *crash_size,
> -			     unsigned long long *crash_base,
> -			     unsigned long long *low_size,
> -			     bool *high)
> +/*
> + * This function parses command lines in the format
> + *
> + *   crashkernel=[start1-end1:]size1[,...][@offset|,high|,low]
> + *
> + * The function returns 0 on success and -EINVAL on failure.
> + */
> +static int __init _parse_crashkernel(char *cmdline, struct crashkernel *ck)
>  {
> -	int ret;
> +	unsigned long long start, end, size, offset;
> +	unsigned long long system_ram;
> +	char *next, *cur = cmdline;
>  
> -	/* crashkernel=X[@offset] */
> -	ret = parse_crashkernel_common(cmdline, memblock_phys_mem_size(),
> -				crash_size, crash_base);
> -	if (ret == -ENOENT) {
> -		ret = parse_crashkernel_high(cmdline, 0, crash_size, crash_base);
> -		if (ret || !*crash_size)
> -			return -1;
> -
> -		/*
> -		 * crashkernel=Y,low can be specified or not, but invalid value
> -		 * is not allowed.
> -		 */
> -		ret = parse_crashkernel_low(cmdline, 0, low_size, crash_base);
> -		if (ret == -ENOENT)
> -			*low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> -		else if (ret)
> -			return -1;
> -
> -		*high = true;
> -	} else if (ret || !*crash_size) {
> -		/* The specified value is invalid */
> -		return -1;
> +	/*
> +	 * Firmware sometimes reserves some memory regions for its own use,
> +	 * so the system memory size is less than the actual physical memory
> +	 * size. Work around this by rounding up the total size to 128M,
> +	 * which is enough for most test cases.
> +	 */
> +	system_ram = memblock_phys_mem_size()
> +	system_ram = roundup(system_mem, SZ_128M);
> +
> +	start = 0;
> +	end = ULLONG_MAX;
> +	size = memparse(cur, &next);
> +	if (cur == next) {
> +		pr_warn("crashkernel: Memory value expected\n");
> +		return -EINVAL;
> +	}
> +	cur = next;
> +	ck->type=CRASHKERNEL_NORMAL;
> +
> +	/* case crashkerne=size[@offset|,high|,low] */
> +	if (!strchr(cmdline, '-')) {
> +		ck->size = size;
> +	}
> +
> +	while (*cur != ' ' && *cur != '\0') {
> +		switch (*cur) {
> +		case '@':
> +			offset = memparse(++cur, &next);
> +			if (*next != ' ' && *next != '\0') {
> +				pr_warn("crashkernel: Offset must be at the end\n");
> +				return -EINVAL;
> +			}
> +			/* allow corner cases with @0 */
> +			ck->type=CRASHKERNEL_FIXED_OFFSET;
> +			ck->offset = offset;
> +			break;
> +
> +		case '-':
> +			start = size;
> +			end = memparse(++cur, &next);
> +			/* allow <start>-:<size> */
> +			if (cur == next) {
> +				end = system_ram;
> +				next++;
> +			}
> +
> +			if (*next != ':') {
> +				pr_warn("crashkernel: ':' expected\n");
> +				return -EINVAL;
> +			}
> +
> +			cur = next + 1;
> +			size = memparse(cur, &next);
> +			if (cur == next) {
> +				pr_warn("crashkernel: No size provided\n");
> +				return -EINVAL;
> +			}
> +
> +			if (end <= start) {
> +				pr_warn("crashkernel: end <= start\n");
> +				return -EINVAL;
> +			}
> +
> +			if (start <= system_ram && end > system_ram)
> +				ck->size = size;
> +
> +
> +			cur = next + 1;
> +			break;
> +
> +		case ',':
> +			cur++;
> +
> +			/* check for ,high, ,low */
> +			if (strncmp(cur, "high", strlen("high"))) {
> +				ck->type=CRASHKERNEL_HIGH;
> +				cur+=strlen("high");
> +				if (*cur != ' ' || *cur != '\0') {
> +					pr_warn("crashkernel: ,high must be at the end\n");
> +					return -EINVAL;
> +				}
> +				break;
> +			} else if (strncmp(cur, "low". strlen("low"))) {
> +				ck->type=CRASHKERNEL_LOW;
> +				cur+=strlen("low");
> +				if (*cur != ' ' || *cur != '\0') {
> +					pr_warn("crashkernel: ,high must be at the end\n");
> +					return -EINVAL;
> +				}
> +				break;
> +			}
> +
> +			/* start with next entry */
> +			size = memparse(cur, &next);
> +			if (cur == next) {
> +				pr_warn("crashkernel: Memory value expected\n");
> +				return -EINVAL;
> +			}
> +			cur = next;
> +			break;
> +
> +		default:
> +			pr_warn("crashkernel: Invalid character '%c' provided\n", *cur);
> +			return -EINVAL;
> +		}
>  	}
>  
>  	return 0;
>  }
>  
> +#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> +int __init parse_crashkernel(char *cmdline, struct crashkernel *ck)
> +{
> +	const char *name="crashkernel=";
> +	char *ck_cmdline;
> +
> +	BUG_ON(!ck);
> +
> +	ck_cmdline = get_last_crashkernel(cmdline, name);
> +	if (!ck_cmdline)
> +		return -ENOENT;
> +	ck_cmdline += strlen(name);
> +	return _parse_crashkernel(ck_cmdline, ck);
> +}
> +
>  static int __init reserve_crashkernel_low(unsigned long long low_size)
>  {
>  #ifdef CONFIG_64BIT
> @@ -371,70 +455,57 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
>  	return 0;
>  }
>  
> -void __init reserve_crashkernel_generic(char *cmdline,
> -			     unsigned long long crash_size,
> -			     unsigned long long crash_base,
> -			     unsigned long long crash_low_size,
> -			     bool high)
> +void __init reserve_crashkernel_generic(char *cmdline)
>  {
> -	unsigned long long search_end = CRASH_ADDR_LOW_MAX, search_base = 0;
> -	bool fixed_base = false;
> -
> -	/* User specifies base address explicitly. */
> -	if (crash_base) {
> -		fixed_base = true;
> -		search_base = crash_base;
> -		search_end = crash_base + crash_size;
> -	}
> +	struct ck = { 0 };
>  
> -	if (high) {
> -		search_base = CRASH_ADDR_LOW_MAX;
> -		search_end = CRASH_ADDR_HIGH_MAX;
> -	}
> +	parse_crashkernel(cmdline, &ck);
>  
> -retry:
> -	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> -					       search_base, search_end);
> -	if (!crash_base) {
> -		/*
> -		 * For crashkernel=size[KMG]@offset[KMG], print out failure
> -		 * message if can't reserve the specified region.
> -		 */
> -		if (fixed_base) {
> -			pr_warn("crashkernel reservation failed - memory is in use.\n");
> -			return;
> -		}
> +	if (!ck.size)
> +		return;
>  
> -		/*
> -		 * For crashkernel=size[KMG], if the first attempt was for
> -		 * low memory, fall back to high memory, the minimum required
> -		 * low memory will be reserved later.
> -		 */
> -		if (!high && search_end == CRASH_ADDR_LOW_MAX) {
> -			search_end = CRASH_ADDR_HIGH_MAX;
> -			search_base = CRASH_ADDR_LOW_MAX;
> -			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> -			goto retry;
> +	switch (ck.type) {
> +	CRASHKERNEL_FIXED_OFFSET:
> +		crash_base = memblock_phys_alloc_range(ck.size, CRASH_ALIGN,
> +						       ck.offset,
> +						       ck.offset + ck.size);
> +		break;
> +
> +	CRASHKERNEL_NORMAL:
> +		if (DEFAULT_CRASH_KERNEL_LOW_SIZE) {
> +			/* Simply continue in case we fail to allocate the low
> +			 * memory */
> +			if (!reserve_crashkernel_low(DEFAULT_CRASH_KERNEL_LOW_SIZE))
> +				ck.size -= DEFAULT_CRASH_KERNEL_LOW_SIZE;
>  		}
>  
> -		/*
> -		 * For crashkernel=size[KMG],high, if the first attempt was
> -		 * for high memory, fall back to low memory.
> -		 */
> -		if (high && search_end == CRASH_ADDR_HIGH_MAX) {
> -			search_end = CRASH_ADDR_LOW_MAX;
> -			search_base = 0;
> -			goto retry;
> -		}
> -		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> -			crash_size);
> +		fallthrough;
> +	CRASHKERNEL_HIGH:
> +		crash_base = memblock_phys_alloc_range(ck.size, CRASH_ALIGN,
> +						       CRASH_ADDR_LOW_MAX,
> +						       CRASH_ADDR_HIGH_MAX);
> +		if (crash_base)
> +			break;
> +
> +		fallthrough;
> +	CRASHKERNEL_LOW:
> +		crash_base = memblock_phys_alloc_range(ck.size, CRASH_ALIGN, 0,
> +						       CRASH_ADDR_LOW_MAX);
> +		break;
> +
> +	default:
> +		pr_warn("Invalid crashkernel type %i\n", ck.type);
>  		return;
>  	}
>  
> -	if ((crash_base > CRASH_ADDR_LOW_MAX) &&
> -	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
> -		memblock_phys_free(crash_base, crash_size);
> -		return;
> +	if (!crash_base) {
> +		pr_warn("could not allocate crashkernel (size:0x%llx)\n",
> +			ck.size);
> +		if (crashk_low_res.end) {
> +			memblock_phys_free(crashk_low_res.start,
> +					   crashk_low_res.end - crashk_low_res.start + 1);
> +		}
> +		return
>  	}
>  
>  	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
> @@ -449,7 +520,7 @@ void __init reserve_crashkernel_generic(char *cmdline,
>  		kmemleak_ignore_phys(crashk_low_res.start);
>  
>  	crashk_res.start = crash_base;
> -	crashk_res.end = crash_base + crash_size - 1;
> +	crashk_res.end = crash_base + ck.size - 1;
>  	insert_resource(&iomem_resource, &crashk_res);
>  }
>  #endif
> 

