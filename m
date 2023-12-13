Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A3E810E0B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbjLMKHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbjLMKHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:07:36 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4910A83;
        Wed, 13 Dec 2023 02:07:41 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 797076000F;
        Wed, 13 Dec 2023 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702462059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NNBNl0TQMsl9kyDYCCoCiEJ6n4wPwD+uoJm0c+3lwuY=;
        b=MewhdTNm3jOs2pi3D64QUvQZPkNQ0HPcH3aRaqhy2teQxKwbJVqwXwKAfHep/fpnpTKevP
        9uT3jHCQgEyMVpt8L0D+GqYL9944vOucN+dvsTsYWmMb1tqfDOvegJhwApScWBC9V3KuHw
        O1ZugHSWtvFWXwqF9Et/DSA/ocT3arVyjAf8y4vz8ktb2EF4KVkYhBdiCSgeGQwq0yfIZy
        6km1AVa+Wy/1U6yUGF8MHKNaI9b/tY4KBIVVB3ps4PZtdEvIYtEBZL+9VhXk3sBgApWjWJ
        Vj/drso5e7UJVmQY3Kqq4DsMi0iNud7qKwTU4fiKP1oko/RNmzLxYFDEtRLwBw==
Date:   Wed, 13 Dec 2023 11:07:37 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Luo Jie <quic_luoj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, hkallweit1@gmail.com, robert.marko@sartura.hr,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
Subject: Re: [PATCH v2 1/5] net: mdio: ipq4019: move eth_ldo_rdy before MDIO
 bus register
Message-ID: <20231213110737.6e96dba1@device.home>
In-Reply-To: <ZXiwU7XnIeSY1NG4@shell.armlinux.org.uk>
References: <20231212115151.20016-1-quic_luoj@quicinc.com>
        <20231212115151.20016-2-quic_luoj@quicinc.com>
        <20231212135001.6bf40e4d@device.home>
        <ZXiwU7XnIeSY1NG4@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Russell,

On Tue, 12 Dec 2023 19:11:15 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Tue, Dec 12, 2023 at 01:50:01PM +0100, Maxime Chevallier wrote:
> > Hello,
> > 
> > On Tue, 12 Dec 2023 19:51:46 +0800
> > Luo Jie <quic_luoj@quicinc.com> wrote:  
> > > @@ -252,11 +244,32 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
> > >  	if (IS_ERR(priv->mdio_clk))
> > >  		return PTR_ERR(priv->mdio_clk);
> > >  
> > > -	/* The platform resource is provided on the chipset IPQ5018 */
> > > -	/* This resource is optional */
> > > -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > > -	if (res)
> > > -		priv->eth_ldo_rdy = devm_ioremap_resource(&pdev->dev, res);
> > > +	/* These platform resources are provided on the chipset IPQ5018 or
> > > +	 * IPQ5332.
> > > +	 */
> > > +	/* This resource are optional */
> > > +	for (index = 0; index < ETH_LDO_RDY_CNT; index++) {
> > > +		res = platform_get_resource(pdev, IORESOURCE_MEM, index + 1);
> > > +		if (res) {
> > > +			priv->eth_ldo_rdy[index] = devm_ioremap(&pdev->dev,
> > > +								res->start,
> > > +								resource_size(res));  
> > 
> > You can simplify that sequence by using
> > devm_platform_get_and_ioremap_resource(), which will do both the
> > platform_get_resource and the devm_ioremap at once for you.  
> 
> Sadly it can't if resources are optional. __devm_ioremap_resource()
> which will be capped by devm_platform_get_and_ioremap_resource() will
> be passed a NULL 'res', which will lead to:
> 
>         if (!res || resource_type(res) != IORESOURCE_MEM) {
>                 dev_err(dev, "invalid resource %pR\n", res);
>                 return IOMEM_ERR_PTR(-EINVAL);
>         }
> 
> There isn't an "optional" version of
> devm_platform_get_and_ioremap_resource().
> 

Ah right, I missed that part indeed. Sorry for the noise then, and
thanks for double-checking :)

Best regards,

Maxime
