Return-Path: <linux-kernel+bounces-13140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF35382003F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CAAA1C22553
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F137125A5;
	Fri, 29 Dec 2023 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhIcz4qU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BC0125AD;
	Fri, 29 Dec 2023 15:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBD4C433C8;
	Fri, 29 Dec 2023 15:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703863802;
	bh=rrRRym+4B4/ohQWp8hfDWnDdsCoZaLrAne2Eup3YzEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qhIcz4qUO22X6OPMTIQfrlr2Rps8fsxwxyhzPG/Dy1xiVaP7+vSb2GZnYdB6Prea0
	 gLM//hbU1L9cx5kys2LRlGA3TLmz5O7rAYZDoTibfTQT5heoPmijRG5HFffzeamBSz
	 uxa3Ao13IaCBS99AMaZfprby3kcNSPLAmljdSj8hErHqmCaQ69kv5XM7vZUi8UZriE
	 vOCcSPAEs/563+z0mLn2ez7nb31IKo1c4kjQtIUwZ6ZxL6yWgm30LVT6fheVl67Mfk
	 DrwqztIDisvjQ1B0koJRwr4bq7tDJxwiPrHFtIK5mSuDao7qPEQupg+A38ABvo32A9
	 NJYE9SKCmtmtQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rJEo7-0005gI-0h;
	Fri, 29 Dec 2023 16:29:55 +0100
Date: Fri, 29 Dec 2023 16:29:55 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Vinod Koul <vkoul@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: qcom: Reshuffle reset logic in 2_7_0 .init
Message-ID: <ZY7l828-mSGXVwrk@hovoldconsulting.com>
References: <20231227-topic-8280_pcie-v1-0-095491baf9e4@linaro.org>
 <20231227-topic-8280_pcie-v1-1-095491baf9e4@linaro.org>
 <ZY7R581pgn3uO6kk@hovoldconsulting.com>
 <fa0fbadc-a7c3-4bea-bed7-0006db0616dc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa0fbadc-a7c3-4bea-bed7-0006db0616dc@linaro.org>

[ Again, please remember to add a newline before you inline comments to
make you replies readable. ]

On Fri, Dec 29, 2023 at 04:01:27PM +0100, Konrad Dybcio wrote:
> On 29.12.2023 15:04, Johan Hovold wrote:
> > On Wed, Dec 27, 2023 at 11:17:19PM +0100, Konrad Dybcio wrote:
> >> At least on SC8280XP, if the PCIe reset is asserted, the corresponding
> >> AUX_CLK will be stuck at 'off'.
> > 
> > No, this path is exercised on every boot without the aux clock ever
> > being stuck at off. So something is clearly missing in this description.

> That's likely because the hardware has been initialized and not cleanly
> shut down by your bootloader. When you reset it, or your bootloader
> wasn't so kind, you need to start initialization from scratch.

What does that even mean? I'm telling you that this reset is asserted on
each boot, on all sc8280xp platforms I have access to, and never have I
seen the aux clk stuck at off.

So clearly your claim above is too broad and the commit message is
incorrect or incomplete.
 
> >> Assert the reset (which may end up being a NOP if it was previously
> >> asserted) and de-assert it back *before* turning on the clocks to avoid
> >> such cases.
> >>
> >> In addition to that, in case the clock bulk enable fails, assert the
> >> RC reset back, as the hardware is in an unknown state at best.
> > 
> > This is arguably a separate change, and not necessarily one that is
> > correct either

> If the clock enable fails, the PCIe hw is not in reset state, ergo it
> may be doing "something", and that "something" would eat non-zero power.
> It's just cleaning up after yourself.

How can it do something without power and clocks? And leaving reset
asserted for non-powered devices is generally not a good idea.
 
> > so should at least go in a separate patch if it should
> > be done at all.

> I'll grumpily comply..

I suggest you leave it deasserted unless you have documentation
suggesting that the opposite is safe and recommended for this piece of
hardware.
 
> >> Fixes: ed8cc3b1fc84 ("PCI: qcom: Add support for SDM845 PCIe controller")
> > 
> > I think you're being way to liberal with your use of Fixes tags. To
> > claim that this is a bug, you need to make a more convincing case for
> > why you think so.

> The first paragraph describes the issue that this patch fixes.

Yes, but this is all very hand-wavy so far. With a complete commit
message I may agree, but you still haven't convinced me that this is a
bug and not just a workaround from some not fully-understood issue on
one particular platform.
 
> > Also note Qualcomm's vendor driver is similarly asserting reset after
> > enabling the clocks.

> It's also not asserting the reset on suspend, see below.

Right, as I mentioned.
 
> > That driver does not seem to reset the controller on resume, though, in
> > case that is relevant for your current experiments.

> I know, the vendor driver doesn't fully shut down the controller. This
> is however the only sequence that we (partially) have upstream, and the
> only one that is going to work on SC8280XP (due to hw design).
> 
> On other platforms, a "soft shutdown" (i.e. dropping the link, cutting
> clocks but not fully resetting the RC state) should be possible, but
> that's not what this patchset concerns.

The commit message does not even mention suspend, it just makes a
clearly false general claim about a clock being stuck unless you reorder
things.

Johan

