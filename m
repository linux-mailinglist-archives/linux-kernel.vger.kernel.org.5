Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6407621E5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjGYS6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjGYS6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:58:43 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D352681;
        Tue, 25 Jul 2023 11:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=X0R22BGbmRjXXZscNgSBbP4wiQyyIcB9qX3GclN3VKQ=; b=pMHzyljz3zocsCU3tG8KLgimld
        AHsticsdDT5NHdPPBL5+fpo+9omp3YmofR8Zwa317kF/DgNvm/9XPvQuXDpOdnfCslAtEAoLt1+zT
        AURHv8Doe0j2pA0GGUU5hmZWOkOB8hY8lebFHPL7ZVR8qayQsM1yxoXjSN2ClZWLW/J4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qONEL-002IX2-IB; Tue, 25 Jul 2023 20:57:57 +0200
Date:   Tue, 25 Jul 2023 20:57:57 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Quan, Evan" <Evan.Quan@amd.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "mdaenzer@redhat.com" <mdaenzer@redhat.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "jingyuwang_vip@163.com" <jingyuwang_vip@163.com>,
        "Lazar, Lijo" <Lijo.Lazar@amd.com>,
        "jim.cromie@gmail.com" <jim.cromie@gmail.com>,
        "bellosilicio@gmail.com" <bellosilicio@gmail.com>,
        "andrealmeid@igalia.com" <andrealmeid@igalia.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "jsg@jsg.id.au" <jsg@jsg.id.au>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH V7 4/9] wifi: mac80211: Add support for ACPI WBRF
Message-ID: <d4cfbbae-9cd0-4767-8c80-ec09d1dbaf9c@lunn.ch>
References: <20230719090020.2716892-1-evan.quan@amd.com>
 <20230719090020.2716892-5-evan.quan@amd.com>
 <9b1f45f9-02a3-4c03-b9d5-cc3b9ab3a058@lunn.ch>
 <7d059aed-fac0-cdcd-63d5-58185bb345db@amd.com>
 <DM6PR12MB26196A993B3BA93392AA0FEDE403A@DM6PR12MB2619.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB26196A993B3BA93392AA0FEDE403A@DM6PR12MB2619.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > >> @@ -1395,6 +1395,8 @@ int ieee80211_register_hw(struct
> > ieee80211_hw *hw)
> > >>    debugfs_hw_add(local);
> > >>    rate_control_add_debugfs(local);
> > >>
> > >> +  ieee80211_check_wbrf_support(local);
> > >> +
> > >>    rtnl_lock();
> > >>    wiphy_lock(hw->wiphy);
> > >>
> > >
> > >> +void ieee80211_check_wbrf_support(struct ieee80211_local *local) {
> > >> +  struct wiphy *wiphy = local->hw.wiphy;
> > >> +  struct device *dev;
> > >> +
> > >> +  if (!wiphy)
> > >> +          return;
> > >> +
> > >> +  dev = wiphy->dev.parent;
> > >> +  if (!dev)
> > >> +          return;
> > >> +
> > >> +  local->wbrf_supported = wbrf_supported_producer(dev);
> > >> +  dev_dbg(dev, "WBRF is %s supported\n",
> > >> +          local->wbrf_supported ? "" : "not"); }
> > >
> > > This seems wrong. wbrf_supported_producer() is about "Should this
> > > device report the frequencies it is using?" The answer to that depends
> > > on a combination of: Are there consumers registered with the core, and
> > > is the policy set so WBRF should take actions. > The problem here is,
> > > you have no idea of the probe order. It could be this device probes
> > > before others, so wbrf_supported_producer() reports false, but a few
> > > second later would report true, once other devices have probed.
> > >
> > > It should be an inexpensive call into the core, so can be made every
> > > time the channel changes. All the core needs to do is check if the
> > > list of consumers is empty, and if not, check a Boolean policy value.
> > >
> > >       Andrew
> >
> > No, it's not a combination of whether consumers are registered with the core.
> > If a consumer probes later it needs to know the current in use frequencies too.
> >
> > The reason is because of this sequence of events:
> > 1) Producer probes.
> > 2) Producer selects a frequency.
> > 3) Consumer probes.
> > 4) Producer stays at same frequency.
> >
> > If the producer doesn't notify the frequency because a consumer isn't yet
> > loaded then the consumer won't be able to get the current frequency.
> Yes, exactly.

So now we are back to, what is the point of wbrf_supported_producer()?

I'm talking general case here, not your ACPI implementation. All i'm
really interested in is the generic API, which is what an Intel CPU,
combined with a Radieon GPU and a Qualcomm WiFi device will use. Or an
AMD CPU combined with an nvidia GPU and a Mediatek Wifi, etc. The wbrf
core should support an combination of produces and consumers in a
generic way.

If you assume devices can probe in any order, and come and go, it
seems like the producers need to always report what frequencies they
are using. Otherwise when a noise generator pops into existence, as
you say, it has no idea what frequencies the producers are using.

The exception is when policy says there is no need to actually do
anything. If we can assume the policy is fixed, then
wbrf_supported_producer() could just report the policy which the wbrf
core should know about.

    Andrew

