Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1649E79D38A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjILO0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbjILO0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:26:53 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B9010D;
        Tue, 12 Sep 2023 07:26:49 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52e828ad46bso7421731a12.1;
        Tue, 12 Sep 2023 07:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694528808; x=1695133608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJt7Pz2jvPJwNkb0nu9cCOHLFYNPsGlJOODgla0ZsRs=;
        b=GlJmwkigczfG5MzhWv1z8qkDY6l2txN3q7D+NmIoI7mOA+nzWYscYnVwzQ6kkEimmm
         OW7zIK8wOUG8Q/NvCqdyjIK85LGgQCnjtgzIpMbRgrZmCPTutgurjRNkSSXoC4+yruwH
         c2GJmrilba1ZEgcqmqvHOiQK3EglsmabYB5Br2r5KFVs58+SO5/1wHAR3wfRvnYNbuBb
         VSlztwZ/WtTbKBx0gwCm9u8v8obdIVgIZcGMPirloDozv4sMm7mgkaHkgZSXp36MIGyx
         7F6m+1gFCFVneAFU/KL2qdYzH9ZIfJIIZom7gymoFKGyg+VkQeFNDBRUrZeBMMspxpbr
         AXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694528808; x=1695133608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJt7Pz2jvPJwNkb0nu9cCOHLFYNPsGlJOODgla0ZsRs=;
        b=kG4LTFWWBLRAXjeU1HNI8eqafWnzLOy9lkayHkr+nvcGoXB14ZDSAqeS/XE6Rn+T1n
         whLjpM4Vbol/uZLf0w5eLNJR7WzHRsu1cXi85R1Kw3oXPY7c4y8IJztwwo/hqMgnJLor
         askaj8R/wyleKR68yQAAMpXoYsGrwjb3PnIRwnFOmUegyuqpCLt2+OhSrncGed52elQe
         XrRvjSz+OQiuvG0QmSI9Bh+WgA+50aDtUNwo02sGNd8E78SXK93LzKAMtmm+tk6W5ptJ
         2/9GDKS0Qaln0Rf7jnOYLh89tDPxqD5kVeKxtwmsGbRAmJ6wYILsUfA4y+jGahNuX8rX
         ZbGQ==
X-Gm-Message-State: AOJu0Yxna1L+URQwYSmn/beiOKwDGxH/XEXCt2Rw8LeJnHl/sl+S1iOr
        GIhCz8GHViIoHAC99pkDNS8rzEOM8EuseQ==
X-Google-Smtp-Source: AGHT+IHXyRKf3KsQLEP2VBXb4dtzBc4dBytaEvS01woUgkTy3L4yCQjgIh+URLDSqkj5y29kH1cXpw==
X-Received: by 2002:aa7:c308:0:b0:525:442b:6068 with SMTP id l8-20020aa7c308000000b00525442b6068mr10973126edq.13.1694528807651;
        Tue, 12 Sep 2023 07:26:47 -0700 (PDT)
Received: from skbuf ([188.25.254.186])
        by smtp.gmail.com with ESMTPSA id z26-20020aa7cf9a000000b005232c051605sm5986761edx.19.2023.09.12.07.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 07:26:47 -0700 (PDT)
Date:   Tue, 12 Sep 2023 17:26:44 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Oleksij Rempel <linux@rempel-privat.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [[RFC PATCH v4 net-next] 0/2] net: dsa: hsr: Enable HSR HW
 offloading for KSZ9477
Message-ID: <20230912142644.u4sdkveei3e5hwaf@skbuf>
References: <20230911160501.5vc4nttz6fnww56h@skbuf>
 <20230912101748.0ca4eec8@wsk>
 <20230912092909.4yj4b2b4xrhzdztu@skbuf>
 <20230906152801.921664-1-lukma@denx.de>
 <20230911165848.0741c03c@wsk>
 <20230911160501.5vc4nttz6fnww56h@skbuf>
 <20230912101748.0ca4eec8@wsk>
 <20230912092909.4yj4b2b4xrhzdztu@skbuf>
 <20230912160326.188e1d13@wsk>
 <20230912160326.188e1d13@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912160326.188e1d13@wsk>
 <20230912160326.188e1d13@wsk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 04:03:26PM +0200, Lukasz Majewski wrote:
> > In any case, as long as it's the DSA master's address that we program
> > to hardware, then I see it as inevitable to add a new struct
> > dsa_switch_ops :: master_addr_change() function
> 
> Please correct my understanding. The above change would affect the
> whole DSA subsystem. It would require to have the core DSA modified and
> would affect its operation?

Uhm, yes, that would be the idea. If we were going to track changes to
the DSA master's MAC address, we should do it from the DSA framework
which has the existing netdev notifier listener infrastructure in place.

> > Or you can argue that dragging the DSA master into the discussion
> > about how we should program REG_SW_MAC_ADDR_0 is a complication.
> 
> Yes, it is IMHO the complication.

Ok, it's a point of view.

> git grep -n "REG_SW_MAC_ADDR_0"
> drivers/net/dsa/microchip/ksz8795_reg.h:326:#define REG_SW_MAC_ADDR_0
>         0x68 
> drivers/net/dsa/microchip/ksz9477.c:1194:
>      ksz_write8(dev, REG_SW_MAC_ADDR_0 + i,
> 
> drivers/net/dsa/microchip/ksz9477_reg.h:169:#define REG_SW_MAC_ADDR_0
> 0x0302
> 
> In the current net-next the REG_SW_MAC_ADDR_0 is altered used (the only
> usage are now with mine patches on ksz9477).
> 
> To sum up:
> 
> 1. Up till now in (net-next) REG_SW_MAC_ADDR_0 is ONLY declared for
> Microchip switches. No risk for access - other than HSR patches.

I know (except for Oleksij's WoL patches, which will eventually be
resubmitted).

> 2. The MAC address alteration of DSA master and propagation to slaves
> is a generic DSA bug.

Which can be/will be fixed. The diff I've included in the question to
Jakub closes it, in fact.

> Considering the above - the HSR implementation is safe (to the extend
> to the whole DSA subsystem current operation). Am I correct?

If we exclude the aforementioned bug (which won't be a bug forever),
there still exists the case where the MAC address of a DSA user port can
be changed. The HSR driver has a NETDEV_CHANGEADDR handler for this as
well, and updates its own MAC address to follow the port. If that is
allowed to happen after the offload, currently it will break the offload.
