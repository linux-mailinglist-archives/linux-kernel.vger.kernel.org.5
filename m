Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52427B7DAC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjJDLBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242051AbjJDLBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:01:53 -0400
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E23BD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 04:01:48 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4S0sFl0WlJzMqGWl;
        Wed,  4 Oct 2023 11:01:47 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4S0sFf5pRbzMppB8;
        Wed,  4 Oct 2023 13:01:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1696417306;
        bh=gWybje2HvLgDOH5ZYG1Lx+4xobEwytv14WvC0k0ZXhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NlG1gyKYLonJ1+MJppZUKCtoojLOgIeJbKleESzlTWhJtG4VndWzCUSU64xXJh6iu
         T7kCQFVJV6tXIWJ9h2K86LxQSFmErn/4HiC2IYPyQNTVfJ3gA12QhyEXH8o7DQzUOK
         kq+wAhIkTPO2dLkT8kJDGGiT3OXNWvnZsMHiDrF8=
Date:   Wed, 4 Oct 2023 13:01:45 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, yusongping@huawei.com,
        artem.kuzin@huawei.com, Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: build warning after merge of the landlock tree
Message-ID: <20231004.SeachioS1aop@digikod.net>
References: <20231003142737.381e7dcb@canb.auug.org.au>
 <20230920092641.832134-12-konstantin.meskhidze@huawei.com>
 <20231003.ahPha5bengee@digikod.net>
 <CAMuHMdVZsA4H47od6FV9+OzgWB2hnTQGr8YOcAL3yyURdm1AoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVZsA4H47od6FV9+OzgWB2hnTQGr8YOcAL3yyURdm1AoA@mail.gmail.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 03:23:22PM +0200, Geert Uytterhoeven wrote:
> Hi Mickaël,
> 
> On Tue, Oct 3, 2023 at 3:15 PM Mickaël Salaün <mic@digikod.net> wrote:
> > On Tue, Oct 03, 2023 at 02:27:37PM +1100, Stephen Rothwell wrote:
> > > After merging the landlock tree, today's linux-next build (powerpc
> > > allyesconfig) produced this warning:
> > >
> > > samples/landlock/sandboxer.c: In function 'populate_ruleset_net':
> > > samples/landlock/sandboxer.c:170:78: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 3 has type '__u64' {aka 'long unsigned int'} [-Wformat=]
> > >   170 |                                 "Failed to update the ruleset with port \"%llu\": %s\n",
> > >       |                                                                           ~~~^
> > >       |                                                                              |
> > >       |                                                                              long long unsigned int
> > >       |                                                                           %lu
> > >   171 |                                 net_port.port, strerror(errno));
> > >       |                                 ~~~~~~~~~~~~~
> > >       |                                         |
> > >       |                                         __u64 {aka long unsigned int}
> > >
> > > Introduced by commit
> > >
> > >   24889e7a2079 ("samples/landlock: Add network demo")
> >
> > PowerPC-64 follows the LP64 data model and then uses int-l64.h (instead of
> > int-ll64.h like most architectures) for user space code.
> >
> > Here is the same code with the (suggested) "%lu" token on x86_86:
> >
> >   samples/landlock/sandboxer.c: In function ‘populate_ruleset_net’:
> >   samples/landlock/sandboxer.c:170:77: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 3 has type ‘__u64’ {aka ‘long long unsigned int’} [-Werror=format=]
> >     170 |                                 "Failed to update the ruleset with port \"%lu\": %s\n",
> >         |                                                                           ~~^
> >         |                                                                             |
> >         |                                                                             long unsigned int
> >         |                                                                           %llu
> >     171 |                                 net_port.port, strerror(errno));
> >         |                                 ~~~~~~~~~~~~~
> >         |                                         |
> >         |                                         __u64 {aka long long unsigned int}
> >
> >
> > We would then need to cast __u64 to unsigned long long to avoid this warning,
> > which may look useless, of even buggy, for people taking a look at this sample.
> 
> In userspace code, you are supposed to #include <inttypes.h>
> and use PRIu64.

Thanks for these tips!

> 
> > Anyway, it makes more sense to cast it to __u16 because it is the
> > expected type for a TCP port. I'm updating the patch with that.
> > Konstantin, please take this fix for the next series:
> > https://git.kernel.org/mic/c/fc9de206a61a
> 
> Until someone passes a too large number, and it becomes truncated...

That should not happen because it is checked by the kernel (for this
specific case), but let's make it simple and print the 64-bit value.

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
