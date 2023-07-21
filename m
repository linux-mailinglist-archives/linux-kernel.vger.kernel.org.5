Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3053575C1CE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjGUIfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjGUIfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:35:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D152D7B;
        Fri, 21 Jul 2023 01:35:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40F2561880;
        Fri, 21 Jul 2023 08:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDD1C433C9;
        Fri, 21 Jul 2023 08:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689928507;
        bh=6LbigfYqXwFco4QzAjvVJNGTQFJ6Z80yZ4lA9uao7dY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IRJtIxEhfjoSTdAixbjssNlPaTcC4Be+VneENzRk4Nk1bSBm/gmfw+0EU7JoxMbQQ
         bd87n4DieSa7VUMp+PaEzvzKUAPejRqvhfqOaUeGaxbHrc3IGfgtD+vftBorke6ull
         z1s7E7lg6aBKEkKzdUnSI2zrwGRXTLOHO+GF6a4cDGxYYqoQ27W1H3IFo1Tn2T62Iu
         ZX57tFlLQaSt1MdXwL5lgB2l5XvbBQROPp92GW/GTZN84m68LBomxoYm7gXupp3yIq
         vYa6MFUT8SNaHV2qdYw90OYSnLZHH5G2CeFKtytWUDcJp7t7lQGMJ5VzLH7jCYbUJz
         /W6uHoyOCwO2A==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qMlbX-0003Qc-2o;
        Fri, 21 Jul 2023 10:35:15 +0200
Date:   Fri, 21 Jul 2023 10:35:15 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        quic_jackp@quicinc.com, Wesley Cheng <quic_wcheng@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com
Subject: Re: [PATCH v9 06/10] usb: dwc3: qcom: Add support to read IRQ's
 related to multiport
Message-ID: <ZLpDQ0R1BjG8fJk8@hovoldconsulting.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-7-quic_kriskura@quicinc.com>
 <ZK6YrLMn9r39zEeB@hovoldconsulting.com>
 <ef29e520-7b9c-f581-e70a-250df80d3821@quicinc.com>
 <ZLEP6Ekh3unSTiCL@hovoldconsulting.com>
 <7c04ebd9-4def-87d6-0640-35fd0ccd20f5@quicinc.com>
 <9a304650-0360-5509-4922-0818e8e306f5@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a304650-0360-5509-4922-0818e8e306f5@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 12:31:05AM +0530, Krishna Kurapati PSSNV wrote:
> On 7/14/2023 4:10 PM, Krishna Kurapati PSSNV wrote:
> > On 7/14/2023 2:35 PM, Johan Hovold wrote:

> >> I haven't had time to look at your latest replies yet, but as I already
> >> said when reviewing v9, it seems you should be using a common helper for
> >> non-mp and mp.

> >   The gist of my mail was to see if I can defer qcom probe when dwc3 
> > probe fails/or doesn't happen on of_plat_pop (which is logical) so that 
> > we can move setup_irq to after dwc3_register_core so that we know 
> > whether we are MP capable or not. This would help us move all IRQ 
> > reading into one function.

>   I see it is difficult to write a common helper. To do so, we need to 
> know whether the device is MP capable or not in advance. And since it is 
> not possible to know it before of_plat_pop is done, I see only few ways 
> to do it:
> 
> 1. Based on qcom node compatible string, I can read whether the device 
> is MP capable or not and get IRQ's accordingly.

See, it's not impossible. You can also determine whether you have a
multiport controller from looking at the interrupt names which are
indexed and distinct for MP.

> 2. Read the port_info in advance but it needs me to go through some DT 
> props and try getting this info. Or read xhci regs like we are doing in 
> core (which is not good). Also since some Dt props can be missing, is it 
> difficult to get the MP capability info before of_plat_pop is done.

That seem unnecessary currently, but long term we probably need to fix
the design of this driver and defer some setup using callbacks that are
called when the core driver probes. Perhaps now is the time to add such
functionality.

> 3. Remove IRQ handling completely. Just because the device has IRQ's 
> present, I don't see a point in adding them to bindings, and because we 
> added them to bindings, we are making a patch to read them (and since 
> this is a little challenging, the whole of multiport series is blocked 
> although I don't need wakeup support on these interrupts right away).

Again, no. The devicetree binding should describe the hardware
capabilities and that has nothing to do with whether you need this for
you current project or not.

> Can't we let the rest of the patches go through and let interrupt 
> handling for 2nd, 3rd and 4rth ports be taken care later ? I am asking 
> this because I want the rest of the patches which are in good shape now 
> (after fixing the nits mentioned) to get merged atleast. I will make 
> sure to add interrupt handling later in a different series once this is 
> merged once I send v10.

As I've explained in earlier mails, I don't think that is acceptable as
you'd be dumping your technical debt on the community which will be left
to clean up your mess.

> Or if there is a simpler way to do it, I would be happy to take any 
> suggestions and complete this missing part in this series itself.

Using the 'compatible' or 'interrupt-names' properties seems like the
easiest way to determine whether you have an MP controller or not.

Johan
