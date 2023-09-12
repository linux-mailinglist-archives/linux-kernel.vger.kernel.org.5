Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF8F79C758
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjILG7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjILG7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:59:38 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA1B10DD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:59:33 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68bed2c786eso4359659b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694501973; x=1695106773; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LlO3N7pqp4fi5xGA4ZVrbbV2rUdgOmvkPdAdAMdS/98=;
        b=Gk7dvV+JXskLV+T9xokIsdQckwrxM+BEs2NeEq6aRJiz8a18TCLfL+XgPQOMa9J3gC
         IpWt1MghMIN5VgYSSxpJ1x913Poq7yOTdi9s59YM0J9FiJ3XhhF7CmJoI6SZ/bvtxwG0
         YCgoA6DLCKYPF+l1yP8Jd1/hWt9plcXWJ/kxV4HHmfFisVyCTd5jrihVJM60NP52QNFv
         N5cdt4nojDUoxgudn5hBg8nJnbE+g8kk08kmHFhNT3qsRO86NEHOaD5l6PqTD1LZRSrA
         VRBAAyE9W97ejIpkZ53WzhEM7ne6QoPNABWFyzg2ltAr7QFYCHrBTWOsxjCHxhCUIvDw
         dN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694501973; x=1695106773;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LlO3N7pqp4fi5xGA4ZVrbbV2rUdgOmvkPdAdAMdS/98=;
        b=A9y67NoPhmShqrD2vxRq24abCGr8qyYbMxHd1PoW0G7sIgznbDm8TEZ20QCv3D8/Rl
         Yq02bhlrJ/RWAS0AdrmMYx7V5dWrtrNKdoeWVAMOXf6uYSZSDZhSJuRpn3ULraBn7dNR
         dZaKkccTxSrroVbJzuoEL36FTFANlNO3s5MKQ+Wh2mX/4rpRfKOFqa/Sy9gBk3TJKfHt
         WYBkVnbNoKSnfQKoAZt7evIxqATA2rEETHRFP2zF9jZ0LnJloSZsYSsJWbXxA2oFEu+p
         Yi1FbYELPHrFoZPjYIN8YUo8JacwPNJpYPdqotecy9qAIAxgpOD4wXHPnwah/nRWWfwa
         mtCQ==
X-Gm-Message-State: AOJu0YzbkXsyXdWcNAFZzMsZo7LeIyQXxcDpcwChPvOBfqmM96zbDaOl
        p6GJGsiWHPuQXtmlYJ4oC1Hv
X-Google-Smtp-Source: AGHT+IHiiSfJhGC0JZK1XwVhpgMz9qY8FvoEghC/BG98cbA6Z+dik3F1LlzN6wd5MSvhL0wQSV6MRw==
X-Received: by 2002:a05:6a20:9706:b0:14b:ecab:a6ba with SMTP id hr6-20020a056a20970600b0014becaba6bamr9283969pzc.28.1694501973237;
        Mon, 11 Sep 2023 23:59:33 -0700 (PDT)
Received: from thinkpad ([117.206.119.163])
        by smtp.gmail.com with ESMTPSA id fu8-20020a17090ad18800b00262e485156esm8406071pjb.57.2023.09.11.23.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 23:59:32 -0700 (PDT)
Date:   Tue, 12 Sep 2023 12:29:18 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] arm64: dts: qcom: sdm845: Add OPP table support
 to UFSHC
Message-ID: <20230912065918.GB6404@thinkpad>
References: <20230731163357.49045-1-manivannan.sadhasivam@linaro.org>
 <20230731163357.49045-6-manivannan.sadhasivam@linaro.org>
 <04eb9f71-78f0-41f2-96a6-fc759ba296fa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04eb9f71-78f0-41f2-96a6-fc759ba296fa@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 04:15:10PM +0300, Dmitry Baryshkov wrote:
> On 31/07/2023 19:33, Manivannan Sadhasivam wrote:
> > From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > UFS host controller, when scaling gears, should choose appropriate
> > performance state of RPMh power domain controller along with clock
> > frequency. So let's add the OPP table support to specify both clock
> > frequency and RPMh performance states replacing the old "freq-table-hz"
> > property.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > [mani: Splitted pd change and used rpmhpd_opp_low_svs]
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   arch/arm64/boot/dts/qcom/sdm845.dtsi | 42 +++++++++++++++++++++-------
> >   1 file changed, 32 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index 055ca80c0075..2ea6eb44953e 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -2605,22 +2605,44 @@ ufs_mem_hc: ufshc@1d84000 {
> >   				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
> >   				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
> >   				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
> > -			freq-table-hz =
> > -				<50000000 200000000>,
> > -				<0 0>,
> > -				<0 0>,
> > -				<37500000 150000000>,
> > -				<0 0>,
> > -				<0 0>,
> > -				<0 0>,
> > -				<0 0>,
> > -				<75000000 300000000>;
> > +
> > +			operating-points-v2 = <&ufs_opp_table>;
> >   			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mem_noc SLAVE_EBI1 0>,
> >   					<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
> >   			interconnect-names = "ufs-ddr", "cpu-ufs";
> >   			status = "disabled";
> > +
> > +			ufs_opp_table: opp-table {
> > +				compatible = "operating-points-v2";
> > +
> > +				opp-50000000 {
> > +					opp-hz = /bits/ 64 <50000000>,
> > +						 /bits/ 64 <0>,
> > +						 /bits/ 64 <0>,
> > +						 /bits/ 64 <37500000>,
> > +						 /bits/ 64 <0>,
> > +						 /bits/ 64 <0>,
> > +						 /bits/ 64 <0>,
> > +						 /bits/ 64 <0>,
> > +						 /bits/ 64 <75000000>;
> > +					required-opps = <&rpmhpd_opp_low_svs>;
> > +				};
> 
> I'd say, I'm still slightly unhappy about the 0 clock rates here.

Neither do I. But it is the only viable option I could found.

> We need only three clocks here: core, core_clk_unipro and optional
> ice_core_clk. Can we modify ufshcd_parse_operating_points() to pass only
> these two or three clock names to devm_pm_opp_set_config() ? The OPP core
> doesn't need to know about all the rest of the clocks.
> 

We need to enable/disable all of the clocks, but only need to control the rate
for these 3 clocks. So we cannot just use 3 clocks.

If the OPP table has only 3 entries (omitting the gate-only clocks), then we
need some hack in the driver to match the rates against the clock entries. Doing
so will result in hardcoding the clock info in the driver which I do not want to
do.

If we have something like "opp-hz-names" to relate the rates to clock-names, it
might do the job. But it needs some input from Viresh.

- Mani

> > +
> > +				opp-200000000 {
> > +					opp-hz = /bits/ 64 <200000000>,
> > +						 /bits/ 64 <0>,
> > +						 /bits/ 64 <0>,
> > +						 /bits/ 64 <150000000>,
> > +						 /bits/ 64 <0>,
> > +						 /bits/ 64 <0>,
> > +						 /bits/ 64 <0>,
> > +						 /bits/ 64 <0>,
> > +						 /bits/ 64 <300000000>;
> > +					required-opps = <&rpmhpd_opp_nom>;
> > +				};
> > +			};
> >   		};
> >   		ufs_mem_phy: phy@1d87000 {
> 
> -- 
> With best wishes
> Dmitry
> 

-- 
மணிவண்ணன் சதாசிவம்
