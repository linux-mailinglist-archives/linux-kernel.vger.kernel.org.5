Return-Path: <linux-kernel+bounces-141972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8389F8A25A7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41BF3284BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C521B968;
	Fri, 12 Apr 2024 05:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNEFY4OB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EB0DDA9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 05:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712899258; cv=none; b=XOA5MzdoXTeXH4VptRRTrHJJik64woH3rTeGoMh+BlKgF7aFdl7//eQIvN9LxsnTCs8IHGOFnI67533K4dDJ4DH6JUCCy0laCcTSLEajcuGjcp2u1UMC4MmVy3dZZ9mPGCcUTr9N1xbKa9DuuPldLlpn7RpaQaisvJU7tJ75FwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712899258; c=relaxed/simple;
	bh=Yw/ki6ObOoZJpn0+pDz0oORbjMgC/ROYym/KZ4/+H68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2HuQ4X0/tNj5CI6DuybymRI+aXv3YZmpuYMSmtFRICV7IgwB3AkVBUykEl0xQzj6DcDiW3/wapc5zEf3mz8geEpaJVH0krRfRHvcsbPyI45B0QsPWr5GRk65WeZqP3s9/WhCAKONdt1dFVb8RQRdgWjpwXcYMvdh3bBeu7rQLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNEFY4OB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96225C2BBFC;
	Fri, 12 Apr 2024 05:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712899258;
	bh=Yw/ki6ObOoZJpn0+pDz0oORbjMgC/ROYym/KZ4/+H68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sNEFY4OBCk8Wb0yLWpOcJSuAO7tUTXt8s/Lvql20Y26hKvqU5oAip6QR85Fgkf7U4
	 XLm1dhjGbWJhuK28wheUQP/oDJHldb+CxFB92Jr8RJtFrbmu6Qkp7Uzd4tedULczfh
	 6p9b5F7x+KVqgew91TswPJeQLPwDYVzKEztGwKIWklnoEexza+bt81ZLNm09qmUvoI
	 6m9f2uHK+BVjiI0BCIHzspqJRZPwZ9AShuMTiWlg8Mweb4nXeSZY+ZnT9CcAOgtUNI
	 yQedbZr8YOOn8k/JLaGMou7hIsIc3vXwjau+sTxIT7Ojv8CaOHjbJOXPHmere4R4us
	 DkSUJj7AZFMDw==
Date: Thu, 11 Apr 2024 22:20:55 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 5/7] x86/bugs: Only harden syscalls when needed
Message-ID: <20240412052055.wpr3zs5l4qjc62vu@treble>
References: <cover.1712813475.git.jpoimboe@kernel.org>
 <97befd7c1e008797734dee05181c49056ff6de57.1712813475.git.jpoimboe@kernel.org>
 <20240412001522.3zp2mzked4ksglkl@desk>
 <20240412035740.ojgvlqahqlm2umsx@treble>
 <20240412041724.gx6jtx7tpz2c7gbe@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240412041724.gx6jtx7tpz2c7gbe@treble>

On Thu, Apr 11, 2024 at 09:17:27PM -0700, Josh Poimboeuf wrote:
> On Thu, Apr 11, 2024 at 08:57:42PM -0700, Josh Poimboeuf wrote:
> > For similar reasons I'm thinking we should also remove the non-eIBRS
> > version (SPECTRE_V2_LFENCE).
> 
> Actually I guess that's still the default mitigation for AMD so I'll
> leave that one in.

Never mind, I forgot that got deprecated for AMD.

-- 
Josh

