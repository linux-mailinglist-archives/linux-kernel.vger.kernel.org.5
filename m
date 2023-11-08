Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F4F7E567D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344524AbjKHMpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjKHMp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:45:29 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600A81BF0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 04:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1699447526; x=1730983526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mp0cZhN3AA8YDI2rLb/AqW/Ftccy17dW1aTL8NsNu+0=;
  b=oRu+wqkgoNsI0LhGhYE6gkfx23YDjMoDeUlnLhOgGYO53c6GwaUJBc6Y
   Q7gwV5XwXCaUcQ9Z9wyhkAzuOLQAPvsfphQvQipnGCrbZ6BROJCFrE1h0
   qY/q1zcLNv5akvSiXqUDqEub70dxUWBDdBnIxwMzhhrI8miR5Z0oLQHhC
   X0VXOgRxC8TPl2+7YR7A1G67Ib9mHpJZ9Z61JOTSfNUgFgQl40Bjuvy+i
   0afb1gt4kD40mG9Uk1elL2jf5hOlaPpreAW+gC8NcTDYyPh14DAq99687
   ciVk+2H/PqD9k667vWBjGaQzVbESNf1SrwftZmJW3LaPnthj2lE+JUdhB
   g==;
X-IronPort-AV: E=Sophos;i="6.03,286,1694728800"; 
   d="scan'208";a="33875585"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Nov 2023 13:45:23 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 69BB028007F;
        Wed,  8 Nov 2023 13:45:19 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH v2 0/2] drm/bridge: tc358767: Fix DRM_BRIDGE_ATTACH_NO_CONNECTOR case
Date:   Wed, 08 Nov 2023 13:45:20 +0100
Message-ID: <3537389.iIbC2pHGDl@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20231108-tc358767-v2-0-25c5f70a2159@ideasonboard.com>
References: <20231108-tc358767-v2-0-25c5f70a2159@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

Am Mittwoch, 8. November 2023, 12:27:21 CET schrieb Tomi Valkeinen:
> These two patches are needed to make tc358767 work in the
> DRM_BRIDGE_ATTACH_NO_CONNECTOR case, at least when using a DP connector.
>=20
> I have tested this with TI AM654 EVM with a tc358767 add-on card
> connected to a DP monitor.

Just a question regarding the usage of this DSI-DP bridge.
What is the state of the DSI lanes after the DSI host has been initialized,=
=20
but before calling atomic_pre_enable? AFAIK this bridge requires LP-11 on D=
SI=20
at any time for accessing the AUX channel.

Best regards,
Alexander

> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
> Changes in v2:
> - Update the format negotiation patch as discussed in
> https://lore.kernel.org/all/7ddf0edb-2925-4b7c-ad07-27c030dd0232@ti.com/ -
> Link to v1:
> https://lore.kernel.org/r/20231031-tc358767-v1-0-392081ad9f4b@ideasonboar=
d.
> com
>=20
> ---
> Aradhya Bhatia (1):
>       drm/bridge: tc358767: Add format negotiation hooks for DPI/DSI to
> (e)DP
>=20
> Tomi Valkeinen (1):
>       drm/bridge: tc358767: Fix link properties discovery
>=20
>  drivers/gpu/drm/bridge/tc358767.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> ---
> base-commit: 9d7c8c066916f231ca0ed4e4fce6c4b58ca3e451
> change-id: 20231031-tc358767-58e3ebdf95f0
>=20
> Best regards,


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


