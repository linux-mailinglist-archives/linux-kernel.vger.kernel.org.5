Return-Path: <linux-kernel+bounces-165298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C5A8B8AE6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F1C282343
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74C512C801;
	Wed,  1 May 2024 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C7abI0xi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D04152795
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714568783; cv=none; b=dabGh0LNDg7ZF63c1GlefzUVh8XNndBuBAzuFLyJNQ6i6mwR/If/BO7821CNEs+DdgjTv/2HXp2lvgyhbRhj6rGwGSSY8R2rNifcxzomthBrWbK4itRkw4JEfEDTjmUSlAjQsH0Hlb/mPUKI81ApoBZczCEPXl00wzVVMuqAKWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714568783; c=relaxed/simple;
	bh=V2kVE6wZDPJ3w0WsZm4Q/spr0mr8CyMrPVob/eNBi5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zcf2+DlbdtuZ33LfV2Qog4RjdDDZd58tPv7QIEB45bv7LgmagCIeAkiv80EN7avzf96e9Ng1CyYrq6OaNntXWVUte5fmMdEo8gD4w6ssTJtglM3t44DHOX7pnyPxtWNFGYltLHzGs9rXfntymmAfsize0vBDkGEtxaPFpaxRiwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C7abI0xi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB54EC113CC;
	Wed,  1 May 2024 13:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714568782;
	bh=V2kVE6wZDPJ3w0WsZm4Q/spr0mr8CyMrPVob/eNBi5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C7abI0xifRwA0J1yZGGfZUl1ZHHl4lm87k1NkMwShCOQTciVWJ0on90gXWYBGVI9n
	 2oEgs/PQjhQDM/GksVWn+lRS+tCSGoOABwqQdQHt8CLSlmP1lO/aiWhydm4ToF+aj+
	 qmJDbp3rizWLZskPcmgGR2cJqto8zB5e55TJUr84=
Date: Wed, 1 May 2024 15:06:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Cc: sudeep.holla@arm.com, javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr, linux-kernel@vger.kernel.org,
	rafael@kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH 2/2 v3] drivers: use __free attribute instead of
 of_node_put()
Message-ID: <2024050148-dutiful-unsubtle-dbb1@gregkh>
References: <20240424125401.oxvt5n64d7a57ge3@bogus>
 <20240501094313.407820-1-vincenzo.mezzela@gmail.com>
 <20240501094313.407820-3-vincenzo.mezzela@gmail.com>
 <2024050102-reshuffle-licking-f84e@gregkh>
 <673df61a-e0f5-450b-8fb4-746bc950e3d1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <673df61a-e0f5-450b-8fb4-746bc950e3d1@gmail.com>

On Wed, May 01, 2024 at 02:33:39PM +0200, Vincenzo Mezzela wrote:
> On 01/05/24 12:48, Greg KH wrote:
> > On Wed, May 01, 2024 at 11:43:13AM +0200, Vincenzo Mezzela wrote:
> > > Introduce the __free attribute for scope-based resource management.
> > > Resources allocated with __free are automatically released at the end of
> > > the scope. This enhancement aims to mitigate memory management issues
> > > associated with forgetting to release resources by utilizing __free
> > > instead of of_node_put().
> > > 
> > > The declaration of the device_node used within the do-while loops is
> > > moved directly within the loop so that the resource is automatically
> > > freed at the end of each iteration.
> > > 
> > > Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> > > Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
> > > ---
> > >   drivers/base/arch_topology.c | 51 +++++++++++++++---------------------
> > >   1 file changed, 21 insertions(+), 30 deletions(-)
> > How was all of this tested?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi,
> 
> I just cross-compiled it for RISC-V to enable the config
> GENERIC_ARCH_TOPOLOGY
> and include arch_topology.c as well.

Cross-compile is nice, how about running it?

> Do you have any suggestion to trigger the affected code and perform some
> testing?

That is up to you to determine if you wish to modify it :)

thanks,

greg k-h

