Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E511C76EF9B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbjHCQfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbjHCQfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:35:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8043310EA;
        Thu,  3 Aug 2023 09:35:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1578B61E3A;
        Thu,  3 Aug 2023 16:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812F8C43391;
        Thu,  3 Aug 2023 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691080510;
        bh=A4FwD5H+bb3JkGJFIRlgZUsJgmXQ78VpOP/Ybb8v82I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NdI2p+cN1TPjrOsk/RL/6mVdf+dWKFxGBAIJgj/UM4NvSQsE+tplSqr6Mv3vN3ht3
         1ZFcSuoa+mA1R91kCV3kWzWVk65nM3CbMmlS86IxOIbkCunqv1/J8l3ApZx5ZXXKeb
         POKZUhHteclt2tMxaGk2M8Qz96RNZsbdMCEhwcqwUZ3nZ4t/GrYz3zZCwt2PGNxOMC
         R7gXd+Oe4qpkjZthjLHtLQRD6PZk2a8ZfsbwibOqvEjh2CI2QBNZth2kI/nwrM/5Sv
         2WXekoHbGTKkupiduIQNZfV0tlPYqFVgYgmZqJmMuAEb+6wZkdHJ+z/1Dh2KdE+Dwz
         3+dkFfDsbQjSg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: fix some Kconfig corner cases
Date:   Thu,  3 Aug 2023 09:38:00 -0700
Message-ID: <169108064633.108343.3306502053661606417.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801105718.3658612-1-arnd@kernel.org>
References: <20230801105718.3658612-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 01 Aug 2023 12:56:32 +0200, Arnd Bergmann wrote:
> The SM_GCC_8550 symbol and others can only be built for ARM64 or when
> compile testing, but it gets selected by other drivers that can also be
> built for 32-bit ARCH_QCOM when not compile testing, which results in
> a Kconfig warning:
> 
> WARNING: unmet direct dependencies detected for SM_GCC_8550
>   Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=m] && (ARM64 || COMPILE_TEST [=n])
>   Selected by [m]:
>   - SM_GPUCC_8550 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
>   - SM_VIDEOCC_8550 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: fix some Kconfig corner cases
      commit: b6bcd1c0c27e1f210228346e6d23a2ec0c263e8c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
