Return-Path: <linux-kernel+bounces-90320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A0286FD8D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727542819DE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC00C208DD;
	Mon,  4 Mar 2024 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1iVqTIn"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9414220300
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544298; cv=none; b=XnYFTon2FVYqQqEgg0PCK/VZ34C2rkWsg3PLo6a5vCRic8LTYS8YlaYNpY6plKh0+M1GzfLUclM9VCLrkYwIgy+1QP0AKcGzGKxqHllZG0txPq7ye/O/JkccPxZKjSHpGODw/wU5xSRJ1nZZ9Fom7KTeFqsSVYANgK9gmZ44vt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544298; c=relaxed/simple;
	bh=UGysbQjN7U+Fnc+EmYJ21JkSEyXm1HGGfRWjIgD5LF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtAqTHzcVAw0d5hOTY9kNQIdx1Kp6rGs82ricBdzxdKzxZiTGItxkNMK+ohli/jVVQApxMXMYw0F9iBYk528h7DfFtmeYptV+1qwY+IAvSIG/bVZXtx2z0ux8r7QqB6w5cLzk90F2IhUpE+fP+ws9wQluWNN+1xYUN1hFUgPlbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1iVqTIn; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so5759996a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 01:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709544295; x=1710149095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23+RGJrKlEGVjD5Y7gANkjAOmzwa+owlfp4JYiP13Bk=;
        b=H1iVqTInC7q9Vm/rk16tm4Ij21zYRlBWlF+hg5qYytNWHpJG8bnAH3F9fH5rEDhEVL
         R38vPk7toyoegtcD0/KiBqZKBsrRqryo8Aa9p7DSUDvvjMJRtE3R5AvkH9yK6P7ZgHDO
         scvfCDSAFbMhcuuJ5YlQ1We/xxVp6RQhXavGjtdNsULbUYbvRPvk+Hic+qhj254tMiqO
         LdD2ipfLhV5uZbcUKq6Re/wUtHV4Z0pH8/n4UCnVjzHKQUhIphcvk+hZzBEaHOcMAepR
         LAvONH60oLIlmKzoSdckHzQWV8CveUTkfGL6ut7xhO1i/cdfdQJYGec4/9yG3I6hDCsA
         grug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709544295; x=1710149095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23+RGJrKlEGVjD5Y7gANkjAOmzwa+owlfp4JYiP13Bk=;
        b=s593lS6b0ex3ZqlD9DVceXU+H6uChhQr6JZ8H0OQ0m8lOyIFAXc290Ei+poUJulS4c
         Prk617/+Ni6+ZSLezKXyghOUJtA1zGhAbtoNkfVrKMQ6jfL8bh0O0S5+vk3RS2hZrHWZ
         gqfukTtmkmhWgPTWgVJ7MxDTROE7gye892avz9cYRcViOHhkLpn6rTQzTMtRgJIMp4nK
         fbDJG8EpU9mqvTNN4C6+VPRc2mqyCRfi8Xp47lrAfvy3XJ/8hASGjTXsNKl2TaQ9DF1S
         +L5YNrNe43U5Cp1mFEBnNpwVNmNgQb28HkWcruOkkuTfi+IWlJv8mZ8Ixef36B0aKDES
         IDNg==
X-Forwarded-Encrypted: i=1; AJvYcCULpFS1tGfDGM3/i7je5pYOUtMMbxg1N8JTAZzT2IkderXyGhoVk26OOtedEu/4W1zQAhEL8Bmv42/ymQo4MkXWrDzRNqbrMcIN3UjA
X-Gm-Message-State: AOJu0Yzjy/Aqg12s/iDd23US1lB0NBcVKPWmxD1fQ1wyGWsE4aPCnblR
	PI8ri6TYfWrVGdnlFKP0fuZ/n9YUgWa3x/691FbLBcPgeMW86wbv
X-Google-Smtp-Source: AGHT+IHmHlbGuV/Ihvf/CrrGSYdSMCcmMumGRL/givwSfqJeB99jEMDut04NZGgx0HG7CLn04o1U7Q==
X-Received: by 2002:a50:9306:0:b0:565:980d:5ba9 with SMTP id m6-20020a509306000000b00565980d5ba9mr5155456eda.32.1709544294703;
        Mon, 04 Mar 2024 01:24:54 -0800 (PST)
Received: from gmail.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id z42-20020a509e2d000000b005669d904871sm4578016ede.49.2024.03.04.01.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:24:54 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 4 Mar 2024 10:24:52 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] sched/balancing: Switch the
 'DEFINE_SPINLOCK(balancing)' spinlock into an 'atomic_t
 sched_balance_running' flag
Message-ID: <ZeWTZMnX8uLwzjui@gmail.com>
References: <20240301110951.3707367-1-mingo@kernel.org>
 <20240301110951.3707367-2-mingo@kernel.org>
 <703aad5f-40ce-4b37-bd5d-4a85615085e4@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <703aad5f-40ce-4b37-bd5d-4a85615085e4@linux.ibm.com>


* Shrikanth Hegde <sshegde@linux.ibm.com> wrote:

> 
> 
> On 3/1/24 4:39 PM, Ingo Molnar wrote:
> > The 'balancing' spinlock added in:
> 
> Hi Ingo. 
> 
> > 
> >   08c183f31bdb ("[PATCH] sched: add option to serialize load balancing")
> >
> 
>  
> [...]
> 
> >  
> >  		need_serialize = sd->flags & SD_SERIALIZE;
> >  		if (need_serialize) {
> > -			if (!spin_trylock(&balancing))
> > +			if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
> 
> Thinking from very little I know, I may be completely wrong. 
> 
> Is it possible that arch_spin_trylock, which would be called from spin_trylock is 
> faster in some architectures? Maybe in contended case? 

This code path should never really be 'contended': SD_SERIALIZE is only set 
for the outermost, largest domains (NUMA and up) that get balanced 
infrequently. This change is more for the sake of readability: a flag 
disguised as a spinlock.

Thanks,

	Ingo

