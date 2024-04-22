Return-Path: <linux-kernel+bounces-153476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BFE8ACE8C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322AC1C20C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8D6150980;
	Mon, 22 Apr 2024 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzV3Dz61"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629AA5028B;
	Mon, 22 Apr 2024 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793416; cv=none; b=S608nk5fDhLTvMJqO1sSZTkuxPoJrbQErFofNLMBKtKKwJI1R+iPk5WhgZSlNvAn4StjdK5lB89+0rCeNSeVjj/vgkrf1YydTJ5XpBmaprX3aPD5Ib5irCERkSkouwKkF91XJeP9PFVK1ePXi6oWcHEuJmVkjh75AbtYoItCDfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793416; c=relaxed/simple;
	bh=iyUYTV5ltJ3rODQwoPpNba45yscFs+Ul9nWQU6yjDfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvCK0Dxyx1Me/id5te290Hx3zO3NyirCa+dNAlu2BccdH7Gw4LzkboNfUXHf1zbd/M+kf55nYht7lzqecoi9oIevExpYu23Uvd0ojqHw+LxPht0gyLyJ/CnkGVsGfXAt6VQ2U1ubct90z+rZzFvtGiIkP9uEjC0sL6X99CfTrV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzV3Dz61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9046C113CC;
	Mon, 22 Apr 2024 13:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713793415;
	bh=iyUYTV5ltJ3rODQwoPpNba45yscFs+Ul9nWQU6yjDfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fzV3Dz61yBDv+hpyv23l2av+nrBuoT/+wcwF6Okuiyt584leQaLRNvqUg/uOtTqGN
	 j4q1xECwuU+4lK9iEpRlo3epfwTkarXtWvkGA4zK95xq7WOPcRZ0KgTkWw3KVnLw/b
	 9MzfFWqyFyW8kUdwRZDBU0WNnQuzLNBzwbLOPiNHzok2oWwl5ynyNLKl3PLsAx0/bJ
	 5EC7vN/8U2hoxVCSwjO42ACCKpu/xK6ZCRxhI/TcrovToUGRDU+SEqFxSjJKGydc5+
	 iBe3TbIBYjxlE7UjH6budWKE9zVFhdz5/BqX0s/V8IoIZG/HPgK8AKBYIBA2IVKITI
	 a19zyfMtirOKA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rytxD-000000005jw-1Bm1;
	Mon, 22 Apr 2024 15:43:31 +0200
Date: Mon, 22 Apr 2024 15:43:31 +0200
From: Johan Hovold <johan@kernel.org>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Zhengping Jiang <jiangzp@google.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Bluetooth: qca: fix NULL-deref on non-serdev setup
Message-ID: <ZiZpg4lyp-LcpV8l@hovoldconsulting.com>
References: <20240319154611.2492-1-johan+linaro@kernel.org>
 <ZiZdag8fw8H1haCb@hovoldconsulting.com>
 <438844e9-47e8-486e-9611-ae524d6974b3@quicinc.com>
 <ZiZkK4BAoqxNg7yG@hovoldconsulting.com>
 <472b9f60-d68e-47ee-9ca9-f71a9ba86a1a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472b9f60-d68e-47ee-9ca9-f71a9ba86a1a@quicinc.com>

On Mon, Apr 22, 2024 at 09:30:28PM +0800, quic_zijuhu wrote:
> On 4/22/2024 9:20 PM, Johan Hovold wrote:
> > On Mon, Apr 22, 2024 at 09:04:58PM +0800, quic_zijuhu wrote:
> >> On 4/22/2024 8:51 PM, Johan Hovold wrote:
> >>> On Tue, Mar 19, 2024 at 04:46:09PM +0100, Johan Hovold wrote:
> > 
> >>>> Johan Hovold (2):
> >>>>   Bluetooth: qca: fix NULL-deref on non-serdev suspend
> >>>>   Bluetooth: qca: fix NULL-deref on non-serdev setup
> >>>
> >>> Could you pick these up for 6.9 or 6.10?
> >>>
> >>> The patches are marked for stable backport and only privileged users can
> >>> set the N_HCI line discipline these days (even if I'm not sure about
> >>> pre-5.14 kernels...) so it may be fine to wait for 6.10 if you prefer.
> > 
> >> could you share the patch links for me to review. i can
> >> 't find them now
> > 
> > Sure, but you should bookmark lore.kernel.org in your browser as you can
> > search the archives there yourself:
> > 
> > 	https://lore.kernel.org/lkml/20240319154611.2492-1-johan+linaro@kernel.org/

> NAK for your [PATCH 1/2] since the null checking is redundant with your
> [PATCH 2/2].

I explained in the cover letter why it is split up like this. If you
don't bother reading, then we will not bother listening to you.

> NAK for your [PATCH 2/2], since it is same with my earlier fix
> https://lore.kernel.org/all/1704960978-5437-1-git-send-email-quic_zijuhu@quicinc.com/
> my new patchset for btattach tool still has this change.

The fix does not depend on your btattach series, which has also been
rejected.

You clearly have some learning to do on how to interact with the kernel
community and to write proper commit messages and patches. If you start
listening to feedback and try not to piss everyone off perhaps you can
even get your patches merged one day. [1][2]

Johan

[1] https://lore.kernel.org/linux-bluetooth/fbe5722b-1e45-4ccb-a050-20a473a823c8@quicinc.com/T/#m8e495666a71eb0e7ae54c82554dfff1fc96983e7
[2] https://lore.kernel.org/linux-bluetooth/1713563327-19694-1-git-send-email-quic_zijuhu@quicinc.com/T/#med0610646a8fd8b3c8586abca9895b124b2d2534

