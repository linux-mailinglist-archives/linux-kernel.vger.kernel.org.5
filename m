Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEBF80912D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjLGTXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjLGTXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:23:14 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C6810DC;
        Thu,  7 Dec 2023 11:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1701976997;
        bh=6SYQxYyGrcDvx6IRN+6dIff5PVo7wQPuPHWX4hH6KZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nJRdrpHl406V8Pqv+diMBiUkggs7GtUBNOx0+SSTMlNWhL6h7/9+XQ/o7Ul2ru7YQ
         0TkWrmXbCwMT0a04wtzuExXuKNewvXrDMSts24ePrOt49uTn3dQ+Ap0nA1sV5cT09A
         BvZPUjsgDL//msyJBTFObJS3p7YQtjTXc7BaeONU=
Date:   Thu, 7 Dec 2023 20:23:16 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Joel Granados <j.granados@samsung.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <f327cf10-3680-43ec-a05c-8c038af767c0@t-8ch.de>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <ZW66FhWx7W67Y9rP@bombadil.infradead.org>
 <b4b0b7ea-d8b3-4538-a5b9-87a23bbdac5f@t-8ch.de>
 <CGME20231205171700eucas1p17edbc33ec1d0be37573b1977b76b9ce6@eucas1p1.samsung.com>
 <d50978d8-d4e7-4767-8ea7-5849f05d3be1@t-8ch.de>
 <20231207111957.b24ib4hcxr6xufll@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231207111957.b24ib4hcxr6xufll@localhost>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-07 12:19:57+0100, Joel Granados wrote:
> On Tue, Dec 05, 2023 at 06:16:53PM +0100, Thomas Weißschuh wrote:
> > Hi Luis, Joel,
> > 
> > On 2023-12-05 09:04:08+0100, Thomas Weißschuh wrote:
> > > On 2023-12-04 21:50:14-0800, Luis Chamberlain wrote:
> > > > On Mon, Dec 04, 2023 at 08:52:13AM +0100, Thomas Weißschuh wrote:
> > > > > Tested by booting and with the sysctl selftests on x86.
> > > > 
> > > > Can I trouble you to rebase on sysctl-next?
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-next
> > > 
> > > Will do.
> > 
> > The rebased series is now available at
> > https://git.sr.ht/~t-8ch/linux b4/const-sysctl
> > 
> > Nothing much has changed in contrast to v2.
> > The only functional change so far is the initialization of
> > ctl_table_header::type in init_header().
> > 
> > I'll wait for Joels and maybe some more reviews before resending it.
> > 
> > > [..]
> > 
> > For the future I think it would make sense to combine the tree-wide constification
> > of the structs with the removal of the sentinel values.

> I don't see how these two would fit. And this is why:
> 1. The "remove sentinel" stuff is almost done. With the sets going into
>    6.7 we would only be missing everything under net/*. So you would not
>    be able to combine them (except for the net stuff)
> 2. The motivation for the two sets is differnt. This would confuse
>    rather than simplify the process.
> 3. In order to introduce the const stuff we would have to go through
>    another round of "convincing" which can potentially derail the
>    "remove sentinel" stuff.

Good reasons, especially 1).
 
> I would *not* like to combine them. I think the const set can stand on
> its own.

It was more about a process optimization. If somebody has to touch each
sysctl table anyway and test the changes, doing so for both series would
be easier for the sysctl and subsystem maintainers.

But alas, it seems I have to do it myself and can't heap it onto your
pile :-)

> > 
> > This would reduce the impacts of the maintainers.
