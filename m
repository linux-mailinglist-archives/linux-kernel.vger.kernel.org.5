Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1777F679D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjKWTgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjKWTgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:36:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB50635B7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 11:35:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B49C433C9;
        Thu, 23 Nov 2023 19:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700768122;
        bh=GV33Ja8p/x8b4Sn/8W6w24BkBB0SuBPzuOK/VUIfmCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kzffbtMp78WBKeyMMfCa4mEGqUq9lzjkw2fDZTauERL5arVXwl0L+1GKOwJ0zDTVR
         eYH+EvwoAsbd9P1wNr9SBPQ2DZShOpfEVeO+k14jEkyA7+y89PDy++akk+k3g7uLGQ
         fiYmBDQDUiNYohvD7gFwNOwWhc7XJw+iDoFVlv80=
Date:   Thu, 23 Nov 2023 19:35:19 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v4 3/6] tty: serial: amba-pl011: cleanup driver
Message-ID: <2023112351-liable-handbag-d120@gregkh>
References: <20231123-mbly-uart-v4-0-7f913a74ff89@bootlin.com>
 <20231123-mbly-uart-v4-3-7f913a74ff89@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123-mbly-uart-v4-3-7f913a74ff89@bootlin.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 02:42:41PM +0100, Théo Lebrun wrote:
> Follow recommandations from:
> 
>     $ ./scripts/checkpatch.pl --strict --file \
>             drivers/tty/serial/amba-pl011.c
> 
> It does NOT fix alerts relative to TIOCMBIT which will be dealt with in
> another patch. Fixes following alerts:
> 
>     CHECK: Alignment should match open parenthesis
>     CHECK: Blank lines aren't necessary after an open brace '{'
>     CHECK: Comparison to NULL could be written [...]
>     CHECK: Lines should not end with a '('
>     CHECK: Please don't use multiple blank lines
>     CHECK: Please use a blank line after function/struct/union/enum declarations
>     CHECK: Prefer using the BIT macro
>     CHECK: Unbalanced braces around else statement
>     CHECK: Unnecessary parentheses around [...]
>     CHECK: braces {} should be used on all arms of this statement
>     CHECK: spaces preferred around that '/' (ctx:VxV)
>     CHECK: spaces preferred around that '|' (ctx:VxV)
>     ERROR: do not initialise statics to false
>     WARNING: Comparisons should place the constant on the right side of the test
>     WARNING: Possible unnecessary 'out of memory' message
>     WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
>     WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...
>     WARNING: quoted string split across lines
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/tty/serial/amba-pl011.c | 147 +++++++++++++++++++---------------------
>  1 file changed, 71 insertions(+), 76 deletions(-)

This patch does not apply.

And really, you should have broken it up into smaller pieces and most of
them would have applied :(

Please rebase and break it up and resend.

thanks,

greg k-h
