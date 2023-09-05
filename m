Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1667926F1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbjIEQEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354506AbjIEMFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:05:10 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B2A1AD;
        Tue,  5 Sep 2023 05:05:06 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5280ef23593so3103386a12.3;
        Tue, 05 Sep 2023 05:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693915504; x=1694520304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+gVz3kWcbIj8nQYejfFIIpGzb+ZDOuSnviWzYWHdi+E=;
        b=mhMDbddEX2sq5m3exbp8xpyloRu9BlR69kphkGtBVpb7/ZlizK50uTE7FlcWaEkTxY
         vdwTPreET5RiGpYlEzIYKaX2PZtZ/PV/Sbmn01D7HebMAwB8AaMoyd6DrMyHuokb4k4U
         FZqlBoxUKAE6dCJlbYbzb58BT7WxM7j6FM62uiLWsCm/ScayPCc12Ry6kdowaCauE0TK
         sRXvEbJ456N1avPZj/rMaP5L8BHu4R35mZZ/eRJgp4/lvF0i2yktuFTwYY+Xw+tQ5WP6
         XG1gnhNCjjQQQjO6eQ13nn73I44vwHGC1gY1LIOjF14fHUGhshyUVtHJP9YffnX454nQ
         Eijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693915504; x=1694520304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gVz3kWcbIj8nQYejfFIIpGzb+ZDOuSnviWzYWHdi+E=;
        b=ZWCMGZ3CiyN/nGJ9hhhyp0yPOEQiCf58sahfdQfdgGBe+4jjRMiag7Le+4sIlEL92g
         8jUcZc0sR0I6nlHDTfN8rr4xF9WFtvV9jMxZwr6JZWHi3+26kW+E3/h7b8DxUWbxQbaF
         a/A2QH0w1Nv/j2UhKgKDBXpIp/uJ9HpH/VzqqbDPf0eH3mwlyUfBtZKJJj3nApRJo/Dd
         XBHXufeWhMGoW5II0KuCb5TJo13nAfPkNxyB42Axw6IA7+amfBMOOB1LwwdF1FkAhODB
         4l2l7ckNfNI1cpzQ3ryxabBBIxT6NMQcYnKDW6qoMAKocWNww2n9l98qob3rlr+u0RdF
         uNhg==
X-Gm-Message-State: AOJu0YyBGX2GjNWl/D6sO7Kxr3FrHbJ1KNMJPZrwx1s6QosHIO5Cpf5u
        2yom8cPGdOOfdBM5epe+aNM=
X-Google-Smtp-Source: AGHT+IEgRHuMzErVlW6Z+BBYnqnJMVQ8Km6v1D6EBfBDI9Tjrj/wavnD4mSYzck63hU/SOZ7lC9ebA==
X-Received: by 2002:a50:ee17:0:b0:523:7192:6803 with SMTP id g23-20020a50ee17000000b0052371926803mr10173304eds.8.1693915504473;
        Tue, 05 Sep 2023 05:05:04 -0700 (PDT)
Received: from skbuf ([188.26.57.165])
        by smtp.gmail.com with ESMTPSA id r19-20020aa7cfd3000000b0052284228e3bsm7090947edy.8.2023.09.05.05.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 05:05:04 -0700 (PDT)
Date:   Tue, 5 Sep 2023 15:05:01 +0300
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
Subject: Re: [PATCH v3 RFC 4/4] net: dsa: hsr: Provide generic HSR
 ksz_hsr_{join|leave} functions
Message-ID: <20230905120501.tvkrrzcneq4fdzqa@skbuf>
References: <20230904120209.741207-1-lukma@denx.de>
 <20230904120209.741207-1-lukma@denx.de>
 <20230904120209.741207-5-lukma@denx.de>
 <20230904120209.741207-5-lukma@denx.de>
 <20230905104725.zy3lwbxjhqhqyzdj@skbuf>
 <20230905132351.2e129d53@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905132351.2e129d53@wsk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 01:23:51PM +0200, Lukasz Majewski wrote:
> > Should be squashed into patch 3/4. The split does not make the code
> > easier to review for me.
> 
> So you recommend to have only one patch in which the hsr_join{leave}
> function from ksz_common.c and ksz9477_hsr_join{leave} from ksz9477.c
> are added?

Correct. In addition, patch 1/4 will be dropped. So there will be 2
patches, one on net/dsa/tag_ksz.c and the other on drivers/net/dsa/microchip/.

> > I don't see any restriction to allow offloading a single HSR device.
> 
> As I've written in the other response - I've followed the xrs700x.c
> convention. 

"the xrs700x.c convention"

xrs700x_hsr_join():

	/* Only ports 1 and 2 can be HSR/PRP redundant ports. */
	if (port != 1 && port != 2)
		return -EOPNOTSUPP;

So, checking for ports 1 and 2 is a stronger condition than the one I'm
asking you to enforce.

The KSZ9477 is more flexible. It can enable HSR offload on any 2 ports,
not just on ports 1 and 2. But it can still be 2 ports max, no more.
You haven't copied the xrs700x convention, but you haven't adapted it,
either.

> Moreover, for me it seems more natural, that we only allow full HSR
> support for 2 ports or none. Please be aware, that HSR supposed to
> support only 2 ports, and having only one working is not recommended by
> vendor.

And where is it enforced that full HSR offload is only applied to 2
ports or none?

> > Looking at patch 3/4, that will obviously not work due to some
> > hardware registers which are global and would be overwritten by the
> > second HSR device.
> 
> I cannot guarantee that there will not be any "side effects" with this
> approach. And to be honest - I would prefer to spent time on testing
> recommended setups.

Please read my reply again, keeping in mind that by "HSR device" I mean
"hsr0" in the commands below, and not the member ports as you've assumed
when responding.

> > 
> > For example, a5psw_port_bridge_join() has a similar restriction to
> > offload a single bridge device.
> 
> HSR is IMHO a bit different than plain "bridge" offloading.

Maybe this was not clear, but by "similar" I mean: if you replace the
"bridge" word with "hsr", and you copy that code snippet from a5psw,
you get the desired outcome.

static int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr,
			/* optionally pass the extack argument from the caller */)
{
	struct ksz_device *dev = ds->priv;

	/* We only support 1 HSR device */
	if (dev->hsr_dev && hsr != dev->hsr_dev) {
		NL_SET_ERR_MSG_MOD(extack,
				   "Offload supported for a single HSR");
		return -EOPNOTSUPP;
	}

	dev->hsr_dev = hsr;

	...

	return 0;
}

I did not imply that HSR is not different than bridge offloading.
I don't see how that is even related to the discussion.

> > If you return -EOPNOTSUPP, then DSA should fall back to an
> > unoffloaded, 100% software-based HSR device, and that should work
> > too. 
> 
> And then we would have one port with SW HSR and another one with HW
> HSR?

No. One HSR device (hsr0, with 2 member ports) with offload and one
HSR device (hsr1, with 2 member ports) without offload (see (b) below).

> >It would be good if you could verify that the unoffloaded HSR
> > works well after the changes too.
> 
> I've tested on KSZ9477-EVB the SW HSR operation with two ports (and two
> or three boards) and HW HSR offloading. Results are presented in the
> cover-letter.

"results in the cover letter"

Results:
With KSZ9477 offloading support added: RX: 100 Mbps TX: 98 Mbps
With no offloading                     RX: 63 Mbps  TX: 63 Mbps

What was the setup for the "no offloading" case?

(a) kernel did not contain the offloading patch set

(b) the testing was on hsr1, in the situation below:

ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45 version 1 # offloaded
ip link add name hsr1 type hsr slave1 lan3 slave2 lan4 supervision 45 version 1 # unoffloaded

(d) in some other way (please detail)

I was specifically asking about situation (b).
