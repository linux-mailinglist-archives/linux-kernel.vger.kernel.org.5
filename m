Return-Path: <linux-kernel+bounces-75363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCFD85E741
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1C0DB25595
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FEB85953;
	Wed, 21 Feb 2024 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AH0vUZLr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A783785951;
	Wed, 21 Feb 2024 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708543606; cv=none; b=rJxP2PmxuQyBku5bRtBqMwnvR8FhmCZLmvjW421kH0tqpAxFtfllh0+Br9I4cVHdA0o5cmFwU8TYs1xlKAbNsTK3JYfzb5J5VRk+jQgA18c6wgLFsuzDMgpbFdn+v6xjvfm1jmmsooSv51clc+/2WcRKMlzVRGGI3CDE3HdBgP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708543606; c=relaxed/simple;
	bh=Ndry+qHCQ603OHGHZTI/GVCt3W1oZYIYEDm1GUXWnNE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWY1Rjaj+SDsByxWznrIu/wCK/bRKwIJ8iErYrwp4OyuPRYeQARuMnQFiqFmlykQM8fPYuMq6Geie5Jo2r13Ehj1b/3mlACscf2F8qhtFerYwhZhf3C39RV/uiBx5I17FSEBKHQ8yFj6+nWP63XeMkUffCVMIQ8oKMVkmF6bRlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AH0vUZLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7A8C433C7;
	Wed, 21 Feb 2024 19:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708543606;
	bh=Ndry+qHCQ603OHGHZTI/GVCt3W1oZYIYEDm1GUXWnNE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AH0vUZLrHsVG4T0qMWIlNXzMjop/28Dty6Te4J2DnaOBNs1MeJYZayf6JYT8X+0vk
	 drfSYeJVTubWIMj+feMOa82Vmy60V+ZWRkZTWsX8g2uotfRB+C+3jxUr3C6l3Z4ESg
	 wvLQ++/1vLT2P1g/Rn1d5Wpn+pzmpLED77fTwkpZIPD7U42res2uEoPk0dFfbF1CrO
	 1ULMuRRuaCFmjo7e7HMtGTIAE1pMJQA9ano9Iwwrj6HPd8OegOQOyU3/f6M0fuWD0+
	 PesrC7TtfSd0hb2SWmF8T6sy4KUjedt/fe+IBoSFyelZMDZ6RKOIAOOCSNGt/9xUbA
	 zOl501ZBlVcag==
Date: Wed, 21 Feb 2024 11:26:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Alexei Starovoitov
 <ast@kernel.org>, Amritha Nambiar <amritha.nambiar@intel.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Larysa Zaremba
 <larysa.zaremba@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Paolo Abeni <pabeni@redhat.com>, Sridhar
 Samudrala <sridhar.samudrala@intel.com>, Stanislav Fomichev
 <sdf@google.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next 0/2] Expose netdev name in netdev netlink APIs
Message-ID: <20240221112644.3d8c4c5a@kernel.org>
In-Reply-To: <20240221192122.GB68788@fastly.com>
References: <1708531057-67392-1-git-send-email-jdamato@fastly.com>
	<20240221110952.43c0ae6e@kernel.org>
	<20240221192122.GB68788@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 11:21:23 -0800 Joe Damato wrote:
> > For context, the reason why I left the names out is that they can change
> > at any moment, but primarily because there are also altnames now:
> > 
> > 2: eth0:
> > [...]
> >     altname enp2s0np0
> > 
> > Most of the APIs try to accept altnames as well as the "main" name.
> > If we propagate the name we'll step back into the rtnetlink naming
> > mess :(  
> 
> OK, I see. I didn't realize this was a thing. I suppose what you are saying
> is that we wouldn't want to expose names at all and stick with ifindexes
> only, is that right?

If you think it's a major usability improvement I can be convinced,
but yes, leaving the names out initially was indeed intentional.

