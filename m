Return-Path: <linux-kernel+bounces-10340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED83681D313
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 09:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50AA81F21A3A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 08:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FF88BF8;
	Sat, 23 Dec 2023 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="iNm7uSiv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750B58BE0;
	Sat, 23 Dec 2023 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id B252441BD2;
	Sat, 23 Dec 2023 13:05:33 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1703318736; bh=e08FoWdtPSBF5xVKc91iPWDm+2CtVdPEztlQEzzLCXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iNm7uSivuY3lLD2FvO/siVeJpH5oY+zOTe++KykAHZBgFklLQbxJ0VeWGVKonQMk7
	 2Q4EgDbFs5VxzLt5Gm6KpfnWJsaHLIuuMvEauc6xfHA/e3WZdnnyG1iIQ2GrqwTOHm
	 5cpFnfqpunmLiQB0VDGSEeR8xbO/i/k10nfuctLmmOVwGDCbNVw9BJwEyDfMIHMdcW
	 nHRZ34p64tLw0udA1b7jAiEsoqyflT/18ivYQNRz0DxA8zZm5V3fbOW2JVVnZ2M4Ia
	 rVw4DYiPZ1VC+nqjKUiacDYyclQTyJYgajJ6eblr1E4D7pY1NwUNy6EiI1pbv1MDG9
	 xKzhDWvl5pxkw==
Date: Sat, 23 Dec 2023 13:05:29 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: qcom: sc7280: revert back to PSCI PC mode
 for herobrine
Message-ID: <bwfqomkub25wr5nsqvbp3dkpeda5halx4rsd2jgfct3rk5qxux@gqrdks7oyavk>
References: <20231222190311.3344572-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222190311.3344572-1-olvaffe@gmail.com>

On Fri, Dec 22, 2023 at 11:03:03AM -0800, Chia-I Wu wrote:
> Commit 7925ca85e9561 ("arm64: dts: qcom: sc7280: Add power-domains for
> cpuidle states") transitioned all SC7280 devices to PSCI OS initiated
> mode, which doesn't work on TFA-based SC7280 devices.  This effectively
> revert the commit for sc7280-herobrine.
>

Hi!

I believe modern TF-A includes OSI mode, and it was added pretty much
specifically for sc7280, as described in [1]. More to that, I think
the original commit that introduced OSI mode for sc7280 did it using
the TF-A specific suspend params (I believe they are different from
qcom firmware) so the leftover state of the base soc dtsi would be
weird...

I can't understand why this change is needed...

Nikita

[1] https://trustedfirmware-a.readthedocs.io/en/latest/design_documents/psci_osi_mode.html

> Fixes: 7925ca85e9561 ("arm64: dts: qcom: sc7280: Add power-domains for cpuidle states")
> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> ---
> 
> v2: improved commit message
> v3: improved commit message.  I hope it's better now!
> 
>  .../boot/dts/qcom/sc7280-firmware-tfa.dtsi    | 107 ++++++++++++++++++
>  .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |   1 +
>  arch/arm64/boot/dts/qcom/sc7280.dtsi          |   4 +-
>  3 files changed, 110 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-firmware-tfa.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-firmware-tfa.dtsi b/arch/arm64/boot/dts/qcom/sc7280-firmware-tfa.dtsi
> new file mode 100644
> index 0000000000000..b3fc03da244d6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-firmware-tfa.dtsi
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +
> +/*
> + * Devices that use SC7280 with TrustedFirmware-A
> + * need PSCI PC mode instead of the OSI mode provided
> + * by Qualcomm firmware.
> + */
> +
> +&CPU0 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +
> +	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +			   &LITTLE_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
> +&CPU1 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +
> +	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +			   &LITTLE_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
> +&CPU2 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +
> +	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +			   &LITTLE_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
> +&CPU3 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +
> +	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +			   &LITTLE_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
> +&CPU4 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +
> +	cpu-idle-states = <&BIG_CPU_SLEEP_0
> +			   &BIG_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
> +&CPU5 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +
> +	cpu-idle-states = <&BIG_CPU_SLEEP_0
> +			   &BIG_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
> +&CPU6 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +
> +	cpu-idle-states = <&BIG_CPU_SLEEP_0
> +			   &BIG_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
> +&CPU7 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +
> +	cpu-idle-states = <&BIG_CPU_SLEEP_0
> +			   &BIG_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
> +/delete-node/ &domain_idle_states;
> +
> +&idle_states {
> +	CLUSTER_SLEEP_0: cluster-sleep-0 {
> +		compatible = "arm,idle-state";
> +		idle-state-name = "cluster-power-down";
> +		arm,psci-suspend-param = <0x40003444>;
> +		entry-latency-us = <3263>;
> +		exit-latency-us = <6562>;
> +		min-residency-us = <9926>;
> +		local-timer-stop;
> +	};
> +};
> +
> +/delete-node/ &CPU_PD0;
> +/delete-node/ &CPU_PD1;
> +/delete-node/ &CPU_PD2;
> +/delete-node/ &CPU_PD3;
> +/delete-node/ &CPU_PD4;
> +/delete-node/ &CPU_PD5;
> +/delete-node/ &CPU_PD6;
> +/delete-node/ &CPU_PD7;
> +/delete-node/ &CLUSTER_PD;
> +
> +&apps_rsc {
> +	/delete-property/ power-domains;
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> index 9ea6636125ad9..09b2d370bf7e0 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> @@ -19,6 +19,7 @@
>  
>  #include "sc7280-qcard.dtsi"
>  #include "sc7280-chrome-common.dtsi"
> +#include "sc7280-firmware-tfa.dtsi"
>  
>  / {
>  	chosen {
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 66f1eb83cca7e..354bf2868eba6 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -383,7 +383,7 @@ core7 {
>  			};
>  		};
>  
> -		idle-states {
> +		idle_states: idle-states {
>  			entry-method = "psci";
>  
>  			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
> @@ -427,7 +427,7 @@ BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
>  			};
>  		};
>  
> -		domain-idle-states {
> +		domain_idle_states: domain-idle-states {
>  			CLUSTER_SLEEP_0: cluster-sleep-0 {
>  				compatible = "domain-idle-state";
>  				idle-state-name = "cluster-power-down";
> -- 
> 2.43.0.195.gebba966016-goog

