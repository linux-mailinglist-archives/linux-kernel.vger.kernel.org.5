Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40457B7CFB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242120AbjJDKVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242090AbjJDKVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:21:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09581AF;
        Wed,  4 Oct 2023 03:21:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC47C433C8;
        Wed,  4 Oct 2023 10:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696414873;
        bh=6p2OVd380km5MkF+sPFxwvvVTm86zMW8H5cFQGmcdVY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Wi/yGkS0T9C5bWzFr6HuIzQ51P1LBReYCW//EaJLFya6h0iAhKklLYCz98A/RlMRL
         Keuh5hIfEzqYtyXAteyIiEWFlZIpoYHdhpbjuokfpks4GIwrkHWg4XFlG17IALN9dg
         NKcei5S7jJxIl0gDtGw9CaXs4d3izjpZ4+VOfI2cehdDCkcCdMG9UJtcSxUz2JGEaZ
         ykFXmqJZC2Gq7PC1TUvUSvJorCW5Ag6m5S7jYIhy2s8A30GpmImPzXXgt4Do8GzvCW
         lJ2fK189Zn3CvY72AjOpZbYob5T56jihV/VsyD+CFH2upaIwQksK0kF28mWSjqmtdu
         gGngJcnOkhd0A==
From:   Kalle Valo <kvalo@kernel.org>
To:     =?utf-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] wifi: wfx: add placeholders for
 remain_on_channel feature
References: <20230927163257.568496-1-jerome.pouiller@silabs.com>
        <20230927163257.568496-6-jerome.pouiller@silabs.com>
Date:   Wed, 04 Oct 2023 13:23:30 +0300
In-Reply-To: <20230927163257.568496-6-jerome.pouiller@silabs.com>
 (=?utf-8?B?IkrDqXLDtG1l?=
        Pouiller"'s message of "Wed, 27 Sep 2023 18:32:53 +0200")
Message-ID: <87pm1uhejh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com> writes:

> First step to implement remain_on_channel.
>
> Signed-off-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
> ---
>  drivers/net/wireless/silabs/wfx/main.c |  3 +++
>  drivers/net/wireless/silabs/wfx/scan.c | 12 ++++++++++++
>  drivers/net/wireless/silabs/wfx/scan.h |  5 +++++
>  3 files changed, 20 insertions(+)
>
> diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wireles=
s/silabs/wfx/main.c
> index ede822d771aaf..31f6e0d3dc089 100644
> --- a/drivers/net/wireless/silabs/wfx/main.c
> +++ b/drivers/net/wireless/silabs/wfx/main.c
> @@ -151,6 +151,8 @@ static const struct ieee80211_ops wfx_ops =3D {
>  	.change_chanctx          =3D wfx_change_chanctx,
>  	.assign_vif_chanctx      =3D wfx_assign_vif_chanctx,
>  	.unassign_vif_chanctx    =3D wfx_unassign_vif_chanctx,
> +	.remain_on_channel       =3D wfx_remain_on_channel,
> +	.cancel_remain_on_channel =3D wfx_cancel_remain_on_channel,
>  };
>=20=20
>  bool wfx_api_older_than(struct wfx_dev *wdev, int major, int minor)
> @@ -288,6 +290,7 @@ struct wfx_dev *wfx_init_common(struct device *dev, c=
onst struct wfx_platform_da
>  	hw->wiphy->features |=3D NL80211_FEATURE_AP_SCAN;
>  	hw->wiphy->flags |=3D WIPHY_FLAG_AP_PROBE_RESP_OFFLOAD;
>  	hw->wiphy->flags |=3D WIPHY_FLAG_AP_UAPSD;
> +	hw->wiphy->max_remain_on_channel_duration =3D 5000;
>  	hw->wiphy->max_ap_assoc_sta =3D HIF_LINK_ID_MAX;
>  	hw->wiphy->max_scan_ssids =3D 2;
>  	hw->wiphy->max_scan_ie_len =3D IEEE80211_MAX_DATA_LEN;
> diff --git a/drivers/net/wireless/silabs/wfx/scan.c b/drivers/net/wireles=
s/silabs/wfx/scan.c
> index 16f619ed22e00..51338fd43ae4f 100644
> --- a/drivers/net/wireless/silabs/wfx/scan.c
> +++ b/drivers/net/wireless/silabs/wfx/scan.c
> @@ -145,3 +145,15 @@ void wfx_scan_complete(struct wfx_vif *wvif, int nb_=
chan_done)
>  	wvif->scan_nb_chan_done =3D nb_chan_done;
>  	complete(&wvif->scan_complete);
>  }
> +
> +int wfx_remain_on_channel(struct ieee80211_hw *hw, struct ieee80211_vif =
*vif,
> +			  struct ieee80211_channel *chan, int duration,
> +			  enum ieee80211_roc_type type)
> +{
> +	return 0;
> +}
> +
> +int wfx_cancel_remain_on_channel(struct ieee80211_hw *hw, struct ieee802=
11_vif *vif)
> +{
> +	return 0;
> +}
> diff --git a/drivers/net/wireless/silabs/wfx/scan.h b/drivers/net/wireles=
s/silabs/wfx/scan.h
> index 78e3b984f375c..2f8361769303e 100644
> --- a/drivers/net/wireless/silabs/wfx/scan.h
> +++ b/drivers/net/wireless/silabs/wfx/scan.h
> @@ -19,4 +19,9 @@ int wfx_hw_scan(struct ieee80211_hw *hw, struct ieee802=
11_vif *vif,
>  void wfx_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *v=
if);
>  void wfx_scan_complete(struct wfx_vif *wvif, int nb_chan_done);
>=20=20
> +int wfx_remain_on_channel(struct ieee80211_hw *hw, struct ieee80211_vif =
*vif,
> +			  struct ieee80211_channel *chan, int duration,
> +			  enum ieee80211_roc_type type);
> +int wfx_cancel_remain_on_channel(struct ieee80211_hw *hw, struct ieee802=
11_vif *vif);
> +
>  #endif

I'm not really seeing the point of this patch. I would expect that once
.remain_on_channel is assign the feature will work without issues, for
example otherwise git bisect will not work correctly.

What about folding patches 5 and 6 into one patch? And then moving that
patch as the last to make sure that the feature is enabled on the driver
only after it works correctly?

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
