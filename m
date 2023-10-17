Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9557CBC5C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbjJQHfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbjJQHfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:35:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6565193;
        Tue, 17 Oct 2023 00:35:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796B6C433C7;
        Tue, 17 Oct 2023 07:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697528114;
        bh=oyQn0fGhBWNG7KRE+BzJzRpJMUNT2Ujk05VM2rd9HmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EuwgqWn2+B9M3RWLetxpdECx9SvQbNsKGBrl9eQzvjXQZLJfxwrG4+PUgJcoDhyMU
         bhGyAnSpC3gJSUIQqN2ZXLEoE07GETXLGVOSylkQXdylbR1B8gsFEtUmlyq/sOuvq+
         eCXZjqyWUQzPm6Nk4oqG5P5lqhbjLF943eDkYBoo=
Date:   Tue, 17 Oct 2023 09:20:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH v2] staging: rtl8192u: Remove broken driver
Message-ID: <2023101752-canteen-uniformly-acc1@gregkh>
References: <20231014211051.GA29518@matrix-ESPRIMO-P710>
 <3d1355bc-d359-4ff6-aee1-fbc84437efec@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d1355bc-d359-4ff6-aee1-fbc84437efec@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 07:33:49AM +0200, Thorsten Leemhuis wrote:
> On 14.10.23 23:10, Philipp Hortmann wrote:
> > Tests on rtl8192u hardware have shown that this driver is broken since
> > 2016. Remove broken driver. Find fix for two bugs in second link.
> > 
> > Link: https://lore.kernel.org/lkml/db98d9ac-7650-4a72-8eb9-4def1f17ea0d@app.fastmail.com/
> > Link: https://lore.kernel.org/lkml/cover.1697089416.git.philipp.g.hortmann@gmail.com/
> > Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> > ---
> > V2: Added 2x links and adapted description.
> > 
> > Did not find any artifacts of rtl8192u in MAINTAINERS.
> > ---
> >  drivers/staging/Kconfig                       |    2 -
> >  drivers/staging/rtl8192u/Kconfig              |   12 -
> > [...]
> 
> My daily linux-next builds for Fedora (based on Fedora rawhide config)
> failed today with this error msg:
> 
> """
> + /usr/bin/make -s 'HOSTCFLAGS=-O2  -fexceptions -g
> -grecord-gcc-switches -pipe -Wall -Werror=format-security
> -Werror=implicit-function-declaration -Werror=implicit-int
> -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS
> -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
> -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -m64 -mcpu=power8
> -mtune=power8 -fasynchronous-unwind-tables -fstack-clash-protection '
> 'HOSTLDFLAGS=-Wl,-z,relro -Wl,--as-needed  -Wl,-z,now
> -specs=/usr/lib/rpm/redhat/redhat-hardened-ld
> -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -Wl,--build-id=sha1
> -specs=/usr/lib/rpm/redhat/redhat-package-notes ' -j2 mrproper
> scripts/Makefile.clean:12: drivers/staging/rtl8192u/Makefile: No such
> file or directory
> make[5]: *** No rule to make target 'drivers/staging/rtl8192u/Makefile'.
>  Stop.
> make[4]: *** [scripts/Makefile.clean:61: drivers/staging/rtl8192u] Error 2
> make[3]: *** [scripts/Makefile.clean:61: drivers/staging] Error 2
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [scripts/Makefile.clean:61: drivers] Error 2
> make[1]: ***
> [/builddir/build/BUILD/kernel-next-20231017/linux-6.6.0-0.0.next.20231017.447.vanilla.fc40.ppc64le/Makefile:1920:
> _clean_.] Error 2
> make: *** [Makefile:236: __sub-make] Error 2
> error: Bad exit status from /var/tmp/rpm-tmp.TJDlJV (%build)
> """
> 
> Full log:
> https://copr-be.cloud.fedoraproject.org/results/@kernel-vanilla/next/fedora-rawhide-ppc64le/06536998-next-next-all/builder-live.log.gz
> 
> Made me wonder if this patch left something behind; a quick grep showed
> something suspicious in drivers/staging/Makefile:
> """
> obj-$(CONFIG_RTL8192U)		+= rtl8192u/
> """

If you did 'make oldconfig' the option should have been removed and then
this line wouldn't have triggered, right?  Odd, but I'll go drop this
entry as well.

thanks,

greg k-h
