Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148FA7C6B1B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377950AbjJLK2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377922AbjJLK2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:28:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D862C90;
        Thu, 12 Oct 2023 03:28:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955BFC433C8;
        Thu, 12 Oct 2023 10:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697106483;
        bh=FbfTb532UtefkAymkh2mZnU5Xx3DDUSbd8sYKfSFdGY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nHNCHhP6wfFh80mXpe0gyuhhSqhByBP9qUEcOutOzvlP1cvTxzMxajie1GblmH0tE
         3sLL9pXiW4F2LU/tR+t9LwvcCTSqLFqmxLGEmokk08Q7c9dVE43ZBZ1tbJubfNLYyq
         zw0dm8+x5G/3f42m4NEX49sNiol2aNzcSbBSg5J9nHzzoyNuB+5o0pZ9ljjMOV1kQk
         Y59Siwik74qPOsbh9CE0GouggBeG0O9cTle9PhObgwpD4CJqTSKVKLLvsGthmuiNqz
         msbqJCraosSs1eOP087Cl4YQyEMObqyX4ndk3tg2S0qmRtdq8SmURvXH8srqeOEuvJ
         ojfY8FXP+1U3Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     oe-kbuild@lists.linux.dev, Felix Fietkau <nbd@nbd.name>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: drivers/net/wireless/mediatek/mt76/mt76x02_util.c:475
 mt76x02_set_key() warn: variable dereferenced before check 'key' (see line
 415)
References: <77fee326-963a-40eb-80c9-2788a9ff9c22@kadam.mountain>
Date:   Thu, 12 Oct 2023 13:27:59 +0300
In-Reply-To: <77fee326-963a-40eb-80c9-2788a9ff9c22@kadam.mountain> (Dan
        Carpenter's message of "Thu, 12 Oct 2023 09:40:39 +0300")
Message-ID: <871qe03zkg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Adding linux-wireless, full report below.)

Dan Carpenter <dan.carpenter@linaro.org> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   401644852d0b2a278811de38081be23f74b5bb04
> commit: e6db67fa871dee37d22701daba806bfcd4d9df49 wifi: mt76: ignore key disable commands
> config: i386-randconfig-141-20231011 (https://download.01.org/0day-ci/archive/20231012/202310121455.LwR349tb-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231012/202310121455.LwR349tb-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202310121455.LwR349tb-lkp@intel.com/
>
> smatch warnings:
> drivers/net/wireless/mediatek/mt76/mt76x02_util.c:475 mt76x02_set_key() warn: variable dereferenced before check 'key' (see line 415)
>
> vim +/key +475 drivers/net/wireless/mediatek/mt76/mt76x02_util.c
>
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  407  int mt76x02_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  408  		    struct ieee80211_vif *vif, struct ieee80211_sta *sta,
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  409  		    struct ieee80211_key_conf *key)
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  410  {
> d87cf75f111183 Lorenzo Bianconi  2018-10-07  411  	struct mt76x02_dev *dev = hw->priv;
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  412  	struct mt76x02_vif *mvif = (struct mt76x02_vif *)vif->drv_priv;
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  413  	struct mt76x02_sta *msta;
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  414  	struct mt76_wcid *wcid;
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04 @415  	int idx = key->keyidx;
>                                                                   ^^^^^^^^^^^
> Dereference
>
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  416  	int ret;
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  417  
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  418  	/* fall back to sw encryption for unsupported ciphers */
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  419  	switch (key->cipher) {
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  420  	case WLAN_CIPHER_SUITE_WEP40:
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  421  	case WLAN_CIPHER_SUITE_WEP104:
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  422  	case WLAN_CIPHER_SUITE_TKIP:
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  423  	case WLAN_CIPHER_SUITE_CCMP:
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  424  		break;
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  425  	default:
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  426  		return -EOPNOTSUPP;
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  427  	}
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  428  
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  429  	/*
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  430  	 * The hardware does not support per-STA RX GTK, fall back
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  431  	 * to software mode for these.
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  432  	 */
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  433  	if ((vif->type == NL80211_IFTYPE_ADHOC ||
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  434  	     vif->type == NL80211_IFTYPE_MESH_POINT) &&
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  435  	    (key->cipher == WLAN_CIPHER_SUITE_TKIP ||
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  436  	     key->cipher == WLAN_CIPHER_SUITE_CCMP) &&
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  437  	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  438  		return -EOPNOTSUPP;
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  439  
> b98558e2529986 Stanislaw Gruszka 2019-03-19  440  	/*
> b98558e2529986 Stanislaw Gruszka 2019-03-19  441  	 * In USB AP mode, broadcast/multicast frames are setup in beacon
> b98558e2529986 Stanislaw Gruszka 2019-03-19  442  	 * data registers and sent via HW beacons engine, they require to
> b98558e2529986 Stanislaw Gruszka 2019-03-19  443  	 * be already encrypted.
> b98558e2529986 Stanislaw Gruszka 2019-03-19  444  	 */
> 61c51a74a4e586 Lorenzo Bianconi  2019-10-29  445  	if (mt76_is_usb(&dev->mt76) &&
> b98558e2529986 Stanislaw Gruszka 2019-03-19  446  	    vif->type == NL80211_IFTYPE_AP &&
> b98558e2529986 Stanislaw Gruszka 2019-03-19  447  	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
> b98558e2529986 Stanislaw Gruszka 2019-03-19  448  		return -EOPNOTSUPP;
> b98558e2529986 Stanislaw Gruszka 2019-03-19  449  
> 4b36cc6b390f18 David Bauer       2021-02-07  450  	/* MT76x0 GTK offloading does not work with more than one VIF */
> 4b36cc6b390f18 David Bauer       2021-02-07  451  	if (is_mt76x0(dev) && !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
> 4b36cc6b390f18 David Bauer       2021-02-07  452  		return -EOPNOTSUPP;
> 4b36cc6b390f18 David Bauer       2021-02-07  453  
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  454  	msta = sta ? (struct mt76x02_sta *)sta->drv_priv : NULL;
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  455  	wcid = msta ? &msta->wcid : &mvif->group_wcid;
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  456  
> e6db67fa871dee Felix Fietkau     2023-03-30  457  	if (cmd != SET_KEY) {
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  458  		if (idx == wcid->hw_key_idx) {
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  459  			wcid->hw_key_idx = -1;
> f2f6a47b504b8f Felix Fietkau     2019-01-25  460  			wcid->sw_iv = false;
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  461  		}
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  462  
> e6db67fa871dee Felix Fietkau     2023-03-30  463  		return 0;
> e6db67fa871dee Felix Fietkau     2023-03-30  464  	}
> e6db67fa871dee Felix Fietkau     2023-03-30  465  
> e6db67fa871dee Felix Fietkau     2023-03-30  466  	key->hw_key_idx = wcid->idx;
> e6db67fa871dee Felix Fietkau     2023-03-30  467  	wcid->hw_key_idx = idx;
> e6db67fa871dee Felix Fietkau     2023-03-30  468  	if (key->flags & IEEE80211_KEY_FLAG_RX_MGMT) {
> e6db67fa871dee Felix Fietkau     2023-03-30  469  		key->flags |= IEEE80211_KEY_FLAG_SW_MGMT_TX;
> e6db67fa871dee Felix Fietkau     2023-03-30  470  		wcid->sw_iv = true;
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  471  	}
> d87cf75f111183 Lorenzo Bianconi  2018-10-07  472  	mt76_wcid_key_setup(&dev->mt76, wcid, key);
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  473  
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  474  	if (!msta) {
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04 @475  		if (key || wcid->hw_key_idx == idx) {
>                                                                     ^^^
> Check for NULL.  I think "key" can't be NULL so this check is always
> true.  The check can be removed and the code pulled in an tab.
>
> 8d66af49a3db9a Lorenzo Bianconi  2018-10-07  476  			ret = mt76x02_mac_wcid_set_key(dev, wcid->idx, key);
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  477  			if (ret)
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  478  				return ret;
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  479  		}
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  480  
> 8d66af49a3db9a Lorenzo Bianconi  2018-10-07  481  		return mt76x02_mac_shared_key_setup(dev, mvif->idx, idx, key);
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  482  	}
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  483  
> 8d66af49a3db9a Lorenzo Bianconi  2018-10-07  484  	return mt76x02_mac_wcid_set_key(dev, msta->wcid.idx, key);
> 60c26859e863c1 Stanislaw Gruszka 2018-09-04  485  }

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
