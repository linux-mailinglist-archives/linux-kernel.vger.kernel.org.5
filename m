Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14DC7F8C22
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjKYPn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjKYPnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:43:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0F510A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:44:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C6BC433C8;
        Sat, 25 Nov 2023 15:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700927041;
        bh=Qrz9Crgta9Wt7b9qZI13jZ8oudgxdLa/S94YLvc+XqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1K49k+8bHI4mY3R93lxy0uTAITjIjXEf0g26QcEJ6JQiD2xatWKZ2+/iCoKdhVwYl
         Co53cSyy21YWEXG/xjwQjUP4ZcNksh/PccmhV24AG0/xxVzrq5Pk4haknovu5qsTkE
         b4ntEf4VtNvNnmhZYl2+2BQi1MBfM2B8ebsa42h4=
Date:   Sat, 25 Nov 2023 15:43:59 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 4.19 00/97] 4.19.300-rc1 review
Message-ID: <2023112526-launder-slashed-ab21@gregkh>
References: <20231124171934.122298957@linuxfoundation.org>
 <d48b5514-759f-47a0-b024-494ce87ec60f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d48b5514-759f-47a0-b024-494ce87ec60f@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 01:13:33PM -0600, Daniel Díaz wrote:
> Hello!
> 
> On 24/11/23 11:49 a. m., Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.300 release.
> > There are 97 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.300-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> We see this failure on Arm32:
> -----8<-----
>   /builds/linux/drivers/tty/serial/meson_uart.c: In function 'meson_uart_probe':
>   /builds/linux/drivers/tty/serial/meson_uart.c:728:13: error: 'struct uart_port' has no member named 'has_sysrq'
>     728 |         port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MESON_CONSOLE);
>         |             ^~
>   make[4]: *** [/builds/linux/scripts/Makefile.build:303: drivers/tty/serial/meson_uart.o] Error 1
> ----->8-----

Thanks, now fixed.

> And this one on Arm64:
> -----8<-----
>   /builds/linux/kernel/profile.c: In function 'profile_dead_cpu':
>   /builds/linux/kernel/profile.c:346:27: warning: the comparison will always evaluate as 'true' for the address of 'prof_cpu_mask' will never be NULL [-Waddress]
>     346 |         if (prof_cpu_mask != NULL)
>         |                           ^~
>   /builds/linux/kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
>      49 | static cpumask_var_t prof_cpu_mask;
>         |                      ^~~~~~~~~~~~~
>   /builds/linux/kernel/profile.c: In function 'profile_online_cpu':
>   /builds/linux/kernel/profile.c:383:27: warning: the comparison will always evaluate as 'true' for the address of 'prof_cpu_mask' will never be NULL [-Waddress]
>     383 |         if (prof_cpu_mask != NULL)
>         |                           ^~
>   /builds/linux/kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
>      49 | static cpumask_var_t prof_cpu_mask;
>         |                      ^~~~~~~~~~~~~
>   /builds/linux/kernel/profile.c: In function 'profile_tick':
>   /builds/linux/kernel/profile.c:413:47: warning: the comparison will always evaluate as 'true' for the address of 'prof_cpu_mask' will never be NULL [-Waddress]
>     413 |         if (!user_mode(regs) && prof_cpu_mask != NULL &&
>         |                                               ^~
>   /builds/linux/kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
>      49 | static cpumask_var_t prof_cpu_mask;
>         |                      ^~~~~~~~~~~~~
> ----->8-----

Is this new?  No code in this -rc touches this file, or prof_cpu_mask
that I can tell.  Hints for what went wrong would be appreciated...

thanks,

greg k-h
