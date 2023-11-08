Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA8F7E54BF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbjKHLNm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Nov 2023 06:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjKHLNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:13:40 -0500
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7001B3;
        Wed,  8 Nov 2023 03:13:38 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9dd5879a126so788084066b.3;
        Wed, 08 Nov 2023 03:13:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699442015; x=1700046815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aa+ViCUK3fZfx5s1sIETj47ifZQeP9M0i8nxo+tjcZI=;
        b=Xt64usWH2OWYyeun8ifSfOruxI8XO6PIk+jE+AUUeom6xvwsIpKiTFOP3gkDMpw1xy
         4SWBoTgD7Db3bSOeAU8KmzqBa8lKzvsrwMQmrkIdAfxybVgslbFKjZZYLgSL05MHoJiO
         uRlCyFJRdyOsOSY9NX3nXU4LsNoxKzYXOjdJg4jM0OTuQ+TgcdLkIbOkvaTAbWrFzV8I
         JId3qkf7KPTePhd9VVJr0rp+iA43DTLH1Z0JtDjKa0Fch/p8S7svBcHAShy/36DZozwX
         amqvkqqIpsF8PswVepz9hXFhgeXjxXIrjbFctMz2/Zks7SNrVWo3P1qHMRSDPP2xq66O
         CJ/A==
X-Gm-Message-State: AOJu0Ywn/5TK9BfDoh8hjjn6YQzN/8h+OHKuKo+0VlL8CWcpHv1JF7ll
        XXMIwxn9fJhKTEhcbqY/JqP9lX5wLbqZBnZT
X-Google-Smtp-Source: AGHT+IG7kJINmYiYUwemScmJGQ+6Kb+dtYvW2pg4CcQls8sson1LSal0/gbDhMXSDWIRMID83mvHLw==
X-Received: by 2002:a17:907:7b95:b0:9c7:59d1:b2c9 with SMTP id ne21-20020a1709077b9500b009c759d1b2c9mr1174660ejc.17.1699442014603;
        Wed, 08 Nov 2023 03:13:34 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id y19-20020a17090668d300b00992f2befcbcsm861697ejr.180.2023.11.08.03.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 03:13:34 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9dd5879a126so788079266b.3;
        Wed, 08 Nov 2023 03:13:34 -0800 (PST)
X-Received: by 2002:a17:907:7d9e:b0:9a9:ef41:e5c7 with SMTP id
 oz30-20020a1709077d9e00b009a9ef41e5c7mr1292716ejc.8.1699442013815; Wed, 08
 Nov 2023 03:13:33 -0800 (PST)
MIME-Version: 1.0
References: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
In-Reply-To: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
From:   Neal Gompa <neal@gompa.dev>
Date:   Wed, 8 Nov 2023 06:12:56 -0500
X-Gmail-Original-Message-ID: <CAEg-Je-pu5Xdej33b_6vrjgddP0A=-Pc_RFbB-wDVNxPXy2mZw@mail.gmail.com>
Message-ID: <CAEg-Je-pu5Xdej33b_6vrjgddP0A=-Pc_RFbB-wDVNxPXy2mZw@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
To:     Hector Martin <marcan@marcan.st>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Daniel Berlin <dberlin@dberlin.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 1:06 AM Hector Martin <marcan@marcan.st> wrote:
>
> Using the WSEC command instead of sae_password seems to be the supported
> mechanism on newer firmware, and also how the brcmdhd driver does it.
>
> According to user reports [1], the sae_password codepath doesn't actually
> work on machines with Cypress chips anyway, so no harm in removing it.
>
> This makes WPA3 work with iwd, or with wpa_supplicant pending a support
> patchset [2].
>
> [1] https://rachelbythebay.com/w/2023/11/06/wpa3/
> [2] http://lists.infradead.org/pipermail/hostap/2023-July/041653.html
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 46 +++++++++-------------
>  .../broadcom/brcm80211/brcmfmac/fwil_types.h       |  2 +-
>  2 files changed, 20 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index 2a90bb24ba77..138af70a33b8 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -1687,52 +1687,44 @@ static u16 brcmf_map_fw_linkdown_reason(const struct brcmf_event_msg *e)
>         return reason;
>  }
>
> -static int brcmf_set_pmk(struct brcmf_if *ifp, const u8 *pmk_data, u16 pmk_len)
> +static int brcmf_set_wsec(struct brcmf_if *ifp, const u8 *key, u16 key_len, u16 flags)
>  {
>         struct brcmf_pub *drvr = ifp->drvr;
>         struct brcmf_wsec_pmk_le pmk;
>         int err;
>
> +       if (key_len > sizeof(pmk.key)) {
> +               bphy_err(drvr, "key must be less than %zu bytes\n",
> +                        sizeof(pmk.key));
> +               return -EINVAL;
> +       }
> +
>         memset(&pmk, 0, sizeof(pmk));
>
> -       /* pass pmk directly */
> -       pmk.key_len = cpu_to_le16(pmk_len);
> -       pmk.flags = cpu_to_le16(0);
> -       memcpy(pmk.key, pmk_data, pmk_len);
> +       /* pass key material directly */
> +       pmk.key_len = cpu_to_le16(key_len);
> +       pmk.flags = cpu_to_le16(flags);
> +       memcpy(pmk.key, key, key_len);
>
> -       /* store psk in firmware */
> +       /* store key material in firmware */
>         err = brcmf_fil_cmd_data_set(ifp, BRCMF_C_SET_WSEC_PMK,
>                                      &pmk, sizeof(pmk));
>         if (err < 0)
>                 bphy_err(drvr, "failed to change PSK in firmware (len=%u)\n",
> -                        pmk_len);
> +                        key_len);
>
>         return err;
>  }
>
> +static int brcmf_set_pmk(struct brcmf_if *ifp, const u8 *pmk_data, u16 pmk_len)
> +{
> +       return brcmf_set_wsec(ifp, pmk_data, pmk_len, 0);
> +}
> +
>  static int brcmf_set_sae_password(struct brcmf_if *ifp, const u8 *pwd_data,
>                                   u16 pwd_len)
>  {
> -       struct brcmf_pub *drvr = ifp->drvr;
> -       struct brcmf_wsec_sae_pwd_le sae_pwd;
> -       int err;
> -
> -       if (pwd_len > BRCMF_WSEC_MAX_SAE_PASSWORD_LEN) {
> -               bphy_err(drvr, "sae_password must be less than %d\n",
> -                        BRCMF_WSEC_MAX_SAE_PASSWORD_LEN);
> -               return -EINVAL;
> -       }
> -
> -       sae_pwd.key_len = cpu_to_le16(pwd_len);
> -       memcpy(sae_pwd.key, pwd_data, pwd_len);
> -
> -       err = brcmf_fil_iovar_data_set(ifp, "sae_password", &sae_pwd,
> -                                      sizeof(sae_pwd));
> -       if (err < 0)
> -               bphy_err(drvr, "failed to set SAE password in firmware (len=%u)\n",
> -                        pwd_len);
> -
> -       return err;
> +       return brcmf_set_wsec(ifp, pwd_data, pwd_len, BRCMF_WSEC_PASSPHRASE);
>  }
>
>  static void brcmf_link_down(struct brcmf_cfg80211_vif *vif, u16 reason,
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
> index 611d1a6aabb9..b68c46caabe8 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
> @@ -584,7 +584,7 @@ struct brcmf_wsec_key_le {
>  struct brcmf_wsec_pmk_le {
>         __le16  key_len;
>         __le16  flags;
> -       u8 key[2 * BRCMF_WSEC_MAX_PSK_LEN + 1];
> +       u8 key[BRCMF_WSEC_MAX_SAE_PASSWORD_LEN];
>  };
>
>  /**
>
> ---
> base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
> change-id: 20231107-brcmfmac-wpa3-9e5f66e8be34
>
> Best regards,
> --
> Hector Martin <marcan@marcan.st>
>
>

Looks good to me.

Reviewed-by: Neal Gompa <neal@gompa.dev>



--
真実はいつも一つ！/ Always, there's only one truth!
