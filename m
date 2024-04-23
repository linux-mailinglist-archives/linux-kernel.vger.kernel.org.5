Return-Path: <linux-kernel+bounces-154767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB1D8AE0B9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52BB1C21C7D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E8B77F13;
	Tue, 23 Apr 2024 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRlUWBb5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF587441E;
	Tue, 23 Apr 2024 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713863321; cv=none; b=FcG5Cj7jlSDhH40SVE/EAoND9aplRctY1zV47S6OWvomHKYpNkpelU1SWWWX59obtrwjCOH3kFzCjVofnncbj/kh5RnQZ1iTm82V1v/krghU2pVSGpOFhHFuZ+qwh1Rz41zZYyXmh2/4PynKPrUeKy20/GdcZkje2pWQ4AhdrKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713863321; c=relaxed/simple;
	bh=15a83D1JMHWclRfM/z678s+f7sq6QGUXYdBCaTmBd8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0uvwokBtJJIobXxoK9BxA2ZO8ZcZAY85WMcD4uMvJt46IKMtTLSw0tNNcteJ9hNvjDTHqjcQyqM43/WOvR96WVukR2plCYqVA77Y6r+qeUcFuhn6emSLDL49CczpMWWBB36OCkHywXFu0Eh190bEWfidPy7mv3FOnoDfmSrQ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRlUWBb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C034EC116B1;
	Tue, 23 Apr 2024 09:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713863320;
	bh=15a83D1JMHWclRfM/z678s+f7sq6QGUXYdBCaTmBd8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iRlUWBb50EHmT13m11xXOZt/qv+NF9r1gZSuMiRTkn2aq0AHwO10LHACFR8qUt2Gb
	 qR7BbU69LqMNVN/sycmEM+0/fIlf42BNqkHOmK5Sv7NAF32yDE0iN2I6HrvkYeAdFo
	 svkMcS3cRLaRAd8Gk0UhlxHEj6kTmlednqdmvcyTPOVH79WExHraiwOw4+eFPBL1Pq
	 lvVqIX2pc7QxhHBF96xVH5krgO3GR8BrWKYhgAE/YEKyhM7RxqWXSlLQosDm8eNmYx
	 arbMgT9xseU4Sw2zu4pU1atN6SHAytlMKr2XEYXpzOCMCpLqTD0beQsWERnPx7Sg4a
	 CWhSk32WtHqdQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rzC8j-000000003Lp-1TNJ;
	Tue, 23 Apr 2024 11:08:38 +0200
Date: Tue, 23 Apr 2024 11:08:37 +0200
From: Johan Hovold <johan@kernel.org>
To: Doug Anderson <dianders@chromium.org>,
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] Bluetooth: qca: fix invalid device address check
Message-ID: <Zid6lfQMlDp3HQ67@hovoldconsulting.com>
References: <20240416091509.19995-1-johan+linaro@kernel.org>
 <CAD=FV=UBHvz2S5bd8eso030-E=rhbAypz_BnO-vmB1vNo+4Uvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UBHvz2S5bd8eso030-E=rhbAypz_BnO-vmB1vNo+4Uvw@mail.gmail.com>

Hi Doug and Janaki,

On Mon, Apr 22, 2024 at 10:50:33AM -0700, Doug Anderson wrote:
> On Tue, Apr 16, 2024 at 2:17 AM Johan Hovold <johan+linaro@kernel.org> wrote:

> > As Chromium is the only known user of the 'local-bd-address' property,
> > could you please confirm that your controllers use the 00:00:00:00:5a:ad
> > address by default so that the quirk continues to be set as intended?
> 
> I was at EOSS last week so didn't get a chance to test this, but I
> just tested it now and I can confirm that it breaks trogdor. It
> appears that trogdor devices seem to have a variant of your "default"
> address. Instead of:
> 
> 00:00:00:00:5a:ad
> 
> We seem to have a default of this:
> 
> 39:98:00:00:5a:ad
> 
> ...so almost the same, but not enough the same to make it work with
> your code. I checked 3 different trogdor boards and they were all the
> same, though I can't 100% commit to saying that every trogdor device
> out there has that same default address...
> 
> Given that this breaks devices and also that it's already landed and
> tagged for stable, what's the plan here? Do we revert? Do we add the
> second address in and hope that there aren't trogdor devices out in
> the wild that somehow have a different default?

This patch is currently queued for 6.10 so there should be time to get
this sorted.

My fallback plan was to add further (device-specific) default addresses
in case this turned out to be needed (e.g. this is what the Broadcom
driver does).

I assume all Trogdor boards use the same controller, WCN3991 IIUC, but
if you're worried about there being devices out there using a different
address we could possibly also use the new
"qcom,local-bd-address-broken" DT property as an indicator to set the
bdaddr quirk.

We have Qualcomm on CC here so perhaps Janaki, who should have access to
the documentation, can tell us what the default address on these older
controllers looks like?

Janaki, are there further default addresses out there that we need to
consider?

Perhaps "39:98" can even be inferred from the hardware id somehow (cf.
bcm4377_is_valid_bdaddr())?

Doug, could you please also post the QCA version info for Trogdor that's
printed on boot?

Johan

