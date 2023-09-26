Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8197AF788
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 02:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjI0AqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 20:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjI0AoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 20:44:06 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1246618F;
        Tue, 26 Sep 2023 16:58:52 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5346b64f17aso2685898a12.2;
        Tue, 26 Sep 2023 16:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695772731; x=1696377531; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QA5wibxddBBtvyDx0LhDMJhGcmx/0ioxBDf9/dQOnX4=;
        b=XLttiG0/bYt4NG1yGiwmMK2jdyl2vNzg+TN3hjoMu83KI1jIaPK4pU83yixlVncYlU
         ceoTuhoaIBDhPXuM4DYWZwLTQ5f+q/ErntHOn8JMp8VRDcMWSnNk+FrH+x0C1mnA/dGL
         qVdUPqaw/5wWNsm5IPP/ECgapcu7gcOS/ODuwv8UygqhtfErtOVJsRAUKI3x9OAhzfyP
         dftJiZFI0dgjOT1ldKzTIA1MTYE4dhnjfWwmdqUPy2DVmDtUmDWnij4srwOHAWvddEXW
         xBEJOMq/TEBDt8zfxI6Dx+FJqjwFUQHZYOHc+7asVioucJU4W7otIEEaxZvymi0p6905
         pgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695772731; x=1696377531;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QA5wibxddBBtvyDx0LhDMJhGcmx/0ioxBDf9/dQOnX4=;
        b=OTT+++cwZrnXufA7VqsIA6SqvrOthU24As+r+T8LTqsobr/9srdiCPIogPuFmyx6GQ
         /0+zyPdwt61yywgH4GnvjcY2ewhkdI2XkFYP0hYuOjFXW6ioenh8sy3UCJSJJCzAtMow
         95M3ldxzg5F3M9qxxNGWvkr8ZLvTuz1H1rBbpplRXx3rOR7e472b4h46Qs1l1QU7dquI
         bao5EWJfBg3O2buJVcA4J3lwJjZC9qdE2SEjeN2aSg2QgeyJRm91dAEUEf+Z87UpQNgj
         ar3vaZhcZXbBPq/PzI3bYpjywvLODkQHkBUBCZv+IUo2aFA8XGVg/0uIgSyaZi5ljvu0
         98xA==
X-Gm-Message-State: AOJu0YzO6K0uOUvzTBZy+4qO3FrmXEPNc5GSbbjI6s5fsiZNv95CZ2Uq
        Tea1k9CP2G4V5Imy9omaom8=
X-Google-Smtp-Source: AGHT+IE4KF0eiwfVaOhNf6jfqE9oaPUi2T3QaEVeWt2PYMsAvO5XVI2IHJDbRXFwJyHhRryS5KD4Fw==
X-Received: by 2002:aa7:d7d3:0:b0:523:36cf:8bf1 with SMTP id e19-20020aa7d7d3000000b0052336cf8bf1mr442553eds.34.1695772731143;
        Tue, 26 Sep 2023 16:58:51 -0700 (PDT)
Received: from skbuf ([188.25.161.12])
        by smtp.gmail.com with ESMTPSA id cw27-20020a056402229b00b0052ffc2e82f1sm190330edb.4.2023.09.26.16.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 16:58:50 -0700 (PDT)
Date:   Wed, 27 Sep 2023 02:58:48 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     =?utf-8?B?UGF3ZcWC?= Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/8] net: dsa: vsc73xx: Add vlan filtering
Message-ID: <20230926235848.3uftpkj7m24qsord@skbuf>
References: <20230912122201.3752918-1-paweldembicki@gmail.com>
 <20230912122201.3752918-6-paweldembicki@gmail.com>
 <20230912161709.g34slexfaop6xp7w@skbuf>
 <CAJN1Kkwzwt++6GtrAnCbKzYto-uQECYZz5=N7bePqK9wsK2_+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJN1Kkwzwt++6GtrAnCbKzYto-uQECYZz5=N7bePqK9wsK2_+g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 04:26:00PM +0200, Paweł Dembicki wrote:
> > > +             if (vsc->untagged_storage[port] < VLAN_N_VID &&
> > > +                 !vid_is_dsa_8021q(vsc->untagged_storage[port]) &&
> > > +                 !vid_is_dsa_8021q(vid) &&
> >
> > The problem here which led to these vid_is_dsa_8021q() checks is that
> > dsa_switch_tag_8021q_vlan_add() sets all flags on user ports to
> > BRIDGE_VLAN_INFO_UNTAGGED | BRIDGE_VLAN_INFO_PVID, and you can't offload
> > those, correct?
> 
> In my case, the major problem with tag8021q vlans is
> "dsa_tag_8021q_bridge_join" function:
> "dsa_port_tag_8021q_vlan_add" is called before "dsa_port_tag_8021q_vlan_del".
> I must disable pvid/untagged checking, because it will always fail. I
> let kernel do the job,
> it keeps only one untagged/pvid per port after "dsa_tag_8021q_bridge_join".

I'm not sure that you described the problem in a way that I can understand, here.

After dsa_tag_8021q_bridge_join():
-> dsa_port_tag_8021q_vlan_add(dp, bridge_vid)
-> dsa_port_tag_8021q_vlan_del(dp, standalone_vid)

it's *expected* that there should be only one untagged/pvid per port: the bridge_vid.

For context, consider the fact that you can run the following commands:

bridge vlan add dev eth0 vid 10 pvid
bridge vlan add dev eth0 vid 11 pvid

and after the second command, vid 10 stops being a pvid.

So I think that the "Port %d can have only one pvid! Now is: %d.\n" behavior
is not correct. You need to implement the pvid overwriting behavior, since
there's always only 1 pvid.

So that leaves the "untagged" flag as being problematic, correct? Could
you comment...

> 
> > But when the port is VSC73XX_VLAN_IGNORE mode (and
> > tag_8021q is active), VSC73XX_TXUPDCFG_TX_INSERT_TAG is 0, and thus,
> > *all* VLANs are egress-untagged VLANs, correct?
> >
> > If that is the case, why do you call vsc73xx_vlan_set_untagged() in the
> > first place, for tag_8021q VLANs, if you don't rely on the port's native
> > VLAN for egress untagging?

... on this? Here I'm pointing out that "all VLANs have the egress-untagged flag"
is a configuration that can actually be supported by vsc73xx. You just
need to ensure that VSC73XX_TXUPDCFG_TX_INSERT_TAG is 0. And tag_8021q
basically requests exactly that configuration on user ports (both the
bridge_vid and the standalone_vid are egress-untagged). So your check is
too restrictive, you are denying a configuration that would work.
The problem only appears when you mix egress-tagged with egress-untagged
VLANs on a port. Only then there can be at most 1 egress-untagged VID,
because you need to enable VSC73XX_TXUPDCFG_TX_INSERT_TAG for the
egress-tagged VIDs to work.

> > A comment would be good which states that the flipping between the
> > hardware and the storage values relies on the fact that vsc73xx_port_vlan_filtering()
> > only gets called on actual changes to vlan_filtering, and thus, to
> > vsc73xx_tag_8021q_active(). So, we know for sure that what is in storage
> > needs to go to hardware, and what is in hardware needs to go to storage.
> >
> > It's an interesting implementation for sure.
> >
> 
> Thank you.

I'm not sure if that was a compliment :) At least in this form, it's
certainly non-trivial to determine by looking at the code if it is
correct or not, and it uses different patterns than the other VLAN
implementations in DSA drivers. Generally, boring and obvious is
preferable. But after I took the time to understand, it seems plausible
that the approach might work.

Let's see how the same idea looks, cleaned up a bit but not redesigned,
in v4.
