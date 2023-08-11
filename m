Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F6F779210
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbjHKOls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbjHKOlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:41:46 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAAF2D7B;
        Fri, 11 Aug 2023 07:41:42 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7F4FE000C;
        Fri, 11 Aug 2023 14:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691764901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/4m5U0LhjY1Jq5li399j2cUJWhFltS+fVPgIybFfJYE=;
        b=NrDc3y+ncrw7qejY/qgtpRZrXf4ZpivvC94Rk0NJB6Z1XTVfgogG1p6BPFoJ5SxWl3TFsB
        XhlOpU02iZEFE12M8PKqOHH2KmlpuyzGMcWM0outgV2wpBEqLdxVdI78QReg2cJlveuASs
        mmRo0kRfQy61iByc2Qsrj9gNs5t+H8ozoj1TnG0Rs4MJhsi9S4Z6cqvlH4JPt42Moh12oQ
        9cYKnWWx2xrUX0OPnC7ouKKSrlVv6pPIOTZyInwXAsSH/6kNB6oBB/g7ayb4mkk+4ZGqbS
        iNX0h0cZNGUqTMOTkzVw05AA5IWXfogjOrYosgbTnqK5zFBDctm0ndsm5NajGg==
Message-ID: <252cdb0b-3630-9e29-45a6-ea0474f0d983@bootlin.com>
Date:   Fri, 11 Aug 2023 16:42:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/3] net: dsa: rzn1-a5psw: add support for
 .port_bridge_flags
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     =?UTF-8?Q?Cl=C3=A9ment_Leger?= <clement@clement-leger.fr>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230810093651.102509-1-alexis.lothore@bootlin.com>
 <20230810093651.102509-3-alexis.lothore@bootlin.com>
 <20230811100307.ocqkijjj5f6hi3q2@skbuf>
Content-Language: en-US
From:   =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <20230811100307.ocqkijjj5f6hi3q2@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vladimir,
On 8/11/23 12:03, Vladimir Oltean wrote:
> Hi Alexis,
> 
> On Thu, Aug 10, 2023 at 11:36:50AM +0200, alexis.lothore@bootlin.com wrote:
>> +	if (flags.mask & BR_FLOOD) {
>> +		val = flags.val & BR_FLOOD ? BIT(port) : 0;
>> +		a5psw_reg_rmw(a5psw, A5PSW_UCAST_DEF_MASK, BIT(port), val);
>> +	}
>> +
>> +	if (flags.mask & BR_MCAST_FLOOD) {
>> +		val = flags.val & BR_MCAST_FLOOD ? BIT(port) : 0;
>> +		a5psw_reg_rmw(a5psw, A5PSW_MCAST_DEF_MASK, BIT(port), val);
>> +	}
>> +
>> +	if (flags.mask & BR_BCAST_FLOOD) {
>> +		val = flags.val & BR_BCAST_FLOOD ? BIT(port) : 0;
>> +		a5psw_reg_rmw(a5psw, A5PSW_BCAST_DEF_MASK, BIT(port), val);
>> +	}
> 
> These 3 port masks will only do what you expect while the bridge has
> vlan_filtering=0, correct? When vlan_filtering=1, packets classified to
> a VLAN which don't hit any FDB entry will be always flooded to all ports
> in that VLAN, correct?

After thoroughly reading the A5PSW doc again, I feel that this sentence is not
exactly true. If I refer to section 4.5.3.9, paragraph 3.c:

The VLAN table is used for both, VLAN domain verification [...] as well as VLAN
resolution. Once the frame has passed any VLAN domain verification (i.e. will
not be discarded by the verification function already), the forwarding
resolution applies.
[...]
- If the destination MAC address (Unicast or Multicast) is not found in the MAC
address table, or if the destination address is the Broadcast address, the frame
is forwarded according to the following rules:
  - The destination port mask is loaded from the respective register
U/M/BCAST_DEFAULT_MASK depending on unicast, multicast or broadcast. Then the
following filtering on this mask applies.
    - If the frame carries a VLAN tag, the VLAN resolution table is searched for
a matching VLAN ID and the frame is sent only to ports that are associated with
the VLAN ID.
    - If the frame carries a VLAN tag and the VLAN ID does not match any entry
in the VLAN Resolution Table, or the frame does not carry a VLAN tag, the frame
is forwarded to all ports that are enabled by the default mask.
    - If it cannot be associated with any VLAN group and if the default group
has been set to all zero, the frame is discarded.
[...]

I understand from the second bullet that even when vlan filtering is enabled
(which occurs as first step), the first flooding filter (used in second step,
resolution) remains the flooding masks from unicast/multicast/broadcast default
mask registers. The vlan resolution is then applied over it as a second filter,
and only make the flooding more "restrictive", it does not bypass it (so if a
port is in the vlan which VID is in an incoming packet but the port is not also
defined in the U/M/B default mask, incoming packet won't be flooded to it).
> 
> Maybe you could restrict transitions to flooding disabled on ports with
> vlan_filtering 1, and restrict transitions to vlan_filtering 1 on ports
> with flooding disabled. Or at least add some comments about the
> limitations. I wouldn't want subtle incompatibilities between the
> hardware design and Linux' expectations to go under the radar like this.
> 

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

