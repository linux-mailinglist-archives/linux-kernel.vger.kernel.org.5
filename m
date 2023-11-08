Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0A87E59FB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjKHP1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjKHP1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:27:43 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20A01AE;
        Wed,  8 Nov 2023 07:27:40 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5441ba3e53cso9389870a12.1;
        Wed, 08 Nov 2023 07:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699457259; x=1700062059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GbKer+D8Q+KHc3RawBywAbRhnUO2N5YC2mknZI5eaAk=;
        b=XInJUJVxtm5gUXHctN72xlpyc8Lf1b9AUBbWkacvhhpFYkc273CUm5gMflzYr+XrBr
         DzzHrTXRBSEyxNfMitsIi9WmthZ0etHzMHnwHvfP2dN64dIgXa9D5ZMHWpIvyQlHcFlq
         4lO0d2VJABrI7SclK3eiHR6wJy9wrWGyb41LN9e7LzdM9HVsZihSKHNE+YzO/5OENNVa
         jF/ft30ALuNjdBf7R7cqhJCVd7Y+VyHQcx6Rsfx2/OFEPsMwz8nnjlL9PhumaUZSsPJd
         LnSRqbNU2ExcrJItMIxJKbnSQ6af1rm9L7+jiYKwjedlBsQS6HSFml8GMgprJpXH3CyS
         Qhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699457259; x=1700062059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbKer+D8Q+KHc3RawBywAbRhnUO2N5YC2mknZI5eaAk=;
        b=RAbhn06xwvsdu9w5dhLZ0M9AlX77kIe2WYY/VVECZmCZqvlGv3+Nbgb+zVKK1JJu7b
         PbO1raMsn8y0DrSo5+IX09Sj46ZY3fpDZy5p9WDeAM/70R6K2h5To8dx/rdcXqD23u5u
         R/rigyJWH3LFg7SMAoYmotW9+0BZ6XsfnNA8DYJoG5Zm+bwDQ7QApmTKGHK4WEUIYlGo
         71fzx6kmkOB9n6uNAkwZdzyhpkNXwHSOlf9/akAMRbFz+El3XQ+uQANDclRvWnQsIg5T
         LrAZjaYw3XSmstdpCOBQQE1TWvduWfL1XQhZ/twAH3wRVLq0ZMDGYU2h/e894JYxRChh
         /myg==
X-Gm-Message-State: AOJu0YyC7Ks3f7Kmd0M+AQLCf4r1Ls+Y/fob6+us/jik8cbdWJG4+28a
        77xXhfIa10JpS5cR+pxvDZY=
X-Google-Smtp-Source: AGHT+IGEH7nKLCeA0lDhAwUUQXgn2UhS9sWmWknjymraKE1HIbs3PeGN8y0LRZvFF007+cX+OctJsw==
X-Received: by 2002:a17:907:6d20:b0:9be:aebc:d479 with SMTP id sa32-20020a1709076d2000b009beaebcd479mr1813981ejc.19.1699457258882;
        Wed, 08 Nov 2023 07:27:38 -0800 (PST)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id z17-20020a170906669100b009920e9a3a73sm1203843ejo.115.2023.11.08.07.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 07:27:38 -0800 (PST)
Date:   Wed, 8 Nov 2023 17:27:36 +0200
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
Subject: Re: [PATCH net v3 3/4] net: ethernet: cortina: Handle large frames
Message-ID: <20231108152736.euqbedurxvq2wben@skbuf>
References: <20231107-gemini-largeframe-fix-v3-0-e3803c080b75@linaro.org>
 <20231107-gemini-largeframe-fix-v3-3-e3803c080b75@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107-gemini-largeframe-fix-v3-3-e3803c080b75@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 10:54:28AM +0100, Linus Walleij wrote:
> The Gemini ethernet controller provides hardware checksumming
> for frames up to 1514 bytes including ethernet headers but not
> FCS.
> 
> If we start sending bigger frames (after first bumping up the MTU
> on both interfaces sending and receiveing the frames), truncated

s/receiveing/receiving/

> packets start to appear on the target such as in this tcpdump
> resulting from ping -s 1474:
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
> We delete the code disabling the hardware checksum for large
> MTU:s: this is suboptimal because it will disable hardware

"MTUs" maybe?

> checksumming also on small packets which the checksumming
> engine can handle just fine, which is a waste of resources.
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
> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/net/ethernet/cortina/gemini.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index b21a94b4ab5c..78287cfcbf63 100644
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
> @@ -1159,9 +1160,30 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
>  		word3 |= mtu;
>  	}
>  
> -	if (skb->ip_summed != CHECKSUM_NONE) {
> +	if (skb->len >= ETH_FRAME_LEN) {
> +		/* Hardware offloaded checksumming isn't working on frames
> +		 * bigger than 1514 bytes. A hypothesis about this is that the
> +		 * checksum buffer is only 1518 bytes, so when the frames get
> +		 * bigger they get truncated, or the last few bytes get
> +		 * overwritten by the FCS.
> +		 *
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
> +		/* We do not switch off the checksumming on non TCP/UDP
> +		 * frames: as is shown from tests, the checksumming engine
> +		 * is smart enough to see that a frame is not actually TCP
> +		 * or UDP and then just pass it through without any changes
> +		 * to the frame.
> +		 */
>  		if (skb->protocol == htons(ETH_P_IP)) {
>  			word1 |= TSS_IP_CHKSUM_BIT;
>  			tcp = ip_hdr(skb)->protocol == IPPROTO_TCP;
> @@ -1978,15 +2000,6 @@ static int gmac_change_mtu(struct net_device *netdev, int new_mtu)
>  	return 0;
>  }
>  
> -static netdev_features_t gmac_fix_features(struct net_device *netdev,
> -					   netdev_features_t features)
> -{
> -	if (netdev->mtu + ETH_HLEN + VLAN_HLEN > MTU_SIZE_BIT_MASK)
> -		features &= ~GMAC_OFFLOAD_FEATURES;
> -
> -	return features;
> -}
> -

I think this entire ndo_fix_features() can be indeed removed, but your
justification was not immediately convincing. I'd point out that after
your patch 1/4 "net: ethernet: cortina: Fix MTU max setting", you
actually made this dead code, because netdev->mtu can't be larger than
netdev->max_mtu.

If you reverse the patch order a bit, such that "net: ethernet: cortina:
Handle large frames" comes first, I think it would be much more logical
for the removal of gmac_fix_features() to be part of the commit
"net: ethernet: cortina: Fix MTU max setting", with the simple
justification: the new MTU makes the code stop having any role.

>  static int gmac_set_features(struct net_device *netdev,
>  			     netdev_features_t features)
>  {
> @@ -2212,7 +2225,6 @@ static const struct net_device_ops gmac_351x_ops = {
>  	.ndo_set_mac_address	= gmac_set_mac_address,
>  	.ndo_get_stats64	= gmac_get_stats64,
>  	.ndo_change_mtu		= gmac_change_mtu,
> -	.ndo_fix_features	= gmac_fix_features,
>  	.ndo_set_features	= gmac_set_features,
>  };
>  
> 
> -- 
> 2.34.1
> 
