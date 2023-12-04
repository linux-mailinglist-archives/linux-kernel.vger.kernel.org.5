Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F1A803212
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbjLDMDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjLDMDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:03:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD7D1990
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:01:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8506C433C8;
        Mon,  4 Dec 2023 12:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701691318;
        bh=dj/jyhV+xo1jIzRIWtSaa1FCw41fyfaNus/o63XmaOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DETzKrJoOxI8mNS42lev4LPYJoY7SNqoFhoV3N4JrdRLyKD/fCkaXSGhPRXNmsYP1
         PL7uXpifJxEZx0a3muC+XCTJv8o/7wr7Dqa4gGjdcpRZBTbb5i8gUfgxw43ktJe/z1
         Q0klyTAVyoJhyur68luJo4G8dLLR2yKDnoyvB1lAYPZEhVVdLCeYhzjBxYv2vTvrjz
         SF+p50oSFAHgZDug1a1l9yNHA4VzO5AIb3wbDbhxc5NnaIHluGWRR9Bzj9+vY6d7nA
         Lh9goruMTArrrp2I4LKGLymul/uMvubIKxj1836pj78p6CdmpDrkaGBIyU7YLjj+gj
         eqJGF1Mt4OLtA==
Date:   Mon, 4 Dec 2023 17:31:37 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, alessandro.carminati@gmail.com
Subject: Re: (subset) [PATCH v7 0/5] UFS: Add OPP support
Message-ID: <20231204120137.GE35383@thinkpad>
References: <20231012172129.65172-1-manivannan.sadhasivam@linaro.org>
 <170157925807.1717511.5041129304704724408.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <170157925807.1717511.5041129304704724408.b4-ty@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 08:54:46PM -0800, Bjorn Andersson wrote:
> 
> On Thu, 12 Oct 2023 22:51:24 +0530, Manivannan Sadhasivam wrote:
> > This series adds OPP (Operating Points) support to UFSHCD driver.
> > 
> > Motivation behind adding OPP support is to scale both clocks as well as
> > regulators/performance state dynamically. Currently, UFSHCD just scales
> > clock frequency during runtime with the help of "freq-table-hz" property
> > defined in devicetree. With the addition of OPP tables in devicetree (as
> > done for Qcom SDM845 and SM8250 SoCs in this series) UFSHCD can now scale
> > both clocks and performance state of power domain which helps in power
> > saving.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [4/5] arm64: dts: qcom: sdm845: Add OPP table support to UFSHC
>       commit: ec987b5efd59fdea4178d824d8ec4bbdf3019bdf
> [5/5] arm64: dts: qcom: sm8250: Add OPP table support to UFSHC
>       commit: 725be1d6318e4ea7e3947fd4242a14cf589cfebf
> 

Bjorn, could you please drop these two patches? I found the OPP regression in
the ufs-qcom driver due to some patches that got merged last cycle. Nitin is
working on a fix for that. So I'd like to defer merging of these dts patches to
v6.9.

I can resend them after v6.8-rc1.

- Mani

> Best regards,
> -- 
> Bjorn Andersson <andersson@kernel.org>

-- 
மணிவண்ணன் சதாசிவம்
