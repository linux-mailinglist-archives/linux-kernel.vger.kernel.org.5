Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDD5812971
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443330AbjLNHfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbjLNHfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:35:32 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A116F95;
        Wed, 13 Dec 2023 23:35:36 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 4FD39206E7;
        Thu, 14 Dec 2023 08:35:31 +0100 (CET)
Date:   Thu, 14 Dec 2023 08:35:27 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     David Lin <yu-hao.lin@nxp.com>
Cc:     Brian Norris <briannorris@chromium.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "francesco@dolcini.it" <francesco@dolcini.it>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v2] wifi: mwifiex: fix STA cannot connect to AP
Message-ID: <ZXqwP7NscRtE1uGL@francesco-nb.int.toradex.com>
References: <20231208234127.2251-1-yu-hao.lin@nxp.com>
 <ZXpjjmD5Se7axJju@google.com>
 <PA4PR04MB96383A106724AC1CE683112BD18CA@PA4PR04MB9638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB96383A106724AC1CE683112BD18CA@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On Thu, Dec 14, 2023 at 02:22:57AM +0000, David Lin wrote:
> > From: Brian Norris <briannorris@chromium.org>
...
> > Nitpick: "fix STA cannot connect to AP" isn't the best commit message; that
> > could describe an enormous number of fixes. Maybe something more like
> > "Configure BSSID consistently when starting AP"?
> 
> Thanks for your suggestion. I will change commit message as you
> suggested. Does it mean I should create another patch from v1?

Just create `[PATCH v3] wifi: mwifiex: fix STA cannot connect to AP`

Add the change suggested by Brian and the tags you received on this v2:

 - Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
 - Tested-by: Rafael Beims <rafael.beims@toradex.com> # Verdin iMX8MP / SD8997 SD
 - Acked-by: Brian Norris <briannorris@chromium.org>

> > Not directly related to this patch, but while you're expanding the size of this
> > command buffer: it always felt like a security-hole-in-waiting that none of
> > these command producers do any kinds of bounds checking.
> > We're just "lucky" that these function only generate contents of ~100 bytes at
> > max, while MWIFIEX_SIZE_OF_CMD_BUFFER=2048. But, just add a few more
> > user-space controlled TLV params, and boom, we'll have ourselves a nice
> > little CVE.
> > 
> > It probably wouldn't hurt to significantly write much of this driver, but at a
> > minimum, we could probably use a few checks like this:
> > 
> >         cmd_size += sizeof(struct host_cmd_tlv_mac_addr);
> >         if (cmd_size > MWIFIEX_SIZE_OF_CMD_BUFFER)
> >                 return -1;
> >         // Only touch tlv *after* the bounds check.
> > 
> > That doesn't need to block this patch, of course.
> > 
> > Brian
> >
> 
> I will modify the code for next patch.

I would suggest not modify this in this patch, we should fix all the code that
is subjected to this potential issue.

I would personally do a follow-up patch just to add the check to avoid
overflowing the cmd buffer everywhere it is used.

Francesco

