Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4D67F9BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjK0IkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjK0IkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:40:12 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA669192
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:40:16 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3316d3d11e1so2152101f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701074415; x=1701679215; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=awMjj1wwjjtbhxeSOrDUmJkKzIc1TOvAP1VaIYVhyB4=;
        b=G4RpAmGHCGfTJCCsEq6yTa6l11Snvw7nJqRFx0R4/wedPih0cS/+IKVLFURo7Qzmwa
         9z/9vrDoPC0HvxuRUPrhkga4fRU859Blf9/cV/22EPDNXOSm5/cdCR6AlzxwS7fGfZTH
         fjGh5wVkMcsRGwdqx1C5A0Oz0LYi3WbyyDPUWz3x3e2miF6GNx/IlBd3X6SB3Ri+kR3f
         Vgyh8bBzyooD/1XivLrilvWdLYmuDVuGfXbCtWfmDGwwE0WGvp9XNTAnyoh/K/Vf88vE
         4SVPURTIKuIaIKU8gG0X4mJfVjnLBy5WoH+7WTLm8doNPr5ypsY6r1x8LPrO0LpJaT4b
         Gw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701074415; x=1701679215;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=awMjj1wwjjtbhxeSOrDUmJkKzIc1TOvAP1VaIYVhyB4=;
        b=I5P4IWT+yC31SmuhRuG7t3AL4ugTvEX5PLQOcCyDSyYd/qFKz/ptc/Xea03/rK2vob
         AmgMOmn7ek3kY0MHDBzQQTCFT87RmNYlSRrcHGNhhuXc6ohTCrX+UgtEYPli/ncOeqQ/
         ru2q5X7Slw4q6Jei35RhajcnD39EMkA2ZIHX0cpkcT5XjL6UMVTMK4/Fj9XcgXyrYDsi
         YZP8fadKYeWgc2/14tIwE+kccI18Hbr1X0an73TBvIMftpCN6xfpuLvOcbPT9o35qjES
         s7hyG2LbG8YDIzk71aYrdaIdewuJfi6IF/dvX+MbGNRuu0QzbsE+0wcPm51wSg2XQs9Y
         EChg==
X-Gm-Message-State: AOJu0Yz7HkZp7RoStMNbQTw0YehK9fM0nX6cCgEZMdLftbgIHctYrKnE
        KjBVKlu4P53UHf2IDI64Y3U/yg==
X-Google-Smtp-Source: AGHT+IHs7+vl2dXMbfBG7lM+Dhbkyr6wxdZgrF/7HEcN/ll3mbyId9SC+Nm3hyT1Watz+jvEAwZ/5Q==
X-Received: by 2002:a5d:4e89:0:b0:32f:7ff9:b731 with SMTP id e9-20020a5d4e89000000b0032f7ff9b731mr10343900wru.1.1701074415231;
        Mon, 27 Nov 2023 00:40:15 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m5-20020a5d56c5000000b00332cbd59f8bsm11263255wrw.25.2023.11.27.00.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 00:40:15 -0800 (PST)
From:   Dan Carpenter <dan.carpenter@linaro.org>
X-Google-Original-From: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Mon, 27 Nov 2023 11:40:12 +0300
To:     oe-kbuild@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c:711
 iwl_mvm_mld_add_sta() warn: missing error code 'ret'
Message-ID: <5db1bb80-5f08-449d-854e-36fbd8ab1d0b@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2da77f431ac49b5763b88751a75f70daa46296c
commit: 3aa80d31869bc2ba86f709843f7dbe1514ea10bb wifi: iwlwifi: mvm: check for iwl_mvm_mld_update_sta() errors
config: powerpc-randconfig-r071-20231126 (https://download.01.org/0day-ci/archive/20231127/202311270524.6QM9aKuf-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231127/202311270524.6QM9aKuf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202311270524.6QM9aKuf-lkp@intel.com/

smatch warnings:
drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c:711 iwl_mvm_mld_add_sta() warn: missing error code 'ret'

vim +/ret +711 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c

57974a55d99546 Gregory Greenman 2023-03-28  670  int iwl_mvm_mld_add_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
57974a55d99546 Gregory Greenman 2023-03-28  671  			struct ieee80211_sta *sta)
57974a55d99546 Gregory Greenman 2023-03-28  672  {
57974a55d99546 Gregory Greenman 2023-03-28  673  	struct iwl_mvm_vif *mvm_vif = iwl_mvm_vif_from_mac80211(vif);
57974a55d99546 Gregory Greenman 2023-03-28  674  	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
57974a55d99546 Gregory Greenman 2023-03-28  675  	unsigned long link_sta_added_to_fw = 0;
57974a55d99546 Gregory Greenman 2023-03-28  676  	struct ieee80211_link_sta *link_sta;
57974a55d99546 Gregory Greenman 2023-03-28  677  	int ret = 0;
57974a55d99546 Gregory Greenman 2023-03-28  678  	unsigned int link_id;
57974a55d99546 Gregory Greenman 2023-03-28  679  
57974a55d99546 Gregory Greenman 2023-03-28  680  	lockdep_assert_held(&mvm->mutex);
57974a55d99546 Gregory Greenman 2023-03-28  681  
57974a55d99546 Gregory Greenman 2023-03-28  682  	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
57974a55d99546 Gregory Greenman 2023-03-28  683  		ret = iwl_mvm_mld_alloc_sta_links(mvm, vif, sta);
87f7e2435cb7dd Miri Korenblit   2023-03-28  684  		if (ret)
87f7e2435cb7dd Miri Korenblit   2023-03-28  685  			return ret;
87f7e2435cb7dd Miri Korenblit   2023-03-28  686  
57974a55d99546 Gregory Greenman 2023-03-28  687  		spin_lock_init(&mvm_sta->lock);
57974a55d99546 Gregory Greenman 2023-03-28  688  
57974a55d99546 Gregory Greenman 2023-03-28  689  		ret = iwl_mvm_sta_init(mvm, vif, sta, IWL_MVM_INVALID_STA,
57974a55d99546 Gregory Greenman 2023-03-28  690  				       STATION_TYPE_PEER);
9e949dfdc5d169 Johannes Berg    2023-05-14  691  	} else {
9e949dfdc5d169 Johannes Berg    2023-05-14  692  		ret = iwl_mvm_alloc_sta_after_restart(mvm, vif, sta);
9e949dfdc5d169 Johannes Berg    2023-05-14  693  	}
9e949dfdc5d169 Johannes Berg    2023-05-14  694  
57974a55d99546 Gregory Greenman 2023-03-28  695  	if (ret)
57974a55d99546 Gregory Greenman 2023-03-28  696  		goto err;
57974a55d99546 Gregory Greenman 2023-03-28  697  
57974a55d99546 Gregory Greenman 2023-03-28  698  	/* at this stage sta link pointers are already allocated */
57974a55d99546 Gregory Greenman 2023-03-28  699  	ret = iwl_mvm_mld_update_sta(mvm, vif, sta);
3aa80d31869bc2 Johannes Berg    2023-09-21  700  	if (ret)
3aa80d31869bc2 Johannes Berg    2023-09-21  701  		goto err;
57974a55d99546 Gregory Greenman 2023-03-28  702  
57974a55d99546 Gregory Greenman 2023-03-28  703  	for_each_sta_active_link(vif, sta, link_sta, link_id) {
57974a55d99546 Gregory Greenman 2023-03-28  704  		struct ieee80211_bss_conf *link_conf =
0d504ca1f19b1a Johannes Berg    2023-03-29  705  			link_conf_dereference_protected(vif, link_id);
57974a55d99546 Gregory Greenman 2023-03-28  706  		struct iwl_mvm_link_sta *mvm_link_sta =
57974a55d99546 Gregory Greenman 2023-03-28  707  			rcu_dereference_protected(mvm_sta->link[link_id],
57974a55d99546 Gregory Greenman 2023-03-28  708  						  lockdep_is_held(&mvm->mutex));
57974a55d99546 Gregory Greenman 2023-03-28  709  
57974a55d99546 Gregory Greenman 2023-03-28  710  		if (WARN_ON(!link_conf || !mvm_link_sta))
57974a55d99546 Gregory Greenman 2023-03-28 @711  			goto err;

error code?

57974a55d99546 Gregory Greenman 2023-03-28  712  
57974a55d99546 Gregory Greenman 2023-03-28  713  		ret = iwl_mvm_mld_cfg_sta(mvm, sta, vif, link_sta, link_conf,
57974a55d99546 Gregory Greenman 2023-03-28  714  					  mvm_link_sta);
57974a55d99546 Gregory Greenman 2023-03-28  715  		if (ret)
57974a55d99546 Gregory Greenman 2023-03-28  716  			goto err;
57974a55d99546 Gregory Greenman 2023-03-28  717  
57974a55d99546 Gregory Greenman 2023-03-28  718  		link_sta_added_to_fw |= BIT(link_id);
57974a55d99546 Gregory Greenman 2023-03-28  719  
57974a55d99546 Gregory Greenman 2023-03-28  720  		if (vif->type == NL80211_IFTYPE_STATION)
57974a55d99546 Gregory Greenman 2023-03-28  721  			iwl_mvm_mld_set_ap_sta_id(sta, mvm_vif->link[link_id],
57974a55d99546 Gregory Greenman 2023-03-28  722  						  mvm_link_sta);
57974a55d99546 Gregory Greenman 2023-03-28  723  	}
87f7e2435cb7dd Miri Korenblit   2023-03-28  724  
87f7e2435cb7dd Miri Korenblit   2023-03-28  725  	return 0;
57974a55d99546 Gregory Greenman 2023-03-28  726  
57974a55d99546 Gregory Greenman 2023-03-28  727  err:
57974a55d99546 Gregory Greenman 2023-03-28  728  	/* remove all already allocated stations in FW */
57974a55d99546 Gregory Greenman 2023-03-28  729  	for_each_set_bit(link_id, &link_sta_added_to_fw,
57974a55d99546 Gregory Greenman 2023-03-28  730  			 IEEE80211_MLD_MAX_NUM_LINKS) {
57974a55d99546 Gregory Greenman 2023-03-28  731  		struct iwl_mvm_link_sta *mvm_link_sta =
57974a55d99546 Gregory Greenman 2023-03-28  732  			rcu_dereference_protected(mvm_sta->link[link_id],
57974a55d99546 Gregory Greenman 2023-03-28  733  						  lockdep_is_held(&mvm->mutex));
57974a55d99546 Gregory Greenman 2023-03-28  734  
57974a55d99546 Gregory Greenman 2023-03-28  735  		iwl_mvm_mld_rm_sta_from_fw(mvm, mvm_link_sta->sta_id);
57974a55d99546 Gregory Greenman 2023-03-28  736  	}
57974a55d99546 Gregory Greenman 2023-03-28  737  
57974a55d99546 Gregory Greenman 2023-03-28  738  	/* free all sta resources in the driver */
57974a55d99546 Gregory Greenman 2023-03-28  739  	iwl_mvm_mld_sta_rm_all_sta_links(mvm, mvm_sta);
57974a55d99546 Gregory Greenman 2023-03-28  740  	return ret;
87f7e2435cb7dd Miri Korenblit   2023-03-28  741  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

