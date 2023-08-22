Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EC77849BC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjHVSxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjHVSxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:53:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CD5E61;
        Tue, 22 Aug 2023 11:53:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9B0C65D7B;
        Tue, 22 Aug 2023 18:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0D6C433C7;
        Tue, 22 Aug 2023 18:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692730383;
        bh=bKiDZmN49huWf7NWKy0Ori9rr/bVNoT6UpjkQ5TVMmo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OITsBL8GveepBAjZCgo5KbglXtc1/m82nLHDkWsfB54qKA6hFX1PynX1TEVeb5msA
         2aG4TIbKW0mg9cZBRYmcO5eturhlFyCpCCsm6LqmpKu9Aunm2hyaMZHPPXXRk5jboE
         SmW3lXJcAjuLUOIwm/ur+B22J5i9nyRHRJTmuRZ2Xl7KxrbQDBMpI4EGOotoGYmC7i
         +T6u9I+V4ShC1r4JiBIXzcZskcD5Z1W2DnPNRUTQk5q8MRhsXryEQ+lPqoJseYaPZx
         dRC8c0YWeD60ilE64eQHnK7NmoSKVJ2WLS0VWmVbPYFl//j+J5CT7k0WdVffiT6OGx
         x0JR87wuG7Miw==
Message-ID: <cb32b5abb9fbe13fb82d906b37908276.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230808051407.647395-3-quic_imrashai@quicinc.com>
References: <20230808051407.647395-1-quic_imrashai@quicinc.com> <20230808051407.647395-3-quic_imrashai@quicinc.com>
Subject: Re: [PATCH 2/4] clk: qcom: branch: Add mem ops support for branch2 clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 22 Aug 2023 11:52:59 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Imran Shaik (2023-08-07 22:14:05)
> diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
> index 0cf800b9d08d..0ffda6bef00e 100644
> --- a/drivers/clk/qcom/clk-branch.h
> +++ b/drivers/clk/qcom/clk-branch.h
> @@ -24,8 +24,11 @@
>  struct clk_branch {
>         u32     hwcg_reg;
>         u32     halt_reg;
> +       u32     mem_enable_reg;
> +       u32     mem_ack_reg;
>         u8      hwcg_bit;
>         u8      halt_bit;
> +       u8      mem_enable_ack_bit;
>         u8      halt_check;
>  #define BRANCH_VOTED                   BIT(7) /* Delay on disable */
>  #define BRANCH_HALT                    0 /* pol: 1 =3D halt */

I suspect making a wrapper around struct clk_branch would be a better
approach so that we don't bloat all the other clk_branch structures that
exist in the qcom clk drivers.

 $ git grep 'struct clk_branch' -- drivers/clk/qcom | wc -l
   6357

How many of these are going to be using these new registers? It may also
make sense to do that for hardware clock gating as well, but I'm not
really sure. Anyway, the idea is

	struct clk_mem_branch {
		u32 enable_reg;
		u32 ack_reg;
		u8  ack_bit;
		struct clk_branch branch;
	};

and then a container_of define. Plus, you can put some comment above the
structure to describe when these clks are used.
