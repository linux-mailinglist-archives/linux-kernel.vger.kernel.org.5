Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADDD804C7C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344776AbjLEIdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjLEIdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:33:53 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C3B9C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:34:00 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40838915cecso55123655e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 00:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701765238; x=1702370038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNjw1GI2DMeeEO8a0ncjg93cZ43siJyc4WqEwC9FgsU=;
        b=HNF7NV0rsj8hiQ9BkAEovux5F4avbMOXTcxM4+1I1TV/EHBzE27IUDG0Fl+m95RqLm
         S7gj79T9aC9KEZ2iuin/UBPOyDPxqjZtWhkjc6NsfreAJiS27z0Drr3LyCGgQUGwaGM1
         gSzJzxhjBB1yKTWx/aWPo8weZf3GSzfZnLqReTXCm/tEBK5xKdjeTrA4S+km6hoHsHwv
         P5OgsTIJV5QsqbJ5JlxtFt/3fa+f+NsR6Z6kQ/qZXuG0ya4xs09fSoVl5rldDYh88SFf
         PuDxqLXxcueFY/XgZY7AN5faeEuiJstToyPWZD+Dy8gHPIOL6Yqhqe/zZ4WDQKmTOTsn
         82Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701765238; x=1702370038;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNjw1GI2DMeeEO8a0ncjg93cZ43siJyc4WqEwC9FgsU=;
        b=mIc3e6K3TrFcdo9ee3T4IK1qiIFBgLCT06eXExKJe/7MqKFkDXoze64syB4Al1PY5/
         +15jxbrElhBfFoSaAO0Fl0lSNOdGFINc7GdBbfVT+v1+JgQG0I3AyZrXyF2BaovtZq7H
         mBbURut6LZxgH92CU/P80MuB3REQazC0gHEoDK6blCabHFkFH9uV/bWassxCdeLG9Vqo
         nK4NJz9o2aSqWIGmZKSM18D9en4mw+UhfYXiTvMDQ77DFy3UW76qOPDKKgZZ5m1S0Jb2
         uKmvgwxgHsNyny46gsHGJt8SQRzClSvpY3T5CHcm8igB7djjc95lwjs0v09yrHVoESJv
         FlIA==
X-Gm-Message-State: AOJu0YyB6aobcPmgmDV7Brq544zznNtntKQEDtK41RgBJrUF+n76oqf9
        a6lLMsu08UFU60d3Y+F4JSrEXxyk8CRLT1D+Pj8flfBB
X-Google-Smtp-Source: AGHT+IF0NaHC2CSMSyi42s+sZrJ71IPfvZMrDM4yBLR4DfR9kixwjhIfCu8gd8tkDM25n22BlG0fJw==
X-Received: by 2002:a1c:4c11:0:b0:40b:5e21:e270 with SMTP id z17-20020a1c4c11000000b0040b5e21e270mr252919wmf.93.1701765238424;
        Tue, 05 Dec 2023 00:33:58 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id bd22-20020a05600c1f1600b004090798d29csm18012765wmb.15.2023.12.05.00.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 00:33:58 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231204072814.968816-1-arnd@kernel.org>
References: <20231204072814.968816-1-arnd@kernel.org>
Subject: Re: [PATCH] drm/bridge: tc358768: select CONFIG_VIDEOMODE_HELPERS
Message-Id: <170176523748.4093903.5105511607949310724.b4-ty@linaro.org>
Date:   Tue, 05 Dec 2023 09:33:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 04 Dec 2023 08:27:36 +0100, Arnd Bergmann wrote:
> A dependency on this feature was recently introduced:
> 
> x86_64-linux-ld: vmlinux.o: in function `tc358768_bridge_pre_enable':
> tc358768.c:(.text+0xbe3dae): undefined reference to `drm_display_mode_to_videomode'
> 
> Make sure this is always enabled.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)

[1/1] drm/bridge: tc358768: select CONFIG_VIDEOMODE_HELPERS
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=26513300978f7285c3e776c144f27ef71be61f57

-- 
Neil

