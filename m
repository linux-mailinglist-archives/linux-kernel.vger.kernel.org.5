Return-Path: <linux-kernel+bounces-45515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0158431B9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B76E3B22DFF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66907F6;
	Wed, 31 Jan 2024 00:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TP/DXvRA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C66363;
	Wed, 31 Jan 2024 00:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706660365; cv=none; b=LFQB+FGPFV+d2sV3TsQTCcutAtFn1OiqGBvAUh5ORtn3kIcAVqyofPuvienlCp7cWphtlYFYchYa9c+JfZyqOqf0srdws5A7yjFQP3iqkL3z2uufcjnFWGGWMXkNbUSVmKef5R5FLAd3QHAVeSuViO2TH72so9+GS6AAtn7qQ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706660365; c=relaxed/simple;
	bh=AUvmiiN2J4iUZBQtOTauNb4kWOolnYW+zkQQa/Z11CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3ihBn6YP6lX3YSXACUTQusQh0qS0I0yosKdrSPtZYSIw35Kfr+j9Ji8grWRSr/NtcPIaMNSpLTgLihdgGQVRu/VXhQlY6rFOTAaCJ6Q8YH5kNfNt9rjq8rq/yBh+MqFCnmJ7A6y8S137P5Xdj2gBZ3P8p9/gT9YuyXGyDJ4sMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TP/DXvRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF13CC433F1;
	Wed, 31 Jan 2024 00:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706660364;
	bh=AUvmiiN2J4iUZBQtOTauNb4kWOolnYW+zkQQa/Z11CY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TP/DXvRA3eH3jDc7yrTGi4ZABSlsTWSNsKaqLu9xMD6LXPJzNg+yGz9C44f2zvjQD
	 H4pahFsQbu+q+xSx2BdVY8A87LmJaZ3JqNJhNcWyYvsVoVRle7Fuw8xFvvd7IhmxG3
	 QhaHVie17w3XVeV8JK8CfpuFH9I0ZC1WJGIoxv/XEruZVQIIJWS8w/fJwfhSZod+2+
	 +yRXX/WPeTIH+p9IqlXPEU0UVT4b6g2A1cHYWc3OXKh6G7N1r0ugGsNgNOEe3hHBs3
	 kBW37XJZt8DFdyVAH9fnkEpyBZsR8mgg3hzSGRNViU2PAgL3Sk7pVjBsOxkv+4qsjo
	 M6kpw/rqkp2ew==
Date: Tue, 30 Jan 2024 18:19:20 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: Re: [PATCH v4 3/5] clk: qcom: gdsc: Add set and get hwmode
 callbacks to switch GDSC mode
Message-ID: <xl767op6zn5iene3h4jg3x3w7fofrqztqkdgg4qqmiy34p27if@hnev3tnldqw5>
References: <20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org>
 <20240122-gdsc-hwctrl-v4-3-9061e8a7aa07@linaro.org>
 <qbqsvxmnl2tuansxzr6u4vqxemw4dzrsvz2ill6qnyxdp5gtji@lsemt4asmsax>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qbqsvxmnl2tuansxzr6u4vqxemw4dzrsvz2ill6qnyxdp5gtji@lsemt4asmsax>

On Tue, Jan 30, 2024 at 05:00:28PM -0600, Bjorn Andersson wrote:
> On Mon, Jan 22, 2024 at 10:47:03AM +0200, Abel Vesa wrote:
> > From: Jagadeesh Kona <quic_jkona@quicinc.com>
> > 
> > Add support for set and get hwmode callbacks to switch the GDSC between
> > SW and HW modes. Currently, the GDSC is moved to HW control mode
> > using HW_CTRL flag and if this flag is present, GDSC is moved to HW
> > mode as part of GDSC enable itself. The intention is to keep the
> > HW_CTRL flag functionality as is, since many older chipsets still use
> > this flag.
> > 
> 
> This provides insight into why we end up with both HW_CTRL and
> HW_CTRL_TRIGGER. This doesn't describe why this change is needed, but
> rather just an implementation detail.
> 
> > But consumer drivers also require the GDSC mode to be switched dynamically
> > at runtime based on requirement for certain usecases. Some of these
> > usecases are switching the GDSC to SW mode to keep it ON during the
> > enablement of clocks that are dependent on GDSC and while programming
> > certain configurations that require GDSC to be ON. Introduce a new
> > HW_CTRL_TRIGGER flag to register the set_hwmode_dev and get_hwmode_dev
> > callbacks which allows the consumer drivers to switch the GDSC back and
> > forth between HW/SW modes dynamically at runtime using new
> > dev_pm_genpd_set_hwmode API.
> > 
> 
> This still expresses the need for HW_CTRL_TRIGGER in terms of "some
> drivers need for some use case". We don't need these many words to say:
> "Introduce HW_CTRL_TRIGGER for client drivers that need it."
> 
> 
> I find that it would be useful to document that every time a GDSC is
> turned on the mode will be switched to SW...
> 

I believe I'm wrong here. Reading the patch again, I think we might
retain the mode across a disable/enable cycle. I at least don't see
anything explicit returning us to SW mode.

According to Linux though, the GDSC is off, so as described below, there
will be no votes for supplying resources.

Regards,
Bjorn

