Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645167F0BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 06:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjKTFow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 00:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjKTFot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 00:44:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF04A13E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 21:44:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84432C433C8;
        Mon, 20 Nov 2023 05:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700459085;
        bh=xMwd22goVNx0T6tDO3m4JjyUIDZiEW0Rduv+odROm9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aQMf0xcbls1MTU8bgulVhh9gj9GLtEDuCuqqGFi/H+xj8tOcl4CSt/zdM6W0nVU8Z
         IXizWTy0vBfPt1LnX6gD98br/oI7LsfZz1D8Uk6PtdY1Gfs2cvTwg6/gbrNTWB1QKL
         oISVuegEoa31Af8qizAqcL3SDaNCiTTL9VNOyEebnCuvWoJNRNXMacp/aerOMJ6QPM
         pV4UVQhlwcm5vmYQgQTukENVMBf0u1J9AcnvT0eRLMAb1RPBkaM8iZr+jaM9q8jN7K
         6LthYoE9VGf76PQLkUeLBgDhDzm+R6zBapN0LVgB7XuuQElK0Aj4X0orXswwxnua4M
         wAZVMBnZ9F6BA==
Date:   Mon, 20 Nov 2023 13:44:34 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] usb: cdns3: support power-off of controller when in
 host role
Message-ID: <20231120054434.GA518673@nchen-desktop>
References: <20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com>
 <20231113-j7200-usb-suspend-v1-4-ad1ee714835c@bootlin.com>
 <20231114083838.GC64573@nchen-desktop>
 <CWYHLRBFE1X1.15330WETL2R7U@tleb-bootlin-xps13-01>
 <20231117033814.GA485583@nchen-desktop>
 <CX0ZY6JPH6HP.3JWUAN8KZ2SZB@tleb-bootlin-xps13-01>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CX0ZY6JPH6HP.3JWUAN8KZ2SZB@tleb-bootlin-xps13-01>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-11-17 10:58:12, Théo Lebrun wrote:
> Hello,
> 
> On Fri Nov 17, 2023 at 4:38 AM CET, Peter Chen wrote:
> > On 23-11-14 12:10:18, Théo Lebrun wrote:
> > > Hello,
> > > 
> > > On Tue Nov 14, 2023 at 9:38 AM CET, Peter Chen wrote:
> > > > > +	if (cdns->pdata && cdns->pdata->quirks & CDNS3_RESET_ON_RESUME)
> > > > > +		cdns->xhci_plat_data->quirks |= XHCI_RESET_ON_RESUME | XHCI_SUSPEND_RESUME_CLKS;
> > > > > +
> > > >
> > > > If you set this flag, how could you support the USB remote wakeup
> > > > request? In that case, the USB bus does not expect re-enumeration.
> > > 
> > > We didn't support remote USB wakeup. Only S2R mattered in our case and
> > > USB remote wakeup wasn't a possibility.
> >
> > Without this patch, will below be hit for your platform:
> >
> > 	/* re-initialize the HC on Restore Error, or Host Controller Error */
> > 	if (temp & (STS_SRE | STS_HCE)) {
> > 		reinit_xhc = true;
> > 		if (!xhci->broken_suspend)
> > 			xhci_warn(xhci, "xHC error in resume, USBSTS 0x%x, Reinit\n", temp);
> > 	}
> 
> Yes it hits. The warning as well. How big of an issue is that?
> 
> My understanding is that this is the expected behavior with reset on
> resume if we don't explicitely pass the flag XHCI_RESET_ON_RESUME. I
> don't think we should be having the broken_suspend bit set as its
> mentioning some specific quirk on AMD hardware.
> 
> Is the only expected difference inbetween having CDNS3_RESET_ON_RESUME &
> not having it is resume time? For reference, the status read is 0x411
> ie STS_HALT | STS_PCD | STS_SRE. xhc_state is zero.
> 

Yes. I know some xHCI controllers have powered off during suspend will
hit it, just would like to confirm if it is the same with yours. If you
don't want remote wakeup, it is most probably the same with quirks you set.

-- 

Thanks,
Peter Chen
