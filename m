Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79147763BE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbjHIPeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjHIPeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:34:01 -0400
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E99E7F;
        Wed,  9 Aug 2023 08:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1691595231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IUjvc0hCBrzREs+fZbNzsO+5+uaKgJCIeVukgQ8i7+A=;
        b=cKfZCdNKT+zUlLJDSNainIts3G762q4FHCKWv0eLr8bs4hwYSlWpHoN7Dz95Shd2dcZOXc
        KQEn1hkpHvqmakvqqH1xgHX2K9IHD7OYlrtJYTsjx6crBMCpx1VDYtaZuoUSgPvtYzQWMq
        MkjSbrAmj8zDN7r/k6ZCxMdP7aUhZ80=
From:   Sven Eckelmann <sven@narfation.org>
To:     Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        Remi Pommarel <repk@triplefau.lt>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>,
        stable@vger.kernel.org
Subject: Re: [PATCH net] batman-adv: Fix batadv_v_ogm_aggr_send memory leak
Date:   Wed, 09 Aug 2023 17:33:49 +0200
Message-ID: <1951515.yKVeVyVuyW@ripper>
In-Reply-To: <20230809152913.27218-1-repk@triplefau.lt>
References: <20230809152913.27218-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2119410.OBFZWjSADL";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2119410.OBFZWjSADL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 09 Aug 2023 17:33:49 +0200
Message-ID: <1951515.yKVeVyVuyW@ripper>
In-Reply-To: <20230809152913.27218-1-repk@triplefau.lt>
References: <20230809152913.27218-1-repk@triplefau.lt>
MIME-Version: 1.0

On Wed, 09 Aug 2023 17:29:13 +0200, Remi Pommarel wrote:
> When batadv_v_ogm_aggr_send is called for an inactive interface, the skb
> is silently dropped by batadv_v_ogm_send_to_if() but never freed causing
> the following memory leak:
> 
>   unreferenced object 0xffff00000c164800 (size 512):
>     comm "kworker/u8:1", pid 2648, jiffies 4295122303 (age 97.656s)
>     hex dump (first 32 bytes):
>       00 80 af 09 00 00 ff ff e1 09 00 00 75 01 60 83  ............u.`.
>       1f 00 00 00 b8 00 00 00 15 00 05 00 da e3 d3 64  ...............d
>     backtrace:
>       [<0000000007ad20f6>] __kmalloc_track_caller+0x1a8/0x310
>       [<00000000d1029e55>] kmalloc_reserve.constprop.0+0x70/0x13c
>       [<000000008b9d4183>] __alloc_skb+0xec/0x1fc
>       [<00000000c7af5051>] __netdev_alloc_skb+0x48/0x23c
>       [<00000000642ee5f5>] batadv_v_ogm_aggr_send+0x50/0x36c
>       [<0000000088660bd7>] batadv_v_ogm_aggr_work+0x24/0x40
>       [<0000000042fc2606>] process_one_work+0x3b0/0x610
>       [<000000002f2a0b1c>] worker_thread+0xa0/0x690
>       [<0000000059fae5d4>] kthread+0x1fc/0x210
>       [<000000000c587d3a>] ret_from_fork+0x10/0x20
> 
> [...]

Applied, thanks!

[1/1] batman-adv: Fix batadv_v_ogm_aggr_send memory leak
      commit: 421d467dc2d483175bad4fb76a31b9e5a3d744cf

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>
--nextPart2119410.OBFZWjSADL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmTTsd0ACgkQXYcKB8Em
e0avDw/+MF/kddOKnCxKk9v0V/vSIk/U0uEOmlH7zC7YPuyOGgFZVxIF65zdp5N5
hSaVC4pM2qY2BM3W4ooN8OZOvaNzWIURKWG1Dy6Wv8OCfqGNPYDsg5K/c13pMbBo
ovHZzZDGaM9aQgTkstHsgX2f05HkCDsTZlwlmH5A4XE4HJhiMWcD6q939UWnMLrW
lEXmm3nQ4M0ZCiRWg9dwLv92h0POfi3G1Svg0CZ+82+rrrde3Rtjsuo3qP+D2yk2
aNI6z10VOlh6e0CG/hGAwJ5r521aYyozEMv9NRwCycTMupA9gP/VGbvhHe12cVOF
67lG5E7D1L9t9lqNeUWrAq99IW4GSQsITaUlOg+aWDw8BahBe1ltfsW3pI63nisG
pUvwhvv6fEVpnJHblV37JvVxNkc/rusWdGcxPP5oLFQ2kS3U0DD9xU07UhTrt0ei
R95iwjNw7UxXY4T/nWpeIKoBSq9tVwjsw3A39lMaF7viD7aBl2WHtOMc11H12qSG
U1L5TrgQUn/YNBeIbqq7FYIr1XHmpSN0fS3AIwvWlySGmvr/NM2ycQM+Ceq0878D
dHFQ8l3FpuXop+3/OtaWzO/ix13MA6eYsggfez0xSQgWVJg1So7Na46rO5ijoLEJ
++o3GT8ruQOz4PerpQo1Ib6kNSeMPcM4DYWjBN1BdBXB3IfJFxg=
=ARQj
-----END PGP SIGNATURE-----

--nextPart2119410.OBFZWjSADL--



