Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123D278FBD9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 12:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349000AbjIAKlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 06:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjIAKln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 06:41:43 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9DCE7E;
        Fri,  1 Sep 2023 03:41:37 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1693564893; bh=dFbwtDJxJ3HW4RqTF081/I0JWvciPbeXRHk2/3ukeF8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DeL15dAYTdhHUjIrUqCho0sh8R88QFfjqkM3e5OlVzyh3gK8mStsMz8Z8XL/D4o56
         nFj+bkbQdfCRGzwTMxiI00JeGN6cH67J3wBDgtEBdiHLR544k8a8p7zBPOJFlDWCJp
         dVlUluzQYS4Tl57KplbV4BO8zmapkakIsjG8I/bCdaw2kGaTQXDGRBD7MGVj6/Oy/2
         TlAGJaD7DjRcMJD5n7Y7vpObTas9LPfZS0ZJurtIHia2eFYVS6xOAXBH90tgAezWg/
         D4l/ys185OnwSX0iuiozM2vS7w2598HW2E3/Bl3KPQ18C13HpfP/Mam5KIGYCLI+wa
         f99d75AnzEiww==
To:     Dongliang Mu <dzm91@hust.edu.cn>, Kalle Valo <kvalo@kernel.org>,
        Sujith Manoharan <c_manoha@qca.qualcomm.com>,
        "John W. Linville" <linville@tuxdriver.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ath9k: fix null-ptr-deref in ath_chanctx_event
In-Reply-To: <20230901080701.1705649-1-dzm91@hust.edu.cn>
References: <20230901080701.1705649-1-dzm91@hust.edu.cn>
Date:   Fri, 01 Sep 2023 12:41:33 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87y1hqtbtu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dongliang Mu <dzm91@hust.edu.cn> writes:

> Smatch reports:
>
> ath_chanctx_event() error: we previously assumed 'vif' could be null
>
> The function ath_chanctx_event can be called with vif argument as NULL.
> If vif is NULL, ath_dbg can trigger a null pointer dereference.
>
> Fix this by adding a null pointer check.
>
> Fixes: 878066e745b5 ("ath9k: Add more debug statements for channel context")
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  drivers/net/wireless/ath/ath9k/channel.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath9k/channel.c b/drivers/net/wireless/ath/ath9k/channel.c
> index 571062f2e82a..e343c8962d14 100644
> --- a/drivers/net/wireless/ath/ath9k/channel.c
> +++ b/drivers/net/wireless/ath/ath9k/channel.c
> @@ -576,7 +576,9 @@ void ath_chanctx_event(struct ath_softc *sc, struct ieee80211_vif *vif,
>  		if (sc->sched.state != ATH_CHANCTX_STATE_WAIT_FOR_BEACON)
>  			break;
>  
> -		ath_dbg(common, CHAN_CTX, "Preparing beacon for vif: %pM\n", vif->addr);
> +		if (vif)
> +			ath_dbg(common, CHAN_CTX,
> +				"Preparing beacon for vif: %pM\n", vif->addr);

Please don't send patches for static checker errors without actually
checking if there is a valid bug. Which there isn't in this case.

Specifically, that branch of the switch statement dereferences the avp
pointer, which will be NULL if 'vif' is. Meaning we will have crashed
way before reaching this statement if vif is indeed NULL.

-Toke
