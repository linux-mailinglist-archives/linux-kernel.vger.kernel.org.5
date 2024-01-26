Return-Path: <linux-kernel+bounces-40327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6227B83DE94
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182841F25698
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D821DA40;
	Fri, 26 Jan 2024 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEkTsWGm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A231CD3F;
	Fri, 26 Jan 2024 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286199; cv=none; b=fkpxCt6ZMbMfdTfQBW6ORKApV4y9LnkLq+p2JQ0xV7Z8RWaSg0Q/Hrt76rcge7Gh4RzSlp1SavikUVH3j7vPXyPwETml8Fnjf8PsBa6e62ZUgxyjr7Eus3L3qpk8ia/CyfEJxDvKMRt0i+9EK274nbzfUtW3VBYHefzDxMunJuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286199; c=relaxed/simple;
	bh=2JCXgq32qIglC6mO72WRbjPvok3iIvPLQe2ZqDXoq+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACJ4xEDku3bvSGTSw2JZKg6ICFGNRqGXbXlqj0sw14WqDgvT6lr7qE8kUzM4oZA96by1+Nn55tgOhpoUky2FEso6GWIB71FT/CZB/A70Mg2NKinkTCN0NAJvEOLABOLXlzls/oKTBM86zzCFh9R1CPz4UhI8Chu+1Ik/8edcD/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEkTsWGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10D0C433F1;
	Fri, 26 Jan 2024 16:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706286198;
	bh=2JCXgq32qIglC6mO72WRbjPvok3iIvPLQe2ZqDXoq+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fEkTsWGm+pTv3JpEFsZcSKKxEWVnImncAwsQyoI3Ld7l8SqlSPkkztT/6mu8pqEam
	 vpLLbGXpWSpvxubuMPdi5uAwFg5PAsQpDJ2RYnDpXQb18Lkdozxrjscnx2eqEOnHm8
	 N3YGwkvhkqmRoM4YyAG0hwlgvuEX6Cw1xuO9WWStHUSB+R76n524qZSpZ52mqSDMbt
	 qAmd1GVQf7jgU3LVhcwQgru0P+PSyZS1HKGCkz9QcV41zFIh+g6izksdFp3d+SIS53
	 oB319QBS/gebFb4F/ER1A13hzFoCVoHbdFA3lczGeOkC/6HOiU0ADFoxFjTG9zgJ8u
	 8cbQygMkAxiWg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rTOzK-000000007rm-46Kw;
	Fri, 26 Jan 2024 17:23:31 +0100
Date: Fri, 26 Jan 2024 17:23:30 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Jiri Kosina <jikos@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc8280xp-x13s: Fix/enable
 touchscreen
Message-ID: <ZbPcgqr9gBByqV7Q@hovoldconsulting.com>
References: <20240125-x13s-touchscreen-v1-0-ab8c882def9c@quicinc.com>
 <20240125-x13s-touchscreen-v1-2-ab8c882def9c@quicinc.com>
 <ZbNpdaSyFS9tYrkd@hovoldconsulting.com>
 <20240126130232.GA5506@aspen.lan>
 <ZbPCJv7HW8OQzPMT@hovoldconsulting.com>
 <20240126145346.GN2936378@hu-bjorande-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126145346.GN2936378@hu-bjorande-lv.qualcomm.com>

On Fri, Jan 26, 2024 at 06:53:46AM -0800, Bjorn Andersson wrote:
> On Fri, Jan 26, 2024 at 03:31:02PM +0100, Johan Hovold wrote:
> > On Fri, Jan 26, 2024 at 01:02:32PM +0000, Daniel Thompson wrote:

> > > In short it looks like the delays make the difference and, even a short
> > > delay, can fix the problem.
> > 
> > Right, but since the suppliers are left enabled by the bootloader (and
> > never disabled by the kernel), that only begs the question of why this
> > makes a difference.
> 
> You're right, the supply is kept on by other things, so this isn't the
> problem.
> 
> > Without the delay, the other HID devices are probing (successfully)
> > slightly before, but essentially in parallel with the touchscreen while
> > using the same resources. Is that causing trouble somehow?
> 
> The difference to those other HID devices is GPIO 99 - the reset pin,
> which is configured pull down input from boot - i.e. the chip is held in
> reset.
> 
> When the HID device is being probed, pinctrl applies &ts0_default starts
> driving it high, bringing the device out of reset. But insufficient time
> is given for the chip to come up so the I2C read fails.

Ah, that's it.

You should drop that 'output-high' from the pin config as part of this
patch to avoid toggling the reset line twice at boot.

Looks like we have the same problem on the CRD as well. There the
touchscreen still works, possibly because it has been enabled by the
boot firmware or simply because that touchscreen can handle a shorter
delay.

Where exactly did you find those delay values in the ACPI tables? I
couldn't seem to find anything in the decompiled DSDT.

> If you later try to probe again, 200ms has elapsed since the reset was
> deasserted (driven high).

Right.

Johan

