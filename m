Return-Path: <linux-kernel+bounces-117549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F5C88AC7A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D51301F66
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABDC13AA40;
	Mon, 25 Mar 2024 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miCwdgNM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF671369AD;
	Mon, 25 Mar 2024 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386558; cv=none; b=P0/i4TInUxHvPkJGL+0MRsGA5jLfZQOIVqZKT71mO/DPvMpLh+FQGYlEJXgbbLGMq+rerLC10kwiPnSiiv4xlQhrtneUo7DhF9kyqYUXFPXQJzbIo3KwF0hKKT42Dz3a4XAlInL9vqArKAIHO1r9XYJ16J1eDnORLds0OO9saBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386558; c=relaxed/simple;
	bh=FnwDoVmLdF/Lh4NDHXU1Feju53Qbi/Ir8xxAWKoRJoQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=TFcr2ccophhJBi2vjM0/QCKPYHha+YeAPL+OA+2VzVI6Y/UMQH7KrhafoflInshU1VL+rBkB4v1p488vwEhic9kWb0wCg/26rr7BFyFLGnIsycBbJzRH9J0a+0zPQ43NkMBTdyEcjij5JrTmzlQjnK7/CB0kPP7ffL99Y16H8do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miCwdgNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9A7C433F1;
	Mon, 25 Mar 2024 17:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711386557;
	bh=FnwDoVmLdF/Lh4NDHXU1Feju53Qbi/Ir8xxAWKoRJoQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=miCwdgNMjir8pTrrial6fzzMWlyw0NCEIvQ2u+Y7kQeK+1kjfIQX4ADsdaKbTEF/C
	 bwj09DvVp9bC1TVyUvFE3dN7dQrcLOKT4KxYh4+m73bvHY80leTDEhRX/SIZQhekDy
	 PK+u24aLnkSeZrDLk0kM2gDsJyn3/lgsAa7/5lH3+MpAXE54qqIDK8Fst3UKQTBCDw
	 256RRuQwPmNgGs+iMxmti0XR9TPRZpKbP3VqbVLngrC9T3mpHjRRC1OPA6XOTrUuQV
	 OzUd/guIOg35Iwut2zQx/hawIsPfdsolRQncDUsYGfxNncwSjDm7jJ/0PRKIIV4uBw
	 a5z2nYUa0vrkw==
Message-ID: <9d0adc0b44b1f119ea6c65dd5c296b7b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=X13_5Kubq3A=y8gnz==6tt2bsfc0PiFAj06HX9V7_+mg@mail.gmail.com>
References: <20240325054403.592298-1-sboyd@kernel.org> <20240325054403.592298-6-sboyd@kernel.org> <CAD=FV=X13_5Kubq3A=y8gnz==6tt2bsfc0PiFAj06HX9V7_+mg@mail.gmail.com>
Subject: Re: [PATCH 5/5] clk: Get runtime PM before walking tree for clk_summary
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, linux-arm-msm@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>
To: Doug Anderson <dianders@chromium.org>
Date: Mon, 25 Mar 2024 10:09:15 -0700
User-Agent: alot/0.10

Quoting Doug Anderson (2024-03-25 09:19:51)
> Hi,
>=20
> On Sun, Mar 24, 2024 at 10:44=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> =
wrote:
> >
> > Similar to the previous commit, we should make sure that all devices are
> > runtime resumed before printing the clk_summary through debugfs. Failure
> > to do so would result in a deadlock if the thread is resuming a device
> > to print clk state and that device is also runtime resuming in another
> > thread, e.g the screen is turning on and the display driver is starting
> > up.
> >
> > Fixes: 1bb294a7981c ("clk: Enable/Disable runtime PM for clk_summary")
> > Cc: Taniya Das <quic_tdas@quicinc.com>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  drivers/clk/clk.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> Shouldn't this also squash in a revert of commit 1bb294a7981c ("clk:
> Enable/Disable runtime PM for clk_summary")? As it is,
> clk_summary_show_subtree() is left with an extra/unnecessary
> clk_pm_runtime_get() / clk_pm_runtime_put(), right?

Sure, it is superfluous now. I suppose it means we can remove
clk_pm_runtime_get()/put() calls in
clk_{disable,unprepare}_unused_subtree() as well.

>=20
> Other than that, this looks good to me:
>=20
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

