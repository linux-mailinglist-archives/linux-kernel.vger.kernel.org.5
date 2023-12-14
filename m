Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDC9812445
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 02:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442919AbjLNBFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 20:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbjLNBFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 20:05:00 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B78FDD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:05:06 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c9fbb846b7so87166581fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702515905; x=1703120705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HkhdBtSmWwRfNHiwiMECGN6RIaBB+5rPDSa5547POLU=;
        b=BEoIKWZRGzFmRch6BDNbz00iV0gj0v2+BuIbkFDpMirxq4JQ7srRIgX2mzPsEtAmUq
         SORGhiw+uqWt3ClqIK539mZfkro3HeYyfRq3SeSqOwokwOXssZrl+vK61+IcmaQSBLvG
         j6kqx1krcHVBVzgJwfH84JbfblozMNZsJpoJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702515905; x=1703120705;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkhdBtSmWwRfNHiwiMECGN6RIaBB+5rPDSa5547POLU=;
        b=P54l63b1AI6MOF4N1jhRPDOdCHyllFFEcmnCG2n3nrK0tuW51mAkVLivINLETcMJxO
         pymvuH5jxoCH0QAVkPZCsZlcoficsiDiq1F66jBR8qKKfXWnAU/K+EPgN+9027rWAVCl
         q3Ng1bMZlSUsSUpro4o+cGw+nDrd0OU3GyIxzXEumrrO1rkDbrCIueM+91bWBrjqIeAh
         uKWCcs5hRAvK0wFt32E+ovR1Dqm3LAGjamDqgRdYIL6mO3mRI7qDhPGpE2FAoQw9cQXr
         swO7v92Gk9gYhdnUAMocUuvtiLCGb5vac1vECjjxBJ50prAQWuNhsRKV5xIcDzi6g74K
         hlbw==
X-Gm-Message-State: AOJu0YxORAsvdBFft3dmIvo+yTRZTiTjK+cGEH5o+WWohnc7ZD0CeL6L
        XX6vzlU0mcCEw94eGIT/JDL9PAJ7XTIthR4hRKr+XIF7LzHOX7Hw
X-Google-Smtp-Source: AGHT+IF69Ly0RR20PQb/TZjZLM+6Nams1IX/WItd9cZEzf5KMg5g/Ejl1lhmIsE6oRJQJmFHNCMgb0HmFsfsOThyLCw=
X-Received: by 2002:a2e:9441:0:b0:2c9:fece:5be4 with SMTP id
 o1-20020a2e9441000000b002c9fece5be4mr3498017ljh.42.1702515904718; Wed, 13 Dec
 2023 17:05:04 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 17:05:04 -0800
MIME-Version: 1.0
In-Reply-To: <20231211165526.1.I9d1afcaad76a3e2c0ca046dc4adbc2b632c22eda@changeid>
References: <20231211165526.1.I9d1afcaad76a3e2c0ca046dc4adbc2b632c22eda@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 13 Dec 2023 17:05:04 -0800
Message-ID: <CAE-0n5199hd1wUtsYpDVRHDwtP75wHB-44Hj9AF5fdGrN_nATQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/bridge: parade-ps8640: Never increase the length
 when reading from AUX
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Philip Chen <philipchen@chromium.org>,
        Robert Foss <rfoss@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2023-12-11 16:55:26)
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index 8161b1a1a4b1..fb2ec4264549 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -302,7 +302,7 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_dp_aux *aux,
>
>                 fallthrough;
>         case SWAUX_STATUS_ACKM:
> -               len = data & SWAUX_M_MASK;
> +               len = min(len, (unsigned int)(data & SWAUX_M_MASK));
>                 break;
>         case SWAUX_STATUS_DEFER:
>         case SWAUX_STATUS_I2C_DEFER:
> @@ -310,7 +310,7 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_dp_aux *aux,
>                         msg->reply |= DP_AUX_NATIVE_REPLY_DEFER;
>                 else
>                         msg->reply |= DP_AUX_I2C_REPLY_DEFER;
> -               len = data & SWAUX_M_MASK;
> +               len = min(len, (unsigned int)(data & SWAUX_M_MASK));
>                 break;
>         case SWAUX_STATUS_INVALID:
>                 return -EOPNOTSUPP;

If the hardware indicates the len is larger than the length of 'buf' do
we need to throw away reads of the fifo until we read the length that
we're told? I'm specifically looking at the read loop at the end of
ps8640_aux_transfer_msg() where it reads a byte at a time out of
'PAGE0_SWAUX_RDATA'. So maybe what we need to do is have 'buf_len' and
'len' and then return the min of the two at the end of the function but
only copy over 'buf_len' amount.
