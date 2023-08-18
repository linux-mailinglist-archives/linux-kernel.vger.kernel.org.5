Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4027F780756
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358673AbjHRIlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357775AbjHRIku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:40:50 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FF63A94
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:40:49 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe9c20f449so6356825e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692348048; x=1692952848;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1ms0sp3NA7xots6oKziMgk6P6/BMAfGtB9VS6N0YEU=;
        b=EWUFFIyUDQ29kempWRuVEt8PLTZaglKUoVnum2NRKndacFITxISkYmQgI5etdtDMN5
         CT7eyCTNm3+koNBEkeZcQKYpMH/XkvGp6I3mTFCneDa4+4sYZVZHJI2nMBnue6OCjtF1
         7ko7fLJdRMNLRXrEnGJDmchMSUE1rKHW2X1jRSr14IGWdKloVjUB4zNfe9mSgcfg70he
         +m6ySNmJqovpai7wfVhYseZ6cpUcli0ANcSEn7q6N9nzDsZbzGu8aP6ErgYr1jPKw2sN
         AhsrObdk5NFwEe0bM11+187jjF1mfC2e1JRuY4DWDP+AXSD98K/qkDEueyzZPgekPWOi
         Beeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692348048; x=1692952848;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1ms0sp3NA7xots6oKziMgk6P6/BMAfGtB9VS6N0YEU=;
        b=JMhBMa5rdUo/1c+o6aLJyW0eN/HptRlmJOXs8N+qvbj5hlGuOAAArWfuYm5bGtP3j9
         h/4HHnBX3ZIaMPXQBW/dNxLAxc+U3BPbVX4MHWh7XyosX2uJmJl8S6KyEgRRDQS69MmD
         9yLSgP7e5qt6gH4QiU0oPEdBfSvyleI4N1p0MnXFq9hXd1wvLr4ormG78a47Kq4i28RJ
         AugF5R9CPStkQRwX3qTShK4JWEZdhI2BiQGdE2YT73lEkdHF2Lai53rzC6HK9USR8A9M
         BdroFQ3eNvqVBmRV8NAfl3GTQQ5zL8+7eJsxXqzNHex3r+OTXpteYnYZGfHQTiR2ucUJ
         0W3g==
X-Gm-Message-State: AOJu0YxNIp42rUmE48+ier5DRfP+UlPwZI9GaUO9zCrCCkL0UAvd6HNW
        +A/fPdbjPOlOaSr+AYb55qyBrp78x9HL0okVmLy/EA==
X-Google-Smtp-Source: AGHT+IGXBWQhpbxUAariamk2uLHaGEhe45Sqg63PPejAXPvCgWNBNSw4+HezjbkcG3Cy12Vtk7X9Hw==
X-Received: by 2002:a05:600c:b4f:b0:3fe:d71a:d84e with SMTP id k15-20020a05600c0b4f00b003fed71ad84emr180660wmr.1.1692348047998;
        Fri, 18 Aug 2023 01:40:47 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600c11ce00b003fe577eb8cbsm5497622wmi.44.2023.08.18.01.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 01:40:47 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robert Foss <rfoss@kernel.org>,
        Frieder Schrempf <frieder@fris.de>
Cc:     Tim Harvey <tharvey@gateworks.com>, Adam Ford <aford173@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>
In-Reply-To: <20230724151640.555490-1-frieder@fris.de>
References: <20230724151640.555490-1-frieder@fris.de>
Subject: Re: [PATCH v2] drm: bridge: samsung-dsim: Fix init during host
 transfer
Message-Id: <169234804670.3642120.1486717692776482497.b4-ty@linaro.org>
Date:   Fri, 18 Aug 2023 10:40:46 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 24 Jul 2023 17:16:32 +0200, Frieder Schrempf wrote:
> In case the downstream bridge or panel uses DSI transfers before the
> DSI host was actually initialized through samsung_dsim_atomic_enable()
> which clears the stop state (LP11) mode, all transfers will fail.
> 
> This happens with downstream bridges that are controlled by DSI
> commands such as the tc358762.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)

[1/1] drm: bridge: samsung-dsim: Fix init during host transfer
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=20c827683de05a6c7e7ae7fae586899690693251

-- 
Neil

