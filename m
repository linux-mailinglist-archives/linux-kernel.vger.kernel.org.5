Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACAD7C77DC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442767AbjJLUYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442679AbjJLUYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:24:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4634ECF;
        Thu, 12 Oct 2023 13:24:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34CAC433C7;
        Thu, 12 Oct 2023 20:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697142284;
        bh=2MF86sytX4fTZh0mQJESXVz65SbrM4mAf50g6EPGAGE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=g0OQJ9K4UECZWSfUIe4ERxixLwb2xg8590fKPYaqH/6dL3LcSejut5Z633jLleNGT
         Xq0gL5XPBf1GODOb4nZEkRFykpDAcRUdMh0vRqMqntw8djf48L9xEr+KDEhYd47ee2
         NnQmEaDZ19xHh7vVSxZlNwcqzyP4X4oSxEsxschiglljNmuA78asTgl3JL74Lx0PBH
         g55M00+m/GdiDQBGWhF2vaIHFYd/paULQ+UzhL1SFwp7yiapiRsq6GdZzcLshZ+l98
         a5GRlKJUVg5G6E5EeEmbY6EsmbwINBXcpd34Dv4XHWaiwkrjmOsRxpdhR8mKsL8D6M
         TdNtxsp/Aiscw==
Message-ID: <9888cc31bca1e1e148e3a0e4be4a0b5d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231011090028.1706653-3-quic_imrashai@quicinc.com>
References: <20231011090028.1706653-1-quic_imrashai@quicinc.com> <20231011090028.1706653-3-quic_imrashai@quicinc.com>
Subject: Re: [PATCH V2 2/4] clk: qcom: branch: Add mem ops support for branch2 clocks
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
Date:   Thu, 12 Oct 2023 13:24:42 -0700
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

Quoting Imran Shaik (2023-10-11 02:00:26)
> diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
> index fc4735f74f0f..9ac8d04b425a 100644
> --- a/drivers/clk/qcom/clk-branch.c
> +++ b/drivers/clk/qcom/clk-branch.c
> @@ -134,6 +135,42 @@ static void clk_branch2_disable(struct clk_hw *hw)
>         clk_branch_toggle(hw, false, clk_branch2_check_halt);
>  }
> =20
> +static int clk_branch2_mem_enable(struct clk_hw *hw)
> +{
> +       struct clk_mem_branch *mem_br =3D to_clk_mem_branch(hw);
> +       const char *name =3D clk_hw_get_name(&mem_br->branch.clkr.hw);
> +       u32 val;
> +       int timeout =3D 200, ret;

const int timeout?

> +
> +       regmap_update_bits(mem_br->branch.clkr.regmap, mem_br->mem_enable=
_reg,
> +                       mem_br->mem_enable_ack_bit, mem_br->mem_enable_ac=
k_bit);
> +
> +       ret =3D regmap_read_poll_timeout(mem_br->branch.clkr.regmap, mem_=
br->mem_ack_reg,
> +                       val, val & mem_br->mem_enable_ack_bit, 0, timeout=
);

The 'mem_br->branch' is used a few times so please make another local
variable for that called 'branch'.

> +       if (ret) {
> +               WARN(1, "%s mem enable failed", name);

Needs a newline on the message string.

> +               return ret;
> +       }
> +
> +       return clk_branch2_enable(hw);
> +}
> +
> +static void clk_branch2_mem_disable(struct clk_hw *hw)
> +{
> +       struct clk_mem_branch *mem_br =3D to_clk_mem_branch(hw);
> +
> +       regmap_update_bits(mem_br->branch.clkr.regmap, mem_br->mem_enable=
_reg,
> +                                               mem_br->mem_enable_ack_bi=
t, 0);

Please add a newline here.

> +       return clk_branch2_disable(hw);
> +}
> +
