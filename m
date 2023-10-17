Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5655F7CBB86
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjJQGpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQGpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:45:12 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A33DA7;
        Mon, 16 Oct 2023 23:45:10 -0700 (PDT)
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.94.2)
        (envelope-from <laforge@gnumonks.org>)
        id 1qsdpC-003Ysp-QU; Tue, 17 Oct 2023 08:45:07 +0200
Received: from laforge by nataraja with local (Exim 4.97-RC2)
        (envelope-from <laforge@gnumonks.org>)
        id 1qsdoQ-000000020rj-2TUW;
        Tue, 17 Oct 2023 08:44:18 +0200
Date:   Tue, 17 Oct 2023 08:44:18 +0200
From:   Harald Welte <laforge@gnumonks.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Takeru Hayasaka <hayatake396@gmail.com>,
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
Message-ID: <ZS4tQpFq6CnrKGIc@nataraja>
References: <20231012060115.107183-1-hayatake396@gmail.com>
 <20231016152343.1fc7c7be@kernel.org>
 <ZS4lkKv3xfnkEWRi@nataraja>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS4lkKv3xfnkEWRi@nataraja>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On Tue, Oct 17, 2023 at 08:11:28AM +0200, Harald Welte wrote:
> I cannot really comment on that, as I haven't yet been thinking about how RSS
> might potentially be used in GTPU use cases.  I would also appreciate
> some enlightenment on that.  What kind of network element/function are we talking
> about (my guess is an UPF).  How does its architecture look like to spread GTPU flows
> across CPUs using RSS?

Thinking of this a few more minutes: In my opinion the usual use case
would be to perform RSS distribution based on a (hash of) the TEID,
possibly in combination with the destination IP(v4/v6) address of the
outer IP header, and possibly also including the [outer] destination UDP
port number.

The latter could likely be always included in the hash, as either it is
the standard port (like in all public standard GTPU traffic) and would
hence not contribute to the distribution across the hash function, or it
would be a non-standard port number in some kind of private/custom
deployment, and then you would want to use it to differentiate traffic,
as otherwise you wouldn't use non-standard ports.

> +#define GTPU_V4_FLOW 0x13    /* hash only */
> +#define GTPU_V6_FLOW 0x14    /* hash only */

so if I'm guessing correctly, those would be hashing only on the V4/V6
destination address?  Why would that be GTP specific?  The IPv4/v6
header in front of the GTP header is a normal IP header.

> +#define GTPC_V4_FLOW 0x15    /* hash only */
> +#define GTPC_V6_FLOW 0x16    /* hash only */

Are there really deployments where the *very limited* GTP-C control
traffic needs RSS for scalability?  The control plane GTP-C traffic
during session setup or mobility is extremely little, compared to GTP-U.

Also, same question applies: Why is hasing the v4/v6 destination address
GTP specific and not generic like any other IP packet?

> +#define GTPC_TEID_V4_FLOW 0x17       /* hash only */
> +#define GTPC_TEID_V6_FLOW 0x18       /* hash only */

Why do we have TEID based hashing only in GTP-C?  The User plane in
GTP-U is normally what you'd want to load-share across CPUs/nodes/...
That's where you have thousands to millions more packets than GTP-C.
What am I missing?

> +#define GTPU_EH_V4_FLOW 0x19 /* hash only */
> +#define GTPU_EH_V6_FLOW 0x20 /* hash only */
> +#define GTPU_UL_V4_FLOW 0x21 /* hash only */
> +#define GTPU_UL_V6_FLOW 0x22 /* hash only */
> +#define GTPU_DL_V4_FLOW 0x23 /* hash only */
> +#define GTPU_DL_V6_FLOW 0x24 /* hash only */

Can you explain what those are supposed to do?  what exactly are those
hashing on?

IMHO that kind of explanation should be in the comment next to the
#define (for all of them) rather than "hash only".  That way it's
obvious to the reader what they do, rather than having to guess.

-- 
- Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
