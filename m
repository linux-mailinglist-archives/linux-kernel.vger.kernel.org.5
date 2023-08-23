Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8573785F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 20:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbjHWSEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 14:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237995AbjHWSEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 14:04:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910E51AD;
        Wed, 23 Aug 2023 11:04:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EFC265BD7;
        Wed, 23 Aug 2023 18:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0FEC433C7;
        Wed, 23 Aug 2023 18:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692813865;
        bh=1d7ThlaABV8FE3gjTpsPvmzevwSLEmFn0LkTXxK0Hxk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gDw9+o1p3Jcpof2McSd2doyZWwQvklS2nKFVPyXXYuJxZ9p1XYgUr+vU0lmn2Ta31
         YVFaGFy+UWNABaRcsuu4ZbWg0Az5hqSaAWPQRWZh3WqqOOoGKxREtZNu7qtmoumKAI
         cMRPdiYpI8z5lzz+LfRCtQistmDbkVgj5hHKbeU3kGh9xhGLp6VJtndewnBDOv1c39
         lMU1oZsYxAzl3yCQPa5r7bxzI8xt4AonxeBb89LRjJyLiDGL3u3iAo+tZXXXhO0xvv
         hwf+iYsgiKK38DuQ7nmC9kErBm8kXgVV9BuRAd3nYaIt4LZLVGq89wut59XLdCL3aj
         QZVfwcjPFJZHg==
Message-ID: <2819cf11177d81ab1fcface7e742cf50.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230823085031.27252-2-quic_luoj@quicinc.com>
References: <20230823085031.27252-1-quic_luoj@quicinc.com> <20230823085031.27252-2-quic_luoj@quicinc.com>
Subject: Re: [PATCH v5 1/4] clk: qcom: branch: Add clk_branch2_mdio_ops
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
To:     Luo Jie <quic_luoj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, catalin.marinas@arm.com, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, will@kernel.org
Date:   Wed, 23 Aug 2023 11:04:22 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Luo Jie (2023-08-23 01:50:28)
> diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
> index fc4735f74f0f..5e08c026ca4a 100644
> --- a/drivers/clk/qcom/clk-branch.c
> +++ b/drivers/clk/qcom/clk-branch.c
> @@ -153,3 +153,10 @@ const struct clk_ops clk_branch_simple_ops =3D {
>         .is_enabled =3D clk_is_enabled_regmap,
>  };
>  EXPORT_SYMBOL_GPL(clk_branch_simple_ops);
> +
> +const struct clk_ops clk_branch2_mdio_ops =3D {
> +       .prepare =3D clk_branch2_enable,
> +       .unprepare =3D clk_branch2_disable,
> +       .is_prepared =3D clk_is_enabled_regmap,
> +};
> +EXPORT_SYMBOL_GPL(clk_branch2_mdio_ops);

I'd call it clk_branch2_simple_prepare_ops or something like that.
There's nothing mdio specific about it.
