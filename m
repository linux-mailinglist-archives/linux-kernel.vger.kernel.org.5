Return-Path: <linux-kernel+bounces-151979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076E08AB699
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38ECA1C21C49
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FD613CFAC;
	Fri, 19 Apr 2024 21:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsKSuY39"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B9211713
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713563193; cv=none; b=BEj1lJfG+Aro6IQc6FSnk/E/eMeg7I4g4FDgnu0GcbTfD4StLLXcQ0lDesF5PkvmGJg2LslLkMJkVBFoRTQD0GHnGS60FbbQBOMoM2GdtRWzc6PgIqMbkesjmnijFTVf1DaIpG8eqnArvC9MtAS1JZSSvdbesBzAkQhtHtugEJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713563193; c=relaxed/simple;
	bh=JqQId/KDevEZmUaHLf6u8GZsAyLmvNuf3utf6UEm3vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cj8uos54GlFceVnJoKpvv8P8X0MQzxmYm/iO+VzC/nCm3uh/HTmQR+nSoNDUeuQHVJ80DiIyAQhVVd3UXBzLtLnAoheSsdS0I0+GIbqK4MsbNEv87DGTLkMcOw5nkvYapqoIOdsltLL2k/0T12DGu+LNG4tigeMq8yzfPR24e1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsKSuY39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C530C072AA;
	Fri, 19 Apr 2024 21:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713563193;
	bh=JqQId/KDevEZmUaHLf6u8GZsAyLmvNuf3utf6UEm3vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MsKSuY399KMnUoP/0LFX2AhIpDvFT2CjQWGREu3HqNmwnzRj+pd4ManuQrq8+Ly5m
	 XZqg2YQVOCOdEqHqGv5LZDQuQjTB/vRzmhw5QJzoYhs/tjIiMawyaP7ybriWYafi+W
	 TdlXeDlhjjlfxmhDsNcXzC4sKybBZzhP4VfXs0mD8o5Wg2Rc7UrWQtTOsDW62nMF3B
	 G8qa3lBEoE5SDROuLMBF9uB/NZtBQueUbptKPMcz5ywwOsSJndUzxPqlVxXnV9UBjd
	 N8TNwd0W9GBWDOX4V0yyfA2WgiNFYSuz62U8UJJwz+w3+Ae5Frvam1IgWxg74GJq+Y
	 N2fYBF95DfJ5w==
Date: Fri, 19 Apr 2024 14:46:30 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
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
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
	Maksim Davydov <davydov-max@yandex-team.ru>
Subject: Re: [PATCH v4 5/5] x86/bugs: Add 'spectre_bhi=vmexit' cmdline option
Message-ID: <20240419214630.owsieyiyj5p432cy@treble>
References: <cover.1713559768.git.jpoimboe@kernel.org>
 <72d86c6da24138f39ca6fc9459b1d037301c1427.1713559768.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <72d86c6da24138f39ca6fc9459b1d037301c1427.1713559768.git.jpoimboe@kernel.org>

On Fri, Apr 19, 2024 at 02:09:51PM -0700, Josh Poimboeuf wrote:
> In cloud environments it can be useful to *only* enable the vmexit
> mitigation and leave syscalls vulnerable.  Add that as an option.
> 
> This is similar to the old spectre_v2=auto option which was removed with

As Daniel pointed out this should be /v2/bhi/

-- 
Josh

