Return-Path: <linux-kernel+bounces-156314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A2F8B0118
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6E3BB2355C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D333E15696A;
	Wed, 24 Apr 2024 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="me6Gb6RE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D177156880
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713936914; cv=none; b=D7SLkxki2kcINc5ZBBAP1dSCBd/IbAG0fw9Ljv0RauRdTy0brg1hCb78sSR3ehjeL/Zvowebibroy0ZyPVu5xO0KyTch2sQF2rWPmJkJH8vxcMIRDAFKMsYthOyKvc7s2sVTaW2Mly3UR4I5ohmii8knK/OrSWeMFWY892r2VIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713936914; c=relaxed/simple;
	bh=Jn60dYRd1TpXyCZr+gNbLZI2wVr5L4k3MosQ5rxQ7qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0MpnedCSB0fC6zblL8ytP5y0D7ZhPw95Yr2nuZhUTSlRrIUWkRF+hAske3la9vrLAot8yNkkLHlapMgRT8NxyghPjDo3yvxc4Pw+03PoOY1wJi3rNYla4+K3TgqwVkRJBBGOiHbhWxoHHgVBBli+QBlMUx7oYQwufsdiYtHcWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=me6Gb6RE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD0DC2BD11;
	Wed, 24 Apr 2024 05:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713936913;
	bh=Jn60dYRd1TpXyCZr+gNbLZI2wVr5L4k3MosQ5rxQ7qI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=me6Gb6REqEGYDSgYaLVysK5rTC3FApIW8/DgWMIAHN4p1u3QswSoRh8VwHmCNdEdi
	 0Qp4yfmWcMElMmp2jdFRidrf5pJblWD6ehNyj7NhuTtJL6NwWCa7EI/hZvfbxr3EN5
	 jafbO1E2767NcasRIql5YRa+uRfshrdkUjYIKwWUEXleEE8k6igrPElxn6D9JClkJN
	 7CdIvrfgctJqUr1rbwnX3vycp+ezdY+W/ShyfQ8bBJiHv8Ws4vsjn+lH876yefNL64
	 1eC10b8vRgryE9PfJZzMDsC2x7n/wHqriZRAxFCBgnXR7FKmwnSgB5iT2/U0V12trg
	 dzgsY7rSaJVoA==
Date: Tue, 23 Apr 2024 22:35:11 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 2/5] cpu/speculation: Fix CPU mitigation defaults for
 !x86
Message-ID: <20240424053511.grt6tgt34wwpvzog@treble>
References: <cover.1713559768.git.jpoimboe@kernel.org>
 <9d3c997264829d0e2b28718222724ae8f9e7d8b4.1713559768.git.jpoimboe@kernel.org>
 <ZiMHu--agdvt4Rl1@google.com>
 <ZifBT9N0QivOZ2L_@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZifBT9N0QivOZ2L_@google.com>

On Tue, Apr 23, 2024 at 07:10:23AM -0700, Sean Christopherson wrote:
> On Fri, Apr 19, 2024, Sean Christopherson wrote:
> > On Fri, Apr 19, 2024, Josh Poimboeuf wrote:
> > > CPU speculative execution mitigations were inadvertently disabled on
> > > non-x86 arches by the following commit:
> > > 
> > >  f337a6a21e2f ("x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n")
> > > 
> > > Fix it by replacing CONFIG_SPECULATION_MITIGATIONS with a new generic
> > > CONFIG_CPU_MITIGATIONS option and moving the x86-specific mitigations to
> > > a separate menu which depends on CONFIG_CPU_MITIGATIONS.
> > 
> > Ah drat, I didn't check my mailbox until after Cc'ing Linus my own version[*].
> > 
> > I don't have a strong preference between the two, though I do think it's worth
> > nothing that this will (obvioulsy) allow disabling mitigations at compile time
> > on all architectures, which may or may not be desirable.
> > 
> > [*] https://lore.kernel.org/all/20240420000556.2645001-2-seanjc@google.com
> 
> Josh, when you get a chance, can you weigh in on my menu-preserving approach?
> 
> I want to get this resolved asap so that we're not scrambing on Friday again :-)

Yeah, yours looks good.  Lemme go ack.

-- 
Josh

