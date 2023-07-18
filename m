Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B967585B5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjGRTmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGRTl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:41:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22EC198E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:41:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3979260B45
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 19:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471F5C433C7;
        Tue, 18 Jul 2023 19:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689709317;
        bh=e5TeCW4dLFqhF4I7vtXPeuXyiF89ZhZmbGGaNJLtsuU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XZmUyhUNdt4h2uDTeo1tZEPe79idS0yJjGLCyV0L1I75XRoF45kTFlvgfJKdsfY0O
         70bXQtCxFmA4fF/FJTi4i/L8GduaT4jhAhh31ouYhwVq2J6ZH47MBxujs0/OM3jsf4
         SzzL+AMPmvnlFTemY9NkB9Es3O4N3a1XWDzskMDmXClqKcK5i2CIkHMqu2SMmhBCNo
         T8ZP7R59dEajX3QnT997W5kol1+DSOIa43iEIzSXQDeaRHgdK7Ptf2Bd3wpn5QQ4ed
         KPBtxOUPXv2i9NDKdTfgwS+7QHSoo5r1qg8zHtRt/ASTaTtPkG3HD5IS9SyRsHaDU2
         VbQwK9ivcklGA==
Date:   Tue, 18 Jul 2023 12:41:56 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Kees Cook <kees@kernel.org>, justinstitt@google.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] net: dsa: remove deprecated strncpy
Message-ID: <20230718124156.07632716@kernel.org>
In-Reply-To: <dbfb40d7-502e-40c0-bdaf-1616834b64e4@lunn.ch>
References: <20230718-net-dsa-strncpy-v1-1-e84664747713@google.com>
        <316E4325-6845-4EFC-AAF8-160622C42144@kernel.org>
        <20230718121116.72267fff@kernel.org>
        <dbfb40d7-502e-40c0-bdaf-1616834b64e4@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 21:31:04 +0200 Andrew Lunn wrote:
> On Tue, Jul 18, 2023 at 12:11:16PM -0700, Jakub Kicinski wrote:
> > On Tue, 18 Jul 2023 11:05:23 -0700 Kees Cook wrote:  
> > > Honestly I find the entire get_strings API to be very fragile given
> > > the lack of passing the length of the buffer, instead depending on
> > > the string set length lookups in each callback, but refactoring that
> > > looks like a ton of work for an uncertain benefit.  
> > 
> > We have been adding better APIs for long term, and a print helper short
> > term - ethtool_sprintf(). Should we use ethtool_sprintf() here?  
> 
> I was wondering about that as well. There is no variable expansion in
> most cases, so the vsnprintf() is a waste of time.
> 
> Maybe we should actually add another helper:
> 
> ethtool_name_cpy(u8 **data, unsigned int index, const char *name);

I wasn't sure if vsnprintf() is costly enough to bother, but SG.

Probably without the "unsigned int index", since the ethtool_sprintf()
API updates the first argument for the caller.

> Then over the next decade, slowly convert all drivers to it. And then
> eventually replace the u8 with a struct including the length.
> 
> The netlink API is a bit better. It is one kAPI call which does
> everything, and it holds RTNL. So it is less likely the number of
> statistics will change between the calls into the driver.
