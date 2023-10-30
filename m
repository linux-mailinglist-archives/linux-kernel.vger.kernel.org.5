Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38EA7DBB91
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbjJ3OQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjJ3OQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:16:31 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A30DE;
        Mon, 30 Oct 2023 07:16:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9c773ac9b15so675497366b.2;
        Mon, 30 Oct 2023 07:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698675387; x=1699280187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NotOi/IQjQkafFHNa5lm4v8ln1I7duJrUMZ0i8r8XoY=;
        b=bDXaHL8PLPPM2HKcmQ45j1GhEku5gHYz4UmtXvjfXdYu7CXKJtu7ChfoIdeVNwxFUX
         09oCp3yvnGQYrP1R6y2o2tl7Sz6j8xgMiRi8vSgo1GnNceZXcQK1lKyBgNA7UutLy9HL
         +nelcrE0PVGFQGMJvBVyao7MJ52wrhICgWtAQn/2wP+01AVPnG3L4JyG+kfJ6u3Gyw0q
         7in7eZPlqQTvoEVi5tAh4jLQ3KxlId6w5Eqsr6YphCpwJm6OFVHMruIga4z+IIW1jUwS
         O/1/jkZQRi+vsvzP5cFXdV/Ck1bpiCCOGJRIzPkjpUI36VtvDibdIeBKTdwZpgqvX8zb
         9vFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698675387; x=1699280187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NotOi/IQjQkafFHNa5lm4v8ln1I7duJrUMZ0i8r8XoY=;
        b=CKEp5pu5cv9AJZlBqQLqPSfBP1PGT+Z0qDACRBjX09AmCfNFToqStZgDHy6Ezu+Bwd
         Lp6PVfRSuZBy8/DnzD3PLhz5mwkRinUNrJiqQrohO4HT4qxy1S3ugxYa/qc9LLYxGJth
         rcisXMZY3sc6N2VWkMDmRfU8b9MjnnQQ9gsXQUs5s1QASzb/ezZQKt8y5VxopsATh1WC
         qGyiaQLN+HUMvsGYRlddAlIzyEcswMRlQxR8I/AuYiJH/R/QL/FVeXhPGgKFxFDro9mn
         d2fqOsg7hsQofrLBf2JyqMXwF54RpKowOMbWizDya2MXhDo4hR8Ue1RK2llx5TUoPamC
         2TMQ==
X-Gm-Message-State: AOJu0Yydo1jIqIttHx45741+1roF3sbmaUmtthoLLIC8ZF/qhr/Q1EvW
        X5UiD4X/rB4KQeyvgNc7Yno=
X-Google-Smtp-Source: AGHT+IHIhDbQTbb2pT5sEOcg8opE2jO+TfDUzPSTq+WgT93QauODCdQY5CVihq5WGK5Ym2t0j5UUIg==
X-Received: by 2002:a17:906:a198:b0:9d3:f436:6804 with SMTP id s24-20020a170906a19800b009d3f4366804mr1660027ejy.29.1698675386476;
        Mon, 30 Oct 2023 07:16:26 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id g16-20020a1709064e5000b0098951bb4dc3sm6075214ejw.184.2023.10.30.07.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 07:16:26 -0700 (PDT)
Date:   Mon, 30 Oct 2023 16:16:23 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
Message-ID: <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 10:26:50AM +0100, Linus Walleij wrote:
> It was reported that the "LuCI" web UI was not working properly
> with a device using the RTL8366RB switch. Disabling the egress
> port tagging code made the switch work again, but this is not
> a good solution as we want to be able to direct traffic to a
> certain port.
> 
> It turns out that packets between 1496 and 1500 bytes are
> dropped unless padded out to 1518 bytes.
> 
> If we pad the ethernet frames to a minimum of ETH_FRAME_LEN + FCS
> (1518 bytes) everything starts working fine.
> 
> 1496 is the size of a normal data frame minus the internal DSA
> tag. The number is intuitive, the explanation evades me.
> 
> As we completely lack datasheet or any insight into how this
> switch works, this trial-and-error solution is the best we
> can do. FWIW this bug may very well be the reason why Realteks
> code drops are not using CPU tagging. The vendor routers using
> this switch are all hardwired to disable CPU tagging and all
> packets are pushed to all ports on TX. This is also the case
> in the old OpenWrt driver, derived from the vendor code drops.
> 
> I have tested smaller sizes, only 1518 or bigger padding works.
> 
> Modifying the MTU on the switch (one setting affecting all
> ports) has no effect.
> 
> Before this patch:
> 
> PING 192.168.1.1 (192.168.1.1) 1470(1498) bytes of data.
> ^C
> --- 192.168.1.1 ping statistics ---
> 2 packets transmitted, 0 received, 100% packet loss, time 1048ms
> 
> PING 192.168.1.1 (192.168.1.1) 1472(1500) bytes of data.
> ^C
> --- 192.168.1.1 ping statistics ---
> 12 packets transmitted, 0 received, 100% packet loss, time 11267ms
> 
> After this patch:
> 
> PING 192.168.1.1 (192.168.1.1) 1470(1498) bytes of data.
> 1478 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=0.533 ms
> 1478 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=0.630 ms
> 
> PING 192.168.1.1 (192.168.1.1) 1472(1500) bytes of data.
> 1480 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=0.527 ms
> 1480 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=0.562 ms
> 
> Also LuCI starts working with the 1500 bytes frames it produces
> from the HTTP server.
> 
> Fixes: 9eb8bc593a5e ("net: dsa: tag_rtl4_a: fix egress tags")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v2:
> - Pad packages >= 1496 bytes after some further tests
> - Use more to-the-point description
> - Provide ping results in the commit message
> - Link to v1: https://lore.kernel.org/r/20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org
> ---
>  net/dsa/tag_rtl4_a.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/net/dsa/tag_rtl4_a.c b/net/dsa/tag_rtl4_a.c
> index c327314b95e3..3292bc49b158 100644
> --- a/net/dsa/tag_rtl4_a.c
> +++ b/net/dsa/tag_rtl4_a.c
> @@ -45,6 +45,16 @@ static struct sk_buff *rtl4a_tag_xmit(struct sk_buff *skb,
>  	if (unlikely(__skb_put_padto(skb, ETH_ZLEN, false)))
>  		return NULL;
>  
> +	/* Packets over 1496 bytes get dropped unless they get padded
> +	 * out to 1518 bytes. 1496 is ETH_DATA_LEN - tag which is hardly
> +	 * a coinicidence, and 1518 is ETH_FRAME_LEN + FCS so we define
> +	 * the threshold size and padding like this.
> +	 */
> +	if (skb->len >= (ETH_DATA_LEN - RTL4_A_HDR_LEN)) {
> +		if (unlikely(__skb_put_padto(skb, ETH_FRAME_LEN + ETH_FCS_LEN, false)))
> +			return NULL;
> +	}

De-obfuscating the macros:

	if (skb->len >= 1496)
		__skb_put_padto(skb, 1518, false);

	(...)

	skb_push(skb, 4);

which means that here, skb->len will be 1522, if it was originally 1496.
So the code adds 26 extra octets, and only 4 of those are legitimate (a tag).
The rest is absolutely unexplained, which means that until there is a
valid explanation for them:

pw-bot: cr

(sorry, but if it works and we don't know why it works, then at some
point it will break and we won't know why it stopped working)

In the discussion on the previous thread:
https://lore.kernel.org/netdev/CACRpkdbq03ZXcB-TaBp5Udo3M47rb-o+LfkEkC-gA1+=x1Zd-g@mail.gmail.com/

you said that what increments is Dot1dTpPortInDiscards. 802.1Q-2018 says
about it: "Count of received valid frames that were discarded (i.e.,
filtered) by the Forwarding Process." which is odd enough to me, since
packets sent by rtl4a_tag_xmit() should *not* be processed by the forwarding
layer of the switch, but rather, force-delivered to the specified egress
port.

Could you please try to revert the effect of commit 339133f6c318 ("net:
dsa: tag_rtl4_a: Drop bit 9 from egress frames") by setting that bit in
the egress tag again? Who knows, maybe it is the bit which tells the
switch to bypass the forwarding process. Or maybe there is a bit in a
different position which does this. You could try to fill in all bits in
unknown positions, check that there are no regressions with packet sizes
< 1496, and then see if that made any changes to packet sizes >= 1496.
If it did, try to see which bit made the difference.

> +
>  	netdev_dbg(dev, "add realtek tag to package to port %d\n",
>  		   dp->index);
>  	skb_push(skb, RTL4_A_HDR_LEN);
> 
> ---
> base-commit: d9e164e4199bc465b3540d5fe3ffc8a9a4fc6157
> change-id: 20231027-fix-rtl8366rb-e752bd5901ca
> 
> Best regards,
> -- 
> Linus Walleij <linus.walleij@linaro.org>
> 

