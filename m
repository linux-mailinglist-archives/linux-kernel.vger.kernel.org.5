Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56C87F9FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjK0Mid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjK0MiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:38:16 -0500
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27301BD;
        Mon, 27 Nov 2023 04:38:16 -0800 (PST)
Received: from [78.30.43.141] (port=38766 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1r7asJ-001Z1Q-Bn; Mon, 27 Nov 2023 13:38:09 +0100
Date:   Mon, 27 Nov 2023 13:38:06 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Felix Huettner <felix.huettner@mail.schwarz>
Cc:     linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kadlec@netfilter.org,
        fw@strlen.de, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, shuah@kernel.org, luca.czesla@mail.schwarz,
        max.lamprecht@mail.schwarz
Subject: Re: [PATCH net-next v2] net: ctnetlink: support filtering by zone
Message-ID: <ZWSNrlHYdp+URAy6@calendula>
References: <ZWSCPKtDuYRG1XWt@kernel-bug-kernel-bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWSCPKtDuYRG1XWt@kernel-bug-kernel-bug>
X-Spam-Score: -1.8 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 27, 2023 at 11:49:16AM +0000, Felix Huettner wrote:
> conntrack zones are heavily used by tools like openvswitch to run
> multiple virtual "routers" on a single machine. In this context each
> conntrack zone matches to a single router, thereby preventing
> overlapping IPs from becoming issues.
> In these systems it is common to operate on all conntrack entries of a
> given zone, e.g. to delete them when a router is deleted. Previously this
> required these tools to dump the full conntrack table and filter out the
> relevant entries in userspace potentially causing performance issues.
> 
> To do this we reuse the existing CTA_ZONE attribute. This was previous
> parsed but not used during dump and flush requests. Now if CTA_ZONE is
> set we filter these operations based on the provided zone.
> However this means that users that previously passed CTA_ZONE will
> experience a difference in functionality.
> 
> Alternatively CTA_FILTER could have been used for the same
> functionality. However it is not yet supported during flush requests and
> is only available when using AF_INET or AF_INET6.

You mean, AF_UNSPEC cannot be specified in CTA_FILTER?

Please, extend libnetfilter_conntrack to support for this feature,
there is a filter API that can be used for this purpose.

Thanks.
