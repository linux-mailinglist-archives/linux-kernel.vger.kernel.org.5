Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483C5849747
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbkBEKED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Feb 2024 05:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbkBEKEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2024 05:04:01 -0500
Received: from mail22.mail.schwarz (mail22.mail.schwarz [185.124.192.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ACF97;
        Mon,  5 Feb 2024 02:04:05 -0800 (PST)
X-SCHWARZ-TO: coreteam@netfilter.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 i.maximets@ovn.org, kadlec@netfilter.org, davem@davemloft.net,
 netfilter-devel@vger.kernel.org, fw@strlen.de, netdev@vger.kernel.org,
 edumazet@google.com, pablo@netfilter.org, linux-kselftest@vger.kernel.org,
 horms@ovn.org, shuah@kernel.org
X-SCHWARZ-ENVELOPEFROM: felix.huettner@mail.schwarz
Received: from felix.runs.onstackit.cloud ([45.129.43.133])
  by mail22.mail.schwarz with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 10:04:04 +0000
Date:   Mon, 5 Feb 2024 10:04:03 +0000
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
Message-ID: <ZcCyk3/evNdYMJK0@felix.runs.onstackit.cloud>
References: <ZWSCPKtDuYRG1XWt@kernel-bug-kernel-bug>
 <ZYV6hgP35k6Bwk+H@calendula>
 <2032238f-31ac-4106-8f22-522e76df5a12@ovn.org>
 <ZbzOA1D1IGYX2oxS@calendula>
 <Zbzen36ahZaiR+qp@felix.runs.onstackit.cloud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbzen36ahZaiR+qp@felix.runs.onstackit.cloud>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 
> > > Hi, Felix and Pablo.
> > > 
> > > I was looking through the code and the following part is bothering me:
> > > 
> > >  diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
> > >  index fb0ae15e96df..4e9133f61251 100644
> > >  --- a/net/netfilter/nf_conntrack_netlink.c
> > >  +++ b/net/netfilter/nf_conntrack_netlink.c
> > >  @@ -1148,6 +1149,10 @@ static int ctnetlink_filter_match(struct nf_conn *ct, void *data)
> > >          if (filter->family && nf_ct_l3num(ct) != filter->family)
> > >                  goto ignore_entry;
> > >  
> > >  +       if (filter->zone.id != NF_CT_DEFAULT_ZONE_ID &&
> > >  +           !nf_ct_zone_equal_any(ct, &filter->zone))
> > >  +               goto ignore_entry;
> > >  +
> > >          if (filter->orig_flags) {
> > >                  tuple = nf_ct_tuple(ct, IP_CT_DIR_ORIGINAL);
> > >                  if (!ctnetlink_filter_match_tuple(&filter->orig, tuple,
> > > 
> > > If I'm reading that right, the default zone is always flushed, even if the
> > > user requested to flush a different zone.  I.e. the entry is never ignored
> > > for a default zone.  Is that correct or am I reading that wrong?
> > > 
> > > If my observation is correct, then I don't think this functionality can
> > > actually be used by applications as it does something unexpected.
> > 
> > This needs a fix, the NF_CT_DEFAULT_ZONE_ID is used as a marker to
> > indicate if the filtering by zone needs to happen or not.
> > 
> > I'd suggest to add a boolean flag that specifies that zone filtering
> > is set on.

Hi everyone,

i build a patch along with tests for the mentioned issue. However the issue
was rather that the filter would be skipped if we wanted to flush zone 0,
which caused all zones to be flushed.

The fix is available here: https://lore.kernel.org/netdev/ZcCxn9HDsB8DUPrI@felix.runs.onstackit.cloud/T/#u
