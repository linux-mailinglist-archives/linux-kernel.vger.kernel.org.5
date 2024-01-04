Return-Path: <linux-kernel+bounces-16862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD0D82451C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C5F28770A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA9924A1D;
	Thu,  4 Jan 2024 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="fZWHC0wV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AB72420A;
	Thu,  4 Jan 2024 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id LPfur9mFBfp3nLPfurhleV; Thu, 04 Jan 2024 16:30:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704382227;
	bh=plHPyIH5zVjLRms9bS6pvrWDpZ/Jom8vlRsgZcTioiA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fZWHC0wV4NbhMpSoqvoCHst8pYerROB1GxAXy2KRWQyhlYQAj0unvlMgjogN+z7Si
	 AQ/ex9kBTmSPmgXsIgG0ByRf3v/UR3mtoZVAn22FSYx2fQg1BEVE7Kt/t8i0N6d5ZE
	 16NdPq5nXz+cnvursWGqnb1uYOsEo5UUMIB50HOL+2eZek4+6v2SeB1bm+13O9S2Lv
	 KgK2n2f9ozG2amGDnGO4YMoBeiV4PxNmsWt8Jd6Jj0oRIw6JWxghh5CDfzTq+HWW+J
	 Iu+i8XIQVElBcLFFPdvCsdiH3jWwcLP2tmZBEg79sSGsqu7RZAwsqfiHKK2fe1VhEl
	 op6URmp8BB+EQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 04 Jan 2024 16:30:27 +0100
X-ME-IP: 92.140.202.140
Message-ID: <175febb5-f31a-4540-8b70-7206fef83760@wanadoo.fr>
Date: Thu, 4 Jan 2024 16:30:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: wilc1000: fix RCU usage in connect path
Content-Language: fr
To: alexis.lothore@bootlin.com
Cc: ajay.kathat@microchip.com, claudiu.beznea@tuxon.dev, kvalo@kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 thomas.petazzoni@bootlin.com
References: <20240104143925.194295-1-alexis.lothore@bootlin.com>
 <20240104143925.194295-3-alexis.lothore@bootlin.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240104143925.194295-3-alexis.lothore@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/01/2024 à 15:39, Alexis Lothoré a écrit :
> From: Alexis Lothoré <alexis.lothore-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
> 
> With lockdep enabled, calls to the connect function from cfg802.11 layer
> lead to the following warning:
> 
> =============================
> WARNING: suspicious RCU usage
> 6.7.0-rc1-wt+ #333 Not tainted
> -----------------------------
> drivers/net/wireless/microchip/wilc1000/hif.c:386
> suspicious rcu_dereference_check() usage!
> [...]
> stack backtrace:
> CPU: 0 PID: 100 Comm: wpa_supplicant Not tainted 6.7.0-rc1-wt+ #333
> Hardware name: Atmel SAMA5
>   unwind_backtrace from show_stack+0x18/0x1c
>   show_stack from dump_stack_lvl+0x34/0x48
>   dump_stack_lvl from wilc_parse_join_bss_param+0x7dc/0x7f4
>   wilc_parse_join_bss_param from connect+0x2c4/0x648
>   connect from cfg80211_connect+0x30c/0xb74
>   cfg80211_connect from nl80211_connect+0x860/0xa94
>   nl80211_connect from genl_rcv_msg+0x3fc/0x59c
>   genl_rcv_msg from netlink_rcv_skb+0xd0/0x1f8
>   netlink_rcv_skb from genl_rcv+0x2c/0x3c
>   genl_rcv from netlink_unicast+0x3b0/0x550
>   netlink_unicast from netlink_sendmsg+0x368/0x688
>   netlink_sendmsg from ____sys_sendmsg+0x190/0x430
>   ____sys_sendmsg from ___sys_sendmsg+0x110/0x158
>   ___sys_sendmsg from sys_sendmsg+0xe8/0x150
>   sys_sendmsg from ret_fast_syscall+0x0/0x1c
> 
> This warning is emitted because in the connect path, when trying to parse
> target BSS parameters, we dereference a RCU pointer whithout being in RCU
> critical section.
> Fix RCU dereference usage by moving it to a RCU read critical section. To
> avoid wrapping the whole wilc_parse_join_bss_param under the critical
> section, just use the critical section to copy ies data
> 
> Fixes: c460495ee072 ("staging: wilc1000: fix incorrent type in initializer")
> Signed-off-by: Alexis Lothoré <alexis.lothore-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
> ---
>   drivers/net/wireless/microchip/wilc1000/hif.c | 35 ++++++++++++-------
>   1 file changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
> index 6f1218a51061..806b7337b5ae 100644
> --- a/drivers/net/wireless/microchip/wilc1000/hif.c
> +++ b/drivers/net/wireless/microchip/wilc1000/hif.c
> @@ -377,38 +377,48 @@ struct wilc_join_bss_param *
>   wilc_parse_join_bss_param(struct cfg80211_bss *bss,
>   			  struct cfg80211_crypto_settings *crypto)
>   {
> -	const struct cfg80211_bss_ies *ies = rcu_dereference(bss->ies);
> -	const u8 *tim_elm, *ssid_elm, *rates_ie, *supp_rates_ie;
> +	const u8 *ies_data, *tim_elm, *ssid_elm, *rates_ie, *supp_rates_ie;
>   	const u8 *ht_ie, *wpa_ie, *wmm_ie, *rsn_ie;
>   	struct ieee80211_p2p_noa_attr noa_attr;
> +	const struct cfg80211_bss_ies *ies;
>   	struct wilc_join_bss_param *param;
> -	u8 rates_len = 0;
> +	u8 rates_len = 0, ies_len;
>   	int ret;
>   
>   	param = kzalloc(sizeof(*param), GFP_KERNEL);
>   	if (!param)
>   		return NULL;
>   
> +	rcu_read_lock();
> +	ies = rcu_dereference(bss->ies);
> +	ies_data = kmemdup(ies->data, ies->len, GFP_ATOMIC);

Is it mandatory to have GFP_ATOMIC here?
If yes, then some other drivers may need to be fixed (at least [1]).

> +	if (!ies_data) {
> +		rcu_read_unlock();

'param' allocated just a few lines above is leaking now.

CJ


[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/pci/p2pdma.c#n660


> +		return NULL;
> +	}
> +	ies_len = ies->len;
> +	rcu_read_unlock();
> +
>   	param->beacon_period = cpu_to_le16(bss->beacon_interval);
>   	param->cap_info = cpu_to_le16(bss->capability);
>   	param->bss_type = WILC_FW_BSS_TYPE_INFRA;
>   	param->ch = ieee80211_frequency_to_channel(bss->channel->center_freq);
>   	ether_addr_copy(param->bssid, bss->bssid);
>   
> -	ssid_elm = cfg80211_find_ie(WLAN_EID_SSID, ies->data, ies->len);
> +	ssid_elm = cfg80211_find_ie(WLAN_EID_SSID, ies_data, ies_len);
>   	if (ssid_elm) {
>   		if (ssid_elm[1] <= IEEE80211_MAX_SSID_LEN)
>   			memcpy(param->ssid, ssid_elm + 2, ssid_elm[1]);
>   	}
>   
> -	tim_elm = cfg80211_find_ie(WLAN_EID_TIM, ies->data, ies->len);
> +	tim_elm = cfg80211_find_ie(WLAN_EID_TIM, ies_data, ies_len);
>   	if (tim_elm && tim_elm[1] >= 2)
>   		param->dtim_period = tim_elm[3];
>   
>   	memset(param->p_suites, 0xFF, 3);
>   	memset(param->akm_suites, 0xFF, 3);
>   
> -	rates_ie = cfg80211_find_ie(WLAN_EID_SUPP_RATES, ies->data, ies->len);
> +	rates_ie = cfg80211_find_ie(WLAN_EID_SUPP_RATES, ies_data, ies_len);
>   	if (rates_ie) {
>   		rates_len = rates_ie[1];
>   		if (rates_len > WILC_MAX_RATES_SUPPORTED)
> @@ -419,7 +429,7 @@ wilc_parse_join_bss_param(struct cfg80211_bss *bss,
>   
>   	if (rates_len < WILC_MAX_RATES_SUPPORTED) {
>   		supp_rates_ie = cfg80211_find_ie(WLAN_EID_EXT_SUPP_RATES,
> -						 ies->data, ies->len);
> +						 ies_data, ies_len);
>   		if (supp_rates_ie) {
>   			u8 ext_rates = supp_rates_ie[1];
>   
> @@ -434,11 +444,11 @@ wilc_parse_join_bss_param(struct cfg80211_bss *bss,
>   		}
>   	}
>   
> -	ht_ie = cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, ies->data, ies->len);
> +	ht_ie = cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, ies_data, ies_len);
>   	if (ht_ie)
>   		param->ht_capable = true;
>   
> -	ret = cfg80211_get_p2p_attr(ies->data, ies->len,
> +	ret = cfg80211_get_p2p_attr(ies_data, ies_len,
>   				    IEEE80211_P2P_ATTR_ABSENCE_NOTICE,
>   				    (u8 *)&noa_attr, sizeof(noa_attr));
>   	if (ret > 0) {
> @@ -462,7 +472,7 @@ wilc_parse_join_bss_param(struct cfg80211_bss *bss,
>   	}
>   	wmm_ie = cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT,
>   					 WLAN_OUI_TYPE_MICROSOFT_WMM,
> -					 ies->data, ies->len);
> +					 ies_data, ies_len);
>   	if (wmm_ie) {
>   		struct ieee80211_wmm_param_ie *ie;
>   
> @@ -477,13 +487,13 @@ wilc_parse_join_bss_param(struct cfg80211_bss *bss,
>   
>   	wpa_ie = cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT,
>   					 WLAN_OUI_TYPE_MICROSOFT_WPA,
> -					 ies->data, ies->len);
> +					 ies_data, ies_len);
>   	if (wpa_ie) {
>   		param->mode_802_11i = 1;
>   		param->rsn_found = true;
>   	}
>   
> -	rsn_ie = cfg80211_find_ie(WLAN_EID_RSN, ies->data, ies->len);
> +	rsn_ie = cfg80211_find_ie(WLAN_EID_RSN, ies_data, ies_len);
>   	if (rsn_ie) {
>   		int rsn_ie_len = sizeof(struct element) + rsn_ie[1];
>   		int offset = 8;
> @@ -517,6 +527,7 @@ wilc_parse_join_bss_param(struct cfg80211_bss *bss,
>   			param->akm_suites[i] = crypto->akm_suites[i] & 0xFF;
>   	}
>   
> +	kfree(ies_data);
>   	return (void *)param;
>   }
>   


