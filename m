Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879A77B4C54
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbjJBHL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbjJBHLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:11:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368A0A4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:11:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-406609df1a6so22656325e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696230709; x=1696835509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cu+Pw3V8CZGZb1GhpvcMQYnQKTsxIX2d8XmOXeqyg14=;
        b=EO5GF2+sjZyA/EG4Hr1qKWCB69BEPS8qrWoDIx8ilJjFfak9CEINmpAI1S+HQyBH4I
         4oVo00xaLUbOC5fJgUKiVqIel0I6WddhkbBwSNXC/l3x6upXH2+4ABr7D7lypAFbdIxo
         Xvemm8SLXPW0SyzH3U61NlAZ14KYt9/VrwCKKeZ6aK5vhCnfFEicJG0qK0gPeTcPJECl
         vIGRomvYaMs1YgcejAjTD94qhANj7T8xRgniuCwb+o/Pyf7cog18HvyNz0cCpzrCIFqK
         ohIl9oJKqn80hUWD6jkM1j7GddOv0/zqrmcQeNzciZu++qz8GklwlGOt9Z/ZsGgVwGXm
         cTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696230709; x=1696835509;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cu+Pw3V8CZGZb1GhpvcMQYnQKTsxIX2d8XmOXeqyg14=;
        b=PaBIHEmHOVPu94Yltw8LeWSXd89J00y44bYws7K56STN0Gd9DC1jW3J6iF+QqVy/Yt
         RA8JyASGIqBBmixS7rmgtqE34xqdg+Y0g9Os0RyVqmwyRrBG6edOSRvNwvt6mh7AVm7t
         C6+TMXK9SL6YoakpFWEqp1Xc6ZmNE7JkUE+OqQaAnGCxbLznDKSJ6PWYBELXgs2GAdSV
         OCfEfVX55dKPt4WoYvGRQukwjW7JFCcz8DVRNdh1tolfwZVvxf6jei9ST02VnjQB3nuR
         HeKE7//x4F/1s/DdXreguHpyMUrVD/+5qTGlghUwVijNPC0/woi3tKz8+2AKYLM3f73T
         HXgg==
X-Gm-Message-State: AOJu0YyTiAPeNKRjg2Cd0sCXEzEX7CultFoapZEZjXwQ0ZGQLMG+OjhL
        j9Ky9L9yeund6Uh9H9L6dOb1Og==
X-Google-Smtp-Source: AGHT+IF7M0r7YecLamPiSaTnqh4n0mbUCyT7C+0uE8yr8BE/ChptJ9Ip4V7LpXbEvzdVSlE7YnQlUA==
X-Received: by 2002:a05:600c:2208:b0:406:4242:e7df with SMTP id z8-20020a05600c220800b004064242e7dfmr8833207wml.35.1696230709611;
        Mon, 02 Oct 2023 00:11:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c025900b00405623e0186sm6601371wmj.26.2023.10.02.00.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 00:11:49 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Brown <broonie@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231001-drm-tc358767-maple-v1-1-f759fcc4bd98@kernel.org>
References: <20231001-drm-tc358767-maple-v1-1-f759fcc4bd98@kernel.org>
Subject: Re: [PATCH] drm/bridge: tc358767: Convert to use maple tree
 register cache
Message-Id: <169623070881.3600226.5478609228303935837.b4-ty@linaro.org>
Date:   Mon, 02 Oct 2023 09:11:48 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 01 Oct 2023 01:43:13 +0200, Mark Brown wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/bridge: tc358767: Convert to use maple tree register cache
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=4dd9368671fb7649dc914e661256a07250c271ca

-- 
Neil

