Return-Path: <linux-kernel+bounces-43450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC27841403
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B2F28953F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A220676051;
	Mon, 29 Jan 2024 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kf+NJgmf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A389676023;
	Mon, 29 Jan 2024 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558744; cv=none; b=Uh4i1u1NVF5N3xrSIujXfTw1gKqGWGh6AyeGBqt2JvsY9w3OdfAVU7eeL/M1NXDdsb/tlC20f1Re1KRbkLsj6IvJtctM6ZYshFkKlbjL9EkyzMPjuUsazzu9pFkTlCkaOjz+y9I89zhsPTuk0Wj1hzO5sCis+qW5RqV+q97v6ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558744; c=relaxed/simple;
	bh=8m6RSucF6xsOWibtMoJwrvmBk6giWU4417H7w22bFAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kClenbQBROAVc6PwORgtlghjCsXv7f3EsoXm1+6unjFge2fd8StlOywBsh5u7XWhmsRiWEGDNHWqGGv+qnbfL0Rp5JXVmp8G0y9fJ35jP+RO/4A7RfotFI40LyoepGNP2bebkfTwtWaaKxv0yfLV7prhtd7vN+St198N06hkz+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kf+NJgmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4838C433F1;
	Mon, 29 Jan 2024 20:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706558744;
	bh=8m6RSucF6xsOWibtMoJwrvmBk6giWU4417H7w22bFAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kf+NJgmfA2IUhtAFmzQ5aRjWp9TThBFC1IfHNcFCrxx3tHn2M4JVJW5e7P8cqZ5hh
	 fRPG2Ud+zZ5P3C3dFF1W/Jdc1uSfUHemz3bOq8BXuScxO7bDu6+s4zsrJRfn/Cbx1v
	 fSOM2vo/hq/6EhdhcF1TIOfjHz6yxpJaIbCLjm1ZFkN2G2hekMi5+Jo6MD1XpQJ+iT
	 sY42LngM5u+y64wLUvleEw2wGKMp4Xv0Qojhl57A4zI7AGox8FCGWtF6XJIqbILAQ1
	 +R8Oa42YlAUKTI1zQjXUZ7EnF5lHObEzFqBBGsN7vybJO8HzgGgh3utXSiNFOWI3SM
	 WYd4m6LrU4rHw==
Date: Mon, 29 Jan 2024 12:05:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Brett Creeley <bcreeley@amd.com>
Cc: Brett Creeley <brett.creeley@amd.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, shannon.nelson@amd.com
Subject: Re: [PATCH v2 net-next 0/10] pds_core: Various improvements and AQ
 race condition cleanup
Message-ID: <20240129120542.39757c00@kernel.org>
In-Reply-To: <7da8652f-a466-4b38-8d0b-6494e9901a98@amd.com>
References: <20240126174255.17052-1-brett.creeley@amd.com>
	<20240126204423.47c20ef6@kernel.org>
	<7da8652f-a466-4b38-8d0b-6494e9901a98@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 09:27:21 -0800 Brett Creeley wrote:
> > On Fri, 26 Jan 2024 09:42:45 -0800 Brett Creeley wrote:  
> >> This series includes the following changes:
> >>
> >> There can be many users of the pds_core's adminq. This includes
> >> pds_core's uses and any clients that depend on it. When the pds_core
> >> device goes through a reset for any reason the adminq is freed
> >> and reconfigured. There are some gaps in the current implementation
> >> that will cause crashes during reset if any of the previously mentioned
> >> users of the adminq attempt to use it after it's been freed.
> >>
> >> Issues around how resets are handled, specifically regarding the driver's
> >> error handlers.  
> > 
> > Patches 1, 2 and 4 look like fixes. Is there any reason these are
> > targeting net-next? If someone deploys this device at scale rare
> > things will happen a lot..  
> 
> No reason, just an oversight on my part. I actually think patches 1, 2, 
> 3, 4, 5, and 9 could all go to net. Unfortunately some of these patches 
> are intertwined (i.e. patch 10 depends on patch 9).
> 
> If I push the previously mentioned patches to net and they get accepted, 
> how soon are fixes typically added to the net-next tree so I can 
> rebase/re-push the remaining patches?

net gets merged into net-next very Thursday, exact timing depends on how
quickly Linus pulls from us.

