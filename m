Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A41B7FB6D7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjK1KL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjK1KL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:11:58 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34D0DC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:12:04 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b472f98a3so14004395e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701166323; x=1701771123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jJIpXfUqMsnRBGS3y5ASpjNGohuz9xx+5+nx6r1n00=;
        b=ORrtJBLYe0mmmKRXE2HbU1eyu6BPN+Icc7+95lf+yaoqwqAlQhApn/KE+KjWpC9rq/
         Nisdu3kafEebeY57cHMppXRHTmygzP0ZxOQLRx4Yt5crfdGG7Q52Gs1JG1W7tQPa6gK/
         qppRZ8T3NRObNZ8c3mBaOglkCyLdxwNWzuXCDag/Ob1qOEReJ18BNfpZY7srMrvuIKb9
         f7gNjR6hRwNKrG6cHNQppvEVHLUQGGtmO50R68Kj8BctCEZmldtUyRbcMk44TIa3Kahh
         8HM+MTbafEWHjgmOUJS51Yn1mj5yIB5EN3PCNFvlOYOi9E1dZPTpTk4MupsInip7kHR5
         YlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701166323; x=1701771123;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jJIpXfUqMsnRBGS3y5ASpjNGohuz9xx+5+nx6r1n00=;
        b=jKZVOXRyTZIS7856gXzeMeDl3habIj5BjcaWZRSLboz0Jntwx/NhmgAsvtMcZhjrN4
         hCNyonG5kUZbKSpnCAPpER2uHkIZ/xfaa43NJ7GFebfFGqdYpWNLvGr13rvsozKhrHNN
         8vnK5HNidLJg5NxTp0/3gAnYQLjRSPx5AfE3cw/EovjO8Ewyq/d5XgQj+KEcfzx90ipj
         9ceWXIxj+QIGbXy7ATvICw/OtIZj0hkJEAXlZkrFPRIcwKOHjYjW/XVsNu1oe9TP60Kk
         GScvIlbn0Dy0Gemgj6n23MCP6LtpkmqWPbd63yP/5el+iOazNVbZZxjyjJG5mqgpZkcD
         fVyw==
X-Gm-Message-State: AOJu0YyDUHUYEmcDg2q8PQ8UV8nYg5iJlSmdyYvjL4wNX6YIaXVNdKNe
        3tCIBwFNhzffBQXB3YZP2V6qkw==
X-Google-Smtp-Source: AGHT+IFj1SEyzBamITvGlM9acxZpE+SuR4K1DvYsd7sL0DSYgEK67+INqGACpV1iZ7zuYcFPjnlSiw==
X-Received: by 2002:a05:600c:4e8b:b0:40b:4c1a:f5b2 with SMTP id f11-20020a05600c4e8b00b0040b4c1af5b2mr1186553wmq.35.1701166323063;
        Tue, 28 Nov 2023 02:12:03 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id e10-20020a056000194a00b003330b139fa5sm1643604wry.30.2023.11.28.02.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 02:12:02 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Liu Ying <victor.liu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20231128-revert-panel-fix-v1-0-69bb05048dae@linaro.org>
References: <20231128-revert-panel-fix-v1-0-69bb05048dae@linaro.org>
Subject: Re: (subset) [PATCH 0/3] Revert panel fixes and original buggy
 patch
Message-Id: <170116632194.2250210.1478661000647719120.b4-ty@linaro.org>
Date:   Tue, 28 Nov 2023 11:12:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 28 Nov 2023 00:10:18 +0100, Linus Walleij wrote:
> This series reverts the attempts to fix the bug that went
> into v6.7-rc1 in commit 199cf07ebd2b
> "drm/bridge: panel: Add a device link between drm device and panel device"
> and then it reverts that patch as well.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)

[3/3] Revert "drm/bridge: panel: Add a device link between drm device and panel device"
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=9b6a59e5db87c2c6b3ca0391176ed4358623d5e4

-- 
Neil

