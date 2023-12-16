Return-Path: <linux-kernel+bounces-2071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B17D815783
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1238F28580B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5334610A0A;
	Sat, 16 Dec 2023 04:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adlewkaq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40DB539E;
	Sat, 16 Dec 2023 04:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F695C433C8;
	Sat, 16 Dec 2023 04:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702701306;
	bh=yKomdcJ7yz8oOjAGsZLlvVacjnOwqWgzQX+Yh00wFj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=adlewkaqL9FMU8YRkQNQt7gD8jn00g+8OJ2lEqsY7bvAqGgnZesPuWGSuRyT+6nxW
	 nkl+em9j/Oq2gnybDLX0WVR3NydkUV4IPx2cU3u/Bg4vLGh9+HitFWzJY9LcTnilEl
	 P0z1PDsrlevWCuvR8gfAe+MPZRK1/DwyDnIoGfQZjju8K9YqITW/BSbT9ejT3OJdLr
	 V1rbr+6dTtJ9gg5UJf++ZXLk0nvGMDFmOBkl/urGHPXBLst5hwG2BOD2stMX+VJvMA
	 4ZIOsVFy9h1pJJnAKp0xBcbSDmaC+e2P7e8nYAOQbaA1Uo8ddXeuRfsVlsEssbfdkx
	 M7xnlZFV/rrEw==
Date: Fri, 15 Dec 2023 22:35:03 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Arnd Bergmann <arnd@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] Revert "soc: qcom: stats: Add DDR sleep stats"
Message-ID: <cxrw3fc4jxd2zee655g4gi2eshqnwquhezcehnvwjuyt4qkihr@ganx5uwzc35r>
References: <20231214-topic-undo_ddr_stats-v1-1-1fe32c258e56@linaro.org>
 <4472fd8e-73a6-44b6-a1d0-c5ebc55d4211@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4472fd8e-73a6-44b6-a1d0-c5ebc55d4211@linaro.org>

On Sat, Dec 16, 2023 at 01:05:53AM +0100, Konrad Dybcio wrote:
> On 14.12.2023 13:25, Konrad Dybcio wrote:
> > After recent reports ([1], [2]) of older platforms (particularly 8150 and
> > 7180) breaking after DDR sleep stats introduction, revert the following:
> > 
> > Commit 73380e2573c3 ("soc: qcom: stats: fix 64-bit division")
> > Commit e84e61bdb97c ("soc: qcom: stats: Add DDR sleep stats")
> > 
> > The feature itself is rather useful for debugging DRAM power management,
> > however it looks like the shared RPMh stats data structures differ on
> > previous SoCs.
> > 
> > Revert its addition for now to un-break booting on these earlier SoCs,
> > while I try to come up with a better way to enable it conditionally.
> > 
> > [1] https://lore.kernel.org/linux-arm-msm/20231209215601.3543895-2-dmitry.baryshkov@linaro.org/
> > [2] https://lore.kernel.org/linux-arm-msm/CAD=FV=XX4wLg1NNVL15RK4D4tLvuSzZyUv=k_tS4bSb3=7QJzQ@mail.gmail.com/
> > 
> > Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Reported-by: Doug Anderson <dianders@chromium.org>
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> Arnd, since Bjorn seems to be MIA, could you please pick this directly
> so that it gets into the next RC? Un-breaking booting on some platforms
> would be very welcome :D
> 

I'm confused, the two offending commits are staged for v6.8. Which -rc
do you want this applied in?! And you posted this patch yesterday...

Regards,
Bjorn

