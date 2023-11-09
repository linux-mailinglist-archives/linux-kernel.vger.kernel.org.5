Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7759A7E69EC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjKILub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjKILu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:50:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363EB2D73
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 03:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699530589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rRWgktC5dBfBH0y4IlPCeWKy9YBplXDcHKZ7n5koZ7o=;
        b=eH6ZsfYueXxTrgC0Q3qZV2E/kUAVka2upRv5K+VLRpjV4QkiJ+m8Bo2tZjtLKuVwSM1NcP
        ebXPFvlENeynVCgbPP3giVVK2uNMx0fMlWIOric6AfmkvxWILsFXNpoh+f09Q+ndIfIKHJ
        fpAqquhbgKrMJNR8iWMAJaVWBYzhKX0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-1ilLTdcbMg2_JsUOE6WzIg-1; Thu, 09 Nov 2023 06:49:45 -0500
X-MC-Unique: 1ilLTdcbMg2_JsUOE6WzIg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-77891ef5fc9so14463985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 03:49:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699530585; x=1700135385;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rRWgktC5dBfBH0y4IlPCeWKy9YBplXDcHKZ7n5koZ7o=;
        b=ESsDETVTFbiHbFLSogREUYeFMFMoAcodymGXYAuNTM06/LW9jChfDM5q/qLtzCJRJc
         9ZfyZ5hC4Dcgxpwd/RD4Bp4Dr7XxdHYNknMP+pkxw/erryZPve4qfaltZDaG/Mlw7uEU
         srLhyQG3pToXhAXjNKgnGqfFP/p8PJO9nPtPI/hl/PdXiTDNVLuskY0tYH+gOGSR4HCb
         t/pootawTX8XzVibrgDXsiyG9ucNm0k/99a3TvNxDkFokQGt8eCnU7lYm5fs0mEHGhvd
         HczwczLRfMoWJdcnDU7AzZHIU73YZv0aT7VFoA/bP5KUQMGE7+saP8d30nf8SCfbYxON
         FAwg==
X-Gm-Message-State: AOJu0Yz+sG7VuVCDjQHUPADirHImlijW1lhI/T4kOia1e3uI+mOhCkZQ
        7fNQ/AOiB7j5+L+PF58VfJDniitYNYfCelVylBYTVR1obEFZa3wO7zVQVHculaZQDktWM2InzRX
        Bbw1wkyi/PUdgKFemHzkh1i2V
X-Received: by 2002:a05:622a:5186:b0:41e:4be2:d3eb with SMTP id ex6-20020a05622a518600b0041e4be2d3ebmr5519123qtb.1.1699530584773;
        Thu, 09 Nov 2023 03:49:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGUS4SbJ9ssl4USsnfkA9xKEduU/vOY24B+xDTRXOVdGNcq+w7LhBc+XgFeookbhcTcoTQKA==
X-Received: by 2002:a05:622a:5186:b0:41e:4be2:d3eb with SMTP id ex6-20020a05622a518600b0041e4be2d3ebmr5519110qtb.1.1699530584454;
        Thu, 09 Nov 2023 03:49:44 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-228-197.dyn.eolo.it. [146.241.228.197])
        by smtp.gmail.com with ESMTPSA id kf20-20020a05622a2a9400b0041b83654af9sm1859307qtb.30.2023.11.09.03.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 03:49:44 -0800 (PST)
Message-ID: <5783a6f8819a741f0f299602ff615e6a03368246.camel@redhat.com>
Subject: Re: [PATCH net v2 1/2] r8169: add handling DASH when DASH is
 disabled
From:   Paolo Abeni <pabeni@redhat.com>
To:     ChunHao Lin <hau@realtek.com>, hkallweit1@gmail.com
Cc:     nic_swsd@realtek.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date:   Thu, 09 Nov 2023 12:49:41 +0100
In-Reply-To: <20231108184849.2925-2-hau@realtek.com>
References: <20231108184849.2925-1-hau@realtek.com>
         <20231108184849.2925-2-hau@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-11-09 at 02:48 +0800, ChunHao Lin wrote:
> For devices that support DASH, even DASH is disabled, there may still
> exist a default firmware that will influence device behavior.
> So driver needs to handle DASH for devices that support DASH, no
> matter the DASH status is.
>=20
> This patch also prepare for "fix DASH deviceis network lost issue".
>=20
> Signed-off-by: ChunHao Lin <hau@realtek.com>

You should include the fixes tag you already added in v1 and your Sob
should come as the last tag

The same applies to the next patch=20

> Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

It's not clear where/when Heiner provided the above tag for this patch.
I hope that was off-list.

> Cc: stable@vger.kernel.org
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 35 ++++++++++++++++-------
>  1 file changed, 25 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethe=
rnet/realtek/r8169_main.c
> index 0c76c162b8a9..108dc75050ba 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -624,6 +624,7 @@ struct rtl8169_private {
> =20
>  	unsigned supports_gmii:1;
>  	unsigned aspm_manageable:1;
> +	unsigned dash_enabled:1;
>  	dma_addr_t counters_phys_addr;
>  	struct rtl8169_counters *counters;
>  	struct rtl8169_tc_offsets tc_offset;
> @@ -1253,14 +1254,26 @@ static bool r8168ep_check_dash(struct rtl8169_pri=
vate *tp)
>  	return r8168ep_ocp_read(tp, 0x128) & BIT(0);
>  }
> =20
> -static enum rtl_dash_type rtl_check_dash(struct rtl8169_private *tp)
> +static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
> +{
> +	switch (tp->dash_type) {
> +	case RTL_DASH_DP:
> +		return r8168dp_check_dash(tp);
> +	case RTL_DASH_EP:
> +		return r8168ep_check_dash(tp);
> +	default:
> +		return false;
> +	}
> +}
> +
> +static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
>  {
>  	switch (tp->mac_version) {
>  	case RTL_GIGA_MAC_VER_28:
>  	case RTL_GIGA_MAC_VER_31:
> -		return r8168dp_check_dash(tp) ? RTL_DASH_DP : RTL_DASH_NONE;
> +		return RTL_DASH_DP;
>  	case RTL_GIGA_MAC_VER_51 ... RTL_GIGA_MAC_VER_53:
> -		return r8168ep_check_dash(tp) ? RTL_DASH_EP : RTL_DASH_NONE;
> +		return RTL_DASH_EP;
>  	default:
>  		return RTL_DASH_NONE;
>  	}
> @@ -1453,7 +1466,7 @@ static void __rtl8169_set_wol(struct rtl8169_privat=
e *tp, u32 wolopts)
> =20
>  	device_set_wakeup_enable(tp_to_dev(tp), wolopts);
> =20
> -	if (tp->dash_type =3D=3D RTL_DASH_NONE) {
> +	if (!tp->dash_enabled) {
>  		rtl_set_d3_pll_down(tp, !wolopts);
>  		tp->dev->wol_enabled =3D wolopts ? 1 : 0;
>  	}
> @@ -2512,7 +2525,7 @@ static void rtl_wol_enable_rx(struct rtl8169_privat=
e *tp)
> =20
>  static void rtl_prepare_power_down(struct rtl8169_private *tp)
>  {
> -	if (tp->dash_type !=3D RTL_DASH_NONE)
> +	if (tp->dash_enabled)
>  		return;
> =20
>  	if (tp->mac_version =3D=3D RTL_GIGA_MAC_VER_32 ||
> @@ -4869,7 +4882,7 @@ static int rtl8169_runtime_idle(struct device *devi=
ce)
>  {
>  	struct rtl8169_private *tp =3D dev_get_drvdata(device);
> =20
> -	if (tp->dash_type !=3D RTL_DASH_NONE)
> +	if (tp->dash_enabled)
>  		return -EBUSY;
> =20
>  	if (!netif_running(tp->dev) || !netif_carrier_ok(tp->dev))
> @@ -4896,7 +4909,7 @@ static void rtl_shutdown(struct pci_dev *pdev)
>  	rtl_rar_set(tp, tp->dev->perm_addr);
> =20
>  	if (system_state =3D=3D SYSTEM_POWER_OFF &&
> -	    tp->dash_type =3D=3D RTL_DASH_NONE) {
> +		!tp->dash_enabled) {

Since you have to repost, please maintain the correct indentation
above:

	if (system_state =3D=3D SYSTEM_POWER_OFF &&
	    !tp->dash_enabled) {

        ^^^^
spaces here.


Cheers,

Paolo

