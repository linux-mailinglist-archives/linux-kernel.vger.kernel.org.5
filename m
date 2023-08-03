Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399AF76E250
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbjHCIBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbjHCIAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:00:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E4546A2;
        Thu,  3 Aug 2023 00:50:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9519661C28;
        Thu,  3 Aug 2023 07:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76960C433C7;
        Thu,  3 Aug 2023 07:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691049006;
        bh=TwMah1P/QSs3KjgOLUcqE01UhQrbw1JK1xFtsSHEwdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X7D8YZ4lBRAxDbDf6B/DGXuio8UfUUfaAKHNKkvO2QPOuOqJykURVFA7GOuTGIN+l
         uVTZ/efUIYl1UAmim6cBB8Bb10jMmxNPYRx/b+7BJZRvx3cHSfcauu7GZKouOZ0mCc
         pC+VaT8AnNmNZYFNv0rHAGqRv4qMB/P3by+xi3cc=
Date:   Thu, 3 Aug 2023 09:50:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 1/1] serial: core: Fix serial_base_match() after
 fixing controller port name
Message-ID: <2023080351-chaplain-headgear-bcbb@gregkh>
References: <20230803071034.25571-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803071034.25571-1-tony@atomide.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 10:10:32AM +0300, Tony Lindgren wrote:
> While fixing DEVNAME to be more usable, I broke serial_base_match() as the
> ctrl and port prefix for device names seemed unnecessary.
> 
> The prefixes are still needed by serial_base_match() to probe the serial
> base controller port, and serial tx is now broken.
> 
> Let's fix the issue by checking against dev->type and drv->name instead
> of the prefixes that are no longer in the DEVNAME.
> 
> Fixes: 1ef2c2df1199 ("serial: core: Fix serial core controller port name to show controller id")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202308021529.35b3ad6c-oliver.sang@intel.com
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes since v1:
> - Leave out magic numbers and use str_has_prefix() as suggested by Andy
>   and Greg
> 
> - Improve patch description and add a link for Closes tag as suggested
>   by Jiri
> 
> - Check the name against device_type name since we have it and leave
>   out the changes to try to define names in the header because of the
>   issues noted by Jiri
> 
> - Leave out Tested-by from Mark and Anders as the patch changed

Thanks for this, now queued up.

greg k-h
