Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768F37A8A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbjITRKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbjITRKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:10:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4101DA3;
        Wed, 20 Sep 2023 10:10:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59508C4339A;
        Wed, 20 Sep 2023 17:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695229822;
        bh=yi/QaKUzu89G9FWmGFRchfsQQ/b6YUKl1lKijsBirj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pCQ2j0lIK/SfCLhJx5NnqapK9sHxDjO9QgCbQhyfVH2W2lEB8+jy4jUtiOY3DonSY
         UPmLszfxgEvSVNV2OGjaiSWvuatayoV+NsncV/6bXcGnd+k9gs/vxmExPI7oudUnkJ
         IUGiw7qssgqP0pLvI53w8/8vTMp3HRkeiWKrvXdTTSjmGEGk6iI1nErkTRgjFvRPJS
         UJP1rrK4p2iGlw/ZhrF9O9/l/cnrmQLixzFrBF3FIl37yxDXoH+629mBd/10A5XzwC
         yHBmZVfISC0eIMxDS+8EhrlGLCzxRD7qrnne44yysWiaaurR+nhA3VXw9hCdBU0+0L
         CXKaDyLZI5JXQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, mturquette@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Devi Priya <quic_devipriy@quicinc.com>
Cc:     quic_saahtoma@quicinc.com
Subject: Re: [PATCH V2] clk: qcom: clk-rcg2: Fix clock rate overflow for high parent frequencies
Date:   Wed, 20 Sep 2023 10:14:08 -0700
Message-ID: <169523004952.2665018.4505782565131153297.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230901073640.4973-1-quic_devipriy@quicinc.com>
References: <20230901073640.4973-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 01 Sep 2023 13:06:40 +0530, Devi Priya wrote:
> If the parent clock rate is greater than unsigned long max/2 then
> integer overflow happens when calculating the clock rate on 32-bit systems.
> As RCG2 uses half integer dividers, the clock rate is first being
> multiplied by 2 which will overflow the unsigned long max value.
> Hence, replace the common pattern of doing 64-bit multiplication
> and then a do_div() call with simpler mult_frac call.
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: clk-rcg2: Fix clock rate overflow for high parent frequencies
      commit: f7b7d30158cff246667273bd2a62fc93ee0725d2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
