Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E28792854
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbjIEQSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354363AbjIELBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:01:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7551AB;
        Tue,  5 Sep 2023 04:01:00 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5298e43bb67so5060946a12.1;
        Tue, 05 Sep 2023 04:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693911659; x=1694516459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zwy2enTt2SO2Sv9oRLC9SuqNesFb2onrt5Fx6Ho7KA8=;
        b=nk8+2inmrknKcgvJL7umnAT63490i7hGLWbkcO5hoFSSBbxLpjZNkPztQ9lhGlYVVK
         Jn7zKvfE83QSCjB8FBSDUm+qxC7ItIbFDnGAq2L55noUqg37YXgsOmDsDkCIQqC0Jehn
         VsvNjqpc7/Fl+2joPT9n83+YGlf7jcAfhw1mXDbldqFNBrDVv8o4Esg8K0YqhDuzKtGM
         NwKN1GTnpE3vQfddpak9PpFBPsa++F2yKSqFEK+49DxDA4uFnYvXhA9Kpmw4HGqFWM/N
         xQ2nhVYCIaVIuRmCwQTnFi0dQT34dI3JaQCLWpGLv3xKER8JwyoGEvSUc5hBv6rb1Hu9
         ruqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693911659; x=1694516459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zwy2enTt2SO2Sv9oRLC9SuqNesFb2onrt5Fx6Ho7KA8=;
        b=Wdqet+AhXZ5x37ubVEvLZ5yqD90O0OPfySBJg7GtRU+lHnQ61lUUrf1zhG2qaW6jK5
         R4jWQ7FXKGbHP9tXs1ZDGBohUvWaveJ7M7ZwD0+Qw3kQo6hTX2MQZiK1KetTKWkMzgaf
         orA0r4MQNp+UJf9L61yNuuNPxsfWYID9JWHXlAk6s1QA4IEQPH2fjXN9Fq/Zc9mcdvtj
         72iTBE4MoUp6rd8/E/Y7UV6hDt6/xtg8z89J+kFOmrgq7lRtMtmbMehniLiP1zwNS/ka
         Un2ILFg5jhiGwKD04hTS+poY0NwLyKuVZsqAmkeDfpKnnKG6AybZzrJewxJqwEWjE/Uc
         G7Sg==
X-Gm-Message-State: AOJu0YxmVEQ0J/9phACWCIMsapXUGHw50qbqe6i8UpYpIZIgcJUvJNiQ
        Lu6FZFab8Ni4OSFqOfmk65k=
X-Google-Smtp-Source: AGHT+IECWinjGCWmQ4Iuzke+met9TY4SkOWQQZKuyx1EiJ4+IFPhm7nCQotFIWo+YDGJJDiil7HquA==
X-Received: by 2002:a05:6402:32e:b0:522:d801:7d07 with SMTP id q14-20020a056402032e00b00522d8017d07mr13252480edw.10.1693911658944;
        Tue, 05 Sep 2023 04:00:58 -0700 (PDT)
Received: from skbuf ([188.26.57.165])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7c64e000000b00528922bb53bsm7014864edr.76.2023.09.05.04.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 04:00:58 -0700 (PDT)
Date:   Tue, 5 Sep 2023 14:00:56 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
        davem@davemloft.net, Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Tristram.Ha@microchip.com, Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
        George McCollister <george.mccollister@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RFC 2/4] net: dsa: Extend ksz9477 TAG setup to support
 HSR frames duplication
Message-ID: <20230905110056.gzkaiznlq5hcvrac@skbuf>
References: <20230904120209.741207-1-lukma@denx.de>
 <20230904120209.741207-3-lukma@denx.de>
 <20230905102239.mkufbzxwrvuatlrb@skbuf>
 <20230905124409.40c7c2f1@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905124409.40c7c2f1@wsk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 12:44:09PM +0200, Lukasz Majewski wrote:
> > Not to mention that there are other problems with the "dev->hsr_ports"
> > concept. For example, having a hsr0 over lan0 and lan1, and a hsr1
> > over lan2 and lan3, would set dev->hsr_ports to GENMASK(3, 0).
> 
> I doubt that having two hsr{01} interfaces is possible with current
> kernel.

You mean 2 hsr{01} interfaces not being able to coexist in general,
or just "offloaded" ones?

> The KSZ9477 allows only to have 2 ports of 5 available as HSR
> ones.
> 
> The same is with earlier chip xrs700x (but this have even bigger
> constrain - there only ports 1 and 2 can support HSR). 

> > > +	if (dev->features & NETIF_F_HW_HSR_DUP) {
> > > +		val &= ~KSZ9477_TAIL_TAG_LOOKUP;  
> > 
> > No need to unset a bit which was never set.
> 
> I've explicitly followed the vendor's guidelines - the TAG_LOOKUP needs
> to be cleared.
> 
> But if we can assure that it is not set here I can remove it.

Let's look at ksz9477_xmit(), filtering only for changes to "u16 val".

static struct sk_buff *ksz9477_xmit(struct sk_buff *skb,
				    struct net_device *dev)
{
	u16 val;

	val = BIT(dp->index);

	val |= FIELD_PREP(KSZ9477_TAIL_TAG_PRIO, prio);

	if (is_link_local_ether_addr(hdr->h_dest))
		val |= KSZ9477_TAIL_TAG_OVERRIDE;

	if (dev->features & NETIF_F_HW_HSR_DUP) {
		val &= ~KSZ9477_TAIL_TAG_LOOKUP;
		val |= ksz_hsr_get_ports(dp->ds);
	}
}

Is KSZ9477_TAIL_TAG_LOOKUP ever set in "val", or am I missing something?

> > > +		val |= ksz_hsr_get_ports(dp->ds);
> > > +	}  
> > 
> > Would this work instead?
> > 
> > 	struct net_device *hsr_dev = dp->hsr_dev;
> > 	struct dsa_port *other_dp;
> > 
> > 	dsa_hsr_foreach_port(other_dp, dp->ds, hsr_dev)
> > 		val |= BIT(other_dp->index);
> > 
> 
> I thought about this solution as well, but I've been afraid, that going
> through the loop of all 5 ports each time we want to send single packet
> will reduce the performance.
> 
> Hence, the idea with having the "hsr_ports" set once during join
> function and then use this cached value afterwards.

There was a quote about "premature optimization" which I can't quite remember...

If you can see a measurable performance difference, then the list
traversal can be converted to something more efficient.

In this case, struct dsa_port :: hsr_dev can be converted to a larger
struct dsa_hsr structure, similar to struct dsa_port :: bridge.
That structure could look like this:

struct dsa_hsr {
	struct net_device *dev;
	unsigned long port_mask;
	refcount_t refcount;
};

and you could replace the list traversal with "val |= dp->hsr->port_mask".
But a more complex solution requires a justification, which in this case
is performance-related. So performance data must be gathered.

FWIW, dsa_master_find_slave() also performs a list traversal.
But similar discussions about performance improvements didn't lead anywhere.
