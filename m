Return-Path: <linux-kernel+bounces-117743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E28788AEFF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3504E28EF29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0D21BC2F;
	Mon, 25 Mar 2024 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jneoR6nW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CEEA50;
	Mon, 25 Mar 2024 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392269; cv=none; b=F6NB1cy0YVge6SLuU0z8iRX6dKQHYOV5H/Cbw6JS9LNc+1llrLTzoU7R+SItsZ6RIseFu316rUM9U/xXNWvu7YuojjlSlN/phrJEGiV1GFwT6obZy2elHA4j0Zz5SGKcU7srw8jjfcQi0VQPdWvQpoN9se193+Qmxdu+DlOIFPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392269; c=relaxed/simple;
	bh=KjVbKX/1JnTQ8KZWhFzZU8Xw/T8i1qrk1vDw7Qq3Mws=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=fZGYjc691XA+L7fcBj3/eU/FxqsrwgEhKrpcYUMi+xV+JeKfohti5a9bo7W8ivJ3JiBtb19cvndsfG0HzArQpn8kN990fbEH9S5rMEIoE3k1Lhf/SZmpo99zAfGBemYWejhekwfO7OhIdjLyzFqp/O3bCdll2+9AFULZ6NNmksg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jneoR6nW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2500C433C7;
	Mon, 25 Mar 2024 18:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711392268;
	bh=KjVbKX/1JnTQ8KZWhFzZU8Xw/T8i1qrk1vDw7Qq3Mws=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=jneoR6nWazV1lIQm6ihGRYD3oocADsEu2qxM9y0EsyA6kAnDvfMmppLBIJ1LUb3k7
	 jzjSgjfPyugq476VFyifljkzRf6k+VPh2BAzjmFyspcCZpnpHbFvmSOUKTejhaihg7
	 GVAUDewsHvnN6yK8s6HLnaC+EjMcWbj7CfQCVoSpv7IgcVp+BIASR+B0qfAzfVm1la
	 14glH/x0UdADmnN0I5TupdRs9O8PIWh8QnsPECNkzOdwE3S9Z4PTEgIA4blbWzlTbN
	 GDf6b1gV67xZZLAQKZFjSTh6GS93DERFuz9FdzjEW58X9FM2JNFI1PkYpO6SHSHSOR
	 jcTuCGIDJvCLA==
Message-ID: <6c8ed50511cbcbf07ef165d900c689e2.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240325184204.745706-1-sboyd@kernel.org>
References: <20240325184204.745706-1-sboyd@kernel.org>
Subject: Re: [PATCH v2 0/5] Fix a deadlock with clk_pm_runtime_get()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, linux-arm-msm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Krzysztof Kozlowski <krzk@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Taniya Das <quic_tdas@quicinc.com>, Ulf Hansson <ulf.hansson@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Mon, 25 Mar 2024 11:44:26 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-03-25 11:41:54)
> This patch series fixes a deadlock reported[1] on ChromeOS devices
> (Qualcomm sc7180 Trogdor). To get there, we allow __clk_release() to run
> without the prepare_lock held. Then we add runtime PM enabled clk_core
> structs to a list that we iterate and enable runtime PM for each entry
> before grabbing the prepare_lock to walk the clk tree. The details are
> in patch #4.
>=20
> The patch after that is based on the analysis in the disable unused
> patch. We similarly resume devices from runtime suspend when walking the
> clk tree for the debugfs clk_summary.
>=20
> Unfortunately this doesn't fix all problems with the usage of runtime PM
> in the clk framework. We still have a problem if preparing a clk happens
> in parallel to the device providing that clk runtime resuming or
> suspending. In that case, the task will go to sleep waiting for the
> runtime PM state to change, and we'll deadlock. This is primarily a
> problem with the global prepare_lock. I suspect we'll be able to fix
> this by implementing per-clk locking, because then we will be able to
> split up the big prepare_lock into smaller locks that don't deadlock on
> some device runtime PM transitions.
>=20
> I'll start working on that problem in earnest now because I'm worried
> we're going to run into that problem very soon.
>=20
> Changes from v1 (https://lore.kernel.org/r/):

Oops this is https://lore.kernel.org/r/20240325054403.592298-1-sboyd@kernel=
org

