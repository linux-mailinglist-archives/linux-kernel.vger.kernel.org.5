Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FC075A16E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjGSWJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjGSWJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:09:49 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633A31FE2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:09:48 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 4A3FB202EA;
        Thu, 20 Jul 2023 00:09:45 +0200 (CEST)
Date:   Thu, 20 Jul 2023 00:09:43 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 06/15] dt-bindings: display/msm: sc7180-dpu: Describe
 SM6125
Message-ID: <tpkiplw7l2mzdwekynkrg6dwm7svktwm2zooodb3c42btyvo3e@yjrpqem26wtx>
References: <20230718-sm6125-dpu-v3-0-6c5a56e99820@somainline.org>
 <20230718-sm6125-dpu-v3-6-6c5a56e99820@somainline.org>
 <3ce19d8f-97d8-15b6-5148-78e200b112e9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ce19d8f-97d8-15b6-5148-78e200b112e9@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-19 01:06:03, Dmitry Baryshkov wrote:
> On 19/07/2023 00:24, Marijn Suijten wrote:
> > SM6125 is identical to SM6375 except that while downstream also defines
> > a throttle clock, its presence results in timeouts whereas SM6375
> > requires it to not observe any timeouts.  This is represented by
> > reducing the clock array length to 6 so that it cannot be passed.  Note
> > that any SoC other than SM6375 (currently SC7180 and SM6350) are
> > unconstrained and could either pass or leave out this "throttle" clock.
> 
> Could you please describe, what kind of timeouts do you observe? Is this 
> the DSI underruns issue?

Ping-pong timeouts and low(er) framerate.  However, they were previosuly
not happening on a random boot out of tens... and now I can no longer
reproduce the timeout on 4 consecutive boots after adding the throttle
clock.  Could it perhaps be the power domains and opps that we added in
v2 and v3?

We previously discussed in DMs that the rate was bouncing between 25MHz
and 403MHz without the clock specified, and with it it it got set at 385
or 403MHz.  Now, a month or so later, repeatedly running this command
shows 25MHz when the panel is not being refreshed, and between 337 and
403MHz on modetest -r -v:

    sony-pdx201 ~ $ sudo ./debugcc -p sm6125 gcc_disp_throttle_core_clk
                gcc_disp_throttle_core_clk: 337.848277MHz (337848277Hz)

Either all these boots are flukes, or it is really fixed and this patch
should be revised...

> If so, it might be fixed by the MDSS 
> interconnect fix ([1]).
> 
> [1] https://patchwork.freedesktop.org/series/116576/

Might have an effect but I don't have any interconnects defined in this
SoC DT yet.

- Marijn

> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> >   .../devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml   | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
> > index 630b11480496..37f66940c5e3 100644
> > --- a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
> > +++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
> > @@ -15,6 +15,7 @@ properties:
> >     compatible:
> >       enum:
> >         - qcom,sc7180-dpu
> > +      - qcom,sm6125-dpu
> >         - qcom,sm6350-dpu
> >         - qcom,sm6375-dpu
> >   
> > @@ -73,6 +74,19 @@ allOf:
> >           clock-names:
> >             minItems: 7
> >   
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          const: qcom,sm6125-dpu
> > +
> > +    then:
> > +      properties:
> > +        clocks:
> > +          maxItems: 6
> > +
> > +        clock-names:
> > +          maxItems: 6
> > +
> >   examples:
> >     - |
> >       #include <dt-bindings/clock/qcom,dispcc-sc7180.h>
> > 
> 
> -- 
> With best wishes
> Dmitry
> 
