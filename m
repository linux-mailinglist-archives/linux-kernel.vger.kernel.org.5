Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C8B770610
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjHDQb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjHDQbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:31:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288FF4C10;
        Fri,  4 Aug 2023 09:31:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74C21620A7;
        Fri,  4 Aug 2023 16:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE97C433CA;
        Fri,  4 Aug 2023 16:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691166677;
        bh=jhplGazxUjW6Kin0V8iloOqTZLDJpCl1zEaHCyPA1fM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dLhqNsnSg4yY/9nwol2eZbD6+D9MExdUAVnK6eywfZwGbATOSzECNkUbkU6m102dD
         L8sqC6Pl7aFvSrpx2iNtiZR79se8NCyOJLXJDSj0X6BneaMNDOUqYrH9go3QqpZgW4
         FNddhvIIcdTxXW9o+FWts9XFbrg7+VHPsBJXSTcrzN6zZke+dSHg9j8B6suLZ1MMLF
         Jf/M2/wBfWbLqZvKIoe4J9ML0pjYaDXQRaD8bO0G6tb4bVL7x/5UJ65VR4I2QMn7+/
         2BtOE8OIHP6GfhevdMj1FP/5LwM/zw/EMLnUNug6u06iS9iTSrkbcZjAZ6zg40zZzr
         EpvmfUxkeYKsg==
Message-ID: <aba1b417-67ad-aec0-03ef-43da925c74da@kernel.org>
Date:   Fri, 4 Aug 2023 19:31:11 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v2 00/10] Fix up icc clock rate calculation on some
 platforms
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, quic_okukatla@quicinc.com
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230726-topic-icc_coeff-v2-0-8c91c6c76076@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20230726-topic-icc_coeff-v2-0-8c91c6c76076@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

On 31.07.23 13:52, Konrad Dybcio wrote:
> Certain platforms require that some buses (or individual nodes) make
> some additional changes to the clock rate formula, throwing in some
> magic, Qualcomm-defined coefficients, to account for "inefficiencies".

Maybe some links to the downstream code would help to better check and
understand this. Adding also Odelu in case he has any comments on the
patches.

Thanks,
Georgi

> Add the framework for it and utilize it on a couple SoCs.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Changes in v2:
> - Use the (arguably less favourable but necessary for precission) 100/x
>    instead of x/100 for ib coefficient, update values in consequent
>    patches to reflect that
> - Rename "_percent" to "_coeff" because of /\
> - Add the necessary code to support per-node clocks
> - Add the necessary code to support per-node coefficients
> - Hook up the CPUSS<->GNoC clock on QCM2290
> - Update EBI node on QCM2290
> - Link to v1: https://lore.kernel.org/r/20230726-topic-icc_coeff-v1-0-31616960818c@linaro.org
> 
> ---
> Konrad Dybcio (10):
>        interconnect: qcom: icc-rpm: Add AB/IB calculations coefficients
>        interconnect: qcom: icc-rpm: Separate out clock rate calulcations
>        interconnect: qcom: icc-rpm: Let nodes drive their own bus clock
>        interconnect: qcom: icc-rpm: Check for node-specific rate coefficients
>        interconnect: qcom: qcm2290: Hook up MAS_APPS_PROC's bus clock
>        interconnect: qcom: qcm2290: Set AB coefficients
>        interconnect: qcom: qcm2290: Update EBI channel configuration
>        interconnect: qcom: sdm660: Set AB/IB coefficients
>        interconnect: qcom: msm8996: Set AB/IB coefficients
>        clk: qcom: smd-rpm: Move CPUSS_GNoC clock to interconnect
> 
>   drivers/clk/qcom/clk-smd-rpm.c             | 16 ++++--
>   drivers/interconnect/qcom/icc-rpm-clocks.c |  6 ++
>   drivers/interconnect/qcom/icc-rpm.c        | 92 ++++++++++++++++++++++++------
>   drivers/interconnect/qcom/icc-rpm.h        | 15 +++++
>   drivers/interconnect/qcom/msm8996.c        |  8 ++-
>   drivers/interconnect/qcom/qcm2290.c        |  9 ++-
>   drivers/interconnect/qcom/sdm660.c         |  4 ++
>   7 files changed, 124 insertions(+), 26 deletions(-)
> ---
> base-commit: ec89391563792edd11d138a853901bce76d11f44
> change-id: 20230726-topic-icc_coeff-b053d5409b9f
> 
> Best regards,

