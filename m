Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEE578231F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 07:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjHUFWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 01:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjHUFWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 01:22:09 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE144A3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 22:22:06 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bf092a16c9so22996435ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 22:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1692595326; x=1693200126;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNJgKrjuFkLbTkmBrNhAZtgomNh0/6AE1OSuW3nAGwo=;
        b=NacVtxYfsB4aDWiFomdWx/iRVikuaPFaFPJz5D2QnJp1v6zFn6gvGEgpYfgJGiDrB4
         D/X0Fy1EPW2HammOnRzVEAzDVYnk5ron47j39UAbeMcOSYVUkl04UqVH9dNpayyqMeeE
         JB+Dsz15/4l3fj3Sl2o0FavANZmFboL9WGo6XWy32Ueu1jr06hnNVgsjjyvYq5k2Hyum
         Dk/m+hvDErbFZsVbUpCLyxxq/OBLjFCuQe76bhYqd8h41vfELcYw9YKXXg4PrBSFhLl2
         o0/Wws3Pc9cM28CSCCuLjFmOJyFTddHWRh1kNDQhw0S2H+KgY+yIKSEv0T5QEeb3BRk0
         IAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692595326; x=1693200126;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNJgKrjuFkLbTkmBrNhAZtgomNh0/6AE1OSuW3nAGwo=;
        b=PTIeKPptAr7jo/ylUXucqzDOq5CF4+8cKZN2vd6Tif1CMMo2P0M8ozQsVMRcB4om1S
         RDuLWxtyI2moOvDtwSRDQaBzFRIDM5ZEViV9t32t8/zwY7tb0SnMzj2ivGkoD/wA+ltt
         p5DUrarGo1Gm21GZ/Ilxe2gk2T+XEFXObZ6e5OF2WpciwcR1pg6oJhCBoMBiVcD4Ryfx
         NwzKW8nt9XKSsUGv/zzzCmDGORc+jMn/9GHNHIuMOd3+PWOU/xVxpgms4R8fpDSTpCEo
         dzLj0TdwvY7mhg4JnUtcvIPD0ljGb6EcYDZPKLDNEydSHv78I58TB45yHAtn8UOkZeRy
         AwaA==
X-Gm-Message-State: AOJu0YzUrv6VgUl1v46QeV3/CwcUBJtHyIC8dDugEeliZHUJqdnVtFth
        RQXhMY38B++Z8mHf9znS1uLOWA==
X-Google-Smtp-Source: AGHT+IG3ZPgRomyYKb15GlJLOX3HPI9YTShqcmyYEBasQL87VWmKT/tCwp9szHJ3kxrePf6C5Xx1cw==
X-Received: by 2002:a17:902:d510:b0:1bb:ee0f:ab0f with SMTP id b16-20020a170902d51000b001bbee0fab0fmr7162181plg.17.1692595325830;
        Sun, 20 Aug 2023 22:22:05 -0700 (PDT)
Received: from smtpclient.apple ([47.75.78.161])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b001b05e96d859sm5978858pld.135.2023.08.20.22.22.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Aug 2023 22:22:05 -0700 (PDT)
From:   Li Feng <fengli@smartx.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH] block: fix unexpected split in bio_discard_limit
Date:   Mon, 21 Aug 2023 13:22:48 +0800
References: <20230817075509.1438569-1-fengli@smartx.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20230817075509.1438569-1-fengli@smartx.com>
Message-Id: <B7093938-9D67-4987-8B6B-B05890147580@smartx.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping=E2=80=A6

Thanks,
Li

> 2023=E5=B9=B48=E6=9C=8817=E6=97=A5 =E4=B8=8B=E5=8D=883:55=EF=BC=8CLi =
Feng <fengli@smartx.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> bio_discard_limit() enforces discard boundaries within the range of =
32-bit
> unsigned integers, resulting in unexpected discard cut boundaries.
>=20
> For example, max discard size =3D 1MiB, discard_granularity =3D 512B, =
then the
> discard lengths sent in the range [0,4G) are 1MiB, 1MiB... (1MiB-512).
> The next discard offset from 4G is [4G-512, 4G-512+1MiB).
> The discard of the 4G offset boundary does not comply with the optimal =
1MiB
> size.
>=20
> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
> block/blk-lib.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index e59c3069e835..ec95508c3593 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -32,7 +32,7 @@ static sector_t bio_discard_limit(struct =
block_device *bdev, sector_t sector)
> 	 * Align the bio size to the discard granularity to make =
splitting the bio
> 	 * at discard granularity boundaries easier in the driver if =
needed.
> 	 */
> -	return round_down(UINT_MAX, discard_granularity) >> =
SECTOR_SHIFT;
> +	return round_down(ULONG_MAX, discard_granularity) >> =
SECTOR_SHIFT;
> }
>=20
> int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
> --=20
> 2.41.0
>=20

