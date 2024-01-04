Return-Path: <linux-kernel+bounces-16665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F0C824216
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB84C1C23B21
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666CA22305;
	Thu,  4 Jan 2024 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdF1P6fb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E802230B;
	Thu,  4 Jan 2024 12:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BC1C433C7;
	Thu,  4 Jan 2024 12:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704372972;
	bh=hJwTVTNH2vMOH8QEELzhJd21g+u5Zo0IhLOmEiOa2FQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=SdF1P6fbSuP2XN1mOCPcpcchu1Env+KErc6rlATyaUk1S0JX4KH6Q6zB9HoRpidDm
	 vOA4qhhL6u+ZSRA+jurELNvacJU7Wd81xOvhCYYzfavlS3Xi83JXLZPivdztdczDCD
	 5D7NZ56DoEhA/bFbMt2VtOOhVq+KlfOE3yAToRipWGs+sbmnD8lQCJBXtxQco7D7Gl
	 uE6BtpBK2DLBMag6blwDoc+r5985POYv2rkmYXq3UatubqGr3iEP5rWS4+rHltA2Sb
	 V+1Yjk3E0RBrautonp+nqrPuYrLjhSr7mkTCHg32A4btF4tIpjYVjjocfX7aJkUNOo
	 pMfGusoCFv2mA==
Message-ID: <d994e6c3-f69e-4910-b699-65cb3ab6c72b@kernel.org>
Date: Thu, 4 Jan 2024 13:56:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] OPP: Remove the unused argument to config_clks_t
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
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
 Avri Altman <avri.altman@wdc.com>, Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <f24f32f1213b4b9e9ff2b4a36922f8d6e3abac51.1704278832.git.viresh.kumar@linaro.org>
 <64ee255e-9a5a-405e-b342-e91c55bd95ce@kernel.org>
In-Reply-To: <64ee255e-9a5a-405e-b342-e91c55bd95ce@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4.01.2024 13:53, Konrad Dybcio wrote:
> 
> On 3.01.2024 11:48, Viresh Kumar wrote:
>> The OPP core needs to take care of a special case, where the OPPs aren't
>> available for a device, but in order to keep the same unified interface
>> for the driver, the same OPP core API must take care of performing a
>> simple clk_set_rate() for the device.
>>
>> This required the extra argument, but that is used only within the OPP
>> core and the drivers don't need to take care of that.
>>
>> Simplify the external API and handle it differently within the OPP core.
>>
>> This shouldn't result in any functional change.
> Hi, so this apparently breaks serial on Qualcomm platforms using
> "qcom,geni-debug-uart".. I'm seeing garbage on the console, likely
> meaning that ratesetting wasn't done.

+CC Bjorn, Dmitry

Probably also worth noting it only happens when an OPP table is present
in the device tree.

Konrad

