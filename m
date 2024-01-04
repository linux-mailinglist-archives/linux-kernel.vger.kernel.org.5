Return-Path: <linux-kernel+bounces-16663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68395824211
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CC7286E8E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711972231C;
	Thu,  4 Jan 2024 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHLnPAVv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4EF2230A;
	Thu,  4 Jan 2024 12:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADCFC433C7;
	Thu,  4 Jan 2024 12:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704372844;
	bh=TUgtbOo/PVfQSA54Hl3nscCe0OQ8k5krHwt9pHz+FgM=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=cHLnPAVvbsxhokJh4rMwLRys1z3+1kjxvxQGdFmgwkh1UaRd5/0Eq9uZTUcz46VDa
	 KkGxKQ90nc+PupobVDIvS9rDBEv6tJsx5rfOKDupthHWSNz5A27XhaopzaJ8MTWVxX
	 +Y9XI6Obc+OyXl8K2RuzPkTglEXcWQGssHrJNdq39f7HJteFtrQBehCMCFChLAU1bE
	 yhVcVsPRoL4+5/gOVxhUdERSkDpQkRi61VeO4sRpsUJoevJOg7ySSe1y4zzp66PNWw
	 P4kFV4Ixr7KmSZCzUH1/8GMa550FukSl0AW/kEjZUmmCocptrkWaxoTGGNGcMaaZpc
	 OTow14fYYaHew==
Message-ID: <64ee255e-9a5a-405e-b342-e91c55bd95ce@kernel.org>
Date: Thu, 4 Jan 2024 13:53:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] OPP: Remove the unused argument to config_clks_t
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <f24f32f1213b4b9e9ff2b4a36922f8d6e3abac51.1704278832.git.viresh.kumar@linaro.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Dmitry Osipenko <digetx@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <vireshk@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Nishanth Menon <nm@ti.com>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-tegra@vger.kernel.org,
 Avri Altman <avri.altman@wdc.com>
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <f24f32f1213b4b9e9ff2b4a36922f8d6e3abac51.1704278832.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3.01.2024 11:48, Viresh Kumar wrote:
> The OPP core needs to take care of a special case, where the OPPs aren't
> available for a device, but in order to keep the same unified interface
> for the driver, the same OPP core API must take care of performing a
> simple clk_set_rate() for the device.
> 
> This required the extra argument, but that is used only within the OPP
> core and the drivers don't need to take care of that.
> 
> Simplify the external API and handle it differently within the OPP core.
> 
> This shouldn't result in any functional change.

Hi, so this apparently breaks serial on Qualcomm platforms using
"qcom,geni-debug-uart".. I'm seeing garbage on the console, likely
meaning that ratesetting wasn't done.

Konrad

