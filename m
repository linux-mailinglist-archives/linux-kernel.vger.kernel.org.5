Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F2F7CD629
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbjJRIPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjJRIPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:15:21 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C247B6;
        Wed, 18 Oct 2023 01:15:15 -0700 (PDT)
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.94.2)
        (envelope-from <laforge@gnumonks.org>)
        id 1qt1hq-00BbbJ-Ah; Wed, 18 Oct 2023 10:15:06 +0200
Received: from laforge by nataraja with local (Exim 4.97-RC2)
        (envelope-from <laforge@gnumonks.org>)
        id 1qt1fY-00000002Ylo-3fKj;
        Wed, 18 Oct 2023 10:12:44 +0200
Date:   Wed, 18 Oct 2023 10:12:44 +0200
From:   Harald Welte <laforge@gnumonks.org>
To:     takeru hayasaka <hayatake396@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        osmocom-net-gprs@lists.osmocom.org
Subject: Re: [PATCH net-next v2] ethtool: ice: Support for RSS settings to
 GTP from ethtool
Message-ID: <ZS-TfMKAxHLEiXBl@nataraja>
References: <20231012060115.107183-1-hayatake396@gmail.com>
 <20231016152343.1fc7c7be@kernel.org>
 <CADFiAcKOKiTXFXs-e=WotnQwhLB2ycbBovqS2YCk9hvK_RH2uQ@mail.gmail.com>
 <CADFiAcLiAcyqaOTsRZHex8g-wSBQjCzt_0SBtBaW3CJHz9afug@mail.gmail.com>
 <20231017164915.23757eed@kernel.org>
 <CADFiAc+OnpyNTXntZBkDAf+UfueRotqqWKg+BrApWcL=x_8vjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADFiAc+OnpyNTXntZBkDAf+UfueRotqqWKg+BrApWcL=x_8vjQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Takeru, Jakub and list,

On Wed, Oct 18, 2023 at 10:53:02AM +0900, takeru hayasaka wrote:
> > Let's forget about capabilities of Intel NICs for now - can you as a
> > user think of practical use cases where we'd want to turn on hashing
> > based on TEID for, e.g. gtpu6 and not gtpc6?
> 
> of course!
> There are clearly cases where we would want to use gtpu4|6 instead of gtpc4|6.
> 
> For instance, there are PGWs that have the capability to separate the
> termination of communication of 4G LTE users into Control and User
> planes (C/U).

I would argue it is the standard case in any PGW (or SMF+UPF) to process
GTP-C differently than GTP-U.  That's what the entire CUPS (control/user plane
split) architecture is meant for.

Now the question is how does one implement that? As the related signaling protocols
all allow to specify different IP addresses for GTPv1/v2-C (v1 for 2G/3G
and v2 for 4G) and GTPv1-U (v1 used everywhere) it is always possible to
use separate IP addresses for control and user plane.  It's even normal
that a single GTP-C instance (on one IP) manages multiple GTP-U
instances on other IP-addresses.  Those IPs are then handled by
completely different physical servers/systems/VMs/...

So only in case the user intentionally configures their network to use
the same IP address for GTP-C and GTP-U traffic one will need to start
distinguishing GTP-C and GTP-U on one host/NIC with the RSS mechanism:
Steer the GTP-C traffic to the control plane instance on one CPU and
spread the GTP-U traffic via hash function to multiple other
queues/CPUs.  I personally think it's short-sighted to use identical IPs
for control and user plane, as it means you can never scale out to
multiple machines without introducing some kind of dedicated load
balancer in front.  But assuming some people still want to do it that
way: Yes, then you need the feature to split GTP-C form GTP-U via RSS to
scale well.

What I'm somehwat more wondering about is the usability to load-balance
GTP-C traffic over multiple queues/cores.  As stated earlier, that's
just signaling.

> If we were to propose again, setting aside considerations specific to
> Intel, I believe, considering the users of ethtool, the smallest units
> should be gtpu4|6 and gtpc4|6.

agreed.  Though I'm not entirely sure one would usually want to treat v4
different from v6.  I'd assume they would usually both follow the same
RSS scheme?

> Regarding Extension Headers and such, I think it would be more
> straightforward to handle them implicitly.

I would also agree to that.
-- 
- Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
