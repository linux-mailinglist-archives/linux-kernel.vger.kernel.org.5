Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7E1808668
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjLGLLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379084AbjLGLKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:10:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEEFD54
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 03:11:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0252FC433C8;
        Thu,  7 Dec 2023 11:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701947459;
        bh=1GE+mf0M0KnVzSbveKgDHZnYMGMtfQATU7YdiEcjdfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bRv8qsUpzi+wV0FVGR8+L44XLGzNXSCy3PGcMV7xweY5xGCb/yVLS3xllREgouT8T
         4wt+pnZE0VgOD10Kngj3iBE6nME4nm6VA3HugFaGaE8BAP8DYlf+Vwh609MukT9+/a
         mW/LEHznaNltz20leHIsoDuMI622H94T47KsVowwIcXBgdwjhkKLOh5pHRj1x56spG
         bsJiBnprBudNvERMua54waX5hs7RNnlM+DhDZV5grSUv9h5rwDwilXhwLBFnQ7vzVF
         X/2vsuJbzT1sKTL9Y9oa/BxhTYM3IQ8C6soWrH4PsuIymYQ8vdsPAvaul6E0ozYx/D
         l73Azfkst1uBA==
Date:   Thu, 7 Dec 2023 11:10:55 +0000
From:   Simon Horman <horms@kernel.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     Paolo Abeni <pabeni@redhat.com>, Min Li <lnimi@hotmail.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "lee@kernel.org" <lee@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v6 1/6] ptp: clockmatrix: support 32-bit address
 space
Message-ID: <20231207111055.GF50400@kernel.org>
References: <PH7PR03MB70644CE21E835B48799F3EB3A082A@PH7PR03MB7064.namprd03.prod.outlook.com>
 <20231205092429.GS50400@kernel.org>
 <d657f059d384419fe4df02580a4af9cf69e0e9c2.camel@redhat.com>
 <OS3PR01MB6593B50F4C5BF3687EE3FA97BA84A@OS3PR01MB6593.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3PR01MB6593B50F4C5BF3687EE3FA97BA84A@OS3PR01MB6593.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 04:29:09PM +0000, Min Li wrote:
> > >
> > > Hi Min Li,
> > >
> > > My understanding of Paolo's review of v5 was that it would be cleaner to:
> > >
> > > 1. Leave the type of the module parameter as u16 2. Update the type of
> > > the regaddr parameter to u32
> > 
> > [almost over the air conflict here ;) ]
> > 
> > I think the module parameter as u32 is needed, as later macro definitions
> > will leverage that.

Yes, sorry. I got things muddled up there.

> > > And...
> > >
> > > ... avoid the need for changes like the two above.
> > 
> > This part is correct/what I meant ;)
> > 
> 
> Hi Paolo/Simon
> 
> Thanks for your reviews. Ideally, I would want to maintain regaddr as u16 since for clockmatrix addressing, it is only the lower 8bit of the whole 32bit address while module is upper 24bit. On the other hand, for some simple cases, where only one register in a module, their addresses are defined by module only without regaddr such as sync_ctrl0/1
> 
> Overall, I still want to differentiate between module and regaddr and don't wanna mix them up.

My reading is that this patch reverses the usage of module and regaddr.
F.e. the following hunk:

@@ -553,11 +554,11 @@ static int _sync_pll_output(struct idtcm *idtcm,
	val = SYNCTRL1_MASTER_SYNC_RST;

	/* Place master sync in reset */
	err = idtcm_write(idtcm, 0, sync_ctrl1, &val, sizeof(val));
	err = idtcm_write(idtcm, sync_ctrl1, 0, &val, sizeof(val));
	if (err)
		return err;

	err = idtcm_write(idtcm, 0, sync_ctrl0, &sync_src, sizeof(sync_src));
	err = idtcm_write(idtcm, sync_ctrl0, 0, &sync_src, sizeof(sync_src));
	if (err)
		return err;

If that is really intended I think it needs to be explained, or possibly
a separate patch.
