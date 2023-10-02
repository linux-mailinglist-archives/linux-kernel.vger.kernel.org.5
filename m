Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA277B5C4E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 22:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbjJBU4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 16:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjJBU4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 16:56:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB7CCE
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 13:55:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7B0C433C8;
        Mon,  2 Oct 2023 20:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696280157;
        bh=3SUjHS1R/+k33+41I8df1OAaO4gb+JCavb+GatMXfr8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ts6e8OPAXbwJSqbHZh7OB/J5bL/OHFILZtb1yBVm7HXPB1PZk/XGQ7AuIW4n29dj+
         ecoBTO+7hrPW8Q6xuPPASkVTEUpIET4SQ0Jsvd2gVlk1zyw1YTaRy14t4smDjHCbYx
         Ip/BJuo0W6EjA2rvCbaan0iEIW+cj78pq0AqAEptDJPl392/1LNQKv84du3Y6mEcD5
         kLx5VdsMxdIHgNASSD2ZmOJqOflab/gjsH9hwidf2wGhMgu6x7m8pUtG4MO1ahLvP5
         y4L8a3M2ByHooguBVfjxXHjB0K4VvDBx4MXBRBHPNchRHELaiLL3HcPvunO0YVRUT/
         sMrIc2mpMLNtQ==
Date:   Mon, 2 Oct 2023 13:55:51 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Rohan G Thomas <rohan.g.thomas@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH net-next 1/1] net: stmmac: xgmac: EST interrupts
 handling
Message-ID: <20231002135551.020f180c@kernel.org>
In-Reply-To: <xwcwjtyy5yx6pruoa3vmssnjzkbeahmfyym4e5lrq2efcwwiym@2upf4ko4mah5>
References: <20230923031031.21434-1-rohan.g.thomas@intel.com>
        <xwcwjtyy5yx6pruoa3vmssnjzkbeahmfyym4e5lrq2efcwwiym@2upf4ko4mah5>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2023 14:25:56 +0300 Serge Semin wrote:
> On Sat, Sep 23, 2023 at 11:10:31AM +0800, Rohan G Thomas wrote:
> > Enabled the following EST related interrupts:
> >   1) Constant Gate Control Error (CGCE)
> >   2) Head-of-Line Blocking due to Scheduling (HLBS)
> >   3) Head-of-Line Blocking due to Frame Size (HLBF)
> >   4) Base Time Register error (BTRE)
> >   5) Switch to S/W owned list Complete (SWLC)
> > Also, add EST errors into the ethtool statistic.
> > 
> > The commit e49aa315cb01 ("net: stmmac: EST interrupts handling and
> > error reporting") and commit 9f298959191b ("net: stmmac: Add EST
> > errors into ethtool statistic") add EST interrupts handling and error
> > reporting support to DWMAC4 core. This patch enables the same support
> > for XGMAC.  
> 
> So, this is basically a copy of what was done for the DW QoS Eth
> IP-core (DW GMAC v4.x/v5.x). IMO it would be better to factor it out
> into a separate module together with the rest of the setup methods
> like it's done for TC or PTP. But since it implies some much more work
> I guess we can leave it as is for now...

I think we can push back a little harder. At the very least we should
get a clear explanation why this copy'n'paste is needed, i.e. what are
the major differences. No?
