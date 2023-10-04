Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E917B7DC1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjJDLE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242214AbjJDLCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:02:20 -0400
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [IPv6:2001:1600:4:17::190c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D74EC4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 04:02:16 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4S0sGG5VqQzMqBgl;
        Wed,  4 Oct 2023 11:02:14 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4S0sGD2t0SzMppKM;
        Wed,  4 Oct 2023 13:02:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1696417334;
        bh=ykMu7wUYzgFvuDZ0CG84JZTWl5H2yiOE35Ezb8Q8IBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aGm6yXkxSlt7Dsy/LA1bJBD9HJ16gTSzg2aXKERwe1o0CJGBcfVv6Qe6CMp6Addnm
         pw5b8tVBCrsxyutWFQjlfsrb1Oe26L2qfjjQkp+NM7iZ/rFM5dRy71KkNEZkyd5TYJ
         sBuVUTjM5z0l9lqBJZNnSVZDjICADSuVibhMC+JE=
Date:   Wed, 4 Oct 2023 13:02:15 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        gnoack3000@gmail.com, linux-security-module@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org,
        yusongping@huawei.com, artem.kuzin@huawei.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: build warning after merge of the landlock tree
Message-ID: <20231004.ieZ2eekae5Ch@digikod.net>
References: <20231003.ahPha5bengee@digikod.net>
 <0174c612-ed97-44f3-bec5-1f512f135d21@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0174c612-ed97-44f3-bec5-1f512f135d21@app.fastmail.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 03:40:23PM +0200, Arnd Bergmann wrote:
> On Tue, Oct 3, 2023, at 15:15, Mickaël Salaün wrote:
> > PowerPC-64 follows the LP64 data model and then uses int-l64.h (instead of
> > int-ll64.h like most architectures) for user space code.
> >
> > Here is the same code with the (suggested) "%lu" token on x86_86:
> >
> >   samples/landlock/sandboxer.c: In function ‘populate_ruleset_net’:
> >   samples/landlock/sandboxer.c:170:77: error: format ‘%lu’ expects 
> > argument of type ‘long unsigned int’, but argument 3 has type ‘__u64’ 
> > {aka ‘long long unsigned int’} [-Werror=format=]
> >     170 |                                 "Failed to update the ruleset 
> > with port \"%lu\": %s\n",
> >         |                                                               
> >             ~~^
> >         |                                                               
> >               |
> >         |                                                               
> >               long unsigned int
> >         |                                                               
> >             %llu
> >     171 |                                 net_port.port, 
> > strerror(errno));
> >         |                                 ~~~~~~~~~~~~~
> >         |                                         |
> >         |                                         __u64 {aka long long 
> > unsigned int}
> >
> >
> > We would then need to cast __u64 to unsigned long long to avoid this warning,
> > which may look useless, of even buggy, for people taking a look at this sample.
> >
> > Anyway, it makes more sense to cast it to __u16 because it is the
> > expected type for a TCP port. I'm updating the patch with that.
> > Konstantin, please take this fix for the next series:
> > https://git.kernel.org/mic/c/fc9de206a61a
> >
> >
> > On Tue, Oct 03, 2023 at 02:27:37PM +1100, Stephen Rothwell wrote:
> >> Hi all,
> >> 
> >> After merging the landlock tree, today's linux-next build (powerpc
> >> allyesconfig) produced this warning:
> >> 
> >> samples/landlock/sandboxer.c: In function 'populate_ruleset_net':
> >> samples/landlock/sandboxer.c:170:78: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 3 has type '__u64' {aka 'long unsigned int'} [-Wformat=]
> >>   170 |                                 "Failed to update the ruleset with port \"%llu\": %s\n"
> 
> I think defining the __SANE_USERSPACE_TYPES__ macro should take care of this,
> then __u64 has the same type as it does in the kernel.

Thanks! I didn't know about this macro. We'll use that and print the
full 64-bit value.

> 
>         Arnd
