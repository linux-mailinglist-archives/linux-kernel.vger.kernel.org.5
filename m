Return-Path: <linux-kernel+bounces-6917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17460819F52
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62C91F22AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2282554D;
	Wed, 20 Dec 2023 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFSftMkq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FB824B35;
	Wed, 20 Dec 2023 12:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C48FC433C8;
	Wed, 20 Dec 2023 12:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703076497;
	bh=sSn/BQ2KPfowG0+/3vpfhVEq5uOao18ijFkUkqK42DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NFSftMkqfz02hb0rM1uQmEGj0i8nQusf31YqdI/hTHVLer3jJXyZpLPn3DzFFkcq/
	 EI+S3TdBXyAhiWgyqP8gNJSWIMdKOBgc1PX4DQN9uzy/MsyvedoYfNYSiQF7N+Cw/w
	 VJ8NCL4LnHm99O87LstLcVFlbYyDxROcKL0NJbDeJfRVlbPKzYJiwSJfwL113O9gQk
	 wfH3Lo8KvIU4M6YL+RwnRhanB+Cxzj0U0vGjrmM9XFgVqHDe7vBFqewBrIHiCq0hgd
	 SA1KFdbj4/UIWlZLpsLYcO8GmRndla8jP56aWtxX/hq2rQ3/5c4GGuYMX2W7Pv4gwF
	 IcHngouaOz+iQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rFvzj-0002Bc-0y;
	Wed, 20 Dec 2023 13:48:15 +0100
Date: Wed, 20 Dec 2023 13:48:15 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 04/15] clk: qcom: gcc-sm6375: Add runtime PM
Message-ID: <ZYLij93-n1-OWpIp@hovoldconsulting.com>
References: <20230717-topic-branch_aon_cleanup-v3-0-3e31bce9c626@linaro.org>
 <20230717-topic-branch_aon_cleanup-v3-4-3e31bce9c626@linaro.org>
 <ZYKzU4FFCc9lnE-p@hovoldconsulting.com>
 <0cbdb9fb-9ad6-46c4-9d20-b0a766ab2629@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cbdb9fb-9ad6-46c4-9d20-b0a766ab2629@linaro.org>

On Wed, Dec 20, 2023 at 01:26:55PM +0100, Konrad Dybcio wrote:
> On 20.12.2023 10:26, Johan Hovold wrote:
> > On Wed, Dec 20, 2023 at 01:30:45AM +0100, Konrad Dybcio wrote:
> >> The GCC block on SM6375 is powered by the VDD_CX rail. We need to ensure
> >> that CX is enabled to prevent unwanted power collapse 
> > 
> > As I pointed out earlier, this bit of the commit message is incorrect
> > and misleading as the power domain will never be disabled until you
> > enable runtime PM as part of this very patch:
> > 
> > 	https://lore.kernel.org/all/ZLaSpFFBzP_Yz5yY@hovoldconsulting.com/
> > 
> > Specifically, genpd will not power off CX (at runtime) while the driver
> > is bound when runtime PM is left disabled.

> OK I only now see what you really meant.
> 
> What this bit says is true, but it may be confusing within the context
> of this patch.

I'd say it's misleading since it suggests that something can currently
cause an "unwanted power collapse" which is not the case.

> The CX domain must be turned on [for the SoC to function], however this
> patch does not solve the issue of it being powered down [like you've said
> just binding the PD will keep it always-active for RPM-disabled devices].
> It complements this process, by allowing it to shut down when unnecessary.

Right, so just skip the misleading bits about "unwanted power collapse".

> >> and that the
> >> reference is dropped when unused so that the system can enter a
> >> firmware-managed lower power state.
> >>
> >> Enable runtime PM to keep the power flowing only when necessary.
> > 
> > The rest is correct.

> Let me try to reword this and see if you like it:
> 
> 
> The GCC block on SM6375 is powered by the VDD_CX rail. The Device Tree
> description of this dependency lets Linux keep the rail online to prevent
> power outages. It is however undesirable to keep it enabled at all times,
> as that consumes additional power.

I'd skip or rephrase the second sentence myself.
 
> Moreover, failing to drop the "enabled" vote prevents firmware-managed,
> SoC-wide power collapse in suspend, which leads to even more wasted power.

However if this is what you meant by "firmware-managed lower power
state" then this is not correct either. genpd will still power off the
power domain during system suspend, regardless of whether a driver
implements runtime PM.

> Enable runtime PM to keep the power flowing only when necessary.

So I'm starting to question whether we need this at all. AFAIK CX is
never going to be disabled at runtime and this patch is not needed to
disable CX during system suspend.

Johan

