Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BB17A9986
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjIUSPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjIUSPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:15:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3087B47F;
        Thu, 21 Sep 2023 10:37:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CE9C433BB;
        Thu, 21 Sep 2023 07:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695280798;
        bh=qjFbYo5tJqw3sNctQO007tji3a55xgbw4igevqYkDao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rpVULoBZ3MGrvhXQQ7B685n9CQgbFp3mhxjiWvBfGdqG8ZaLxO+6F/+PEjeI+4uc+
         r9l9pr1hId5qrpT7zz72u3DxjEwzXFvOBjvz/9ZGA75g/kDT5oZIHiOEsv6Zw2vtTS
         oIHeI+YHXxyAH/dj3ja2bPp2frXGlGfqPJVfCoJE=
Date:   Thu, 21 Sep 2023 09:19:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] wifi: mt76: mt7915: remove VHT160 capability on
 MT7915
Message-ID: <2023092145-luxury-fender-d5b9@gregkh>
References: <20230726091704.25795-1-nbd@nbd.name>
 <12289744.O9o76ZdvQC@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12289744.O9o76ZdvQC@natalenko.name>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 07:02:41AM +0200, Oleksandr Natalenko wrote:
> Hello Felix.
> 
> On středa 26. července 2023 11:17:02 CEST Felix Fietkau wrote:
> > The IEEE80211_VHT_CAP_EXT_NSS_BW value already indicates support for half-NSS
> > 160 MHz support, so it is wrong to also advertise full 160 MHz support.
> > 
> > Fixes: c2f73eacee3b ("wifi: mt76: mt7915: add back 160MHz channel width support for MT7915")
> > Signed-off-by: Felix Fietkau <nbd@nbd.name>
> > ---
> >  drivers/net/wireless/mediatek/mt76/mt7915/init.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> > index ee976657bfc3..78552f10b377 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> > @@ -414,7 +414,6 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
> >  			if (!dev->dbdc_support)
> >  				vht_cap->cap |=
> >  					IEEE80211_VHT_CAP_SHORT_GI_160 |
> > -					IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
> >  					FIELD_PREP(IEEE80211_VHT_CAP_EXT_NSS_BW_MASK, 1);
> >  		} else {
> >  			vht_cap->cap |=
> > 
> 
> For some reason this got backported into the stable kernel:
> 
> ```
> $ git log --oneline v6.5.2..v6.5.4 -- drivers/net/wireless/mediatek/mt76/mt7915/
> c43017fbebcc3 wifi: mt76: mt7915: fix power-limits while chan_switch
> edb1afe042c74 wifi: mt76: mt7915: fix tlv length of mt7915_mcu_get_chan_mib_info
> 9ec0dec0baea3 wifi: mt76: mt7915: remove VHT160 capability on MT7915
> 0e61f73e6ebc0 wifi: mt76: mt7915: fix capabilities in non-AP mode
> 6bce28ce28390 wifi: mt76: mt7915: fix command timeout in AP stop period
> 7af917d4864c6 wifi: mt76: mt7915: rework tx bytes counting when WED is active
> feae00c6468ce wifi: mt76: mt7915: rework tx packets counting when WED is active
> 70bbcc4ad6544 wifi: mt76: mt7915: fix background radar event being blocked
> ```
> 
> and this broke my mt7915-based AP.
> 
> However, if I remove `[VT160]` capability from the hostapd config, things go back to normal. It does seem that 160 MHz still works even.
> 
> Is this expected?

Is your device also broken in 6.6-rc2?

thanks,

greg k-h
