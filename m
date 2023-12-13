Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0C5810CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjLMIuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjLMIuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:50:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38EDB7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:50:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D695DC433C8;
        Wed, 13 Dec 2023 08:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702457410;
        bh=841xqb9Awis9Dqn7Pj9/egR+I9vPc7qKv1YXESMWaLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VgmB2XqIL7yh0oYhsiQJgDFaTJcjP5cVU6YRkvcdGYy2tuXFg/sWkt4ZEadZyercJ
         Yf6oDkaEdRYMvPLA3qCULR9nDuvsT355Wr4HJSTjPEh4qKEcb8FRJbJXGsa79K9Z1G
         AysYL3xPIW+lQBWn7saYOfl+vPRdS2I3fz+JHpCo=
Date:   Wed, 13 Dec 2023 09:50:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Guenter Roeck <linux@roeck-us.net>, dianders@chromium.org,
        grundler@chromium.org, davem@davemloft.net, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: RTL8152_INACCESSIBLE was Re: [PATCH 6.1 000/194] 6.1.68-rc1
 review
Message-ID: <2023121342-wanted-overarch-84a7@gregkh>
References: <20231211182036.606660304@linuxfoundation.org>
 <ZXi9wyS7vjGyUWU8@duo.ucw.cz>
 <a6af01bf-7785-4531-8514-8e5eb09e207e@roeck-us.net>
 <ZXliuTqyO_IjlIz7@amd.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXliuTqyO_IjlIz7@amd.ucw.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 08:52:25AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > This is the start of the stable review cycle for the 6.1.68 release.
> > > > There are 194 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > 
> > > 
> > > > Douglas Anderson <dianders@chromium.org>
> > > >      r8152: Add RTL8152_INACCESSIBLE to r8153_aldps_en()
> > > > 
> > > > Douglas Anderson <dianders@chromium.org>
> > > >      r8152: Add RTL8152_INACCESSIBLE to r8153_pre_firmware_1()
> > > > 
> > > > Douglas Anderson <dianders@chromium.org>
> > > >      r8152: Add RTL8152_INACCESSIBLE to r8156b_wait_loading_flash()
> > > > 
> > > > Douglas Anderson <dianders@chromium.org>
> > > >      r8152: Add RTL8152_INACCESSIBLE checks to more loops
> > > > 
> > > > Douglas Anderson <dianders@chromium.org>
> > > >      r8152: Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE
> > > 
> > > Central patch that actually fixes something is:
> > > 
> > > commit d9962b0d42029bcb40fe3c38bce06d1870fa4df4
> > > Author: Douglas Anderson <dianders@chromium.org>
> > > Date:   Fri Oct 20 14:06:59 2023 -0700
> > > 
> > >      r8152: Block future register access if register access fails
> > > 
> > > ...but we don't have that in 6.1. So we should not need the rest,
> > > either.
> > > 
> > 
> > Also, the missing patch is fixed subsequently by another patch, so it can not
> > be added on its own.
> 
> For the record I'm trying to advocate "drop all patches listed as they
> don't fix the bug", not "add more", as this does not meet stable
> criteria.

But the original commit here does say it fixes a bug, see the text of
the commits listed above.  So perhaps someone got this all wrong when
they wrote the original commits that got merged into 6.7-rc?  Otherwise
this seems like they are sane to keep for now, unless the original
author says they should be dropped, or someone who can test this driver
says something went wrong.

thanks,

greg k-h
