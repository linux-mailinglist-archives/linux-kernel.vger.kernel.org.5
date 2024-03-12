Return-Path: <linux-kernel+bounces-100831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC40A879DDB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F9E282F00
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4123144026;
	Tue, 12 Mar 2024 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lRSzTl/B"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD3213B2BF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 21:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280082; cv=none; b=E1nt9I5AyBuRXMa9Gg3jXSan+pq8Ty9p+DpR1zNxMvAfp9csr6s1EvShZoWcAmcX7NHgQcmFJyXJ5RRX5sIAKDRNqrWW0IQ5Ngb0pQDnGGtjtUUWjkctiMokB8Bf9GPp4woudrc+HqmzJ/loyeeZVQCO0oCyi5l5Utsmy8GQIU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280082; c=relaxed/simple;
	bh=L2eQm78Ep/nKl21rfck6kP+4vv28QboG7+r2/W034eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YV3rGytvbZx3xsYe3DKtaYhG9tVvM/ryRQ3UAt/bEtriC0CRxWm7lJ8ywrmJOK3VLIjWakE84oQZQS/ay+HWjZ0X1larrQST9lZFJaspE5vhCCWTHWjMdCr0G5pgJ+xy7zccZWDkXEhLm8DobkTfmcicflAM/461v2qNLLQiXak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lRSzTl/B; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e6b54a28ebso288000b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710280080; x=1710884880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5I2vL4V/sZirteZI/7LO3YutNeNo/zQMZt8rKEiQgEE=;
        b=lRSzTl/B992qzBW+VqA1B0HR7hQkCwmPovamkSbz4M529S6JQ2/ynFL4v7qQDKsoyY
         pjoYzc4THAqz312SSQn5h9jtapt7W8mFSQJyv/QdZG1TzYsSWDjwrokQYXhpRTvXGUl5
         1ZBZUuvr/wLhRE1WCMvX7cLxwcdW6YFMgeSDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710280080; x=1710884880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5I2vL4V/sZirteZI/7LO3YutNeNo/zQMZt8rKEiQgEE=;
        b=oQjFaItNCETUfjxI8zsYWqoOGiwNuK9c4yShKxYkrHgz+dQM3ZJQuDYwbMxVxpvu4O
         UJcbtF4+7xzyFmnCDSngAronsQcSYDcycyi8XDqXZ8O0yFvyhlimdp7YGExbzlaWKlzC
         o36fsU5RKL7BZ+criW/WavxTipR82c1tQSfyafiWxg7pSzPrambZfZOh2hlSYg9R9nyu
         CQL6EbX4+3r4fREw6CC1XVzbHJDRx0kznXQS5Pjetu+ouFCgV8g6HaYmynSCDZ+PKi6H
         eZnOLNeH0Yts5rt7CIjKdWXNQQpo+FwGDEJSGQ7WkcMd+i77cSKazUC41rS/zPcZ0ox6
         rOIA==
X-Forwarded-Encrypted: i=1; AJvYcCXlg0LkboOhiLN4kFt9bUw3c0edMhM4SCVb1qYv8GNIYO4G1ZYhsrNgLgNicDtzyMz9EUeCKowZYEQIG3Jhcl6Q48O9pDiBsUoqsxIq
X-Gm-Message-State: AOJu0YzXSNR3oVDAaEWWF6Kqf/PY9GiQ+1K6d8Sz5puNHLuVL2YJ5tdW
	5K3w+ACrL4KdHn2zEbpwmoYvUurG4Y8t+l0ArwdUo5Nq7IpC+wjfUJMa33T9hg==
X-Google-Smtp-Source: AGHT+IF/3egLMmEl1pnSU7WlZMy9mWzBwZd2/LI2elmUdJ1qQ5VOu3moaheGk92bDVuSfjG9UHYiRw==
X-Received: by 2002:a05:6a00:1403:b0:6e5:db93:33b8 with SMTP id l3-20020a056a00140300b006e5db9333b8mr797744pfu.20.1710280080506;
        Tue, 12 Mar 2024 14:48:00 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y30-20020aa793de000000b006e5a99942c6sm6622936pff.88.2024.03.12.14.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 14:48:00 -0700 (PDT)
Date: Tue, 12 Mar 2024 14:47:59 -0700
From: Kees Cook <keescook@chromium.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Michal Hocko <mhocko@suse.com>,
	cve@kernel.org, linux-kernel@vger.kernel.org,
	Joel Granados <j.granados@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2023-52596: sysctl: Fix out of bounds access for empty
 sysctl registers
Message-ID: <202403121431.55E67E201@keescook>
References: <2024030645-CVE-2023-52596-b98e@gregkh>
 <Ze68r7_aTn6Vjbpj@tiehlicka>
 <Ze9-Xmn8v4P_wppv@bombadil.infradead.org>
 <20240312091730.GU86322@google.com>
 <ZfAkOFAV15BDMU7F@tiehlicka>
 <ZfBwuDyzLl5M0mhC@bombadil.infradead.org>
 <20240312154910.GC1522089@google.com>
 <ZfCZGevmDe149QeX@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfCZGevmDe149QeX@bombadil.infradead.org>

On Tue, Mar 12, 2024 at 11:04:09AM -0700, Luis Chamberlain wrote:
> + Kees,
> 
> On Tue, Mar 12, 2024 at 03:49:10PM +0000, Lee Jones wrote:
> > On Tue, 12 Mar 2024, Luis Chamberlain wrote:
> > 
> > > On Tue, Mar 12, 2024 at 10:45:28AM +0100, Michal Hocko wrote:
> > > > On Tue 12-03-24 09:17:30, Lee Jones wrote:
> > > > [...]
> > > > > > Backporting this is fine, but wouldn't fix an issue unless an external
> > > > > > module had empty sysctls. And exploiting this is not possible unless
> > > > > > you purposely build an external module which could end up with empty
> > > > > > sysctls.
> > > > 
> > > > Thanks for the clarification Luis!
> > > > 
> > > > > Thanks for the amazing explanation Luis.
> > > > > 
> > > > > If I'm reading this correctly, an issue does exist, but an attacker
> > > > > would have to lay some foundations before it could be triggered.  Sounds
> > > > > like loading of a malicious or naive module would be enough.
> > > > 
> > > > If the bar is set as high as a kernel module to create and empty sysctl
> > > > directory then I think it is safe to say that the security aspect is
> > > > mostly moot. There are much simpler ways to attack the system if you are
> > > > able to load a kernel module.
> > > 
> > > Indeed, a simple BUG_ON(1) on external modules cannot possible be a
> > > source of a CVE. And so this becomes BUG_ON(when_sysctl_empty()) where
> > 
> > Issues that are capable of crashing the kernel in any way, including
> > with WARN() or BUG() are being considered weaknesses and presently get
> > CVEs.
> 
> Its not possible to crash any released kernel with the out of bounds issue
> today, the commit is just a fix for a future world with empty sysctls
> which just don't exist today.
> 
> Yes you can crash an external module with an empty sysctl on kernels
> without that commit, but an empty sysctl is not common practice for
> external modules, they'd have to have custom #ifdefs embedded as noted
> earlier with the example crash. So your average external module should
> not be able to crash existing kernels. The scope of a crash then would
> be external modules that used older kernels without the fix starting after
> v6.6. Since the fix is already meged on v6.6+ the scope of possible
> kernels is small, and you'd need a specially crafted sysctl empty array
> to do so.
> 
> > > when_sysctl_empty() is hypotethical and I think the source of this
> > > question for CVE. Today's that not at boot time or dynamically with
> > > any linux kernel sources released, and so its only possible if:
> > > 
> > >   a) As Joel indicated if you backported an empty sysctl array (which
> > >   would be unless you carried all the infrastructure to support it).
> > > 
> > >   b) an external module has an empty sysctl
> > 
> > So what we're discussing here is weather this situation is
> > _possible_, however unlikely.
> 
> I tried my best to summarize that world as we see it above.
> 
> > You are the maintainer here, so the final decision is yours.  If you say
> > this situation is impossible and the CVE should be revoked, I'll go
> > ahead and do just that.
> 
> To the best of our ability, from our perspective, upon our review, the
> only way to trigger a crash would be with sysctls on external modules
> loaded on these kernels:
> 
>  * v6.6 up to v6.6.15 (v6.6.16 has the fix backported) so 16 releases
>  * v6.7 up to v6.7.3  (v6.7.4 has the fix backported) so 4 releases
> 
> External modules having empty sysctls should be rare, however possible.
> So these 20 release would be affected by a crash with specially crafted
> external modules. I suppose one way to exploit this, might be for a
> vendor providing an external safe-looking module with #ifdefs which make
> a sysctl seem non-empty but in reality it would be. That issue would
> exist for 20 kernel releases. Could someone craft something with the out
> of bounds access given the context to do something evil? Your domain of
> expertise, your call, not ours.

I'm not a member of the CNA, but I would lean "yes, the absolute weakest
of CVE" after spending some time reading the code, reading this thread,
to dig in and look at this. If it's a malicious module, it doesn't matter:
the module can do anything. If it's a published module that an attacker
could use due to the resulting logic of processing the 0th sysctl table
entry, okay, yes, CVE. Likely insanely rare, but not impossible. But,
if, as Luis says, there are no upstream modules like this, then it's
not a CVE.

So for real-world impact, we'd have to either say "there might be an
out-of-tree module that could be used as a stepping stone here, and we
want to protect our users, so let's assign a CVE" or we take a hard line
and say that's up to downstreams to assign CVEs for their modules.

I have tried to argue before that it's up to the core kernel code to Do
The Right Thing, even in the face of crappy out-of-tree code, so to me,
since this is a (very very very limited) weakness in the core kernel
code, give it a CVE.

My attempt at a CVSS for it yields a 3.4 overall:
AV:L/AC:H/PR:H/UI:N/S:U/C:L/I:L/A:L/E:U/RL:O/RC:X
https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator?vector=AV:L/AC:H/PR:H/UI:N/S:U/C:L/I:L/A:L/E:U/RL:O/RC:X&version=3.1

-- 
Kees Cook

