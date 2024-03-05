Return-Path: <linux-kernel+bounces-92595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DB0872297
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5214A1C21639
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD071272C8;
	Tue,  5 Mar 2024 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SI8lMgAi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06061272B5;
	Tue,  5 Mar 2024 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652186; cv=none; b=Bu0ZsJcPuWoZKfdNnEnR06NaQQJt1AbCY0pH4mwa7ZobwtAy6Zj9MW4aaVMSZCFV3Pv55t6wy+0SDzSYgk9pjN6lgYw4xu1voWOOxBfM8nozRPCc+O41LxhFceq6fY95aMZpf4ZkWTsjOh4taILNl/d2oKCgkuEJnvTUo6MEMtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652186; c=relaxed/simple;
	bh=u/5zzaDrYAhEqBfIpcoPHzssod74ijgVQkh52KemZi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hA/CD/+YRHrBwdNM+jDaFxaZN3ujgO5DHy2ni1UU++nhriIHhAfRn7TiMsw/SRyrQA1W3ETZTARN732b/wCQUDl8PwYVty3ydMsUe92oeZBsZ+pHOWX53GV3C/DmHXVbzDJnYQ7dp6qU40JnkepEtiEmzu0Kso/DCAkeTr2MUx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SI8lMgAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E819C433F1;
	Tue,  5 Mar 2024 15:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709652185;
	bh=u/5zzaDrYAhEqBfIpcoPHzssod74ijgVQkh52KemZi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SI8lMgAiTBnI9vsotV6qtjcQI1Kwgij530JvdiJ99cTux8H3xYBdo7wbJkpVyqVpS
	 OVFHJ+2uwkQ0Z1z7+GpMSKqQYeIiSE4rn7M55cEqfQXaNCg/burHBTw38XrBX9Kymk
	 FYOMUvFsz7QGgSix7ETQL9q1bOD3ckqrcv0C18yMdZ8NONlkzx6IBDTyA0l16RFDHZ
	 gRMVJBQUCymMCQKqw2NKlNWDMT3OrZaO6bOKepfBby9SKDCptYXl5Xa9GVNQL3s9HZ
	 mUovZ1uAF6LP3NxZ0oWShfAfqaLYvBN9hhVp4R3RNeRDO8wLv6vE10GR6OP7PBSIxJ
	 2/PrQs3p2nZmw==
Date: Tue, 5 Mar 2024 15:23:01 +0000
From: Simon Horman <horms@kernel.org>
To: Lena Wang =?utf-8?B?KOeOi+WonCk=?= <Lena.Wang@mediatek.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	Shiming Cheng =?utf-8?B?KOaIkOivl+aYjik=?= <Shiming.Cheng@mediatek.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net v4] ipv6: fib6_rules: flush route cache when rule is
 changed
Message-ID: <20240305152301.GN2357@kernel.org>
References: <09f2ab1b7946339da5092e10aa216e07c579c60b.camel@mediatek.com>
 <20240304204511.2026a56b@kernel.org>
 <d0621b969918ef41412b26d7e9a4918aaf4023d4.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0621b969918ef41412b26d7e9a4918aaf4023d4.camel@mediatek.com>

On Tue, Mar 05, 2024 at 01:01:24PM +0000, Lena Wang (王娜) wrote:
> On Mon, 2024-03-04 at 20:45 -0800, Jakub Kicinski wrote:
> >  	 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Fri, 1 Mar 2024 14:39:46 +0000 Lena Wang (王娜) wrote:
> > > From: Shiming Cheng <shiming.cheng@mediatek.com>
> > > 
> > > When rule policy is changed, ipv6 socket cache is not refreshed.
> > > The sock's skb still uses a outdated route cache and was sent to
> > > a wrong interface.
> > > 
> > > To avoid this error we should update fib node's version when
> > > rule is changed. Then skb's route will be reroute checked as
> > > route cache version is already different with fib node version.
> > > The route cache is refreshed to match the latest rule.
> > 
> > Doesn't apply, please rebase on top of latest net/main.
> Hi Jakub,
> I use master branch to make this patch. And it seems same with
> main branch of kernel/git/netdev/net.git.
> 
> Could you tell me which branch should be used?
> 
> Thanks
> Lena

Hi Lena,

The primary branch is main these days.
If you are using master than it may well be stale.

For reference, the current HEAD commit is.

4daa873133d3 ("Merge tag 'mlx5-fixes-2024-03-01' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux")

