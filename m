Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5D375C732
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjGUMyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjGUMyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:54:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BB010D2;
        Fri, 21 Jul 2023 05:54:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B67561B27;
        Fri, 21 Jul 2023 12:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A48C433C7;
        Fri, 21 Jul 2023 12:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689944087;
        bh=YU0/0vE5qTMOXI+Xk0sPcnypQl3n9jpNeOgeKHGPwkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EHDDjDdcMARkqsqFmi345vfUHq9ePb9i7zO2Wjj+GSHalbfWW7Q6JahnsZe+xkcpY
         MN6Suxrhxn0HxeLX+/GdTPoDtRVzX1PHjLNRF6f8YmoL1f/7YWvU4tpJR35pmaK6+z
         fjQ0PO232E7u1p9Kw2+qYExq6gyYX88a+C241h2nwSqcmY5AWYd0oyOpa2NNo/xxCC
         VVH9Ow9QOskAEz6Gfe1S+ASWmD+UJ7G2jxcKGibk6zguGh5Tpp6r/lhNmN6TioeCBw
         qZUqrtiJKmTd7VTrs+GQkvZrRWiscRWxxx/iqIAMSqTjCNpWeqML5Z8rpEAT9TeHSH
         9G5VPNhFw9Ehw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qMpep-0005ax-2Y;
        Fri, 21 Jul 2023 14:54:56 +0200
Date:   Fri, 21 Jul 2023 14:54:55 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, ahalaney@redhat.com
Subject: Re: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
Message-ID: <ZLqAHyD5HH6Ka5pl@hovoldconsulting.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-7-quic_kriskura@quicinc.com>
 <ZIB1JEmLCw41v_4e@hovoldconsulting.com>
 <ZJsDpqttBYtbQ0yg@hovoldconsulting.com>
 <26ae15d1-4e13-3ab7-6844-3a7d3ed03af4@quicinc.com>
 <ZLEOk-9VImJNHYHa@hovoldconsulting.com>
 <f02104c0-d177-0e4e-dcb0-ffca589c8b00@quicinc.com>
 <ZLppB67LyWk1kD8w@hovoldconsulting.com>
 <ea41e06c-bd2a-e375-4e7c-8cff85d29627@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea41e06c-bd2a-e375-4e7c-8cff85d29627@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 02:10:07PM +0200, Konrad Dybcio wrote:
> On 21.07.2023 13:16, Johan Hovold wrote:
> > On Fri, Jul 14, 2023 at 04:08:45PM +0530, Krishna Kurapati PSSNV wrote:
> >> On 7/14/2023 2:30 PM, Johan Hovold wrote:
> >>> On Mon, Jul 03, 2023 at 12:35:48AM +0530, Krishna Kurapati PSSNV wrote:
> >>>> On 6/27/2023 9:13 PM, Johan Hovold wrote:
> >>>>> On Wed, Jun 07, 2023 at 02:16:37PM +0200, Johan Hovold wrote:
> >>>>>> On Sun, May 14, 2023 at 11:19:14AM +0530, Krishna Kurapati wrote:
> >>>
> >>>>>>> -	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
> >>>>>>> -	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
> >>>>>>> -		dev_err(qcom->dev, "HS-PHY not in L2\n");
> >>>>>>> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> >>>>>>> +		val = readl(qcom->qscratch_base + pwr_evnt_irq_stat_reg_offset[i]);
> >>>>>>> +		if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
> >>>>>>> +			dev_err(qcom->dev, "HS-PHY%d not in L2\n", i);
> >>>>>>> +	}
> >>>>>
> >>>>>> When testing this on the X13s I get:
> >>>>>>
> >>>>>> 	dwc3-qcom a4f8800.usb: HS-PHY2 not in L2

> Sidenote, I get this on any Qcom device on any platform I try
> to enter suspend on, without these MP patches.

Ok, that might provide some hint. But on sc8280xp (X13s) we only get it
on one of the four MP ports (i.e. on one out of six ports in total).

While on sa8295p-adp there are no such errors on any port.

Johan
