Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEB578CD85
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240512AbjH2UVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240596AbjH2UVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:21:34 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C08E53;
        Tue, 29 Aug 2023 13:21:18 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1bc0d39b52cso29744185ad.2;
        Tue, 29 Aug 2023 13:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693340478; x=1693945278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c81JXAzq4l8CXFEMkDocGz6SNd5sCagmd6kIcbpsZa0=;
        b=d0JNLbkyUS4n8JVEdncH6VQY+rGvNKALqqzLP71dHo8fRGeHSOP3suoNVW6rNsGi2n
         NVU+7tDFBCDxeN/zFOHxSW9V/AuYwiOodGEAi71okYUahXtfQWk/176DtYc+xHWFO70s
         64sWT3pacX+hXmDhy+8mMdoHXyBM+uTXIXC44Bo2BWp/0jKHAfyjGiRU1nSwkpSizcDJ
         tUU5gQgzeqdD7B1GwzhuLKNd3vza9a0NU1X/PUyg8KEeuSj8OBq4GB6tSHMTpTOyp3Ln
         HDOSh5v3RA4vco5pbgmysy6NTmCsEk2a2K1Rq+lT0YvbQ/rbyTjhYFAebV2JEDnvtu17
         JRzA==
X-Gm-Message-State: AOJu0YzHaZy6TSOP0xzDKGZZQMkw5WGM1A1PZO6VUumB7zbrsWWwvUJx
        plppfOSxFSRc7JOs9Dn8j1icH02k49U=
X-Google-Smtp-Source: AGHT+IHSQEIiOROqY3DtMc9L1nin0cVsDes8mQ1K4srVt4ZVwlZtiXrmbkil9WS49Q2v4umFg9qeQw==
X-Received: by 2002:a17:902:e887:b0:1bb:b226:52a0 with SMTP id w7-20020a170902e88700b001bbb22652a0mr183342plg.44.1693340477806;
        Tue, 29 Aug 2023 13:21:17 -0700 (PDT)
Received: from sultan-box.localdomain ([142.147.89.200])
        by smtp.gmail.com with ESMTPSA id ji18-20020a170903325200b001b9d8688956sm9799334plb.144.2023.08.29.13.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 13:21:17 -0700 (PDT)
Date:   Tue, 29 Aug 2023 13:21:13 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     "Greenman, Gregory" <gregory.greenman@intel.com>
Cc:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: iwlwifi: mvm: fix power save for MLD
Message-ID: <ZO5TOS3HxyqN-bNu@sultan-box.localdomain>
References: <20230822040745.260086-1-sultan@kerneltoast.com>
 <5a5d6502180858f811861384acc49f9174ca8652.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a5d6502180858f811861384acc49f9174ca8652.camel@intel.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 04:25:45PM +0000, Greenman, Gregory wrote:
> Hi,
> 
> On Mon, 2023-08-21 at 21:07 -0700, Sultan Alsawaf wrote:
> > From: Sultan Alsawaf <sultan@kerneltoast.com>
> > 
> > The conversion from bss_info_changed() to vif_cfg/link_info_changed()
> > removed a call to iwl_mvm_bss_info_changed_station_common() from what
> > became the vif_cfg_changed() path. As a result, BSS_CHANGED_PS and other
> > power save changes sent via ieee80211_vif_cfg_change_notify() are ignored
> > for MLD, which breaks power save entirely. This has a noticeable impact on
> > power consumption, causing idle package power to hover at 10 W on my
> > i9-13980HX laptop with an AX210 while connected to WiFi.
> > 
> > Add the missing iwl_mvm_bss_info_changed_station_common() call to the
> > vif_cfg_changed() path to fix power save for MLD. This brings idle package
> > power down to 1 W on my laptop, a 9 W improvement.
> > 
> > Fixes: 22c588343529 ("wifi: iwlwifi: mvm: replace bss_info_changed() with vif_cfg/link_info_changed()")
> > Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> > ---
> >  drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
> > index 8b6c641772ee..6abc05976870 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
> > @@ -731,6 +731,8 @@ static void iwl_mvm_mld_vif_cfg_changed_station(struct iwl_mvm *mvm,
> >  
> >         mvmvif->associated = vif->cfg.assoc;
> >  
> > +       iwl_mvm_bss_info_changed_station_common(mvm, vif, &vif->bss_conf,
> > +                                               changes);
> >         if (!(changes & BSS_CHANGED_ASSOC))
> >                 return;
> >  
> 
> I agree that it looks like the call to iwl_mvm_bss_info_changed_station_common() is missing here, but
> I think if is is added here then the call to iwl_mvm_power_update_mac() at the end of this function
> is not needed anymore?

That call to iwl_mvm_power_update_mac() only exists in the backport driver [1]
at the moment, hence why power save is currently broken in the upstream driver.

I wasn't aware that the backport driver had that change until after I sent this,
FWIW. :)

I agree that the iwl_mvm_power_update_mac() call in the backport driver would be
redundant with this patch.

How would you like to go about this? Shall I send a v2 reformatted for the
backport driver, with an updated commit message since power save isn't broken in
the backport driver?

Or could this be staged upstream with [1] subsequently getting dropped from the
backport driver?

Thanks,
Sultan

[1] https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/backport-iwlwifi.git/commit/?id=c3201e3d7d88bdfa0f0a94e4141c626c35724655
