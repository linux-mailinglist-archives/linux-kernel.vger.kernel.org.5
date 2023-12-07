Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A299808D08
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443305AbjLGQCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjLGQCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:02:53 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F39610C3;
        Thu,  7 Dec 2023 08:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=9hxmOxzlmeubWF8MZL43e5U0xtVhFBe0Cobz79lxqI8=; b=zj6odPv7rjZuL72UE9JehHSORQ
        QGDf+Gm9uILicHxNCMYwWZdj0pTcqxXhKJfWWM9FU7fS0pX9lLjuY704AGlZcYh+0+UdcdBMDJaik
        +wURkW151BOqGGrGSUh12VRg/eaHcr5/uHYKEuthIFHWlbg33Bafz4Peqtxz8/CasyZE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52566 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1rBGpw-00072a-QE; Thu, 07 Dec 2023 11:02:53 -0500
Date:   Thu, 7 Dec 2023 11:02:52 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, hvilleneuve@dimonoff.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        stable@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Message-Id: <20231207110252.1c7dfd46c0c5772edda9a770@hugovil.com>
In-Reply-To: <2023120748-swimming-precinct-722c@gregkh>
References: <20231130191050.3165862-1-hugo@hugovil.com>
        <20231130191050.3165862-2-hugo@hugovil.com>
        <2023120748-swimming-precinct-722c@gregkh>
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

On Thu, 7 Dec 2023 10:44:33 +0900
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
> Looks like the 0-day test bot found problems with this, so I'll hold off
> on taking this patch and the rest of the series until that's fixed up
> with a new version of this series.

No problem, I am on it.

Hugo
