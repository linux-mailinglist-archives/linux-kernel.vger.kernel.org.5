Return-Path: <linux-kernel+bounces-41925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE3683F9A4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432291F24201
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550FE36138;
	Sun, 28 Jan 2024 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3mpEZfn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597072AD0E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 20:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472075; cv=none; b=f9ChdM8N9pZ36GJw2HPUd5wbgBxgqffWuBR3yE8vuc5NaDSgGefUiijmPt2uL3BRSCunXde1rG7icF1uzx3X371TCZvJv7YPYzAG8kh8Gq86zIbebn4Nma0CB64Yn9h1emGewhJb8cu3sQl+xk1TWYNLlss6p5NxnAKwH/paK84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472075; c=relaxed/simple;
	bh=/YUY7lcIFxAF2x8ffEtZ0SwOrVeUnlqbB08lR83ef5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBkUIKP876rFVWc5K52tjEjA0mXdcRwFJ3pFg8ZO+6Qk6I5lYZsC+ttnynIis1cHABe97w58ob6diqSdZW/CtlXsOKbPT28Xs7IstrjkyCQx36DKfyokiX2k+OMmRKrLX7KctTUejWurR5XihyZUaAdaj9VpM1O+Sbno/8amSBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3mpEZfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EDCC433F1;
	Sun, 28 Jan 2024 20:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706472074;
	bh=/YUY7lcIFxAF2x8ffEtZ0SwOrVeUnlqbB08lR83ef5w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=u3mpEZfnXlywMMeUZm2PnMXMql8GwZNM1tzi0tQ1eSb/PWyn/OQRHk0/ei04pirAw
	 s4cwYrVpmxazgD96u7YNC1NezwHP8H/hvR/mcG/jbML3JUanVaBmXnh4qtWxuWcJGD
	 LpU944W1FV7bvod6QG+GqsZiBaoI5rg/XAAJhpgVqH2uC0DsNjefnmmx7Pz+A//OU2
	 LhibRizo1jSVvCCudStxDAlEjQwl133bjosWfVgpFA/PVNDxpTxECjQ9WAjbomGOVb
	 t+3QfoGBa6Z4lQNHZk9nMEzCkgDUQUP5haUlfK7axtCpGZbLiAF56u087kJFdlK/S6
	 80bdQz1YRPgEA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4EC00CE1380; Sun, 28 Jan 2024 12:01:14 -0800 (PST)
Date: Sun, 28 Jan 2024 12:01:14 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Zhang, Rui" <rui.zhang@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Raj, Ashok" <ashok.raj@intel.com>,
	"mhklinux@outlook.com" <mhklinux@outlook.com>,
	"arjan@linux.intel.com" <arjan@linux.intel.com>,
	"ray.huang@amd.com" <ray.huang@amd.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
	"Tang, Feng" <feng.tang@intel.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"jgross@suse.com" <jgross@suse.com>,
	"andy@infradead.org" <andy@infradead.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [patch v2 21/30] x86/cpu/topology: Use topology bitmaps for
 sizing
Message-ID: <e2d18e01-13f3-4ab6-828e-38a191da4fd7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240118123127.055361964@linutronix.de>
 <20240118123649.739960607@linutronix.de>
 <7c8874d971c69fb4c22c1b771983f8d5109a9387.camel@intel.com>
 <87fryjhmjs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fryjhmjs.ffs@tglx>

On Fri, Jan 26, 2024 at 09:22:47PM +0100, Thomas Gleixner wrote:
> On Fri, Jan 26 2024 at 07:07, Zhang, Rui wrote:
> >> >  
> >> > +       cnta = domain_weight(TOPO_PKG_DOMAIN);
> >> > +       cntb = domain_weight(TOPO_DIE_DOMAIN);
> >> > +       __max_logical_packages = cnta;
> >> > +       __max_dies_per_package = 1U << (get_count_order(cntb) - >
> >> > get_count_order(cnta));
> >> > +
> >> > +       pr_info("Max. logical packages: %3u\n", cnta);
> >> > +       pr_info("Max. logical dies:     %3u\n", cntb);
> >> > +       pr_info("Max. dies per package: %3u\n", >
> >> > __max_dies_per_package);
> >> > +
> >> > +       cnta = domain_weight(TOPO_CORE_DOMAIN);
> >> > +       cntb = domain_weight(TOPO_SMT_DOMAIN);
> >> > +       smp_num_siblings = 1U << (get_count_order(cntb) - >
> >> > get_count_order(cnta));
> >> > +       pr_info("Max. threads per core: %3u\n", smp_num_siblings);
> >> > +
> >
> > I missed this but Ashok catches it.
> >
> > Say, on my Adlerlake platform, which has 4 Pcores with HT + 8 Ecores,
> > cnta is 12, cntb is 16, and smp_num_siblings is set to 1 erroneously.
> >
> > I think we should use
> > 	smp_num_siblings = DIV_ROUND_UP(cntb, cnta);
> > here.
> 
> Indeed. That's more than obvious.
> 
> > Or even check each core to get the maximum value (in case there are
> > more than 2 siblings in a core some day).
> 
> We want to get rid of HT not make it worse.

Hear, hear!!!  ;-)

							Thanx, Paul

