Return-Path: <linux-kernel+bounces-29971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CF1831603
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81FCF1F2461F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D6A200B2;
	Thu, 18 Jan 2024 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BVCvkwYI"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B363200A0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705570999; cv=none; b=Mnv9oKinwmtHsJmiPgTktm14c5cmF1GpVPTiHyx/WR6OtG/3ZjBZUjUwl34FYS712jrsyyzcax1DeH/zyrcd+n8EfFJ4W1YtLwwATG8RQjopbn7V1TLUYzt9RXvZE4bjQi/Zp8qpMNa69nzyD7ruBHLWfg05a89yy1lg04rmLdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705570999; c=relaxed/simple;
	bh=Q7p3OWqmOkliqPEGHXQJk80V7+FoxK3eZPEcgL4cGNc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent; b=Otdt85QlSin+PW28/sS6NCiE9pdk7iuBsbY5/XnokJBnoQlVhPILLkf7UYvJk1Wsk3NvBoh8JvvgNEwlJdf79U69UFchTDqfv7yIYvFUvuLqJ89K7VDyOWVtrlBvkitSIoXfbrDElKrksJivBo/2vQZcnCkL7ZDuO5Uo8VkRs0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BVCvkwYI; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-337b8da1f49so2312889f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705570992; x=1706175792; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuYpIw9soBWDz51Uc9U824cyLkAJt+cFBIInHg6YOR8=;
        b=BVCvkwYICvMkn1L5asRCBWTJAL0H9QG4lNu8nu2dTvTX4aaarTg6XPujejXWgKID6U
         HQ0uR0lLrEtVTuvkyCxfO5lERKXgmgT4O+uVF9ZDNtXcvAY8xBOQKbaMEF1qiNC8Bs71
         fCKH94AEEaHBqLQ/eFQJwEzVJUH8Wo+A1nIbN/Wbcdhs0PiGpTWCaCAmIute66DR0c5B
         WOWUBWKAyC8ptzeHBYg2gBgaSaAXgkgJM4h5vFKqH8DGaWKmql96gJHxW3fSdvvaQmIG
         ffUHoti8tT0S4QUkN3+k3m0rm1ya7mod221kemLTQNNmwQ9R4TXnp9rxoFa8TC9M83OB
         nUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705570992; x=1706175792;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuYpIw9soBWDz51Uc9U824cyLkAJt+cFBIInHg6YOR8=;
        b=sqOaOWKB5736wmY/brIG6EaqWiuEXm52hH6aJNofoeGIY5SRzas76MwdOAZjdGzIl7
         wu2bDpdyVLtTnWa99h98Db1v7wQZFM9BEkSqfdWQzBLwsaCnjbjpWF2oPXhsCjZdjOmp
         NL4OQYQP4IWTo8v+5y9FHzQbuPHPdCfyCexHAzBOCXAbCl4bMjU6a3X/kkHy+IC0S8vq
         PwrENyifkchnTPM7XZwdCxdlJU/c32fLcg8gABPyJHNKXyc4yjxlLWzANhljOIfgqE/A
         2NaMyLSP/M5PYHlqunxwX/pOuHUCWwqm1F7c4SbT4UGaow/UU525Y532bOhe1qbdQQbQ
         6dVw==
X-Gm-Message-State: AOJu0YwBAq1Acac9rzNeUWFqwZU2zIMsMgp26ct4o7piGRoGHASpvtgy
	W9fCAYt0lrLBFi46uH1LEMy9WxPD/Dh6nAt+z433tq8Ur4gWBshtJ7oFyHzk5w==
X-Google-Smtp-Source: AGHT+IGzcGfdh/XGZX6vq9NkjYiXbIvTy/IuZlNkPA9MWbrFDI/4qIoYnFKmLtyVcsgZ61zbZ7ar+Q==
X-Received: by 2002:a5d:508a:0:b0:337:bde6:63b3 with SMTP id a10-20020a5d508a000000b00337bde663b3mr205462wrt.31.1705570992147;
        Thu, 18 Jan 2024 01:43:12 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:9d7e:25fb:9605:2bef])
        by smtp.gmail.com with ESMTPSA id q8-20020adff788000000b003367a51217csm3581808wrp.34.2024.01.18.01.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 01:43:11 -0800 (PST)
Date: Thu, 18 Jan 2024 10:43:06 +0100
From: Marco Elver <elver@google.com>
To: Alexander Potapenko <glider@google.com>
Cc: quic_charante@quicinc.com, akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com, dan.j.williams@intel.com,
	david@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	mgorman@techsingularity.net, osalvador@suse.de, vbabka@suse.cz,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Nicholas Miehlbradt <nicholas@linux.ibm.com>, rcu@vger.kernel.org
Subject: Re: [PATCH] mm/sparsemem: fix race in accessing memory_section->usage
Message-ID: <ZajyqgE3ZHYHSvZC@elver.google.com>
References: <1697202267-23600-1-git-send-email-quic_charante@quicinc.com>
 <20240115184430.2710652-1-glider@google.com>
 <CANpmjNMP802yN0i6puHHKX5E1PZ_6_h1x9nkGHCXZ4DVabxy7A@mail.gmail.com>
 <Zagn_T44RU94dZa7@elver.google.com>
 <CAG_fn=XcMBWLCZKNY+hiP9HxT9vr0bXDEaHmOcr9-jVro5yAxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=XcMBWLCZKNY+hiP9HxT9vr0bXDEaHmOcr9-jVro5yAxw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Thu, Jan 18, 2024 at 10:01AM +0100, Alexander Potapenko wrote:
> >
> > Hrm, rcu_read_unlock_sched_notrace() can still call
> > __preempt_schedule_notrace(), which is again instrumented by KMSAN.
> >
> > This patch gets me a working kernel:
> >
[...]
> > Disabling interrupts is a little heavy handed - it also assumes the
> > current RCU implementation. There is
> > preempt_enable_no_resched_notrace(), but that might be worse because it
> > breaks scheduling guarantees.
> >
> > That being said, whatever we do here should be wrapped in some
> > rcu_read_lock/unlock_<newvariant>() helper.
> 
> We could as well redefine rcu_read_lock/unlock in mm/kmsan/shadow.c
> (or the x86-specific KMSAN header, depending on whether people are
> seeing the problem on s390 and Power) with some header magic.
> But that's probably more fragile than adding a helper.
> 
> >
> > Is there an existing helper we can use? If not, we need a variant that
> > can be used from extremely constrained contexts that can't even call
> > into the scheduler. And if we want pfn_valid() to switch to it, it also
> > should be fast.

The below patch also gets me a working kernel. For pfn_valid(), using
rcu_read_lock_sched() should be reasonable, given its critical section
is very small and also enables it to be called from more constrained
contexts again (like KMSAN).

Within KMSAN we also have to suppress reschedules. This is again not
ideal, but since it's limited to KMSAN should be tolerable.

WDYT?

------ >8 ------

diff --git a/arch/x86/include/asm/kmsan.h b/arch/x86/include/asm/kmsan.h
index 8fa6ac0e2d76..bbb1ba102129 100644
--- a/arch/x86/include/asm/kmsan.h
+++ b/arch/x86/include/asm/kmsan.h
@@ -64,6 +64,7 @@ static inline bool kmsan_virt_addr_valid(void *addr)
 {
 	unsigned long x = (unsigned long)addr;
 	unsigned long y = x - __START_KERNEL_map;
+	bool ret;
 
 	/* use the carry flag to determine if x was < __START_KERNEL_map */
 	if (unlikely(x > y)) {
@@ -79,7 +80,21 @@ static inline bool kmsan_virt_addr_valid(void *addr)
 			return false;
 	}
 
-	return pfn_valid(x >> PAGE_SHIFT);
+	/*
+	 * pfn_valid() relies on RCU, and may call into the scheduler on exiting
+	 * the critical section. However, this would result in recursion with
+	 * KMSAN. Therefore, disable preemption here, and re-enable preemption
+	 * below while suppressing rescheduls to avoid recursion.
+	 *
+	 * Note, this sacrifices occasionally breaking scheduling guarantees.
+	 * Although, a kernel compiled with KMSAN has already given up on any
+	 * performance guarantees due to being heavily instrumented.
+	 */
+	preempt_disable();
+	ret = pfn_valid(x >> PAGE_SHIFT);
+	preempt_enable_no_resched();
+
+	return ret;
 }
 
 #endif /* !MODULE */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4ed33b127821..a497f189d988 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2013,9 +2013,9 @@ static inline int pfn_valid(unsigned long pfn)
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
 	ms = __pfn_to_section(pfn);
-	rcu_read_lock();
+	rcu_read_lock_sched();
 	if (!valid_section(ms)) {
-		rcu_read_unlock();
+		rcu_read_unlock_sched();
 		return 0;
 	}
 	/*
@@ -2023,7 +2023,7 @@ static inline int pfn_valid(unsigned long pfn)
 	 * the entire section-sized span.
 	 */
 	ret = early_section(ms) || pfn_section_valid(ms, pfn);
-	rcu_read_unlock();
+	rcu_read_unlock_sched();
 
 	return ret;
 }

