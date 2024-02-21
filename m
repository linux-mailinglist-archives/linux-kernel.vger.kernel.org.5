Return-Path: <linux-kernel+bounces-73891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905BC85CD33
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0BA71C220E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6743D65;
	Wed, 21 Feb 2024 01:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BlOuE203"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0F117D5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708477323; cv=none; b=VBnel3L8nEQfWuOpuGBKcPl6ZKjWXl0U+HZd6eJwd2MjLevTTJIcjKu8A5/TCjPCZ4+8qXp/CGx2uKqOQyG1EAZv7egx9t14UH67T1p/RUDHh7ZJCRBcmRlBstXNui7cO5hama1zLHSddIPhfT5dN/YJrCpiHDfwpuSBBpO8fYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708477323; c=relaxed/simple;
	bh=q0d1zg0VgA1XWsqbYGQzwBgECXRcH49a2hn1QrncaLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BY0frpLSTzE/uTqAXp3inNoS+VIhmuklobfwrhsetQLGQnjvHXAjMXoF9ZHjUOdhLj7Dm8OeiC9cQvg1NMqzDGqurpOPJ0sNZXoNlaHXu3YKUI7ZjUMZrkBTX+kFjwWU2sPsK3p3vQKCmNcr458Bf5MsGMjLhOtDVbqiusGAAVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BlOuE203; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Feb 2024 20:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708477318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVSQ1AUX97J8Bh4kyQx7tym/UpGwt+ikMSltFXfe7fU=;
	b=BlOuE203eXmrOVV+1v3BlJ1b57CDxMrfn4G0V8MRHEVPNmtOst34uGjS8LqJAuNUT6CUPY
	ChaOBmlSkHL2e35TYVP5XelwCd9n/UfoM5EGhR3f3oTfdvzmTjE5Bf/NZJ17j9xycGTyLc
	eLzhlm7iTF1UJZYYyCp946TdV+xZhBg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	Christian Brauner <christian@brauner.io>, Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [LSF TOPIC] beyond uidmapping, & towards a better security model
Message-ID: <mmhcgt6axn2kabwwu7n25v3s7yomcnynbrbaith7ecjhxtt6f6@mwjnpt4lzyzr>
References: <tixdzlcmitz2kvyamswcpnydeypunkify5aifsmfihpecvat7d@pmgcepiilpi6>
 <141b4c7ecda2a8c064586d064b8d1476d8de3617.camel@HansenPartnership.com>
 <qlmv2hjwzgnkmtvjpyn6zdnnmja3a35tx4nh6ldl23tkzh5reb@r3dseusgs3x6>
 <CA+enf=tZx9U8P13jC0z0s4Nt6oJduXRGr3_tUOZvjrkt82n3eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+enf=tZx9U8P13jC0z0s4Nt6oJduXRGr3_tUOZvjrkt82n3eg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 20, 2024 at 07:56:32PM -0500, Stéphane Graber wrote:
> Hey there,
> 
> Sorry, I don't have the time to go through all the details in this
> post to provide an adequate response, I'm adding Aleksandr who may be
> able to provide more details on what we've been up to (what James
> alluded to).
> 
> Our proposal is effectively bumping the in-kernel kuid_t/kgid_t from
> uint32 to uint64, which allows for individual user namespaces to get a
> full usable uint32 uid/gid range in the kernel. Obviously any kind of
> data persistence needs some mapping (VFS idmap) and there are a bunch
> of other corner cases as to how this is all exposed to userspace.
> 
> The idea around this stuff started back at Plumbers / Kernel summit
> all the way back in 2019 with a bit of refinement on the idea on and
> off ever since.
> We now have a functional patchset and example userspace code at:
>  - https://github.com/mihalicyn/isolated-userns
>  - https://github.com/mihalicyn/linux/commits/isolated_userns
> 
> If you don't mind watching a video, we have a reasonably detailed talk
> on the topic as well as demo and useful audience questions and
> feedback from FOSDEM here: https://www.youtube.com/watch?v=mOLzSzpVwHU
> 
> After talking about this with folks at a number of LPC / kernel summit
> / FOSDEM by this point, our next step is going to be an RFC patchset,
> I think at this point we just want the cgroupfs issue sorted out
> before sending that out.
> 
> I'll try to set some time to go through your full e-mail later this
> week if Alex doesn't get to it first!

Looking forward to it!

