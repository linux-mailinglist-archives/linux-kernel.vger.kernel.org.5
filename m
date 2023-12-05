Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF9F8056AC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345562AbjLEOAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345588AbjLEOAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:00:52 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341E71B5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:00:58 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c09dfd82aso32489425e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 06:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701784856; x=1702389656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LGKU/B3Bx2Yzi5OmM9o3RWqdkFzerbywN5kCuPw1/JI=;
        b=sCmEypfaiwsI/7MlDjFhHWwn3V32m/3Hx/MPZZxhrvEKjMtpYrKKiUGe9bjTFBa6X7
         O181XHmyK4eT0cQLuGUa0V9f3rdvNxpzVclMy3ommLYSFVxzjcYMOWDPXvs9/H9x5fyH
         +2XQpr1t+MFJkMHeXuvIy/4FBOixPtz0N8bbB4pm4emW2Xr818ckg8nWwMqsksgCApA4
         tLs8ReqCA7bdXXOiRDjvKOgzknyuuwEoCjQsu+1VPMmVzE5yzl+iPwS0d8bARScHlPgg
         ccSkXfzN60pz058qjwQ//x0oSWPCQvc17/MCI68XPBGLrNdo1kyzrVnJNYWMcnF1oQus
         Nnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701784856; x=1702389656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGKU/B3Bx2Yzi5OmM9o3RWqdkFzerbywN5kCuPw1/JI=;
        b=Z5lcwtPOQh28JaytiaF1uxSFyfeieQB+kOT4M5u5tAvqokkc8pk7QTvCKprz0+wVxH
         lA3mq1USwvxdIHpyP+wwtipYd3mbclnrAiatYPp/umR6qHQRMmX1gt6ZoMsmbS5fFH/x
         W+D6L+wmETBm2ndpUfawXktKoArqQ1v1VFxsDUm9It6CgZnCmq3UIQxX9nICHusmTqNE
         yBolKSbs+SlBXBZqjtFOQtY7FEcOXqN5sTxHlMVrDHFFcKaD/yZdUdcpMs7Pxmvu3d87
         PKsPEhyBWAygAgn6A7iNnICxvf6l/xX4tte0ZCpl/Bgq9rTbSJO/7Yqla47qSoO8p6H4
         59Cg==
X-Gm-Message-State: AOJu0YxyykaMWU+aN69zX901AQnTUtF4I3BQDq2oOsyDZsAHV4SfznZH
        kHaeI7uViRMilD9V4tI6yGLzOw==
X-Google-Smtp-Source: AGHT+IFbFAD5sWyepu3ePHaYgueIW6BW7i9W1ch4x7D0b2M5vX7xa2yi4WW7aC30oOMdj38jGgYIeg==
X-Received: by 2002:a05:600c:474a:b0:40b:3d6e:16b7 with SMTP id w10-20020a05600c474a00b0040b3d6e16b7mr536677wmo.33.1701784856266;
        Tue, 05 Dec 2023 06:00:56 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c451100b0040b379e8526sm22325954wmo.25.2023.12.05.06.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 06:00:55 -0800 (PST)
Date:   Tue, 5 Dec 2023 17:00:51 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Robert Foss <rfoss@kernel.org>
Cc:     Sean Paul <seanpaul@chromium.org>, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>,
        Inki Dae <inki.dae@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        kernel-janitors@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH] drm/bridge: nxp-ptn3460: fix i2c_master_send() error
 checking
Message-ID: <a10a75c7-0626-454f-a3c4-d6031713f26f@suswa.mountain>
References: <0cdc2dce-ca89-451a-9774-1482ab2f4762@moroto.mountain>
 <170178410677.683894.16036596185582079991.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170178410677.683894.16036596185582079991.b4-ty@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 02:48:26PM +0100, Robert Foss wrote:
> On Mon, 4 Dec 2023 15:29:00 +0300, Dan Carpenter wrote:
> > The i2c_master_send/recv() functions return negative error codes or the
> > number of bytes that were able to be sent/received.  This code has
> > two problems.  1)  Instead of checking if all the bytes were sent or
> > received, it checks that at least one byte was sent or received.
> > 2) If there was a partial send/receive then we should return a negative
> > error code but this code returns success.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] drm/bridge: nxp-ptn3460: fix i2c_master_send() error checking
>       https://cgit.freedesktop.org/drm/drm-misc/commit/?id=914437992876
> 

Wait.  That was unexpected.  Neil's review comments were correct.  I was
planning to send a v2 patch which was just a cleanup.

regards,
dan carpenter

