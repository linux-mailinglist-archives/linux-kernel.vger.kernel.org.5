Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1487D5C32
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 22:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344308AbjJXULz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 16:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343896AbjJXULx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 16:11:53 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D149FD7A;
        Tue, 24 Oct 2023 13:11:49 -0700 (PDT)
Received: from [78.30.35.151] (port=58754 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qvNkf-008pvw-J8; Tue, 24 Oct 2023 22:11:47 +0200
Date:   Tue, 24 Oct 2023 22:11:44 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Vladimir Smelhaus <vl.sm@email.cz>,
        Linux Netfilter <netfilter@vger.kernel.org>,
        coreteam@netfilter.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Subject: Re: Flowtables ignore timeout settings in recent kernels
Message-ID: <ZTglADWVBgKxKOIC@calendula>
References: <ughg4v$130b$1@ciao.gmane.io>
 <ZSyBtn8cplLWoNn-@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZSyBtn8cplLWoNn-@debian.me>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 07:20:06AM +0700, Bagas Sanjaya wrote:
> On Sun, Oct 15, 2023 at 09:56:14PM +0200, Vladimir Smelhaus wrote:
> > Netfilter ignores the timeout settings for a flowtable
> > 
> > # sysctl -a -r flowtable
> > net.netfilter.nf_flowtable_tcp_timeout = 30
> > net.netfilter.nf_flowtable_udp_timeout = 30
> > 
> > Situation. A long udp connection (tunnel) with some data flowing through a
> > router. The connection is sent to a flowtable on the router. It's a few
> > packets per second, more here and there, a pause here and there, and so on
> > over and over. The pauses are minimal and are also limited by the tunnel
> > settings to be no longer than 25 seconds. Everything is satisfying to make
> > the connection last continuously in the flowtable and not reappear in
> > forward. However, the connection keeps dropping out of the flowtable. It
> > stays in the flowtable (offloaded) for a second at most and then it is
> > kicked out, back to forward.
> > 
> > In an attached test script you can see counters that should be zero but are not. If I watch the normal packet flow on a particular router, I can see packets in the conntrack table that should be OFFLOAD as ASSURED.
> > 
> > Tested in kernel 6.5.6. In an old(er) kernel 5.10 it works as expected.
> > 
> 
> Then please perform bisection to find a culprit that introduces your
> regression (see Documentation/admin-guide/bug-bisect.rst in the kernel
> sources for reference). Also, it'd been great if you also post the
> reproducer script inline (within your email) instead, as some MUAs
> (like mutt that I'm using now) may ignore the attachment.
> 
> Anyway, thanks for the regression report. I'm adding it to regzbot:
> 
> #regzbot ^introduced: v5.10..v6.5

Fix here:

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20231024193815.1987-1-pablo@netfilter.org/

it is a bug from Jun 2023, regression was introduced in the v6.5
development cycle.

Thanks for reporting.
