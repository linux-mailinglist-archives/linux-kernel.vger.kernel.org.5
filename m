Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C7C7D04A5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346616AbjJSWIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjJSWIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:08:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF29A4;
        Thu, 19 Oct 2023 15:08:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7149C433C7;
        Thu, 19 Oct 2023 22:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697753323;
        bh=0xUExZaCnpOZe09w1IymOILE+jJMJDYlYAh9fZjofMw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qCC/P6Z7UE87jxBHLuDwBwT+KgZtuqPAHBmCFVYxig53subGe5m/UnXrOlQ1Kttxa
         jHQ9vw1yma/irMtt9GBQsWafuxPEoxiRWnA0GU7VmuaxbveT4JBxu/b3ck3oQljMbu
         J+rIs5mj40Ud/DefXs1Jzmu6Frp/rEI/BujGJIChvpy4PcE4+izgmrkMSHyUtVIG3Z
         Xka4WoIrLTURuZrBfnFMC1SN/ijke3yG0jWrNymZ1tbywZ4jprIOCnnS5Wg6KUOxLr
         J5f9qRyKtnqNXVlVSsS6DJ0jQxSBipUNP1vQCFrMYW5/mLuoBOOAi2Twt2xDZT9wuH
         9WvO+5K4DSVMg==
Message-ID: <4f4803d538c6727990cda8f2e4fd7397.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <76b652c8-041c-49d6-9804-2781fe2ccfe3@linaro.org>
References: <20230913-gpll_cleanup-v2-0-c8ceb1a37680@quicinc.com> <20230913-gpll_cleanup-v2-1-c8ceb1a37680@quicinc.com> <76f3bc23-8677-42bd-a3a5-43b17cbe552e@linaro.org> <c3dfeecf5cde513cf675b2f1a382f7a4.sboyd@kernel.org> <76b652c8-041c-49d6-9804-2781fe2ccfe3@linaro.org>
Subject: Re: [PATCH v2 01/11] clk: qcom: ipq8074: drop the CLK_SET_RATE_PARENT flag from PLL clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Devi Priya <quic_devipriy@quicinc.com>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>
Date:   Thu, 19 Oct 2023 15:08:41 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2023-10-19 04:22:33)
>=20
>=20
> On 10/19/23 02:16, Stephen Boyd wrote:
> > Quoting Konrad Dybcio (2023-09-15 05:19:56)
> >> On 14.09.2023 08:59, Kathiravan Thirumoorthy wrote:
> >>> GPLL, NSS crypto PLL clock rates are fixed and shouldn't be scaled ba=
sed
> >>> on the request from dependent clocks. Doing so will result in the
> >>> unexpected behaviour. So drop the CLK_SET_RATE_PARENT flag from the P=
LL
> >>> clocks.
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: b8e7e519625f ("clk: qcom: ipq8074: add remaining PLL=E2=80=99s=
")
> >>> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> >>> ---
> >> Stephen, do you think there should be some sort of error
> >> or at least warning thrown when SET_RATE_PARENT is used with
> >> RO ops?
> >>
> >=20
> > Sure? How would that be implemented?
> drivers/clk/clk.c : static void clk_change_rate()
>=20
> if (!skip_set_rate && core->ops->set_rate)
>         core->ops->set_rate(core->hw, core->new_rate, best_parent_rate);
>=20
> ->
>=20
> if (!skip_set_rate) {
>         if (core->ops->set_rate)
>                 core->ops->set_rate(core->hw, core->new_rate,
>                                     best_parent_rate);
>         else
>                 pr_err("bad idea");
> }
>=20

CLK_SET_RATE_PARENT means that "calling clk_set_rate() on this clk will
propagate up to the parent". Changing the rate of the parent could
change the rate of this clk to be the same frequency as the parent if
this clk doesn't have a set_rate clk op, or it could be that this clk
has a fixed divider so during the determine_rate() callback it
calculated what rate the parent should be to achieve the requested rate
in clk_set_rate().

It really matters what determine_rate() returns for a clk and if after
changing rates that rate is actually achieved. I suppose if the
determine_rate() callback returns some rate, and then we recalc rates
and notice that the rate determined earlier doesn't match we're
concerned. So far in the last decade we've never cared about this though
and I'm hesitant to start adding that check. I believe some qcom clk
drivers take a shortcut and round the rate in frequency tables so
whatever is returned in determine_rate() doesn't match what
recalc_rate() calculates.

It would be interesting to get rid of the CLK_SET_RATE_PARENT check in
clk_calc_new_rates() and simply always call clk_calc_new_rates() on the
parent if the parent->rate doesn't match what determine_rate thought it
should be. The framework currently calls the rounding clk op for a clk
and gets back the parent rate that the clk requires to achieve that rate
and then it blindly trusts that the parent rate is going to be achieved.
If the CLK_SET_RATE_PARENT flag is set it calls clk_calc_new_rates()
recursively on the parent, but then it doesn't check that the parent
rate is what was requested. That's mostly there to figure out if the
parent also needs to change rate, i.e. calculating the 'top' clk in a
rate change. Note that this also calls determine_rate again on the
parent, once from the child clk's determine_rate clk op and once from
the framework.

I wouldn't be surprised if some driver is relying on this behavior where
the rate isn't checked after being set. Maybe when we extend struct
clk_rate_request to have a linked list that allows a clk to build up a
chain of rate requests we can also enforce more things like matching
rates on recalc. Then any drivers that are relying on this behavior will
have to opt in to a different method of changing rates and notice that
things aren't working.
