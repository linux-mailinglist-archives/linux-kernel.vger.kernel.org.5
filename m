Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E529B8060EB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345718AbjLEVkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEVkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:40:15 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17761A5;
        Tue,  5 Dec 2023 13:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HwfadbfArAOrbi6WFDIy6INcelr36TFFIrCY2kyM2c4=; b=KsNMkEFoe4cCpPVKu9fmLkWvbx
        BQu1ttDZYNRVoM+Kt4dTeJ2Q2VOTg/u9VMWS/moeP4V481ksJ4PaN8j7d4DTqPBwoMPqhlcV/V/S5
        rvxXh03r3El+HsPg2iPM2pMrdSdo86X4XeXH7Zq10ob83U8NF1qiI78+AG312kAr/4+Jw22BzXYBT
        QdgDfmK3BNQOLMJzSdlleXe1Vrd4JfkLOGurOkjzLKYhniDdC4AD2MPsODbPD2AQXJ191TY9yfhfo
        0pHZ/bwR70EdGU6kwjOsJSNCOlF2MOZhWqz13R87mDFTMA/9MRPW+dQusySuXzHKIMtP6coOeXTX+
        AI5lJuwA==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1rAd9L-0006hb-2f; Tue, 05 Dec 2023 22:40:15 +0100
Date:   Tue, 5 Dec 2023 22:40:15 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Jann Horn <jannh@google.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org, Christian Brauner <brauner@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Is xt_owner's owner_mt() racy with sock_orphan()? [worse with
 new TYPESAFE_BY_RCU file lifetime?]
Message-ID: <ZW+Yv6TR+EMBp03f@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, Jann Horn <jannh@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org, Christian Brauner <brauner@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
References: <CAG48ez0TfTAkaRWFCTb44x=TWP_sDZVx-5U2hvfQSFOhghNrCA@mail.gmail.com>
 <CAG48ez1hXk_cffp3dy-bYMcoyCCj-EySYR5SzYrNiRHGD=hOUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AjyCI6p3WJlNZLnJ"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1hXk_cffp3dy-bYMcoyCCj-EySYR5SzYrNiRHGD=hOUg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AjyCI6p3WJlNZLnJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

On Tue, Dec 05, 2023 at 06:08:29PM +0100, Jann Horn wrote:
> On Tue, Dec 5, 2023 at 5:40 PM Jann Horn <jannh@google.com> wrote:
> >
> > Hi!
> >
> > I think this code is racy, but testing that seems like a pain...
> >
> > owner_mt() in xt_owner runs in context of a NF_INET_LOCAL_OUT or
> > NF_INET_POST_ROUTING hook. It first checks that sk->sk_socket is
> > non-NULL, then checks that sk->sk_socket->file is non-NULL, then
> > accesses the ->f_cred of that file.
> >
> > I don't see anything that protects this against a concurrent
> > sock_orphan(), which NULLs out the sk->sk_socket pointer, if we're in
> 
> Ah, and all the other users of ->sk_socket in net/netfilter/ do it
> under the sk_callback_lock... so I guess the fix would be to add the
> same in owner_mt?

Sounds reasonable, although I wonder how likely a socket is to
orphan while netfilter is processing a packet it just sent.

How about the attached patch? Not sure what hash to put into a Fixes:
tag given this is a day 1 bug and ipt_owner/ip6t_owner predate git.

Thanks, Phil

--AjyCI6p3WJlNZLnJ
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-netfilter-xt_owner-Fix-for-unsafe-access-of-sk-sk_so.patch"

From 3e28490e43b04d49e6e7f145a70fff7dd42c8cc5 Mon Sep 17 00:00:00 2001
From: Phil Sutter <phil@nwl.cc>
Date: Tue, 5 Dec 2023 21:58:12 +0100
Subject: [nf PATCH] netfilter: xt_owner: Fix for unsafe access of sk->sk_socket

A concurrently running sock_orphan() may NULL the sk_socket pointer in
between check and deref. Follow other users (like nft_meta.c for
instance) and acquire sk_callback_lock before dereferencing sk_socket.

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 net/netfilter/xt_owner.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/xt_owner.c b/net/netfilter/xt_owner.c
index e85ce69924ae..50332888c8d2 100644
--- a/net/netfilter/xt_owner.c
+++ b/net/netfilter/xt_owner.c
@@ -76,18 +76,23 @@ owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 		 */
 		return false;
 
-	filp = sk->sk_socket->file;
-	if (filp == NULL)
+	read_lock_bh(&sk->sk_callback_lock);
+	filp = sk->sk_socket ? sk->sk_socket->file : NULL;
+	if (filp == NULL) {
+		read_unlock_bh(&sk->sk_callback_lock);
 		return ((info->match ^ info->invert) &
 		       (XT_OWNER_UID | XT_OWNER_GID)) == 0;
+	}
 
 	if (info->match & XT_OWNER_UID) {
 		kuid_t uid_min = make_kuid(net->user_ns, info->uid_min);
 		kuid_t uid_max = make_kuid(net->user_ns, info->uid_max);
 		if ((uid_gte(filp->f_cred->fsuid, uid_min) &&
 		     uid_lte(filp->f_cred->fsuid, uid_max)) ^
-		    !(info->invert & XT_OWNER_UID))
+		    !(info->invert & XT_OWNER_UID)) {
+			read_unlock_bh(&sk->sk_callback_lock);
 			return false;
+		}
 	}
 
 	if (info->match & XT_OWNER_GID) {
@@ -112,10 +117,13 @@ owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 			}
 		}
 
-		if (match ^ !(info->invert & XT_OWNER_GID))
+		if (match ^ !(info->invert & XT_OWNER_GID)) {
+			read_unlock_bh(&sk->sk_callback_lock);
 			return false;
+		}
 	}
 
+	read_unlock_bh(&sk->sk_callback_lock);
 	return true;
 }
 
-- 
2.41.0


--AjyCI6p3WJlNZLnJ--
