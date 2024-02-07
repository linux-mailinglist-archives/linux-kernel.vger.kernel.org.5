Return-Path: <linux-kernel+bounces-56244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEC284C7D2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33831F2ABDC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5E523748;
	Wed,  7 Feb 2024 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G7aCWeJJ"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC49224F5
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299176; cv=none; b=JpRepl5F/SX3aacZsFZiXYLmSJFZTMnA/AM3uqUH/hv8shLPpV0EGzqV9qXWfcAr9MgJksCgBTZFuU1NChWpjU9lXprvQNb3BDrdiwyHu/STjChn3EDVPYqFXgfMFq5XEecEXH95Y/D7j2qHOC10b13gZ4SD2HEssXXkI56EZfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299176; c=relaxed/simple;
	bh=8pC5J/DPGDYSm7eVYO0ax2DxRputXMPsGsVLNt9KW2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVXUkzFaZnWFXukF5I5xW4cHDKNMFYihW/8e+Wuzm1aXvETcXygZhNDnXkersZGT9Eb4nN1y9qje/k3dG/OL0N1CVlXRNaiYRhlUfn0Uo54V/LpboEqQfw6XjljpBQAuiTPT5J0RhoTXotFXnxW86Jnr37DwsO+pQAWlUmHF6GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G7aCWeJJ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 7 Feb 2024 09:45:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707299172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BbyM0TxgwW7NxbPK8YYz+FX1qkBRa9X6fI99XFXXJRM=;
	b=G7aCWeJJUhuhyNkWBRZ9UM7qlDYraFHLUrbdbVEE0wOk8mLC6yo3/1GVntJvr+NUewQ9en
	9MgAR7WrDBTD6ftSPhs/OCIsWK+SigLahE1gyASEjrHsxvXac7YkxTWVfKoAjlSjWuEADl
	ny0eRVGG9xoovzWOU8BYc/VxoZz4t+w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, maz@kernel.org, catalin.marinas@arm.com,
	will@kernel.org, suzuki.poulose@arm.com, james.morse@arm.com,
	corbet@lwn.net, boris.ostrovsky@oracle.com,
	darren@os.amperecomputing.com, d.scott.phillips@amperecomputing.com
Subject: Re: [PATCH] arm64: errata: Minimize tlb flush due to vttbr writes on
 AmpereOne
Message-ID: <ZcNRV-lMiNgE0_jv@linux.dev>
References: <20240207090458.463021-1-gankulkarni@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207090458.463021-1-gankulkarni@os.amperecomputing.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 07, 2024 at 01:04:58AM -0800, Ganapatrao Kulkarni wrote:
> AmpereOne implementation is doing tlb flush when ever there is
> a write to vttbr_el2. As per KVM implementation, vttbr_el2 is updated
> with VM's S2-MMU while return to VM. This is not necessary when there
> is no VM context switch and a just return to same Guest.
> 
> Adding a check to avoid the vttbr_el2 write if the same value
> already exist to prevent needless tlb flush.

Sorry, zero interest in taking what is really a uarch optimization.
The errata framework exists to allow the kernel achieve *correctness*
on a variety of hardware and is not a collection of party tricks for
optimizing any given implementation.

Think of the precedent this would establish. What would stop
implementers from, say, changing out our memcpy implementation into a
a hundred different uarch-specific routines. That isn't maintainable,
nor is it even testable as most folks don't have access to your
hardware.

Ignoring all of that -- I question the necessity of these patches
altogether. KVM writes to VTTBR at the time of vcpu load as of commit
934bf871f011 ("KVM: arm64: Load the stage-2 MMU context in
kvm_vcpu_load_vhe()"), which should drastically reduce the overhead of
this hardware fix.

--
Thanks,
Oliver

