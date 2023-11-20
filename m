Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4EC7F15C0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjKTOcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjKTOcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:32:19 -0500
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E7DED
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:32:13 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
        t=1700490731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9f2A7iG9QxlXfAhIGL2D+akxaRYV9pGj/jh0RBA7f6g=;
        b=eXTUg62Ik8PLUvGO7KikQvTAi17nKie3zmKzUDBoMEk2ga6YJTT54Tjd9fZM8hrdqElBQ4
        PNCG0CuwseA+UJ2MRXx1SbyNNOMxrIBE34jqYs28BsICDpe86GZ1824IfBZ/2hb2mFsx7R
        Uidq3sIaMcDoYnaW3nMGUeT/Zy93B/jRKSKedNKrVt/EQgE+mD/v9HOfvUZ4igosvIYpCb
        6j3A6+7ObP+vWntzpGTxE3GE9DxGUfyOHDxNvYykR4PF6SuwpBtXgxnlfHtWNCMRgZW0qT
        qaRVL1ffrLSwxwZLInfnFEOrxGq+UYUzFgcdDrjJh1Chl7x5Jw6QjDOHRT2RHw==
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-rockchip@lists.infradead.org, Jonas Karlman <jonas@kwiboo.se>
Cc:     Christopher Obbard <chris.obbard@collabora.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v2] drm/rockchip: vop: Fix color for RGB888/BGR888 format on VOP
 full
Date:   Mon, 20 Nov 2023 15:31:59 +0100
Message-ID: <4726930.fbnEVBQaF0@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20231026191500.2994225-1-jonas@kwiboo.se>
References: <20231026191500.2994225-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2134285.SbVt0S7CNQ";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2134285.SbVt0S7CNQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
Date: Mon, 20 Nov 2023 15:31:59 +0100
Message-ID: <4726930.fbnEVBQaF0@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20231026191500.2994225-1-jonas@kwiboo.se>
References: <20231026191500.2994225-1-jonas@kwiboo.se>
MIME-Version: 1.0

On Thursday, 26 October 2023 21:14:58 CET Jonas Karlman wrote:
> Use of DRM_FORMAT_RGB888 and DRM_FORMAT_BGR888 on e.g. RK3288, RK3328
> and RK3399 result in wrong colors being displayed.
> 
> The issue can be observed using modetest:
> 
>   modetest -s <connector_id>@<crtc_id>:1920x1080-60@RG24
>   modetest -s <connector_id>@<crtc_id>:1920x1080-60@BG24

On my Rock64 (rk3328) I was able to see the problem without this patch and see 
it displaying correctly with it, so 

Tested-by: Diederik de Haas <didi.debian@cknow.org>
--nextPart2134285.SbVt0S7CNQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZVtt3wAKCRDXblvOeH7b
bh3QAP9r8UfZ3jyDD/yp2jWUOlNzKz65zugAk67eVGxIULqbyAEAmtAgGSCuHdAN
t0RCnpEig29n4OGCexugcrRCnSp09wE=
=Aix3
-----END PGP SIGNATURE-----

--nextPart2134285.SbVt0S7CNQ--



