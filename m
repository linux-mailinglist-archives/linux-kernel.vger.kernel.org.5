Return-Path: <linux-kernel+bounces-118452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCA988BB1D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AAC42E2B65
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A61C130A65;
	Tue, 26 Mar 2024 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twIZF4GI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5F12AAE6;
	Tue, 26 Mar 2024 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711437636; cv=none; b=BBUS3roB5W6eL4yogbU6ViNWuYRUZdODa5UgGl9RvRsCR2beCzb2cwu5acQTkI+4FrC6tLOLvI7ro3THRPMo/TAzcyVvIW49QgwiNp0O4uXy9h7jPQtCsVIFpbH8VHxGdqqgKMezZadg6d1m0QdmvMuY6McE04Hc+EFgtXBaVjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711437636; c=relaxed/simple;
	bh=uoegLIh5X4sgw1rU5EW0C+2z4l/NiMQ0WtwqQt0Gm34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcMMRTyXO3zgbI0Et6Hdt9wtTjVwGnfURT0M0H3Tk66HNLtw3rNKDNzWvrtWG1QtThiDrgJK601LIpqptSVPcfOJJyj65ry+5K0OATCjoAQMnG/CTbdI76Gq6W6EoUxX/f1AFaThNKGWSjSNlHsPYMLSMEGzKhHtn+uUnohUeJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twIZF4GI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C11C433F1;
	Tue, 26 Mar 2024 07:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711437636;
	bh=uoegLIh5X4sgw1rU5EW0C+2z4l/NiMQ0WtwqQt0Gm34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=twIZF4GI+sIazGTb9Rnt9qxoYa58vGbFUQFQQvUzCKwRFocUlwVWE7EopZ1kCamLu
	 IU+SYNuNH6C/haJtSOl23MgskmUtrp9DdsC88mgYQND4mWx0LQP0dzS43O+/ZC48Kt
	 OCMtit2Qr2upOSO9sChvl89gL8DdGGdto19QCkkr75XB4qdvbA8/RmGBN/CgvcE+yP
	 4PF62F0HGowuiG9AqDa4BoUwogutWQnHNcMn5zob1pMjOrHeodzovjsv6PkD4jFJlC
	 eiARKYE/qNI9sFmeukAexJB7j7sk7VWfdlwc6cuSQ96T9nxT+l7sFXgPVvDrIv0W1f
	 UuR+wZUM0kWdg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rp16x-000000005dX-2s5V;
	Tue, 26 Mar 2024 08:20:43 +0100
Date: Tue, 26 Mar 2024 08:20:43 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gdsc: treat optional supplies as optional
Message-ID: <ZgJ3S8I4EH4RV5YQ@hovoldconsulting.com>
References: <20240325081957.10946-1-johan+linaro@kernel.org>
 <9b2a7e9f-dbb2-4acb-91a7-fcc64d5cfabd@sirena.org.uk>
 <CAA8EJpqvYYCFRJVr732VORyHgpU-H2nif+n6hB6pJbXsqCH3_Q@mail.gmail.com>
 <bf2c507d-2320-425e-8bc2-8a2858281559@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf2c507d-2320-425e-8bc2-8a2858281559@linaro.org>

On Mon, Mar 25, 2024 at 08:21:24PM +0100, Konrad Dybcio wrote:
> On 25.03.2024 3:10 PM, Dmitry Baryshkov wrote:
> > On Mon, 25 Mar 2024 at 16:01, Mark Brown <broonie@kernel.org> wrote:
> >>
> >> On Mon, Mar 25, 2024 at 09:19:57AM +0100, Johan Hovold wrote:
> >>> Since commit deebc79b28d6 ("clk: qcom: gpucc-sc8280xp: Add external
> >>> supply for GX gdsc") the GDSC supply must be treated as optional to
> >>> avoid warnings like:
> >>>
> >>>       gpu_cc-sc8280xp 3d90000.clock-controller: supply vdd-gfx not found, using dummy regulator
> >>>
> >>> on SC8280XP.
> >>
> >> Can this device actually run with the supply physically disconnected?
> > 
> > On SC8280XP this is supplied via power-domain instead of the supply.
> 
> I think Dmitry is asking about this bit:

AFAICT, Dmitry did not ask anything.

> if (ret != -ENODEV)
> 	return ret;
> 
> which is basically repeating the difference that _optional makes

Not sure what you meant by this either. This is how the regulator
subsystem works.

Johan

