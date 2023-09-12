Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384AE79CF82
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbjILLKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbjILLIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:08:48 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C386173C;
        Tue, 12 Sep 2023 04:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:Reply-To:
        Content-ID:Content-Description;
        bh=ldrgnEH7Sx0aTIOcIuD/sp3SmK2aaFJCluGyd6JiYSU=; b=kJPnynMAZu2R1JSqRZhaGZdz3j
        Vv0VyHVTpJSM5F2zadHn9/KKuECG7EPmPDEvjwNoclnp/vdI9F6l5DYHg0oNGipGk7/5pxIfTOJhj
        rhf/dgVar2VhPSZ4xmAelyPxZJxEszqphCUE8WC4jvNhwgpFAuGXHrOv85ofWpvpn+HEE1u6LnKoS
        M4MPGhoBo/FvDqNm+91KDFN1pRFff7V+3lckmTla0uetkOy7E8TqLrLDleIw+8/lgKO7t0xfDwuLo
        2UYVmUI16XbLWsC+7+dvh5NdihdmxbTv5WLXR5dbuwEJAVlJCbsbyYFLySNWqm1wyqs+L3V6TwAOD
        mBa8OaAQ==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qg1Fv-0031jw-23;
        Tue, 12 Sep 2023 13:08:31 +0200
Date:   Tue, 12 Sep 2023 13:08:25 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/4] cpufreq: qcom-nvmem: Add MSM8909
Message-ID: <ZQBGqYWEm4eq9dNX@kernkonzept.com>
References: <20230912-msm8909-cpufreq-v1-0-767ce66b544b@kernkonzept.com>
 <20230912-msm8909-cpufreq-v1-4-767ce66b544b@kernkonzept.com>
 <5336dac4-af3f-46f7-bcf9-40314f744c8c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5336dac4-af3f-46f7-bcf9-40314f744c8c@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 11:59:47AM +0200, Konrad Dybcio wrote:
> On 12.09.2023 11:40, Stephan Gerhold wrote:
> > When the MSM8909 SoC is used together with the PM8909 PMIC the primary
> > power supply for the CPU (VDD_APC) is shared with other components to
> > the SoC, namely the VDD_CX power domain typically supplied by the PM8909
> > S1 regulator. This means that all votes for necessary performance states
> > go via the RPM firmware which collects the requirements from all the
> > processors in the SoC. The RPM firmware then chooses the actual voltage
> > based on the performance states ("corners"), depending on calibration
> > values in the NVMEM and other factors.
> > 
> > The MSM8909 SoC is also sometimes used with the PM8916 or PM660 PMIC.
> > In that case there is a dedicated regulator connected to VDD_APC and
> > Linux is responsible to do adaptive voltage scaling using CPR (similar
> > to the existing code for QCS404).
> > 
> > This difference can be described in the device tree, by either assigning
> > the CPU a power domain from RPMPD or from the CPR driver.
> > 
> > To describe this in a more generic way, use "apc" as power domain name
> > instead of "cpr". From the Linux point of view there is no CPR involved
> > when MSM8909 is used together with PM8909.
> Without checking, I have a vague recollection of CPR output also
> being called VDD_APCx, so it's a-ok
> 

FWIW: I would say there isn't really something like a "CPR output" in
the hardware. The power supply pin on the SoC for the cores is called
"VDD_APC" and you just have some regulator hooked up there. CPR then
monitors the environment and gives suggestions to adjust the voltage of
the regulator to optimize power and stability. But it doesn't provide
any power itself. You can use it or not. It's just an "add-in" basically.

> > 
> > Also add a simple function that reads the speedbin from a NVMEM cell
> > and sets it as-is for opp-supported-hw. The actual bit position can be
> > described in the device tree without additional driver changes.
> > 
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> > ---
> Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> One nit below:
> 
> [...]
> 
> >  static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
> > +	{ .compatible = "qcom,msm8909", .data = &match_data_msm8909 },
> >  	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
> msm8909 should come after apq8096 (even if adding apq and not msm was
> a mistake)
> 

Right, the list is currently totally out of order. I can prepend a patch
in v2 to sort it first. Will wait some more for more comments though.

Thanks!

-- 
Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael Hohmuth
