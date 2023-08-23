Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9EA78637B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbjHWWho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbjHWWhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:37:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AA610D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 15:37:18 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50078e52537so6636391e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 15:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692830237; x=1693435037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzvVwhGN2UQdM4IEB9Nv1bBlM7ZhuUSCM8IhHEioEQc=;
        b=wCYnm9SIu70jL8k6bK6QkaEohvcXQoe/95buVtbRKZD3rtd8+jVezSOwF2m/MI51gp
         NC1mdcuosY2VzkuBNW9i9CRasIYPsCunGDMxV96VDRjmeXfrYY6XUf75eA7T0Kjoo/m4
         2GzVw4cAJITcEqYinGEDBlwRHs90MkymGnMf4rUk86Rhig9HhQcaYqYdJCO/SRGYjFTw
         EK9euXd6Pkpc7hQZEBgTPbezhzhiW/PFYd6HY6+v089qv3Yk/IPOuAyu07tIikDNhIFM
         k8Xayi7u7bHYZ77PkFeB+CePuq7y41p3/JPdnWaeL7GHPwiG/OpMB8I9luPLLp+8Gmm2
         KKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692830237; x=1693435037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzvVwhGN2UQdM4IEB9Nv1bBlM7ZhuUSCM8IhHEioEQc=;
        b=kNdr0szbAET+69bAB92bRSLDaMm1smE7wAnAQaeUtapCnO36y8NR2SHPqxM2MMS9Vb
         o6pph0+vk1UjS5QgSPqIi5DomIJ1322eReIgodFtbJBSgfQZPSEefDXO3i6ZjlYDrXKV
         ZBalhhCwo8o7Z2twLr+nEPNWUPvBkevO+IvAxC7RzYhClziy/gkbnHjk/d4ZNa5980US
         nHchbhSKfFX3Pju2aQSXNzHcWH+ik1zONbYhJplRSvWveYbrgY2ABPBHAac76OTc0hLs
         tQpIUGNM2ySG9uUnYS/oy+p/qF+nf15jz8P8ghygb/Ox8sklhGBSYWfdxIuKLwz4Kf++
         O9LQ==
X-Gm-Message-State: AOJu0YxPik4Anx+g1Q43RjOykBHiuczeBvGQyrhydt9H0bxrtxufLCst
        jQZgClqK7nokSUiO4OhiOsPyoLacORBc0PhNov9PNA==
X-Google-Smtp-Source: AGHT+IHTYXA5kSHFBqbASjYoubjn9qqIcIl4pXmazIR7gW56HPryHx4IBmcQqteNobcwrMCF38OGXYD9Y2hPt41TwrA=
X-Received: by 2002:a05:6512:689:b0:4ff:8742:4488 with SMTP id
 t9-20020a056512068900b004ff87424488mr12975347lfe.52.1692830237033; Wed, 23
 Aug 2023 15:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692829410.git.gustavoars@kernel.org> <698dc480d939e3ae490140db5c2f36eb84093594.1692829410.git.gustavoars@kernel.org>
In-Reply-To: <698dc480d939e3ae490140db5c2f36eb84093594.1692829410.git.gustavoars@kernel.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Wed, 23 Aug 2023 15:37:05 -0700
Message-ID: <CAFhGd8rzy_7+Wu9NusgCjU9n2XM7LEz20dDZS6vv8Nsk-PfYeA@mail.gmail.com>
Subject: Re: [PATCH 1/3] wifi: mwifiex: Fix tlv_buf_left calculation
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Dan Williams <dcbw@redhat.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 3:30=E2=80=AFPM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> In a TLV encoding scheme, the Length part represents the length after
> the header containing the values for type and length. In this case,
> `tlv_len` should be:
>
> tlv_len =3D=3D (sizeof(*tlv_rxba) - 1) - sizeof(tlv_rxba->header) + tlv_b=
itmap_len
>
> Notice that the `- 1` accounts for the one-element array `bitmap`, which
> 1-byte size is already included in `sizeof(*tlv_rxba)`.
>
> So, if the above is correct, there is a double-counting of some members
> in `struct mwifiex_ie_types_rxba_sync`, when `tlv_buf_left` and `tmp`
> are calculated:
>
> 968                 tlv_buf_left -=3D (sizeof(*tlv_rxba) + tlv_len);
> 969                 tmp =3D (u8 *)tlv_rxba + tlv_len + sizeof(*tlv_rxba);
>
> in specific, members:
>
> drivers/net/wireless/marvell/mwifiex/fw.h:777
>  777         u8 mac[ETH_ALEN];
>  778         u8 tid;
>  779         u8 reserved;
>  780         __le16 seq_num;
>  781         __le16 bitmap_len;
>
> This is clearly wrong, and affects the subsequent decoding of data from
> `event_buf` through `tlv_rxba`:
>
> 970                 tlv_rxba =3D (struct mwifiex_ie_types_rxba_sync *)tmp=
;
>
> Fix this by using `sizeof(tlv_rxba->header)` instead of `sizeof(*tlv_rxba=
)`
> in the calculation of `tlv_buf_left` and `tmp`.
>
> This results in the following binary differences before/after changes:
>
> | drivers/net/wireless/marvell/mwifiex/11n_rxreorder.o
> | @@ -4698,11 +4698,11 @@
> |                 tlv_buf_left -=3D (sizeof(tlv_rxba->header) + tlv_len);
> | -    1da7:      lea    -0x11(%rbx),%edx
> | +    1da7:      lea    -0x4(%rbx),%edx
> |      1daa:      movzwl %bp,%eax
> |  drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c:969
> |                 tmp =3D (u8 *)tlv_rxba  + sizeof(tlv_rxba->header) + tl=
v_len;
> | -    1dad:      lea    0x11(%r15,%rbp,1),%r15
> | +    1dad:      lea    0x4(%r15,%rbp,1),%r15
> |  drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c:968
> |                 tlv_buf_left -=3D (sizeof(tlv_rxba->header) + tlv_len);
> |      1db2:      mov    %edx,%ebx
>
> The above reflects the desired change: avoid counting 13 too bytes;
> which is the total size of the double-counted members in
> `struct mwifiex_ie_types_rxba_sync`:
>
> $ pahole -C mwifiex_ie_types_rxba_sync drivers/net/wireless/marvell/mwifi=
ex/11n_rxreorder.o
> struct mwifiex_ie_types_rxba_sync {
>         struct mwifiex_ie_types_header header;           /*     0     4 *=
/
>
>      |-------------------------------------------------------------------=
----
>      |  u8                         mac[6];               /*     4     6 *=
/  |
>      |  u8                         tid;                  /*    10     1 *=
/  |
>      |  u8                         reserved;             /*    11     1 *=
/  |
>      |  __le16                     seq_num;              /*    12     2 *=
/  |
>      |  __le16                     bitmap_len;           /*    14     2 *=
/  |
>      |  u8                         bitmap[1];            /*    16     1 *=
/  |
>      |-------------------------------------------------------------------=
---|
>                                                                   | 13 by=
tes|
>                                                                   -------=
----
>
>         /* size: 17, cachelines: 1, members: 7 */
>         /* last cacheline: 17 bytes */
> } __attribute__((__packed__));
>
> Fixes: 99ffe72cdae4 ("mwifiex: process rxba_sync event")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drive=
rs/net/wireless/marvell/mwifiex/11n_rxreorder.c
> index 391793a16adc..d1d3632a3ed7 100644
> --- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
> +++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
> @@ -965,8 +965,8 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_priva=
te *priv,
>                         }
>                 }
>
> -               tlv_buf_left -=3D (sizeof(*tlv_rxba) + tlv_len);
> -               tmp =3D (u8 *)tlv_rxba + tlv_len + sizeof(*tlv_rxba);
> +               tlv_buf_left -=3D (sizeof(tlv_rxba->header) + tlv_len);
> +               tmp =3D (u8 *)tlv_rxba  + sizeof(tlv_rxba->header) + tlv_=
len;
>                 tlv_rxba =3D (struct mwifiex_ie_types_rxba_sync *)tmp;
>         }
>  }
> --
> 2.34.1
>
