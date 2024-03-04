Return-Path: <linux-kernel+bounces-90296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F5986FD09
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983401C2251E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF41724B52;
	Mon,  4 Mar 2024 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NenlFay1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9D72C840;
	Mon,  4 Mar 2024 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543890; cv=none; b=skcJo4YL/R1QVzgEx+RAdYzDP0Qk4ZVUJagCGEVvCDPYDfauHLZ8mV2j5XynV9+vVPVFkr9FFKNG/yZZWtiHHiXf4dJBMS0HWhfRdds3ndtTO2FJVw5ts/6ojjOuWUDxGCpVcOriqKpr3/IbCspMi/w1BFUPuyfefFGYUKFl4X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543890; c=relaxed/simple;
	bh=2NE8g2addB4JbRzGr5d4FEp+f0iHBWz+jrXCpfZtwJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0FxgjCGnlFgbTG9jcAZceqfS0zVnyzXJpnD+Z2GZSrLkDtBbVId0rQohZkvEEG46JkZoCdpuehEB81/8qqyVI2ch3N/YjXK86Fot6DUEEvoQCHdN1DHq23xrLeV9vfzqk4ZvdT0kSC7IKFECeeWSSArk3D0CxeFcvQqcL+g3XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NenlFay1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C45EC433C7;
	Mon,  4 Mar 2024 09:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709543890;
	bh=2NE8g2addB4JbRzGr5d4FEp+f0iHBWz+jrXCpfZtwJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NenlFay1MbxbJPHgLYvsg7O47VtPF6kw4AwX5TmQ7vPryNVNrM6qgfGylZQ5wUm1N
	 p6sfyIKOmo039RTOvDQ7vXCjHVZkkNTOwRN0IVYd9X8CZVdLe6OOECVH/S8AwKn01p
	 1QELIvxo01dt4xoBTs2omBSR0DifRalsLaieDKNzL6PgG7oTGY6kOJp3zcnOXtztdp
	 3G3WLpDN6MyeWctiEL+6cKCCasoJIkcCpizPNjcn0QeqlVO3pT5wGVQkUWNGrY8ZcG
	 d9fbzWOe/pmdiPBGVZDSHR3cyHkM+PRx1KD5IzzETy1OFnDP0pAMvQPDxZGp1YrZK8
	 XsizSg3llGdsw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rh4Sf-000000006L4-3Ei2;
	Mon, 04 Mar 2024 10:18:17 +0100
Date: Mon, 4 Mar 2024 10:18:17 +0100
From: Johan Hovold <johan@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] usb: ehci-exynos: Use devm_clk_get_enabled()
 helpers
Message-ID: <ZeWR2VByrV1xWmYN@hovoldconsulting.com>
References: <20240301193831.3346-1-linux.amoon@gmail.com>
 <20240301193831.3346-2-linux.amoon@gmail.com>
 <3d1c7682-d163-4bcf-bd41-d7db0c8f61d1@wanadoo.fr>
 <CANAwSgR0aQ7nt1y5xknvVjHSnfvTaC8JZMLWurb8z2D0Oxg6Rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAwSgR0aQ7nt1y5xknvVjHSnfvTaC8JZMLWurb8z2D0Oxg6Rw@mail.gmail.com>

On Sat, Mar 02, 2024 at 10:05:46PM +0530, Anand Moon wrote:
> On Sat, 2 Mar 2024 at 21:19, Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
> > Le 01/03/2024 à 20:38, Anand Moon a écrit :

> > > The devm_clk_get_enabled() helpers:
> > >      - call devm_clk_get()
> > >      - call clk_prepare_enable() and register what is needed in order to
> > >       call clk_disable_unprepare() when needed, as a managed resource.
> > >
> > > This simplifies the code and avoids the calls to clk_disable_unprepare().
> > >
> > > While at it, use dev_err_probe consistently, and use its return value
> > > to return the error code.

> > > @@ -260,25 +248,17 @@ static int exynos_ehci_suspend(struct device *dev)
> > >
> > >       exynos_ehci_phy_disable(dev);
> > >
> > > -     clk_disable_unprepare(exynos_ehci->clk);

> > I don't think that removing clk_[en|dis]abble from the suspend and
> > resume function is correct.
> >
> > The goal is to stop some hardware when the system is suspended, in order
> > to save some power.
> Yes correct,
> >
> > Why did you removed it?

> devm_clk_get_enabled  function register callback for clk_prepare_enable
> and clk_disable_unprepare, so when the clock resource is not used it should get
> disabled.
> 
> [0] https://elixir.bootlin.com/linux/latest/source/drivers/clk/clk-devres.c#L75
> 
> I have also tested with rtc suspend & resume and did not find any issue.

You seem to be totally confused about how devres works, and arguing back
after Christophe points this out to you instead of going back and doing
the homework you should have done before posting these patches is really
not OK (e.g. as you're wasting other people's time).

And you clearly did not test these patches enough to confirm that you
didn't break the driver.

Johan

