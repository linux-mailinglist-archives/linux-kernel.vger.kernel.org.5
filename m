Return-Path: <linux-kernel+bounces-89630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAD186F33E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 02:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF641C2101E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 01:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459991FB2;
	Sun,  3 Mar 2024 01:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dB7eLw8V"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD0E7E2
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 01:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709428106; cv=none; b=M0t/mY70k1kcqtrSHV9wZl4i3Dhi1eCWwmpNg8LmwzaYCQjTzETUyh+WIkuUAvu0JsHgGe7dM5y0svQy/siYhK1w9NhkoCK2G5zw0RWapCyyZYOmDvmuFeaCfv/uw+LSHO6uRNb2BgpCZCT2g0rib4Oitx4MM2TX4/aGMEBQnLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709428106; c=relaxed/simple;
	bh=/67mrea3HJasTBddQNgS5kArE/f1CslNUCxZyzfcpok=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1zLAFm1fx28k8JNrxbAq6uk45oGjvhXk/+mgPCAU1NSdyxTISxlXlI6AsWXPOrmOQ8Od4p1vuXNBRhtLSWRRyvy6Auwq7d7E7muCSzegX6QVskjHvk9LNDK2BewPkYh/n+ACKaYiPaOqe+gXBWuunRKwDNBEXEP2950+bvmEL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=dB7eLw8V; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-21f0c82e97fso2047959fac.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 17:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709428104; x=1710032904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8MFwGcxq9BWSalmiJUhI0OHJNzJYGEPTx5sTkV2BQOc=;
        b=dB7eLw8VWnmgvf2wdw2zUnBH3aKT9cWI7mRdb8B7buE90par0pY2Np+f52klz0jO0H
         aPNsWfWdfUOQCNlf5aiUQf/rzm0otLj2QtZGgfCqR0zcujcsBkbke5hHChNpRB3MwHSX
         C4N2JIUg8B9T7oehgrAM7ZOTsqAliQtssE6us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709428104; x=1710032904;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MFwGcxq9BWSalmiJUhI0OHJNzJYGEPTx5sTkV2BQOc=;
        b=T9mVLKjZXjXJ7/M1HvYF2LLqWEajAWK0l3r/U63kSbQGpueXekJ/PixUQkG1RujnjP
         ySwHrvpJiBIAFaH01kaM8ytNBmfrVbVrrArLEpqj2sGfsNz+VTso4CEBLOuKWxvg36zz
         m14cSXcm+6oVKJzoHmTpZ0W5bw5kSFSyunEUnkF/ve+CaVXrm3bX2Fp7pJd6dUHgwvcC
         si5qR16b+hH+EkpDWiT67QreP3e+qKUFePGsfrDU8PXVQTnRTMiifajJXKb44ziNMqkC
         nUuzkrwfD1jmyQSJk86MyidYqM5Sns+fVOQecjhRjth9U94sOZ2n8cjBwUKvvsvhxmse
         0Dsg==
X-Gm-Message-State: AOJu0YxzSdnKKvpaFSbjnxu/xFcfcN53lUgx0JASx3gt00QiutzVsJZD
	brY+80ghDcLg1/1EvxQgeaNTIeX+2071cf3oTT6ztPdzD+gnD6FfwP9jICa5eDk=
X-Google-Smtp-Source: AGHT+IG0hxe1CcavG5TU61oeHKZKYZz3r5A/HEL4zCpI/UFPNhbBFy+abAjCeFLvu0FEW8Lad1wSVQ==
X-Received: by 2002:a05:6870:e305:b0:21e:e583:25e1 with SMTP id z5-20020a056870e30500b0021ee58325e1mr6806961oad.32.1709428104279;
        Sat, 02 Mar 2024 17:08:24 -0800 (PST)
Received: from localhost ([91.196.69.76])
        by smtp.gmail.com with ESMTPSA id vz3-20020a056871a40300b00220c6f7734esm895282oab.35.2024.03.02.17.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 17:08:23 -0800 (PST)
Message-ID: <65e3cd87.050a0220.bc052.7a29@mx.google.com>
X-Google-Original-Message-ID: <20240303010819.GA1010397@JoelBox.>
Date: Sat, 2 Mar 2024 20:08:19 -0500
From: Joel Fernandes <joel@joelfernandes.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
	mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
	bristot@kernel.org, mathieu.desnoyers@efficios.com,
	geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
	anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
	krypton@ulrich-teichert.org, rostedt@goodmis.org,
	David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
	jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 26/30] sched: handle preempt=voluntary under PREEMPT_AUTO
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-27-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213055554.1802415-27-ankur.a.arora@oracle.com>

Hi Anukr,

On Mon, Feb 12, 2024 at 09:55:50PM -0800, Ankur Arora wrote:
> The default preemption policy for voluntary preemption under
> PREEMPT_AUTO is to schedule eagerly for tasks of higher scheduling
> class, and lazily for well-behaved, non-idle tasks.
> 
> This is the same policy as preempt=none, with an eager handling of
> higher priority scheduling classes.

AFAICS, the meaning of the word 'voluntary' has changed versus the old
CONFIG_PREEMPT_VOLUNTARY, with this patch.

So the word voluntary does not completely make sense in this context. What is
VOLUNTARY about choosing a higher scheduling class?

For instance, even in the same scheduling class, there is a notion of higher
priority, not just between classes. Example, higher RT priority within RT, or
earlier deadline within EEVDF (formerly CFS).

IMO, just kill 'voluntary' if PREEMPT_AUTO is enabled. There is no
'voluntary' business because
1. The behavior vs =none is to allow higher scheduling class to preempt, it
is not about the old voluntary.
2. you are also planning to remove cond_resched()s via this series and leave
it to the scheduler right?

Or call it preempt=higher, or something? No one is going to understand the
meaning of voluntary the way it is implied here IMHO.

thanks,

 - Joel


