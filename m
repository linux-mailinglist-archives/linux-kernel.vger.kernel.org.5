Return-Path: <linux-kernel+bounces-42540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DDC8402CF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F312845A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFD056B94;
	Mon, 29 Jan 2024 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mm5o0S5Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7215674F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524329; cv=none; b=WauB7OyzDPHl1Dtam3fsVp0LbtIlMUmtlMiZ1WscCIi7LC0cLduOXTtR+H50X39K70oYK6HlxXdajd45CBVE5LuznQttMoM3ZhRk7yNCNzl/lu5bXxkZCeBAOaEI8BvCBtxcnVHKOH6EgGdscLUwVC8onBIzMdUD6qnPb6c6470=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524329; c=relaxed/simple;
	bh=7fLEgPW31efWOOXOHma0dNe+BBLJztyy7yEteG0nros=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XCCAQ+S3d3pdeXodcQ8usv5Tl1wIgMQaV0+tisoQAzu8JOkJNjhHDEuZ6Lw2C4kNcPREKIMhX65fGYUoN1i2oDdwYE10v5FxcF66Kmg9dp4qc5SDhs30bxpORhKYYOYxOAdznva1fLBUInTCQCw4yLpwQ6KdwRZ44q8Gt8yYxrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mm5o0S5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4E2C433F1;
	Mon, 29 Jan 2024 10:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706524329;
	bh=7fLEgPW31efWOOXOHma0dNe+BBLJztyy7yEteG0nros=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mm5o0S5ZjktyVsqkONkDIeBoOE29IMeCZNdeSjs4574n4ib8eL1hipCuQDWlEnAVv
	 jvy0c0gJb2sXupexgcdbCsSAvYHcGhCZnhKVoSLA2ID+CmYSpN5llINhCH/+nsBJau
	 yj6spJCc7kbbTyudkydqCUA9CNKWuQkdyJeqYhtj4ur2iA38RJa8z8sIGZo3yhvyJA
	 /hp7vH3IdXSjEApdpGh6YmLvuVyxwBh4PAdUxZ0P7UqLcMGtKaSvBZG5IDC1WfeMpd
	 /zqkXVY+1uv/zTwm8BPwQpmH7JooG2G87xdH43szh3SRV4+zjeTdAwScAnUV0LHh85
	 VCHdHPpAIbRZQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Jan 2024 11:32:02 +0100
From: Michael Walle <mwalle@kernel.org>
To: Dave Airlie <airlied@gmail.com>
Cc: Inki Dae <daeinki@gmail.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Robert Foss <rfoss@kernel.org>, Frieder
 Schrempf <frieder.schrempf@kontron.de>, Jagan Teki
 <jagan@amarulasolutions.com>, Andrzej Hajda <andrzej.hajda@intel.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Tim Harvey
 <tharvey@gateworks.com>, Alexander Stein <alexander.stein@ew.tq-group.com>,
 linux-kernel@vger.kernel.org, DRI mailing list
 <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>, Michael
 Trimarchi <michael@amarulasolutions.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH] drm: bridge: samsung-dsim: Don't use FORCE_STOP_STATE
In-Reply-To: <CAPM=9tytMB9frxNeD08hu1qsusY=wEE3bJOFmUgA1rSpabwDpg@mail.gmail.com>
References: <20231113164344.1612602-1-mwalle@kernel.org>
 <631fe35a2a3b00781231e4f3f5094fae@kernel.org>
 <1ef3dad2-5f55-40e5-bba7-3c71d71c12e4@kontron.de>
 <CAAQKjZMccDwa63_PNJCP0rNOaHjTwcOz8AbKa=JXLQi-b0QVVw@mail.gmail.com>
 <2400535875c353ff7208be2d86d4556f@kernel.org>
 <ZZ1BBO2nNSp3g-gT@phenom.ffwll.local>
 <CAAQKjZNnJQDn_r1+WNmsxM-2O48O0+yWAUAqpjZRjMYMT3xGwg@mail.gmail.com>
 <CAPM=9tytMB9frxNeD08hu1qsusY=wEE3bJOFmUgA1rSpabwDpg@mail.gmail.com>
Message-ID: <b18d88302acfca001a6693d78909bc2a@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

> Just FYI this conflictted pretty heavily with drm-misc-next changes in
> the same area, someone should check drm-tip has the correct
> resolution, I'm not really sure what is definitely should be.

FWIW, this looks rather messy now. The drm-tip doesn't build.

There was a new call to samsung_dsim_set_stop_state() introduced
in commit b2fe2292624ac (drm: bridge: samsung-dsim: enter display
mode in the enable() callback).

Also merge commit 663a907e199b (Merge remote-tracking branch
'drm-misc/drm-misc-next' into drm-tip) is broken because it
completely removes samsung_dsim_atomic_disable(). Dunno whats
going on there.

I'm just about to look at getting it to compile again and
I'm trying to retest it.

-michael

