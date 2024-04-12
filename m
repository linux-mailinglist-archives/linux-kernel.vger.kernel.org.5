Return-Path: <linux-kernel+bounces-143308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132308A370A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440831C20951
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D1214A091;
	Fri, 12 Apr 2024 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cq+XUqyd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506963D548
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712953483; cv=none; b=PHM/oyZpf8PQo0GO8ZUPq1oyYsPrlx6mV8tpH0XZw+r+DKfpm2+MUI0uUfE2Irj0sTrnzVwxzXtf6GDzaf5a3NF7Cw1dcn2zHy3r2Bf0RMz6tp0O4kiJCstTDwYz9WFQngywwBaV6HtcNgxG21AhEpIlmUqgrWtxIIBjH08g23o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712953483; c=relaxed/simple;
	bh=KzDc1tjmvaW1K9dCBdK3D7/xqyVIO8d5OPT0fRIHC0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBFWuD56uYpvV3nexXJ20ejl1N8FNd0y+dFmt6vGIbxLIbPKsBf0x+AXETOunZDhn0JrO5HqMhqCPnVZKXfQui4vo3uLpW+EhlJBw8yCKRwjukL9TaFid4y1HJnzXx1wB1+IVHo/VqOqiGbUI7m5edxRx1Td5ET3B7xL4b2N72k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cq+XUqyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15485C113CC;
	Fri, 12 Apr 2024 20:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712953482;
	bh=KzDc1tjmvaW1K9dCBdK3D7/xqyVIO8d5OPT0fRIHC0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cq+XUqydz/70unlmcG8SnaONhGJQBDijlrA85tMgqBPNX8+VpnpnXt0Wc+ch60bg1
	 D66RCl2Ak9WQgnVSe9kNL2w5132B2jZHTbk4+hBl3uahqeOLGh9NamZzssQz+F3oiN
	 xGqRyKgNDKMDkN+MK8MsgeKYS6tg60EXovfFXeDhOKNIdwWOGJkVCkNzzcIumjpviZ
	 UXhZzSAb3EPX9k4WIipB1Vqbpiwn/HvY+A5e6lyYE+EEZ0CpmUfV+L7/Wi7TXDJJPN
	 nkjS6XGizIfq/2pIV1Ky+XBMtprPXYKKi4ewmQMLHhvjT0xHvqB+zSUXIMMyUFxpGT
	 YeGclN4t3Risw==
Date: Fri, 12 Apr 2024 13:24:31 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 5/7] x86/bugs: Only harden syscalls when needed
Message-ID: <20240412202431.auz5fcjqim6h7faf@treble>
References: <cover.1712813475.git.jpoimboe@kernel.org>
 <97befd7c1e008797734dee05181c49056ff6de57.1712813475.git.jpoimboe@kernel.org>
 <20240412001522.3zp2mzked4ksglkl@desk>
 <20240412035740.ojgvlqahqlm2umsx@treble>
 <20240412041724.gx6jtx7tpz2c7gbe@treble>
 <20240412052055.wpr3zs5l4qjc62vu@treble>
 <0a718cd3-d0ff-48ab-8d16-d513d95563d3@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a718cd3-d0ff-48ab-8d16-d513d95563d3@citrix.com>

On Fri, Apr 12, 2024 at 11:36:04AM +0100, Andrew Cooper wrote:
> On 12/04/2024 6:20 am, Josh Poimboeuf wrote:
> > On Thu, Apr 11, 2024 at 09:17:27PM -0700, Josh Poimboeuf wrote:
> >> On Thu, Apr 11, 2024 at 08:57:42PM -0700, Josh Poimboeuf wrote:
> >>> For similar reasons I'm thinking we should also remove the non-eIBRS
> >>> version (SPECTRE_V2_LFENCE).
> >> Actually I guess that's still the default mitigation for AMD so I'll
> >> leave that one in.
> > Never mind, I forgot that got deprecated for AMD.
> 
> And then became necessary on two Atoms, although I can't for the life of
> of me find Intel's footnote about this in the maze of speculation docs...

Found it on this page [1] but it doesn't seem to be a very confident
endorsement. And Linux doesn't seem to enable it for those parts
regardless.

  Intel® Atom Goldmont Plus and Tremont Mitigation

  Retpoline may not be a fully effective branch target injection
  mitigation on processors which are based on Intel Atom
  microarchitectures code named Goldmont Plus and Tremont, as documented
  in our existing guidance. On such processors, an LFENCE;JMP sequence may
  be an alternative for retpoline, although this is not architecturally
  guaranteed. Instructions may still be speculatively executed at the
  predicted near JMP target, which can allow some forms of shallow gadgets
  (for example, revealing register values) to be transiently executed.

  Intel is not currently evaluating LFENCE;JMP as an option other than for
  processors based on Goldmont Plus and Tremont microarchitectures, given
  the possibility of a sufficiently large transient window to execute a
  disclosure gadget.

https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/branch-history-injection.html

-- 
Josh

