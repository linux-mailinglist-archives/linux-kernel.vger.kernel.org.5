Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CB57B4C57
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbjJBHMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbjJBHLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:11:55 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A44E0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:11:52 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5041335fb9cso24815661e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696230710; x=1696835510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiq9+pVHUYbBnQZsGKnsCJMnhp9kzQom08VF2zcrJVk=;
        b=X0hLJnpbXXj7ulfU/FeZ5olnhu5hMh0QECTJKgApBOEZN4niWS9TpTcr5YjhrVmbSf
         aqPnkvuO9uiMkyRpCdWd85Yb06CS+VzICZ0WG/h/b/5h6bvCWq4XBFqA2+yGweCZLV02
         ZAZvnhG9IDBvfd9w1eWFAJN8+wzlejJSUcECT4RVwwjxwXpz9iha4FH7CBa0FobqFzkA
         91STBPn/IOFtZ+Z59ORV8xwv3SZHUcy7MoRwYG4nfvPVRUG2BuwrZw/H7hesqQDkVb9v
         P/XIYfdfJ7dHnSXX0edyFXmdqgr+hDTrjUv9WXuuCeOxnjWthcdUdSJ1EnUSNxILJOL3
         sVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696230710; x=1696835510;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiq9+pVHUYbBnQZsGKnsCJMnhp9kzQom08VF2zcrJVk=;
        b=Jk4fd7NSNsCpEb4urT4ohJdAv2I5t06EpAleYsjsSjQFLsHLqNYs1sXBEv7pYcbAzr
         FnyRIYG85JZTdBnEFANges7AqB+59JknXgxyrEZD2kAcBIJ4YceIqebuamko5bnmo+M6
         1ED2mtUEndJBrxyUaF8WBjVJU50wAwlSTIzQd+hkfnUa/XAZo6PzrvQ8Bn1O7Vk+lXmH
         bLlsJY5TMsNN9TsTvzLS4n+Dtt47AXpLxemnDFGqkunl3jQANoQv4nBgyM64T3XAIOSK
         tGiZ8H9D/LRT/Xxn21Q1TtrDPCprW+Kt8OHcbxLeBGGIeWKPrEX6IWz/w9Fgu6A2x8O3
         HwbQ==
X-Gm-Message-State: AOJu0Yx9cm/K6kNMpEp26qn/adGI49wQVRwz0yRK5hpl1aRSFC9h4ovz
        jzL/qMgUAbUDzjPxbekvndJDwQ==
X-Google-Smtp-Source: AGHT+IFJl/CfWMu3s4dAgiVWtfF3mxSDvQUJlt4LH67191t9D8qRoLsyzJoryymS3jfXet4MnbckJw==
X-Received: by 2002:a05:6512:3189:b0:505:6ef8:2544 with SMTP id i9-20020a056512318900b005056ef82544mr8551825lfe.63.1696230710570;
        Mon, 02 Oct 2023 00:11:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c025900b00405623e0186sm6601371wmj.26.2023.10.02.00.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 00:11:50 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Brown <broonie@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231001-drm-chipone-maple-v1-1-fb3ce5a53710@kernel.org>
References: <20231001-drm-chipone-maple-v1-1-fb3ce5a53710@kernel.org>
Subject: Re: [PATCH] drm/bridge: icn6211: Convert to use maple tree
 register cache
Message-Id: <169623070969.3600226.2109511529141649390.b4-ty@linaro.org>
Date:   Mon, 02 Oct 2023 09:11:49 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 01 Oct 2023 00:46:38 +0100, Mark Brown wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/bridge: icn6211: Convert to use maple tree register cache
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=fb6f4f47dd4a71a0394d346eda7589dd9397c4bc

-- 
Neil

