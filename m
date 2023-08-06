Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5603D77147D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 12:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjHFKsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 06:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjHFKr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 06:47:59 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEBDB8;
        Sun,  6 Aug 2023 03:47:54 -0700 (PDT)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id C0D4FCF63C;
        Sun,  6 Aug 2023 10:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1691318873; bh=cADcKcnDy8gLxnojyW532VLW7T8QirnxnQhcPDcckqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=W8JMkEKrEKilRpRJOOyop+A9Z1lwHYBuY/Y6h0EpEB4ujaHvE+oviJ34f1Nvj8wP7
         JK52mmBnBsCL3smqQPA0w45gU/AWDa8+0ZFMA87K6BlDCaCAKaXYg0D1AfGJtXsQoG
         ZE+91uFeMiSHfk/2ddeS8L5iq+/0Y9HRh4ArPOPs=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Rob Herring <robh@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Craig Tatlor <ctatlor97@gmail.com>
Subject: Re: [PATCH v2] ARM: dts: qcom: msm8974: correct qfprom node size
Date:   Sun, 06 Aug 2023 12:47:51 +0200
Message-ID: <12394955.O9o76ZdvQC@z3ntu.xyz>
In-Reply-To: <ff6fwomoik6kz4jtbm5jac7jahrtcia5fb6dj5ykxg7xt574sn@ti42sevqj6pk>
References: <20230130-msm8974-qfprom-v2-1-3839cf41d9ee@z3ntu.xyz>
 <866f1f66-8845-2453-ab9c-d125e23ae758@linaro.org>
 <ff6fwomoik6kz4jtbm5jac7jahrtcia5fb6dj5ykxg7xt574sn@ti42sevqj6pk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Montag, 31. Juli 2023 23:45:21 CEST Bjorn Andersson wrote:
> On Thu, Jun 15, 2023 at 08:20:41PM +0200, Konrad Dybcio wrote:
> > On 15.06.2023 20:17, Luca Weiss wrote:
> > > From: Craig Tatlor <ctatlor97@gmail.com>
> > > 
> > > The qfprom actually has size 0x3000, so adjust the reg.
> > > 
> > > Note that the non-ECC-corrected qfprom can be found at 0xfc4b8000
> > > (-0x4000). The current reg points to the ECC-corrected qfprom block
> > > which should have equivalent values at all offsets compared to the
> > > non-corrected version.
> > > 
> > > [luca@z3ntu.xyz: extract to standalone patch and adjust for review
> > > comments]
> > > 
> > > Fixes: c59ffb519357 ("arm: dts: msm8974: Add thermal zones, tsens and
> > > qfprom nodes") Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> > > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > > ---
> > 
> > Not sure of the actual size of the region, maybe Bjorn can help..
> > 
> > Downstream 3.10 suggests 0x60F0, 0x20F0 after adjusting for the ECC offset
> 
> There is indeed 0x3000 bytes until the next region, but afaict the
> corrected ECC values only cover the first 0x800 bytes thereof.
> 
> Can you please let me know if this patch fixes a problem, or just
> makes the numbers look better?

Initially this patch came from a different direction, to make space to use the 
PVS bits for cpufreq. Since Konrad said in earlier revisions that I should 
always use the +0x4000 space for the ECC-corrected variant I've switched to 
that.

If you think it's not useful to have the qfprom size reflect the actual size, 
we can also drop this patch since I don't think it's actually necessary for 
anything that I have lying around in some branches.

I think I've just sent the current patch to make sure the hardware description 
(dts) is as accurate as possible, but of course since any info on Qualcomm is 
very restricted it could also be a bit wrong.

Regards
Luca

> 
> Regards,
> Bjorn
> 
> > Konrad
> > 
> > > Changes in v2:
> > > - Keep base offset but expand reg from 0x1000 to 0x3000 (Konrad)
> > > - Link to v1:
> > > https://lore.kernel.org/r/20230130-msm8974-qfprom-v1-1-975aa0e5e083@z3n
> > > tu.xyz ---
> > > 
> > >  arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi
> > > b/arch/arm/boot/dts/qcom-msm8974.dtsi index 7ed0d925a4e9..3156fe25967f
> > > 100644
> > > --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> > > +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> > > @@ -1194,7 +1194,7 @@ restart@fc4ab000 {
> > > 
> > >  		qfprom: qfprom@fc4bc000 {
> > >  		
> > >  			compatible = "qcom,msm8974-qfprom", 
"qcom,qfprom";
> > > 
> > > -			reg = <0xfc4bc000 0x1000>;
> > > +			reg = <0xfc4bc000 0x3000>;
> > > 
> > >  			#address-cells = <1>;
> > >  			#size-cells = <1>;
> > > 
> > > ---
> > > base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
> > > change-id: 20230130-msm8974-qfprom-619c0e8f26eb
> > > 
> > > Best regards,




