Return-Path: <linux-kernel+bounces-161111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CCA8B4743
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602321F2182E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 17:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1824F14386F;
	Sat, 27 Apr 2024 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuBX3QB9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5004F848E;
	Sat, 27 Apr 2024 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714239388; cv=none; b=qKtJmhwyxyE5BUBzd/MXPJVHctFeMEDhEY1jP6dfxgy2OBdAz4CNSpsPFFtDId00KLWwSJ3sj92gw7zSMZqSPPyW+pd6Hp+NcVSEcJL21VYOsOqqK2loPQWOPNXQI8ISUeV9U6fAQN8FSbeYC3/bqClJnVXz1UboKUnTa+nC5YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714239388; c=relaxed/simple;
	bh=0Prt+cAaF/eoq/tgvDH2fUkpwtZfA2a4ronJhKEJqB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6gEwUk2sb1o//Qcg7iX4mrBShM5KcIGLiTaGvy7J+KDdpH5pITv5FN9pQs4WoKiRz3boe/VbTZlIEV3IrwNVhOGrXU9uQIoluZMbfuz+cK5Ns8+mQTlyKNIXaoRMDsURROzyViKCmkyFBfu1fjQaGrWyGYKsHMK0JD1I6kQzeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuBX3QB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68505C113CE;
	Sat, 27 Apr 2024 17:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714239387;
	bh=0Prt+cAaF/eoq/tgvDH2fUkpwtZfA2a4ronJhKEJqB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iuBX3QB9mBEIfU+LsFvINS3Rbb3giAdGJGjADZW+O+fOYC7/uaZPtlp/6ZEJa9mXX
	 caKm/PAHPH9S3MmVCj0skf86ydG49RM0Tvxnq15550mVgi6PjvC7lkrOfglpeNMwX3
	 gt3I78v2DDb6EtCS1ym14Zo3K1/+lyM9QsOBp2jbh49lPdT410S5fBSf/sd7DykxQ1
	 VyoDNUHMEEljY3wtNcrZp0ljJnuxSCcs4uk5qqe4nbVfhxGtMt6rl5o48Cu3fWjrs3
	 T9KEpXY0wmcudNPfLOY39zy4Pn4qjdjiAkjxSF9nwmPq2IiH+hKkMHiEJcN+KB71Hv
	 kER6Uo5Q5dJGw==
Date: Sat, 27 Apr 2024 18:36:22 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>, Jiri Pirko <jiri@resnulli.us>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH net 0/4] net: qede: avoid overruling error codes
Message-ID: <20240427173622.GU516117@kernel.org>
References: <20240426091227.78060-1-ast@fiberby.net>
 <20240427114813.GG516117@kernel.org>
 <ab165657-2c69-4b30-a371-6ad7fd28c539@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab165657-2c69-4b30-a371-6ad7fd28c539@fiberby.net>

On Sat, Apr 27, 2024 at 12:58:38PM +0000, Asbjørn Sloth Tønnesen wrote:
> Hi Simon,
> 
> Thank you for your review effort.
> 
> On 4/27/24 11:48 AM, Simon Horman wrote:
> > On Fri, Apr 26, 2024 at 09:12:22AM +0000, Asbjørn Sloth Tønnesen wrote:
> > > This series fixes the qede driver, so that
> > > qede_parse_flow_attr() and it's subfunctions
> > > doesn't get their error codes overruled
> > > (ie. turning -EOPNOTSUPP into -EINVAL).
> > > 
> > > ---
> > > I have two more patches along the same lines,
> > > but they are not yet causing any issues,
> > > so I have them destined for net-next.
> > > (those are for qede_flow_spec_validate_unused()
> > > and qede_flow_parse_ports().)
> > > 
> > > After that I have a series for converting to
> > > extack + the final one for validating control
> > > flags.
> > 
> > Hi,
> > 
> > I'm fine with these patches so far as the code changes go.
> > But it is not clear to me that they are fixing a bug.
> > 
> > If so, I think some explanation should go in the commit messages.
> > If not, I think these should be targeted at net-next
> > (and not have Fixes tags.
> 
> Since I don't have the hardware I didn't try to construct commands, showing
> the wrong error code being returned. I could make up some hypothetical commands,
> and simulate how they would error. I assumed that the bug, was clear based on
> the list of possible return values for each function.
> 
> As an example, in qede_parse_flow_attr() it validates dissector->used_keys,
> and if an unsupported FLOW_DISSECTOR_KEY_* is set, then ede_parse_flow_attr()
> returns -EOPNOTSUPP, which is returned to qede_add_tc_flower_fltr(),
> and only check for non-zero, and since -EOPNOTSUPP is non zero,
> then it returns -EINVAL. So if you try to match on a vlan tag,
> then FLOW_DISSECTOR_KEY_VLAN would be set, and cause a -EOPNOTSUPP
> to be returned, which then gets converted into a -EINVAL.
> 
> All drivers generally returns -EOPNOTSUPP in their used_keys checks, and
> this driver clearly intended to do that as well.
> 
> The -EINVAL override was introduced in the same commit as the above check,
> so it was broken from the start.
> 
> Another example is 319a1d19471e (blamed in 4th patch), Jiri added
> a call to flow_action_basic_hw_stats_types_check() across multiple drivers,
> and since -EINVAL was returned only a few lines above, then he assumed
> that he could just return -EOPNOTSUPP, but that return value gets overruled
> into a -EINVAL. It is clear from the commit that Jiri intended to return
> -EOPNOTSUPP, but this part of the driver didn't follow the principle of
> least astonishment, so that function could only fail with -EINVAL.
> 
> I think it's a bug, when another error code is returned than the one that
> was clearly intended, but it's properly a low impact one.

Thanks, now that you point this out I agree this should have been obvious
to me.

I agree that the patches resolve issues around -EOPNOTSUPP (and other error
values; that these errors are, in general, propagated to user-space; and
that especially in the case of -EOPNOTSUPP, this may effect the behaviour
of the system as it is intended to indicate that offload of an action is not
supported (at this time, for any reason).

> > Also, if you do end posting a v2, blamed, is misspelt several
> > times in commit messages.
> 
> Sorry about that, will fix that if a v2 turns out to be needed.
> 
> -- 
> Best regards
> Asbjørn Sloth Tønnesen
> Network Engineer
> Fiberby - AS42541
> 

