Return-Path: <linux-kernel+bounces-134810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC0B89B73D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75FDDB213CD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2740679D2;
	Mon,  8 Apr 2024 05:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1yWZ8c3a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679A83C2F;
	Mon,  8 Apr 2024 05:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712555054; cv=none; b=lL24Ov0u56ib1A7fZsZ008foqDIQvWdj3s62KbaoWfWUa7qqsd8nuef/y/7Nx2ln+0H30LU+2Wgppf+y3P2BipgOsCm4+DVGggd8HHWkVGwWq5c3OwJ/z/8O1FMVWi6Sf+t/qtfv0L5CthWWHmr33seKznfC+i6U6PJRWgWMqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712555054; c=relaxed/simple;
	bh=vMTO+JCxJ/pC8pUOQVFfrJmUCn0gHKZBHp2mN8vrUkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oclQntMuzKiTk4MfdA3gk/hVf3oSVANsj30EIdiMLi8hxY4RB2WQJUCTEcpho+T65PcDb0nzCla8+QMdoicp5fy1io+XOXtqZ242aDKfGWoo/FH96/CDFJ5qBaJSmfw7XtI2A3iTfEVpg/7DCOO45BZT4D65JMLn9mrpMRir0kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1yWZ8c3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D56FC433F1;
	Mon,  8 Apr 2024 05:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712555054;
	bh=vMTO+JCxJ/pC8pUOQVFfrJmUCn0gHKZBHp2mN8vrUkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1yWZ8c3afHE2SqsjmwsiwlagPW2l0wHd6orMPdWrLRaIm4oevC51UhVuVWvEMsD78
	 HMK8Rnmq2St49ROmoMrJe9eqkhIJClsPRUAFWerMk3yzPPSzyhGZ5mpq7FhIV13v0r
	 NAYbYrf+vMkX3iWja7ouU1FF3yCxfW+KqwaKWPbE=
Date: Mon, 8 Apr 2024 07:44:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Finn Thain <fthain@linux-m68k.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] serial/pmac_zilog: Remove flawed mitigation for rx irq
 flood
Message-ID: <2024040843-plug-thirstily-e478@gregkh>
References: <dda2187e128bfaaf092351812e4538e2e41c17f6.1711599093.git.fthain@linux-m68k.org>
 <Zg3YZN-QupyVaTPm@surfacebook.localdomain>
 <8f234f26-d5e3-66ed-ab0c-86d3c9852b4a@linux-m68k.org>
 <CAHp75VcxLez_Nm0N8=gpWd7SKGd9JF2QXEOOB_gvX3ZtTzj6HQ@mail.gmail.com>
 <87y19s7bk6.fsf@mail.lhotse>
 <4bddf8ec-97f1-07f6-9c0a-523c102c0a1b@linux-m68k.org>
 <87v84sbexv.fsf@mail.lhotse>
 <b1553164-18db-4f5c-b1a5-28a393d64941@kernel.org>
 <3adf561b-2d6b-47be-8fca-2a26ee738670@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3adf561b-2d6b-47be-8fca-2a26ee738670@kernel.org>

On Mon, Apr 08, 2024 at 07:37:22AM +0200, Jiri Slaby wrote:
> On 08. 04. 24, 7:32, Jiri Slaby wrote:
> > On 08. 04. 24, 7:29, Michael Ellerman wrote:
> > > Many maintainers won't drop Cc: tags if they are there in the submitted
> > > patch. So I agree with Andy that we should encourage folks not to add
> > > them in the first place.
> > 
> > But fix the docs first.
> > 
> > I am personally not biased to any variant (as in: I don't care where CCs
> > live in a patch).
> 
> OTOH, as a submitter, it's a major PITA to carry CCs in notes (to have those
> under the --- line). Esp. when I have patches in a queue for years.

Agreed, let's keep them where they are in the signed-off-by area, it's
not hurting or harming anything to have them there.

thanks,

greg k-h

