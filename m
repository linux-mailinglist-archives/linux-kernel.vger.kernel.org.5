Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791527B6A02
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbjJCNPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbjJCNPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:15:38 -0400
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc08])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E01B100
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 06:15:31 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4S0JGN1SdlzMqN0Q;
        Tue,  3 Oct 2023 13:15:24 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4S0JGM1Ml8zMppBN;
        Tue,  3 Oct 2023 15:15:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1696338924;
        bh=mYXOJz9gAA/llGqc8uja06Dbq61EdeXQL0OOvglJWBw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bjXA7XOX13EKX+vc5LCkJetsHYHgzPULA+1gAEpaqNFZ9FusLSnpTbijlBTmaUUrY
         Go4PIClN/Mzu3FvFYrxZIN7aLTMZqF6EU334UiM+U2PomHPmP2IXgtbzKlNz6XS/Kn
         AgLUGGTixs44NQIt7DiNAxfZnYs+Px6a+AQNKhpI=
Date:   Tue, 3 Oct 2023 15:15:22 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, yusongping@huawei.com,
        artem.kuzin@huawei.com, Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: build warning after merge of the landlock tree
Message-ID: <20231003.ahPha5bengee@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231003142737.381e7dcb@canb.auug.org.au>
 <20230920092641.832134-12-konstantin.meskhidze@huawei.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PowerPC-64 follows the LP64 data model and then uses int-l64.h (instead of
int-ll64.h like most architectures) for user space code.

Here is the same code with the (suggested) "%lu" token on x86_86:

  samples/landlock/sandboxer.c: In function ‘populate_ruleset_net’:
  samples/landlock/sandboxer.c:170:77: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 3 has type ‘__u64’ {aka ‘long long unsigned int’} [-Werror=format=]
    170 |                                 "Failed to update the ruleset with port \"%lu\": %s\n",
        |                                                                           ~~^
        |                                                                             |
        |                                                                             long unsigned int
        |                                                                           %llu
    171 |                                 net_port.port, strerror(errno));
        |                                 ~~~~~~~~~~~~~
        |                                         |
        |                                         __u64 {aka long long unsigned int}


We would then need to cast __u64 to unsigned long long to avoid this warning,
which may look useless, of even buggy, for people taking a look at this sample.

Anyway, it makes more sense to cast it to __u16 because it is the
expected type for a TCP port. I'm updating the patch with that.
Konstantin, please take this fix for the next series:
https://git.kernel.org/mic/c/fc9de206a61a


On Tue, Oct 03, 2023 at 02:27:37PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the landlock tree, today's linux-next build (powerpc
> allyesconfig) produced this warning:
> 
> samples/landlock/sandboxer.c: In function 'populate_ruleset_net':
> samples/landlock/sandboxer.c:170:78: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 3 has type '__u64' {aka 'long unsigned int'} [-Wformat=]
>   170 |                                 "Failed to update the ruleset with port \"%llu\": %s\n",
>       |                                                                           ~~~^
>       |                                                                              |
>       |                                                                              long long unsigned int
>       |                                                                           %lu
>   171 |                                 net_port.port, strerror(errno));
>       |                                 ~~~~~~~~~~~~~                                 
>       |                                         |
>       |                                         __u64 {aka long unsigned int}
> 
> Introduced by commit
> 
>   24889e7a2079 ("samples/landlock: Add network demo")
> 
> -- 
> Cheers,
> Stephen Rothwell


