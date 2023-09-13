Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B354779EE48
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjIMQcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjIMQcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:32:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E51F19AC;
        Wed, 13 Sep 2023 09:32:32 -0700 (PDT)
Date:   Wed, 13 Sep 2023 18:32:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694622750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r4gwsCbtaC/KCP2BoXEK3NS8uDKgrnFzIZ7+loZXK6g=;
        b=F92ndIr+WDdrx4JuPNU0rZtELDMxoKPv8Nabki68NizO4Aou9gUF2WZN34yowN7COsgXGd
        dAKOfAyYDx9Mqduge5FKPnqSlELFHbes8kF69r4lVYba+3jWI+ymi39idi6HmUckHxfbs6
        t01BBoeDcqYHg7zbBUYQzoF8flrNdHpbIChvVOI4++6NOfT4K6a5o72g19+fKcBKAh4vj6
        xRuPHcU/eDgfor3KUSyOeUFD+HMfsDqqDv2VS73ojXty6c+prhZ/8RDp8nnNa4Nn+vgU8j
        ir+X3b8AL2fFqXKkD9esqBNCuMiO85tGm8cBJ9JhR/FxtUR13dYY7f7MqSDydw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694622750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r4gwsCbtaC/KCP2BoXEK3NS8uDKgrnFzIZ7+loZXK6g=;
        b=j9bYN7ZwjbxQ1gOcDwGpUIQnOLQiDIeJMb+daOcEYVPYBnieDJNVTK0Kk6yAnIab7lMexa
        4QCJMJIwvLFLdSDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kristian Overskeid <koverskeid@gmail.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Oetken <ennoerlangen@gmail.com>
Subject: Re: [PATCH] net: hsr : Provide fix for HSRv1 supervisor frames
 decoding
Message-ID: <20230913163227.ysmJocR0@linutronix.de>
References: <20230825153111.228768-1-lukma@denx.de>
 <20230905080614.ImjTS6iw@linutronix.de>
 <20230905115512.3ac6649c@wsk>
 <20230911165708.0bc32e3c@wsk>
 <20230911150144.cG1ZHTCC@linutronix.de>
 <20230912101828.06cb403d@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912101828.06cb403d@wsk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-12 10:18:28 [+0200], Lukasz Majewski wrote:
> Hi Sebastian,
Hi Lukasz,

> Ok. No problem. Thanks for the information.

So what happens if you try this:

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index b77f1189d19d1..6d14d935ee828 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -288,13 +288,13 @@ void hsr_handle_sup_frame(struct hsr_frame_info *frame)
 
 	/* And leave the HSR tag. */
 	if (ethhdr->h_proto == htons(ETH_P_HSR)) {
-		pull_size = sizeof(struct ethhdr);
+		pull_size = sizeof(struct hsr_tag);
 		skb_pull(skb, pull_size);
 		total_pull_size += pull_size;
 	}
 
 	/* And leave the HSR sup tag. */
-	pull_size = sizeof(struct hsr_tag);
+	pull_size = sizeof(struct hsr_sup_tag);
 	skb_pull(skb, pull_size);
 	total_pull_size += pull_size;
 

Sebastian
