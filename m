Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D95C7E24ED
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjKFN0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjKFN0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:26:35 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869EAEA;
        Mon,  6 Nov 2023 05:26:31 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5431614d90eso7337006a12.1;
        Mon, 06 Nov 2023 05:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699277190; x=1699881990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cetcitf2manmw5zV6XnE3T5HX2WGgbUdmj2U+XjQQ7Q=;
        b=nMYn4eponyAyR+A3//GUsg4+9gBIW1Zgi+WOqE5/VhtR/GN3Ms99Fg3UwnVM1IQMDO
         QsprsNI6oEFtidsJqtYiHvuny+AGqQgegXk8icuIr2qXp0CZ2ZSjwP0C/f0yirDLMZF+
         T54hYO+gYLas+idj4JJ/uTJB4GXDLtt00oWSUklnupwfjxZ2al+ar0mPCSumN3+FAGLq
         1SHf7tlDMp0qzyQwl7nJMOj1NP9hW5Kop8061SBIwYOinYvD2f1JFePhbgsrUUrbQF3Y
         pdAdyQ/w9/zqdJGC8Br6inJULMaNzwAzMPBvt3IgRY3S7lNGbTU1Rp8kRiLon851ATTV
         pbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699277190; x=1699881990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cetcitf2manmw5zV6XnE3T5HX2WGgbUdmj2U+XjQQ7Q=;
        b=Pft1NevHkrzixH6nWuZfn2UiZmXdpQqK1Exy3IvpkJ0XP1MNEO+AT4DppvLKfDvmXT
         ZE/e0LHoUgrBTVTSHdcgfIoWspxthPTmtPKVU+3/yeMqH7wYHg4dCMbGgg4uSbkyoHLA
         7NZZH5zWDluqnMD0Bf0Fun2OkJnVoloVFrO/Sj8P73xIagAlvW+IcW1Ja2CLYToUD9d+
         vHRXVC9PaYviFel+M0o4G96apMcnqjVKsWqngLcY6obwHi+SU/wAdnjylBSe8K/Fkjqm
         kz1lcJ5NXdLf3FqaEKqKxFeAJIHr0OAP0ToJ9mUolrQpj9dNK+0OKqvYmuxwZJJ1NPNI
         5eNg==
X-Gm-Message-State: AOJu0YwtFAyeAGJpICpJOF9H/m7f//4FFwfsxwNvRaRH3YrIY1eLVVYI
        HqFMQ2dD5CzPjl3LV5W+lT0=
X-Google-Smtp-Source: AGHT+IGQOb8Ums1LVAfGjAKSFuuLvn9r9e+cCapg5lm5Os7Cwf4Delp3YG51x8EOBbspzt06SHIX/w==
X-Received: by 2002:a05:6402:8ce:b0:53e:72be:2b31 with SMTP id d14-20020a05640208ce00b0053e72be2b31mr18427680edz.42.1699277189414;
        Mon, 06 Nov 2023 05:26:29 -0800 (PST)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id w27-20020a50d79b000000b005432f45bee9sm4428436edi.19.2023.11.06.05.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 05:26:29 -0800 (PST)
Date:   Mon, 6 Nov 2023 15:26:26 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 4/4] net: ethernet: cortina: Handle large frames
Message-ID: <20231106132626.orn5r57cc7n5ditj@skbuf>
References: <20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org>
 <20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org>
 <20231105-gemini-largeframe-fix-v2-4-cd3a5aa6c496@linaro.org>
 <20231105-gemini-largeframe-fix-v2-4-cd3a5aa6c496@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105-gemini-largeframe-fix-v2-4-cd3a5aa6c496@linaro.org>
 <20231105-gemini-largeframe-fix-v2-4-cd3a5aa6c496@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2023 at 09:57:26PM +0100, Linus Walleij wrote:
> The Gemini ethernet controller provides hardware checksumming
> for frames up to 1514 bytes including ethernet headers but not
> FCS.
> 
> If we start sending bigger frames (after first bumping up the MTU
> on both interfaces sending and receiveing the frames), truncated
> packets start to appear on the target such as in this tcpdump
> resulting from ping -s 1474:

A bit related: what is gmac_fix_features() supposed to do? I see it
unsets GMAC_OFFLOAD_FEATURES when the MTU goes over a certain limit,
and that also includes NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM. Is that
limit correct, or is it supposed to kick in sooner, to allow
validate_xmit_skb() -> skb_csum_hwoffload_help() do the software
checksuum for you? I'm not sure whether that was the intention.

> 
> 23:34:17.241983 14:d6:4d:a8:3c:4f (oui Unknown) > bc:ae:c5:6b:a8:3d (oui Unknown),
> ethertype IPv4 (0x0800), length 1514: truncated-ip - 2 bytes missing!
> (tos 0x0, ttl 64, id 32653, offset 0, flags [DF], proto ICMP (1), length 1502)
> OpenWrt.lan > Fecusia: ICMP echo request, id 1672, seq 50, length 1482
> 
> If we bypass the hardware checksumming and provide a software
> fallback, everything starts working fine up to the max TX MTU
> of 2047 bytes, for example ping -s2000 192.168.1.2:
> 
> 00:44:29.587598 bc:ae:c5:6b:a8:3d (oui Unknown) > 14:d6:4d:a8:3c:4f (oui Unknown),
> ethertype IPv4 (0x0800), length 2042:
> (tos 0x0, ttl 64, id 51828, offset 0, flags [none], proto ICMP (1), length 2028)
> Fecusia > OpenWrt.lan: ICMP echo reply, id 1683, seq 4, length 2008
> 
> The bit enabling to bypass hardware checksum (or any of the
> "TSS" bits) are undocumented in the hardware reference manual.
> The entire hardware checksum unit appears undocumented. The
> conclusion that we need to use the "bypass" bit was found by
> trial-and-error.
> 
> Since no hardware checksum will happen, we slot in a software
> checksum fallback.
> 
> Check for the condition where we need to compute checksum on the
> skb with either hardware or software using == CHECKSUM_PARTIAL instead
> of != CHECKSUM_NONE which is an incomplete check according to
> <linux/skbuff.h>.
> 
> On the D-Link DIR-685 router this fixes a bug on the conduit
> interface to the RTL8366RB DSA switch: as the switch needs to add
> space for its tag it increases the MTU on the conduit interface
> to 1504 and that means that when the router sends packages
> of 1500 bytes these get an extra 4 bytes of DSA tag and the
> transfer fails because of the erroneous hardware checksumming,
> affecting such basic functionality as the LuCI web interface.
> 
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>

To be clear, I didn't suggest any of this. I just pointed towards the gemini.c
driver as being the problem. Please remove my Suggested-by tag.

> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/net/ethernet/cortina/gemini.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 576174a862a9..84295c1b87e6 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -1145,6 +1145,7 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
>  	dma_addr_t mapping;
>  	unsigned short mtu;
>  	void *buffer;
> +	int ret;
>  
>  	mtu  = ETH_HLEN;
>  	mtu += netdev->mtu;
> @@ -1165,7 +1166,19 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
>  		word3 |= mtu;
>  	}
>  
> -	if (skb->ip_summed != CHECKSUM_NONE) {
> +	if (skb->len >= ETH_FRAME_LEN) {
> +		/* Hardware offloaded checksumming isn't working on frames
> +		 * bigger than 1514 bytes. Perhaps the buffer is only 1518
> +		 * bytes fitting a normal frame and a checksum?
> +		 * Just use software checksumming and bypass on bigger frames.
> +		 */
> +		if (skb->ip_summed == CHECKSUM_PARTIAL) {
> +			ret = skb_checksum_help(skb);
> +			if (ret)
> +				return ret;
> +		}
> +		word1 |= TSS_BYPASS_BIT;
> +	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
>  		int tcp = 0;
>  
>  		if (skb->protocol == htons(ETH_P_IP)) {
> 
> -- 
> 2.34.1
> 

[ context: tag_rtl4_a.c is a "category 2", aka "Ethertype", tagger ]

We say this in Documentation/networking/dsa/dsa.rst:

Checksum offload should work with category 1 and 2 taggers when the DSA conduit
driver declares NETIF_F_HW_CSUM in vlan_features and looks at csum_start and
csum_offset. For those cases, DSA will shift the checksum start and offset by
the tag size. If the DSA conduit driver still uses the legacy NETIF_F_IP_CSUM
or NETIF_F_IPV6_CSUM in vlan_features, the offload might only work if the
offload hardware already expects that specific tag (perhaps due to matching
vendors). DSA user ports inherit those flags from the conduit, and it is up to
the driver to correctly fall back to software checksum when the IP header is not
where the hardware expects. If that check is ineffective, the packets might go
to the network without a proper checksum (the checksum field will have the
pseudo IP header sum).

Shouldn't "word1 |= TSS_BYPASS_BIT;" be done depending on skb->protocol,
rather than depending on skb->len?!

		if (skb->protocol == htons(ETH_P_IP)) {
			word1 |= TSS_IP_CHKSUM_BIT;
			tcp = ip_hdr(skb)->protocol == IPPROTO_TCP;
		} else { /* IPv6 */
			word1 |= TSS_IPV6_ENABLE_BIT;
			tcp = ipv6_hdr(skb)->nexthdr == IPPROTO_TCP;
		} // here
			word1 |= TSS_BYPASS_BIT;

Gemini should never attempt to provide checksums for DSA-tagged packets
unless it is able to take skb->csum_start into consideration, otherwise
it will get it wrong.

This is somewhat independent of the other problem you've found, which
seems to be that large non-DSA packets get truncated anyway. But not
bypassing TX checksum offload truncates a packet? Hmm, strange.
