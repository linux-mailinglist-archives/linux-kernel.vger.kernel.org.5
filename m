Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A32E7E689B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjKIKq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjKIKq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:46:26 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FC01FEB;
        Thu,  9 Nov 2023 02:46:24 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40842752c6eso4938785e9.1;
        Thu, 09 Nov 2023 02:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699526783; x=1700131583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KpLnGcL7z550OA6Od3q20GZe6eCKJcNkkGQivJY18I0=;
        b=HZejx5rTGhx6h4H3PLLXtXDsz9Yp1UcSCsx8z3LQyQIFNjZw1XbQBfVmkPlmUuhep1
         YvtXgu0M8MPH47HjF4Jq7XDL9yWmHq7zIArSOxgKZO4WOSk61jImdSuoskPFYBTCug6E
         fB30S8E+fPfyrZww/xV62iH1ZJmdPgEfbXT3vexUULYoxIqn+i7ba/ym047H29P6iMnS
         NLQi2+69P7w+TG8Rexg13JtWS8Zp2ZaACuO1OUdXY7qi7eYYmpanNvqiE9F/zLK4j0Fk
         +3FxlBdv9oy/tNoa19ajBDaSokwAbEV4r1SVf2D6MPMd62RDWxGFP5i7efM18CQWbUI8
         TbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699526783; x=1700131583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpLnGcL7z550OA6Od3q20GZe6eCKJcNkkGQivJY18I0=;
        b=JIyLBxLT3zN3PvuLMrMHGsu8w9YMZRwZIl1Tjftql5B6meUOJBmJ36e1XgESTNyJJE
         TsHrghOuyAxKWQKe7fK6zH7A+++dYhzBhIk2HS7Ptp0aY2oAH4tM1WixBM3GkRM4d3WQ
         WvUvE8DjqU2OfVMW2oF1F2PDlJL4qap4s4kiDkC1vvm7SOZZ89ubJCXE7CJrdx5+GTTC
         wEm4xGVfRfd008wKMVkSwf7mPkSac9ieASOiD/D5YsztmutjAKYOrA8tVOS2S3YN2R4n
         w78mRKvWiGCyjMKqSn6iZVGJgzAaN7F0cjuEGmHfb4hsq+8bSQKPkK6euzOvQupKCfYi
         0NrQ==
X-Gm-Message-State: AOJu0YwEwCKm57HpzF/aptoKPjR20wZGaUaGx5bZKegS7CrrzodN6TE3
        sRuFBtPd4M1dL5yq3QID+ws=
X-Google-Smtp-Source: AGHT+IHf8qzUppDBrSoPXBM/VDZwRt3WOHBn5t2FBLRRKU7xChEdrEBlWkoG8LUpk7JiZHdripVrHQ==
X-Received: by 2002:a05:600c:4f8d:b0:408:ff28:a4ad with SMTP id n13-20020a05600c4f8d00b00408ff28a4admr3832883wmq.33.1699526782065;
        Thu, 09 Nov 2023 02:46:22 -0800 (PST)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id ba15-20020a0560001c0f00b0032326908972sm7154085wrb.17.2023.11.09.02.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:46:21 -0800 (PST)
Date:   Thu, 9 Nov 2023 12:46:19 +0200
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
Subject: Re: [PATCH net v4 2/3] net: ethernet: cortina: Handle large frames
Message-ID: <20231109104619.3dfcy3dbx2ffe3k4@skbuf>
References: <20231109-gemini-largeframe-fix-v4-0-6e611528db08@linaro.org>
 <20231109-gemini-largeframe-fix-v4-2-6e611528db08@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109-gemini-largeframe-fix-v4-2-6e611528db08@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 10:03:13AM +0100, Linus Walleij wrote:
> The Gemini ethernet controller provides hardware checksumming
> for frames up to 1514 bytes including ethernet headers but not
> FCS.
> 
> If we start sending bigger frames (after first bumping up the MTU
> on both interfaces sending and receiving the frames), truncated
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
> On the D-Link DIR-685 router this fixes a bug on the conduit
> interface to the RTL8366RB DSA switch: as the switch needs to add
> space for its tag it increases the MTU on the conduit interface
> to 1504 and that means that when the router sends packages
> of 1500 bytes these get an extra 4 bytes of DSA tag and the
> transfer fails because of the erroneous hardware checksumming,
> affecting such basic functionality as the LuCI web interface.
> 
> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
