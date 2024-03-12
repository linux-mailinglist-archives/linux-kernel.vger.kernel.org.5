Return-Path: <linux-kernel+bounces-100907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E9A879F32
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16B3EB21EA1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A50B46B9B;
	Tue, 12 Mar 2024 22:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g+1gGKyR"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAF445BFF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710284342; cv=none; b=c5Kk0Ma9FbRisNOBJoBW4IJfkhai/K8pKOZaGu52E7cWDqw469a6PuojW7RofYotzlZpZeLFCFhUl5QBC6UGj5lydo+OGa1bj8Ud2XIELPnblSsFH138dydDy5GGWYZcHbiV/SNvLHfvWO3QXN3UMkrsSAkZ9dGkB/SktojS1r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710284342; c=relaxed/simple;
	bh=OLiKkWhehhsEV6p1VP2tGUtajGo3ORlTcYkNZLmjxTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUnZlXwJibswDx48SJeZ4h7IPMARX8ouYgbyaPx3lnkaIlKNp9tDRyrZ7szSa/A1YRhyiJ/PE2F20jW4iPSvVUNqqfWWAfXQrml139w/Hl9508HLnEPAoJWNJ4bwLRfnE/QOPvcxwgtjPbngK60jKLOp1YpzgqDSoeE/sBIzNgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g+1gGKyR; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a1d83a86e8so1752462eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710284338; x=1710889138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AMS1ZjMWBuM0zSP8AT1FSFAUh4Mt24kH91Wp50B7GE0=;
        b=g+1gGKyRBNHhACQSBffhxQJh3r0EEPx3bzCGrlLz1RbhFzARHbzB0bKxYEeCDAuLa8
         WanE9vxdN8zju4JZhR0Ousk/0jMZLDfoM89bM4IxNRg3JLU/TxIA1w2Kk5G16m1LIqDo
         cPYrLKScL/RWF25pu8sfAZfJBnaHMeT+vIdz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710284338; x=1710889138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMS1ZjMWBuM0zSP8AT1FSFAUh4Mt24kH91Wp50B7GE0=;
        b=F/zDpbdVkDe4UViMGxtzU5EvjuZXntQBDgtUBo8whKwXC0FKR2pxwtqZ335fesr+hT
         NNXiSBb4GKg1XysgO409Es5kFh5KdX/3AX4IA4A8G8Pv3n6Hkjpheg/PcnMSG/R8n5Cb
         4EC4veLXNnSrrgZif5ZFS7fJIqooUOAAbeI3X+paSbLoXzAgAME1GPN9Rw51q9kuI1Rr
         1SkyI0HDrgawJtzLwSiDZvvASxA9JmiyV+iqGkjdVkbnS2ayR7teCjRrnrh1/1xLAKRD
         GRaZRUG2HihEBy7qafi+yBlmtw55UZqeopIuAG94DDbdz2EwM1qVssH8OEGr6Jl97v8x
         yK9w==
X-Forwarded-Encrypted: i=1; AJvYcCXkTLfqoEbCIymJxRqhwS3WJonYmlUK9Jd5mqfN4EL4BUK23vJTJ3vl8wo3lbjryO/krHTE15ZJ53ZcUbgWOFNVKOo1WOP2y0Ep7WCy
X-Gm-Message-State: AOJu0YwToVpX1NM1UgVKpZknUi9r20b5PT1vh/6+H8n1FTB2E82QhdTO
	daglvlI27u7QqWmLjk4XlHWCOkhQ8tSJPHHLAII6JuyC4e8AkqtjtkuwpXojQg==
X-Google-Smtp-Source: AGHT+IF9MmUJEziN0WeptiT+CGUUM2PU2SNfd70L1ZHSDdkRNOQMIWK+9Nm5Y5UBsLTxukrFC3doXQ==
X-Received: by 2002:a05:6358:7e4e:b0:17b:f637:7bb with SMTP id p14-20020a0563587e4e00b0017bf63707bbmr3981134rwm.30.1710284338251;
        Tue, 12 Mar 2024 15:58:58 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e11-20020a63e00b000000b005dc48e56191sm6557745pgh.11.2024.03.12.15.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:58:57 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:58:56 -0700
From: Kees Cook <keescook@chromium.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>, cve@kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	security@kernel.org,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Sasha Levin <sashal@kernel.org>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@denx.de>, John Haxby <john.haxby@oracle.com>,
	Marcus Meissner <meissner@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roxana Bradescu <roxabee@chromium.org>,
	Solar Designer <solar@openwall.com>, Matt Wilson <msw@amazon.com>
Subject: Re: [RFC PATCH 2/2] doc: distros: new document about assessing
 security vulnerabilities
Message-ID: <202403121515.A1DF92B3@keescook>
References: <20240311150054.2945210-1-vegard.nossum@oracle.com>
 <20240311150054.2945210-2-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311150054.2945210-2-vegard.nossum@oracle.com>

On Mon, Mar 11, 2024 at 04:00:54PM +0100, Vegard Nossum wrote:
> On February 13, kernel.org became a CVE Numbering Authority (CNA):
> 
>   https://www.cve.org/Media/News/item/news/2024/02/13/kernel-org-Added-as-CNA
> 
> The kernel.org CNA/CVE team does not provide any kind of assessment of
> the allocated CVEs or patches. However, this is something that many
> distributions want and need.
> 
> Provide a new document that can be used as a guide when assessing
> vulnerabilities. The hope is to have a common point of reference that
> can standardize or harmonize the process and hopefully enable more
> cross-distribution collaboration when it comes to assessing bugfixes.
> 
> We deliberately emphasize the difficulty of assessing security impact
> in the wide variety of configurations and deployments.
> 
> Since what most distros probably ultimately want is a type of CVSS score,
> the guide is written with that in mind. CVSS provides its own "contextual"
> modifiers, but these are not accurate or nuanced enough to capture the
> wide variety of kernel configurations and deployments. We therefore focus
> on practical evaluation under different sets of assumptions.
> 
> Create a new top-level (admittedly rather thin) "book" for information
> for distros and place the document there as this document is not meant
> for either developers or users.
> 
> See the rendered document at:
> 
>   https://vegard.github.io/linux/2024-03-11/security-assessment.html
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Pavel Machek <pavel@denx.de>
> Cc: John Haxby <john.haxby@oracle.com>
> Cc: Marcus Meissner <meissner@suse.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Roxana Bradescu <roxabee@chromium.org>
> Cc: Solar Designer <solar@openwall.com>
> Cc: Matt Wilson <msw@amazon.com>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Documentation/distros/index.rst               |   8 +
>  Documentation/distros/security-assessment.rst | 496 ++++++++++++++++++
>  2 files changed, 504 insertions(+)
>  create mode 100644 Documentation/distros/index.rst
>  create mode 100644 Documentation/distros/security-assessment.rst
> 
> diff --git a/Documentation/distros/index.rst b/Documentation/distros/index.rst
> new file mode 100644
> index 000000000000..871f1e99042b
> --- /dev/null
> +++ b/Documentation/distros/index.rst
> @@ -0,0 +1,8 @@
> +===============================
> +Documentation for distributions
> +===============================
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   security-assessment
> diff --git a/Documentation/distros/security-assessment.rst b/Documentation/distros/security-assessment.rst
> new file mode 100644
> index 000000000000..2e046c9f5f29
> --- /dev/null
> +++ b/Documentation/distros/security-assessment.rst
> @@ -0,0 +1,496 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================================
> +Assessing security vulnerabilities
> +==================================
> +
> +:Author: Vegard Nossum <vegard.nossum@oracle.com>
> +
> +This document is intended for distributions and others who want to assess
> +the severity of the bugs fixed by Linux kernel patches.

Perhaps add, "... when it is infeasible to track a stable Linux
release."

> +We could consider *everything* a security issue until proven otherwise, or we

Who is "we" here (and through-out)?

> +could consider *nothing* a security issue until proven otherwise. Neither of
> +these approaches are useful in practice. Security assessment is therefore
> +partly an exercise in finding the middle ground. This guide attempts to make
> +reasonable tradeoffs in order to maximize the utility of security assessments.
> +
> +Exploitability also depends highly on the context, so we make a distinction
> +between a general worst-case assessment and context-specific assessments.
> +
> +This is NOT an exploitation guide.
> +
> +.. contents:: Table of contents
> +    :local:
> +    :backlinks: none
> +
> +
> +What is a vulnerability?
> +========================
> +
> +For the purposes of this document, we consider all bugfixes to be
> +potential vulnerabilities. This is because, as stated in

The CVE definition makes a distinction here, instead calling a
software flaw with security considerations a "weakness" rather than
"vulnerability". I find "weakness" more in line with people's thinking
about attack chains.

> +Documentation/process/cve.rst, whether a bug is exploitable or not
> +depends highly on the context (threat model, platform/hardware,
> +kernel configuration, boot parameters, runtime configuration,
> +connected peripherals, etc.).

Exploitability is an even higher bar, and tends to be unable to
disprove.

> +The severity of a bugfix can thus range from being completely benign
> +to enabling an attacker to gain complete control over a machine --
> +these two conclusions can be reached for the exact same patch depending
> +on context it is being considered in.

Yes, very much. :)

> +Another aspect of this is that a bug may itself not be very serious, but
> +serve as a step in a chain of exploits. A common example of this is when
> +a kernel pointer is accidentally revealed to userspace, which gives an
> +attacker the ability to bypass `KASLR protections`_.
> +
> +.. _KASLR protections: https://lwn.net/Articles/569635/
> +
> +Common assessment scenarios
> +---------------------------
> +
> +In order to share common ground when discussing different attack
> +scenarios, we define these four contexts which range from general
> +to specific:
> +
> +1. **Worst-case scenario** with a minimum of mitigating factors and
> +   assumptions: driver is enabled, in use, mitigations are disabled or
> +   ineffective, etc.
> +
> +2. **Common configurations**: assuming kernel defaults, taking into
> +   account hardware prevalence, etc.

I'm not sure I'd call this "Common", I'd say "Kernel default configuration"

> +3. **Distro-specific configuration** and defaults: This assessment of a
> +   bugfix takes into account a specific kernel configuration and the
> +   distro's own assumptions about how the system is configured and
> +   intended to be used.

And this just "Distro default configuration".

> +4. **Specific use case** for a single user or deployment: Here we can make
> +   precise assumptions about what kernel features are in use and whether
> +   physical access is possible.

i.e. a configuration that differs from distro default.

> +The most interesting scenarios are probably 1 and 3; the worst-case
> +scenario is the best we can do for an assessment that is supposed to be
> +valid for the entire kernel community, while individual distributions will
> +probably want to take their specific kernel configuration and use cases
> +into account.
> +
> +Latent vulnerabilities
> +----------------------
> +
> +It is worth mentioning the possibility of latent vulnerabilities:
> +These are code "defects" which technically cannot be exploited on any
> +current hardware, configuration, or scenario, but which should nevertheless
> +be fixed since they represent a possible future vulnerability if other
> +parts of the code change.

I take pedantic issue with "cannot be exploited". Again, "exploit" is a
high bar.

Also, why should hardware limit this? If a "latent vulnerability"
becomes part of an attack chain on some future hardware, and we saw it
was a weakness at the time it landed it stable, it should have gotten
a CVE then, yes?

> +
> +An example of latent vulnerabilities is the failure to check the return
> +value of kmalloc() for small memory allocations: as of early 2024, these
> +are `well-known to never fail in practice <https://lwn.net/Articles/627419/>`_
> +and are thus not exploitable and not technically vulnerabilities. If this
> +rule were to change (because of changes to the memory allocator), then these
> +would become true vulnerabilities.

But for kernel prior to that, it IS an issue, yes? And what does "in
practice" mean? Does that include a system under attack that is being
actively manipulated?

> +We recommend that a "worst-case scenario" assessment don't consider latent
> +vulnerabilities as actual vulnerabilities since this is a slippery slope

I wouldn't use the language "actual", but rather reword this from the
perspective of severity. Triage of severity is what is at issue, yes?

> +where eventually all changes can be considered a vulnerability in some sense
> +or another; in that case, we've thrown the baby out with the bath water and
> +rendered assessment completely useless.

I don't find this to be true at all. Distro triage of kernel bug fixes
isn't binary: it'll always be severity based. Many will be 0, yes, but
it is up to the specific deployment to figure out where their cut line
is if they're not just taking all fixes.

> +
> +Exploitability and unknowns
> +---------------------------
> +
> +Beyond build and runtime configuration, there are many factors that play
> +into whether a bug is exploitable in practice. Some of these are very
> +subtle and it may be incredibly difficult to prove that a bug is, in fact,
> +exploitable -- or reliably exploitable.
> +
> +Similarly to latent vulnerabilities, we need to be careful not to throw
> +the baby out with the bath water: requiring a full exploit in order to
> +deem a bug exploitable is a too high burden of proof and would discount
> +many bugs that could be exploitable if enough time and energy was poured
> +into exploring it fully.
> +
> +Many exploits rely on precise memory layouts of structs and things like
> +slab merging (or more generally that certain memory allocation patterns are
> +possible) or extremely tight races that look impossible to achieve.
> +
> +In the absence of other specific information, we recommend considering the
> +bug from a "worst case" point of view, i.e. that it is indeed exploitable.

I agree with this section. :)

> +
> +
> +Types of bugs
> +=============
> +
> +There are many ways to classify types of bugs into broad categories. Two
> +ways that we'll cover here are in terms of the outcome (i.e. what an
> +attacker could do in the worst case) and in terms of the source defect.

Before breaking this down into examples, I would start with a summary of
the more basic security impact categories: Confidentiality, Integrity,
and Availability, as mapping example back to these can be useful in
understanding what a bug is, or can be expanded to.

> +
> +In terms of outcome:
> +
> +- **local DoS** (Denial of Service): a local user is able to crash the
> +  machine or make it unusable in some way
> +
> +- **remote DoS**: another machine on the network is able to crash the
> +  machine or make it unusable in some way
> +
> +- **local privilege escalation**: a local user is able to become root,
> +  gain capabilities, or more generally become another user with more
> +  privileges than the original user
> +
> +- **kernel code execution**: the attacker is able to run arbitrary code
> +  in a kernel context; this is largely equivalent to a privilege escalation
> +  to root

Yes, uid 0 and kernel context are distinct. I don't think I'd say
"largely equivalent" though. Perhaps "Note that root access in many
configurations is equivalent to kernel code execution".

> +- **information leak**: the attacker is able to obtain sensitive information

Instead of "leak", please use the less ambiguous word for this, which is
"exposure". The word "leak" is often confused with resource leaks. This
is especially true for language like "memory leak" (... is this content
exposure or resource drain?)

> +  (secret keys, access to another user's memory or processes, etc.)
> +
> +- **kernel address leak**: a subset of information leaks; this can lead to
> +  KASLR bypass, usually just one step as part of an exploit chain.

Again, "exposure".

> +
> +In terms of source defect:

These are also very specific. Perhaps a summary of higher level issues:
Spatial safety, temporal safety, arithmetic safety, logic errors, etc.

> +- **use after free**: can be exploited by allocating another object in the
> +  spot that was freed and partially or fully controlling the contents of
> +  that object; some otherwise illegal values may let you "control" what the
> +  kernel does (e.g. pointers to other objects or function pointers)
> +
> +- **heap buffer overflow**: similarly may allow you to overwrite values in
> +  other objects or read values from unrelated objects
> +
> +- **stack buffer overflow**: may allow you to overwrite local variables or
> +  return addresses on the stack; this is pretty well mitigated by the
> +  compiler these days (CFI, stackprotector, etc.) and may not be as huge a
> +  concern as it used to be
> +
> +- **double free**: this may result in general memory corruption, corruption
> +  of structures used by the memory allocator, or further use after free
> +
> +- **memory leak**: typically results in DoS if you can make the machine
> +  completely run out of memory, or potentially trigger some error handling
> +  code paths
> +
> +- **reference counting bug**: can result in either a memory leak or a use
> +  after free (with quite different outcomes in terms of severity)
> +
> +- **NULL pointer dereference**: this used to be a severe vulnerability
> +  because `userspace could mmap() something at address 0 and trick the
> +  kernel into dereferencing it <https://lwn.net/Articles/342330/>`_; this
> +  is typically relatively harmless these days because the kernel does not
> +  allow this anymore. Nowadays, a NULL pointer dereference typically just
> +  results in the kernel killing the offending process; however, in some
> +  cases the program that crashed may be holding on to various resources
> +  (such as locks, references) which causes DoS or potentially `overflow
> +  things like reference counts <https://lwn.net/Articles/914878/>`_.
> +
> +- **incorrect error handling**: not really a precise bug category by itself
> +  but can often lead to a number of the other errors listed above (resource
> +  leaks, double frees, etc.)
> +
> +- **not checking kmalloc() return values**: a subtype of error handling
> +  bugs; it is widely believed that `"small" SLAB allocation requests cannot
> +  fail <https://lwn.net/Articles/627419/>`_ and thus do not actually
> +  represent a security vulnerability
> +
> +- **logic error**: this is a very general category of errors and potentially
> +  includes such things as not checking or respecting permissions, bounds,
> +  or other values supplied by userspace
> +
> +- **missing or incorrect bounds check**: a subtype of logic errors, this
> +  often leads to out-of-bounds memory accesses
> +
> +- **races**: missing or incorrect use of locking, atomics, and memory
> +  barriers can manifest in many different ways, including many of the
> +  categories listed above.
> +
> +A useful rule of thumb is that anything that can cause invalid memory
> +dereferences is a potential privilege escalation bug.

Even an "unexpected" dereference. :)

> +
> +These categories are not perfect and not exhaustive; it is meant to be a
> +rough guide covering the most common cases. There is always room to treat
> +special cases specially.
> +
> +
> +Mitigations and hardening
> +=========================
> +
> +The kernel comes with a number of options for hardening and mitigating
> +the effects of certain types of attacks:
> +
> +- `Address-space layout randomization <https://lwn.net/Articles/569635/>`_
> +- `Stack protection <https://lwn.net/Articles/584225/>`_
> +- `Hardened usercopy <https://lwn.net/Articles/695991/>`_
> +- `Reference count hardening <https://lwn.net/Articles/693038/>`_
> +- `Bounds checking (fortify) <https://lwn.net/Articles/864521/>`_
> +
> +The purpose of this section is not to recommend certain options be enabled or
> +disabled (for that, see the `Kernel Self Protection Project's recommended
> +settings <http://kernsec.org/wiki/index.php/Kernel_Self_Protection_Project/Recommended_Settings>`_),
> +but to document the fact that many of these options can affect how a
> +vulnerability is scored.
> +
> +
> +CVEs and CVSS scores for the kernel
> +===================================
> +
> +CVSS (`Common Vulnerability Scoring System <https://en.wikipedia.org/wiki/Common_Vulnerability_Scoring_System>`_)
> +is an open standard for vulnerability scoring and the system which is
> +commonly used by Linux distributions and various industry and government
> +bodies.
> +
> +We won't go into the details of CVSS here, except to give a guide on how
> +it could be applied most effectively in the context of the kernel.
> +
> +**Attack Vector** (Local, Network, Physical):
> +
> +  The attack vector for most bugfixes will probably be **Local**, i.e.
> +  you need a local user account (or more generally user access, e.g. a
> +  shell account) in order to trigger the buggy code.
> +
> +  If a networking protocol or device is involved, the attack
> +  vector may be **Network**. However, many bugs in networking code may
> +  actually only be locally exploitable, for example bugs that would
> +  trigger when passing invalid values to a socket-related system call
> +  (e.g. setsockopt()) or when making system calls in a specific sequence.
> +
> +  The attack vector **Physical** is used when physical access
> +  to a machine is required, for example USB device driver bugs that can
> +  only be exploited by physically inserting a device into a USB port.
> +
> +**Attack Complexity** (Low, High):
> +
> +  This metric represents roughly how difficult it would be to work around
> +  security measures like ASLR and how much an exploit would need to be
> +  tailored to a specific target in order to be successful.
> +
> +  As a rule of thumb, the less severe outcomes like DoS or information
> +  leaks often have complexity **Low**, while outcomes like privilege
> +  escalations and kernel code execution often have complexity **High**.
> +
> +**Privileges Required** (None, Low, High):
> +
> +  This metric refers to what kind of privileges the attacker must have in
> +  order to exploit the bug.
> +
> +  We propose that unauthenticated remote attacks have the value **None**;
> +  if you can trigger the bug as a local user without any specific
> +  additional privileges this would be **Low**, and if additional privileges
> +  are required for the user (such as e.g. ``CAP_NET_RAW``) then this would
> +  be **High**.
> +
> +**User Interaction** (None, Required):
> +
> +  This will usually have the value **None** unless a successful attack
> +  requires interaction from another, legitimate user. In that case the
> +  value will be **Required**; this could be the case e.g. for filesystem
> +  bugs that require the user to run a command (in this case ``mount``)
> +  in order to trigger the bug.
> +
> +**Scope** (Changed, Unchanged):
> +
> +  For bugs where privilege escalation or kernel code execution is a
> +  possible outcome, this will typically be **Changed** (since the kernel
> +  has access to the whole system), whereas for outcomes like DoS the
> +  scope will be **Unchanged**. Information leaks can have either value
> +  depending on whether the information pertains to the original user
> +  (**Unchanged**) or other users (**Changed**).
> +
> +**Confidentiality** (None, Low, High):
> +
> +  For privilege escalation or kernel code execution bugs, this will
> +  typically be **High**; for information leaks this will be **Low**,
> +  and for DoS this will be **None**.
> +
> +**Integrity** (None, Low, High):
> +
> +  For privilege escalation or kernel code execution bugs, this will
> +  typically be **High**; for information leaks this will be **Low**,
> +  and for DoS this will be **None**.
> +
> +**Availability** (None, Low, High):
> +
> +  For information leaks this will be **None**, whereas almost all other
> +  outcomes have a **High** availability impact (a DoS is a loss of
> +  availability by definition, whereas privilege escalations typically
> +  allows the attacker to reduce the availability as well).
> +
> +The temporal metrics are optional, but may be useful for kernel patches:
> +
> +**Exploit Code Maturity**:
> +
> +  **Unreported** where no reproducer of any kind is known (suitable e.g.
> +  for fixes based on reports from static checkers) or **POC** if the issue
> +  has been demonstrated
> +
> +**Remediation Level**:
> +
> +  This will typically always be **Official Fix** since kernel.org CVEs are
> +  only assigned once a patch has been published.
> +
> +**Report Confidence**:
> +
> +  This will be **Unknown** for theoretical issues or issues reported by
> +  static checkers or **Reasonable** for issues that have been triggered
> +  by the reporter or author of the patch (as indicated perhaps by a
> +  stack trace or other error message reproduced in the changelog for the
> +  patch).
> +
> +To calculate a final CVSS score (value from 0 to 10), use a calculator
> +such as `<https://www.first.org/cvss/calculator/>`_ (also includes detailed
> +explanations of each metric and its possible values).

Why not NIST's website directly?

> +A distro may wish to start by checking whether the file(s) being patched
> +are even compiled into their kernel; if not, congrats! You're not vulnerable
> +and don't really need to carry out a more detailed analysis.
> +
> +For things like loadable modules (e.g. device drivers for obscure hardware)
> +and runtime parameters you might have a large segment of users who are not
> +vulnerable by default.

These 2 paragraphs seem more suited for the Reachability section?

> +Reachability analysis
> +=====================
> +
> +One of the most frequent tasks for evaluating a security issue will be to
> +figure out how the buggy code can be triggered. Usually this will mean
> +starting with the function(s) being patched and working backwards through
> +callers to figure out where the code is ultimately called from. Sometimes
> +this will be a system call, but may also be timer callbacks, workqueue
> +items, interrupt handlers, etc. Tools like `cscope <https://en.wikipedia.org/wiki/Cscope>`_
> +(or just plain ``git grep``) can be used to help untangle these callchains.


Before even this, is just simply looking at whether it was built,
whether it was shipped, if a CONFIG exposed the feature, etc.

> +Special care will need to be taken to track function calls made through
> +function pointers, especially those stored somewhere on the heap (e.g.
> +timer callbacks or pointers to "ops" structs like ``struct super_operations``).
> +
> +While unnesting the call stack, it may be useful to keep track of any
> +conditions that need to be satisfied in order to reach the buggy code,
> +perhaps especially calls to ``capable()`` and other capabilities-related
> +functions, which may place restrictions on what sort of privileges you
> +need to reach the code.
> +
> +User namespaces
> +---------------
> +
> +By design, `user namespaces <https://lwn.net/Articles/528078/>`_ allow
> +non-root processes to behave as if they are root for an isolated part
> +of the system. Some important things to be aware of in this respect are:
> +
> +- User namespaces (in combination with mount namespaces) allow a
> +  regular user to mount certain filesystems (proc, sys, and others);
> +  see https://man7.org/linux/man-pages/man7/user_namespaces.7.html
> +  for more information.
> +
> +- User namespaces (perhaps in combination with network namespaces)
> +  allow a regular user to create sockets for network protocols they
> +  would otherwise not be able to access; see
> +  https://lwn.net/Articles/740455/ for more information.
> +
> +- ``capable()`` checks capabilities in the initial user namespace,
> +  whereas ``ns_capable()`` checks capabilities in the current user
> +  namespace.
> +
> +
> +Examples
> +========
> +
> +In the following examples, we give scores from a "worst case" context,

..for an generic distro...

> +i.e. assuming the hardware/platform is in use, the driver is compiled
> +in, mitigations are disabled or otherwise ineffective, etc.
> +
> +**Commit 72d9b9747e78 ("ACPI: extlog: fix NULL pointer dereference check")**:
> +
> +  The first thing to notice is that the code here is in an ``__exit``
> +  function, meaning that it can only run when the module is unloaded
> +  (the ``mod->exit()`` call in the delete_module() system call) --
> +  inspecting this function reveals that it is restricted to processes
> +  with the ``CAP_SYS_MODULE`` capability, meaning you already need
> +  quite high privileges to trigger the bug.
> +
> +  The bug itself is that a pointer is dereferenced before it has been
> +  checked to be non-NULL. Without deeper analysis we can't really know
> +  whether it is even possible for the pointer to be NULL at this point,
> +  although the presence of a check is a good indication that it may be.
> +  By grepping for ``extlog_l1_addr``, we see that it is assigned in the
> +  corresponding module_init() function and moreover that the only way
> +  it can be NULL is if the module failed to load in the first place.
> +  Since module_exit() functions are not called on module_init() failure
> +  we can conclude that this is not a vulnerability.

Sounds right.

> +
> +**Commit 27e56f59bab5 ("UBSAN: array-index-out-of-bounds in dtSplitRoot")**:
> +
> +  Right away we notice that this is a filesystem bug in jfs. There is a
> +  stack trace showing that the code is coming from the mkdirat() system
> +  call. This means you can likely trigger this as a regular user, given
> +  that a suitable jfs filesystem has been mounted. Since this is a bug
> +  found by syzkaller, we can follow the link in the changelog and find
> +  the reproducer. By looking at the reproducer we can see that it almost
> +  certainly mounts a corrupted filesystem image.
> +
> +  When filesystems are involved, the most common scenario is probably
> +  when a user has privileges to mount filesystem images in the context
> +  of a desktop environment that allows the logged-in user to mount
> +  attached USB drives, for example. In this case, physical access would
> +  also be necessary, which would make this Attack Vector **Physical**
> +  and User Interaction **Required**.
> +
> +  Another scenario is where a malicious filesystem image is passed to a
> +  legitimate user who then unwittingly mounts it and runs
> +  mkdir()/mkdirat() to trigger the bug. This would clearly be User
> +  Interaction **Required**, but it's not so clear what the Attack Vector
> +  would be -- let's call it **Physical**, which is the least severe of
> +  the options given to us by CVSS, even though it's not a true physical
> +  attack.

"let's call it" -> "For a distro that doesn't have tools that will mount
filesystem images"... I'm not sure if "Physical" is "worst case" :)

> +
> +  This is an out-of-bounds memory access, so without doing a much deeper
> +  analysis we should assume it could potentially lead to privilege
> +  escalation, so Scope **Changed**, Confidentiality **High**, Integrity
> +  **High**, and Availability **High**.
> +
> +  Since regular users can't normally mount arbitrary filesystems, we can
> +  set Attack Complexity **High** and Privileges **Required**.

Why not? Many distros ship without automounters for inserted media. Some
docker tooling will mount filesystem images.

> +
> +  If we also set Exploit Code Maturity **Unproven**, we end up with the
> +  following CVSSv3.1 vector:
> +
> +  - CVSS:3.1/AV:P/AC:H/PR:H/UI:R/S:C/C:H/I:H/A:H/E:U (6.2 - Medium)
> +
> +  If this score seems high, keep in mind that this is a worst case
> +  scenario. In a more specific scenario, jfs might be disabled in the
> +  kernel config or there is no way for non-root users to mount any
> +  filesystem.

Your worst and mine are very different. ;)

> +
> +**Commit b988b1bb0053 ("KVM: s390: fix setting of fpc register")**:
> +
> +  From the changelog: "corruption of the fpc register of the host process"
> +  and "the host process will incorrectly continue to run with the value
> +  that was supposed to be used for a guest cpu".
> +
> +  This makes it clear that a guest can partially take control of the
> +  host process (presumably the host process running the KVM), which would
> +  be a privilege escalation of sorts -- however, since this is corruption
> +  of floating-point registers and not a memory error, it is highly
> +  unlikely to be exploitable beyond DoS in practice (even then, it is
> +  questionable whether the DoS impacts anything beyond the KVM process
> +  itself).
> +
> +  Because an attack would be difficult to pull off, we propose Attack
> +  Complexity **High**, and because there isn't a clear or likely path to
> +  anything beyond DoS, we'll select Confidentiality **None**, Integrity
> +  **Low** and Availability **Low**.
> +
> +  We suggest the following CVSSv3.1 vector:
> +
> +  - CVSS:3.1/AV:L/AC:H/PR:N/UI:N/S:U/C:N/I:L/A:L/E:U (3.7 - Low)

Though for many distros this issue will be a non-issue unless they ship
s390...

> +
> +
> +Futher reading
> +==============
> +
> +Different vendors have other/different rating and classification systems
> +for vulnerabilities and severities:
> +
> +- Microsoft: https://www.microsoft.com/en-us/msrc/security-update-severity-rating-system
> +- Red Hat: https://access.redhat.com/security/updates/classification
> +- Google: https://cloud.google.com/security-command-center/docs/finding-severity-classifications#severity_classifications
> -- 
> 2.34.1
> 

-- 
Kees Cook

