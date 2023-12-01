Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3D48009F3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378561AbjLALan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378544AbjLALal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:30:41 -0500
Received: from mail21.mail.schwarz (mail21.mail.schwarz [185.124.192.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAF0F1;
        Fri,  1 Dec 2023 03:30:44 -0800 (PST)
X-SCHWARZ-TO: coreteam@netfilter.org, netdev@vger.kernel.org, pabeni@redhat.com,
 edumazet@google.com, kadlec@netfilter.org, pablo@netfilter.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net,
 netfilter-devel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, fw@strlen.de
X-SCHWARZ-ENVELOPEFROM: felix.huettner@mail.schwarz
Received: from unknown (HELO kernel-bug-kernel-bug) ([45.129.43.133])
  by mail21.mail.schwarz with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 11:30:42 +0000
Date:   Fri, 1 Dec 2023 11:30:41 +0000
From:   Felix Huettner <felix.huettner@mail.schwarz>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kadlec@netfilter.org,
        fw@strlen.de, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, shuah@kernel.org, luca.czesla@mail.schwarz,
        max.lamprecht@mail.schwarz
Subject: Re: [PATCH net-next v2] net: ctnetlink: support filtering by zone
Message-ID: <ZWnD4SqjhHXmtXlR@kernel-bug-kernel-bug>
References: <ZWSCPKtDuYRG1XWt@kernel-bug-kernel-bug>
 <ZWSNrlHYdp+URAy6@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWSNrlHYdp+URAy6@calendula>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 27, 2023 at 01:38:06PM +0100, Pablo Neira Ayuso wrote:
> Hi,
> 
> On Mon, Nov 27, 2023 at 11:49:16AM +0000, Felix Huettner wrote:
> > conntrack zones are heavily used by tools like openvswitch to run
> > multiple virtual "routers" on a single machine. In this context each
> > conntrack zone matches to a single router, thereby preventing
> > overlapping IPs from becoming issues.
> > In these systems it is common to operate on all conntrack entries of a
> > given zone, e.g. to delete them when a router is deleted. Previously this
> > required these tools to dump the full conntrack table and filter out the
> > relevant entries in userspace potentially causing performance issues.
> > 
> > To do this we reuse the existing CTA_ZONE attribute. This was previous
> > parsed but not used during dump and flush requests. Now if CTA_ZONE is
> > set we filter these operations based on the provided zone.
> > However this means that users that previously passed CTA_ZONE will
> > experience a difference in functionality.
> > 
> > Alternatively CTA_FILTER could have been used for the same
> > functionality. However it is not yet supported during flush requests and
> > is only available when using AF_INET or AF_INET6.
> 
> You mean, AF_UNSPEC cannot be specified in CTA_FILTER?

Currently ctnetlink_parse_tuple_filter returns EOPNOTSUPP if e.g.
AF_UNSPEC would be passed. This could probably be changed to only
require this for the CTA_IP_SRC and CTA_IP_DST filter flags. However i
am unsure about assumptions in other pieces of code that these fields
exist.

Also CTA_FILTER seems to be currently not supported when deleting
conntrack entries.

> 
> Please, extend libnetfilter_conntrack to support for this feature,
> there is a filter API that can be used for this purpose.

I will do that and post it here (or in the next version) once i am done.

> 
> Thanks.

Thanks for the fast feedback
