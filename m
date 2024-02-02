Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71B7847035
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbkBBMYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Feb 2024 07:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbkBBMYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2024 07:24:03 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Feb 2024 04:24:03 PST
Received: from mail22.mail.schwarz (mail22.mail.schwarz [185.124.192.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC5E97;
        Fri,  2 Feb 2024 04:24:03 -0800 (PST)
X-SCHWARZ-TO: coreteam@netfilter.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 i.maximets@ovn.org, kadlec@netfilter.org, davem@davemloft.net,
 netfilter-devel@vger.kernel.org, fw@strlen.de, netdev@vger.kernel.org,
 edumazet@google.com, pablo@netfilter.org, linux-kselftest@vger.kernel.org,
 horms@ovn.org, shuah@kernel.org
X-SCHWARZ-ENVELOPEFROM: felix.huettner@mail.schwarz
Received: from felix.runs.onstackit.cloud ([45.129.43.133])
  by mail22.mail.schwarz with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 12:22:56 +0000
Date:   Fri, 2 Feb 2024 12:22:55 +0000
From:   Felix Huettner <felix.huettner@mail.schwarz>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Ilya Maximets <i.maximets@ovn.org>, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kadlec@netfilter.org, fw@strlen.de, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, shuah@kernel.org,
        luca.czesla@mail.schwarz, max.lamprecht@mail.schwarz,
        Simon Horman <horms@ovn.org>
Subject: Re: [PATCH net-next v2] net: ctnetlink: support filtering by zone
Message-ID: <Zbzen36ahZaiR+qp@felix.runs.onstackit.cloud>
References: <ZWSCPKtDuYRG1XWt@kernel-bug-kernel-bug>
 <ZYV6hgP35k6Bwk+H@calendula>
 <2032238f-31ac-4106-8f22-522e76df5a12@ovn.org>
 <ZbzOA1D1IGYX2oxS@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbzOA1D1IGYX2oxS@calendula>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_50,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2024 at 12:12:03PM +0100, Pablo Neira Ayuso wrote:
> On Fri, Feb 02, 2024 at 12:04:35PM +0100, Ilya Maximets wrote:
> > On 12/22/23 13:01, Pablo Neira Ayuso wrote:
> > > On Mon, Nov 27, 2023 at 11:49:16AM +0000, Felix Huettner wrote:
> > >> conntrack zones are heavily used by tools like openvswitch to run
> > >> multiple virtual "routers" on a single machine. In this context each
> > >> conntrack zone matches to a single router, thereby preventing
> > >> overlapping IPs from becoming issues.
> > >> In these systems it is common to operate on all conntrack entries of a
> > >> given zone, e.g. to delete them when a router is deleted. Previously this
> > >> required these tools to dump the full conntrack table and filter out the
> > >> relevant entries in userspace potentially causing performance issues.
> > >>
> > >> To do this we reuse the existing CTA_ZONE attribute. This was previous
> > >> parsed but not used during dump and flush requests. Now if CTA_ZONE is
> > >> set we filter these operations based on the provided zone.
> > >> However this means that users that previously passed CTA_ZONE will
> > >> experience a difference in functionality.
> > >>
> > >> Alternatively CTA_FILTER could have been used for the same
> > >> functionality. However it is not yet supported during flush requests and
> > >> is only available when using AF_INET or AF_INET6.
> > > 
> > > For the record, this is applied to nf-next.
> > 
> > Hi, Felix and Pablo.
> > 
> > I was looking through the code and the following part is bothering me:
> > 
> >  diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
> >  index fb0ae15e96df..4e9133f61251 100644
> >  --- a/net/netfilter/nf_conntrack_netlink.c
> >  +++ b/net/netfilter/nf_conntrack_netlink.c
> >  @@ -1148,6 +1149,10 @@ static int ctnetlink_filter_match(struct nf_conn *ct, void *data)
> >          if (filter->family && nf_ct_l3num(ct) != filter->family)
> >                  goto ignore_entry;
> >  
> >  +       if (filter->zone.id != NF_CT_DEFAULT_ZONE_ID &&
> >  +           !nf_ct_zone_equal_any(ct, &filter->zone))
> >  +               goto ignore_entry;
> >  +
> >          if (filter->orig_flags) {
> >                  tuple = nf_ct_tuple(ct, IP_CT_DIR_ORIGINAL);
> >                  if (!ctnetlink_filter_match_tuple(&filter->orig, tuple,
> > 
> > If I'm reading that right, the default zone is always flushed, even if the
> > user requested to flush a different zone.  I.e. the entry is never ignored
> > for a default zone.  Is that correct or am I reading that wrong?
> > 
> > If my observation is correct, then I don't think this functionality can
> > actually be used by applications as it does something unexpected.
> 
> This needs a fix, the NF_CT_DEFAULT_ZONE_ID is used as a marker to
> indicate if the filtering by zone needs to happen or not.
> 
> I'd suggest to add a boolean flag that specifies that zone filtering
> is set on.

Hi Pablo and Ilya,

thanks for finding that.
i will build a fix for that.

