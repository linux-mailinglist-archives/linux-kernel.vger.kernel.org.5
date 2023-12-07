Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E658808D0C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjLGQFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443507AbjLGQFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:05:41 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35A9A3;
        Thu,  7 Dec 2023 08:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=SySsyGcu2+Rhlw3fV2fvXq/y4sERddpzVieViCi3PSE=; b=nMuPgILV62egRS6/gPgmdMBvsM
        /dW1GP+wbaffCJ0MeIOCA7YBYiS7npsODPZ6T2ODMIDdLC9Kje6VH1QVTMOpLgPS6tQzCtZp5Kl/I
        2J8RWDKFlzfR/BQ+mAylvcWRbdbLjS1m4m0grM/Cy39rHwBKHLOhRPmktNao7nxesV8E=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:49036 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1rBGsi-00073a-Fe; Thu, 07 Dec 2023 11:05:45 -0500
Date:   Thu, 7 Dec 2023 11:05:44 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, hvilleneuve@dimonoff.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        stable@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Message-Id: <20231207110544.43edc9e404c599bf3dd3bf5c@hugovil.com>
In-Reply-To: <2023120748-macaroni-gaining-335f@gregkh>
References: <20231130191050.3165862-1-hugo@hugovil.com>
        <20231130191050.3165862-2-hugo@hugovil.com>
        <2023120748-macaroni-gaining-335f@gregkh>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 1/7] serial: sc16is7xx: fix snprintf format specifier in
 sc16is7xx_regmap_name()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023 10:45:48 +0900
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, Nov 30, 2023 at 02:10:43PM -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Change snprint format specifier from %d to %u since port_id is unsigned.
> > 
> > Fixes: 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
> > Cc: stable@vger.kernel.org # 6.1.x: 3837a03 serial: sc16is7xx: improve regmap debugfs by using one regmap per port
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> > I did not originally add a "Cc: stable" tag for commit 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
> > as it was intended only to improve debugging using debugfs. But
> > since then, I have been able to confirm that it also fixes a long standing
> > bug in our system where the Tx interrupt are no longer enabled at some
> > point when transmitting large RS-485 paquets (> 64 bytes, which is the size
> > of the FIFO). I have been investigating why, but so far I haven't found the
> > exact cause, altough I suspect it has something to do with regmap caching.
> > Therefore, I have added it as a prerequisite for this patch so that it is
> > automatically added to the stable kernels.
> 
> As you are splitting fixes from non-fixes in this series, please resend
> this as 2 different series, one that I can apply now to my tty-linus
> branch to get merged for 6.7-final, and one that can go into tty-next
> for 6.8-rc1.  Mixing them up here just ensures that they all would get
> applied to tty-next.

Ok, makes sense. Will do after I fix the 0-day issue.

Thank you,
Hugo.
