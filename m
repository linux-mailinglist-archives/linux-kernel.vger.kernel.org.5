Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A157CF1FC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjJSIG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjJSIGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:06:25 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0EB10F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FOPSO6FiB3QX66M6gqwVZiA1AuBpxTympHlKPbEiOLs=; b=YM4Yri7T9GzuZklgdK3vZ846gA
        XEgU1PSFQ7ChhQOfpIuDRqyfrvH9v3tIZDSMPN8StfuB0rjOC2WsQ/X5vhyYcDnVGAhJrj9fQ7dpA
        OHMiAjRXQHKpCbbh6cwUJMDEZO8RezNi2fbzsUEiZ3Cn9Rvffj0LIyvsyrSJ1tcnGxRZf6mhnGw1a
        gUCxNakePpWHYvN2CbpPJ/So+6HPGRPPqgNGspUyPkc2QZ94UidIKbyt4/ekLMOAKGlnITMMRUpOn
        ilgJmuQKADswt7pdiMf5PMZDD/OfGzOCuojpA1Y7wJmzKSRU3fWq0P+yQyOzK7LTPOOo/RIow8WN9
        U1KmstIw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qtO2p-002gvR-1W;
        Thu, 19 Oct 2023 08:06:15 +0000
Date:   Thu, 19 Oct 2023 09:06:15 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Dumazet <edumazet@google.com>
Cc:     gus Gusenleitner Klaus <gus@keba.com>,
        Al Viro <viro@ftp.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: AW: [PATCH] amd64: Fix csum_partial_copy_generic()
Message-ID: <20231019080615.GY800259@ZenIV>
References: <VI1PR0702MB3840EB26EF2A1A35BFEA53BFD9D5A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231018154205.GT800259@ZenIV>
 <VI1PR0702MB3840F2D594B9681BF2E0CD81D9D4A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231019050250.GV800259@ZenIV>
 <20231019061427.GW800259@ZenIV>
 <20231019063925.GX800259@ZenIV>
 <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 09:39:45AM +0200, Eric Dumazet wrote:

> I wonder if the csum_and_copy_...() helpers are really needed in modern days,
> with much bigger cpu caches.
> 
> Maybe we could remove them and use more standard copy + standard
> checksum over kernel buffers.

FWIW, the reason we don't hit that shit all the time is that on almost
all paths all-zeroes block of data would be rejected anyway/could not
happen.  Note that e.g. for ICMPv6 the csum includes the pseudo-header
and there's no way for that to be all-zeroes, etc.

Whatever we do long-term (and I'd really like to get that mess dealt
with properly - fuckup is definitely mine, and I should have checked
the users of that stuff properly back then), I don't believe that
it's doable this late in the cycle.

How about the following:

icmp_reply(): paper over idiocy in csum_partial_copy_nocheck()

csum-and-copy helpers got screwed back in 2020; attempt to
be clever about reporting faults in csum_and_copy_..._user()
had ended up with "all zeroes" being indistinguishable from
"rfc1071 checksum is 0xffff".

The thing is, it almost works - the values modulo 0xffff are
right in all cases, so for purposes of adding them up we
are fine.  And we are almost never asked to calculate the
csum when there's no non-zeroes somewhere in the data.

Unfortunately, ICMPv4 replies provide at least one exception.
It's too late in the cycle to fix that properly; for now
(and for backports) let's take care of that in icmp_reply()
itself.

X-paperbag: brown
Fucked-up-by: Al Viro <viro@zeniv.linux.org.uk>
Reported-by: gus Gusenleitner Klaus <gus@keba.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index b8607763d113..6da09157f722 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -376,6 +376,7 @@ static void icmp_push_reply(struct sock *sk,
 	} else if ((skb = skb_peek(&sk->sk_write_queue)) != NULL) {
 		struct icmphdr *icmph = icmp_hdr(skb);
 		__wsum csum;
+		__sum16 folded;
 		struct sk_buff *skb1;
 
 		csum = csum_partial_copy_nocheck((void *)&icmp_param->data,
@@ -384,7 +385,8 @@ static void icmp_push_reply(struct sock *sk,
 		skb_queue_walk(&sk->sk_write_queue, skb1) {
 			csum = csum_add(csum, skb1->csum);
 		}
-		icmph->checksum = csum_fold(csum);
+		folded = csum_fold(csum);
+		icmph->checksum = folded ? folded : CSUM_MANGLED_0;
 		skb->ip_summed = CHECKSUM_NONE;
 		ip_push_pending_frames(sk, fl4);
 	}
