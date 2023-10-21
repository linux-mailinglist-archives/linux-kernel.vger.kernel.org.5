Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BA87D1E15
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 17:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjJUP65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 11:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjJUP6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 11:58:55 -0400
X-Greylist: delayed 10942 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 21 Oct 2023 08:58:52 PDT
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1496398;
        Sat, 21 Oct 2023 08:58:52 -0700 (PDT)
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id F2AFF207B8;
        Sat, 21 Oct 2023 17:58:49 +0200 (CEST)
Received: from livingston (unknown [192.168.42.11])
        by gaggiata.pivistrello.it (Postfix) with ESMTP id 9753C7FD86;
        Sat, 21 Oct 2023 17:58:49 +0200 (CEST)
Received: from pivi by livingston with local (Exim 4.96)
        (envelope-from <francesco@dolcini.it>)
        id 1quENF-0006bI-1Z;
        Sat, 21 Oct 2023 17:58:49 +0200
Date:   Sat, 21 Oct 2023 17:58:49 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     David Lin <yu-hao.lin@nxp.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "francesco@dolcini.it" <francesco@dolcini.it>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: Re: [PATCH v6 1/6] wifi: mwifiex: added code to support host mlme.
Message-ID: <ZTP1OXGExKCMk14D@livingston.pivistrello.it>
References: <PA4PR04MB9638DEFC074F41AAEE3AC471D1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9638DEFC074F41AAEE3AC471D1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,
thanks for your patch.

On Fri, Oct 20, 2023 at 03:48:11AM +0000, David Lin wrote:
> 1. For station mode first.
> 2. This feature is a must for WPA3.
> 3. Firmware key api version 2 is needed for this feature.
> 4. The code is only enabled and tested with IW416.
> 5. This feature is disabled for other chips.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> ---
>  .../net/wireless/marvell/mwifiex/cfg80211.c   | 327 ++++++++++++++++++
>  drivers/net/wireless/marvell/mwifiex/cmdevt.c |  14 +-
>  drivers/net/wireless/marvell/mwifiex/decl.h   |  12 +
>  drivers/net/wireless/marvell/mwifiex/fw.h     |  15 +
>  drivers/net/wireless/marvell/mwifiex/init.c   |   3 +
>  drivers/net/wireless/marvell/mwifiex/join.c   |  64 +++-
>  drivers/net/wireless/marvell/mwifiex/main.h   |  10 +
>  drivers/net/wireless/marvell/mwifiex/scan.c   |   6 +
>  drivers/net/wireless/marvell/mwifiex/sdio.c   |  13 +
>  drivers/net/wireless/marvell/mwifiex/sdio.h   |   2 +
>  .../net/wireless/marvell/mwifiex/sta_event.c  |  18 +-
>  .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   3 +-
>  drivers/net/wireless/marvell/mwifiex/sta_tx.c |   9 +-
>  .../net/wireless/marvell/mwifiex/uap_cmd.c    |  26 ++
>  drivers/net/wireless/marvell/mwifiex/util.c   |  73 ++++
>  15 files changed, 582 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> index 7a15ea8072e6..40c39e4765f7 100644
> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> @@ -57,6 +57,31 @@ ieee80211_iface_combination mwifiex_iface_comb_ap_sta_drcs = {
>  	.beacon_int_infra_match = true,
>  };
>  
> +struct mwifiex_ieee80211_mgmt {
> +	__le16 frame_control;
> +	__le16 duration;
> +	u8 da[ETH_ALEN];
> +	u8 sa[ETH_ALEN];
> +	u8 bssid[ETH_ALEN];
> +	__le16 seq_ctrl;
> +	u8 addr4[ETH_ALEN];
> +	union {
> +		struct {
> +			__le16 auth_alg;
> +			__le16 auth_transaction;
> +			__le16 status_code;
> +			/* possibly followed by Challenge text */
> +			u8 variable[];
> +		} __packed auth;
> +		struct {
> +			__le16 capab_info;
> +			__le16 listen_interval;
> +			/* followed by SSID and Supported rates */
> +			u8 variable[];
> +		} __packed assoc_req;
> +	} u;
> +} __pack;

I noticed that you ignored some (all?) of my feedback [1].

Maybe my feedback got lost between the quotes, maybe you just forgot to apply
it. Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Francesco

[1] https://lore.kernel.org/all/ZRLsuJfxuvFk1K16@francesco-nb.int.toradex.com/
