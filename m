Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F347E59E3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjKHPSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHPSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:18:30 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2923C1991;
        Wed,  8 Nov 2023 07:18:28 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso11640272a12.2;
        Wed, 08 Nov 2023 07:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699456706; x=1700061506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=20YB/7o0duQE57AM+W651r/Hi5TulQyuDTg1baZxPYU=;
        b=Uj2nmKRgd4NghuwWkq39H2Ul5R79xosg9KjHk48T0vl8DUBgyIRpzok/hXbF1tEtMW
         Fi9NSAd8QfSguqZ63xxCVNN8wEgvlMTmRCYVBw+6vOTGPCzMBcDnfq7alvJg6eS4Xpu8
         hCXIfsYExlyxSfzkorPOmf25c3J6NlObBYkFa0hBLwTXZtXPWXuqLr/o9ckvve8G4p63
         3eWDu3ctdXSn5zI79dCxhrNFTkS3I5owAA+y/Xyo2ElTBmA7ecMQGWN+eEEAs1JsvXOJ
         1g5zKnH6xDSczUtFh3cvefc+tZCxBGferHPh/1k1DRMOS/jTdlyeiEaXLGjPS4EpWIsT
         bVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699456706; x=1700061506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20YB/7o0duQE57AM+W651r/Hi5TulQyuDTg1baZxPYU=;
        b=n8gS8eXGj6pk+MF8LdwHDWolCVwtYblJYzbMFBHu0T8lRBE5bOgc6r35b5jMj5NEiw
         SEOENHc6weNEI+7r5Ydz9/FrhT+5+rAwEdZNLSqOTkMU7OddHoe76vLYQmefVg2sMC11
         jmIWX3jNlSQuzSaUk4FYWnIBwLiNGD9eKgMuOk99elYyh6NvuYUCxLvufT7xTjKN5qb8
         bGuS94rCSRqyVm852zZS0JckTRlaTqSNJBufsG4TZz7cFv4tA1oD5+Tj6uoEsrzSjeZs
         hnkLK8asAw/9gWEP2LOIilLAeJsiqZhYX44Tmwi83HthY0el7PuNz6SAGZSViGAGxiSe
         q+Ow==
X-Gm-Message-State: AOJu0YyunjYQxmj5RM22nd9bVsMOI4BG0Zjnmq4pT13UG0d+0XkB54JK
        b0IlYXfWj8GYp4WPiXJhztusUafX0ujBXQ==
X-Google-Smtp-Source: AGHT+IGBKj+9SqJ/qYTCOUb8xjtAEEzYl3Lo963j4zWXTvU73ZFy5/fQ1JEo+izBsJLsT+TWXG+JTQ==
X-Received: by 2002:a50:d7c2:0:b0:53d:e0cf:cb95 with SMTP id m2-20020a50d7c2000000b0053de0cfcb95mr2077578edj.21.1699456706277;
        Wed, 08 Nov 2023 07:18:26 -0800 (PST)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id cf27-20020a0564020b9b00b005435faef9cfsm6793016edb.52.2023.11.08.07.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 07:18:26 -0800 (PST)
Date:   Wed, 8 Nov 2023 17:18:23 +0200
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
Message-ID: <20231108151823.dlvzmgjizmhttmao@skbuf>
References: <20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org>
 <20231105-gemini-largeframe-fix-v2-4-cd3a5aa6c496@linaro.org>
 <20231106132626.orn5r57cc7n5ditj@skbuf>
 <CACRpkdb-iAQdw3S_1iBX=SFt6LCPvdW8+K0nvuXxD01q1K9A1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdb-iAQdw3S_1iBX=SFt6LCPvdW8+K0nvuXxD01q1K9A1A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 11:44:37PM +0100, Linus Walleij wrote:
> That indeed seems like the intention. But it's a bit suboptimal, because it
> disables hardware checksum just because the MTU goes over a
> certain level, and stops using the hardware checksum also for all
> packets smaller than the MTU :(
> 
> I'll delete this and make the driver slot in the SW fallback per-packet
> instead, I think it is fair to assume that most packets will be < MTU
> and it is really just a question of where the fallback gets called.

Performing the software checksum per packet instead of doing it for all
packets seems more sensible. I haven't looked at the other offload bits
from GMAC_OFFLOAD_FEATURES to determine if changing those is going to be
problematic.

> > > Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> >
> > To be clear, I didn't suggest any of this. I just pointed towards the gemini.c
> > driver as being the problem. Please remove my Suggested-by tag.
> 
> OK sorry, it was just my way of trying to provide credit where
> credit is due, because you helped so much with this bug.

Ok, but asserting the validity of the DSA code and vaguely pointing
towards an unrelated driver and not even specifying what might be wrong
with its xmit procedure still does not count as worth a Suggested-by tag
to me. So still, please remove it.

> > We say this in Documentation/networking/dsa/dsa.rst:
> >
> > Checksum offload should work with category 1 and 2 taggers when the DSA conduit
> > driver declares NETIF_F_HW_CSUM in vlan_features
> > and looks at csum_start and csum_offset.
> > For those cases, DSA will shift the checksum start and offset by
> > the tag size. If the DSA conduit driver still uses the legacy NETIF_F_IP_CSUM
> > or NETIF_F_IPV6_CSUM in vlan_features, the offload might only work if the
> > offload hardware already expects that specific tag (perhaps due to matching
> > vendors).
> 
> Since things work smoothly I can only assume that the Gemini
> checksum engine actually knows about the Realtek ethertype (0x8899)
> and the protocol (0xa) and takes action on that, since the switch works.
> 
> OR: it has some heuristic on for how to handle it. (Such as looking for
> a valid TCP or UDP header to figure out where to put the checksum.)

The second option seems more plausible to me. It seems unlikely that a
non-Realtek controller would have information about a Realtek
proprietary protocol, that even Linux people have trouble finding a lot
of information about, when explicitly trying to do so.

> But I have no idea how it does it. It doesn't have a firmware AFAIK.
> 
> Examples listed were ICMP so just IP checksums but I tried for example
> SSH, and HTTP and packets look like this:
> 
> 22:51:35.457191 9a:ec:30:5a:46:96 (oui Unknown) > bc:ae:c5:6b:a8:3d
> (oui Unknown),
> ethertype IPv4 (0x0800), length 434: (tos 0x48, ttl 64, id 8221,
> offset 0, flags [DF], proto TCP (6), length 420)
>     _gateway.48102 > fedora.ssh: Flags [P.], cksum 0xcf1b (correct),
> seq 811:1179, ack 2310,
>    win 2054, options [nop,nop,TS val 74858741 ecr 1981407207], length 368
> 
> Checksum correct. So...

Well, the checksum is correct because it's done in software by the
network stack, prior to dsa_user_xmit() being even called, and thus
prior to the DSA tag being added. "ethtool -k lan0 | grep sum" will tell
you as much (compare it to "ethtool -k eth0" which will list some
offload bits set).

> > Shouldn't "word1 |= TSS_BYPASS_BIT;" be done depending on skb->protocol,
> > rather than depending on skb->len?!
> >
> >                 if (skb->protocol == htons(ETH_P_IP)) {
> >                         word1 |= TSS_IP_CHKSUM_BIT;
> >                         tcp = ip_hdr(skb)->protocol == IPPROTO_TCP;
> >                 } else { /* IPv6 */
> >                         word1 |= TSS_IPV6_ENABLE_BIT;
> >                         tcp = ipv6_hdr(skb)->nexthdr == IPPROTO_TCP;
> >                 } // here
> >                         word1 |= TSS_BYPASS_BIT;
> 
> Oddly it assumes everything is either TCP or UDP on
> IPv4 or IPv6. And yet things such as ICMP work just fine.
> 
> I think the checksum engine can contain some various
> heuristics, such as if it cannot recognize what is coming
> in as the selected TCP or UDP, it will pass right through.
> 
> > Gemini should never attempt to provide checksums for DSA-tagged packets
> > unless it is able to take skb->csum_start into consideration, otherwise
> > it will get it wrong.
> >
> > This is somewhat independent of the other problem you've found, which
> > seems to be that large non-DSA packets get truncated anyway. But not
> > bypassing TX checksum offload truncates a packet? Hmm, strange.
> 
> I have a theory about that in the comment, which is that when they
> engineered the hardware they only put in a hardware buffer for
> 1518 bytes in the checksum engine. If you try to put in any more
> it gets truncated. It's a reasonable guess.
> 
> If you do not set the checkumming engine to "bypass" it will try
> to fit the incoming paket into the checksumming buffer, and then
> it will look to see if it can find the right TCP or UDP headers.
> If it can't it will pass the packet out from the buffer without doing
> any changes. But the buffer is just 1518 bytes, which means that
> no matter what kind of package it is, it will get truncated if it
> does not fit into the checksumming buffer.
> 
> This would give exactly the behaviour we're seeing.

The evidence you've presented seems to support your position and not
mine. The controller does not attempt to provide checksums for
DSA-tagged packets, that is not a problem because those have checksums
already, but the packet size is the actual problem, irrespective of
whether the packets are DSA-tagged or not.

But in that case I have some comments on your latest version of the
patch set.
