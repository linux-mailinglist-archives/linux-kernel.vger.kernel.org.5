Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADECD810EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377942AbjLMKxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377847AbjLMKxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:53:37 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDE193
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:53:43 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3363397426eso1472295f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702464822; x=1703069622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AVoR1uUGIhIdM0n8dOyva32mu3rDmn4zFFnMFBtCJg=;
        b=aHKu3hja6RKi1QETcTzcsQlMx22KOP00reYI/dJ2yTwfH1vRgXm3ZIMbNOOeLCbDd1
         Ldg1TLNxIOEkFjUj4Gi6pqcKbbhWvJzsP5GrmPlL0l9kfnTYUKyTnN1akzNBF1ChMN3J
         ztgkQKqvb/15GgM1jWrfDHczJURGQ3WCUoig4AKnuy6belJuYH9mMEBLPDur7Z+7k6ss
         qlolCJgKtXhUTblSeAOodAhcxx5vCevRDlZ7g1Xv7ol0RUjk4H7oLPjriFAOPSEF28mt
         kgJ4cym7IhQaIAgdRVhnYtJ3uV49XK9zeZ0I4yXmMjXK/59khmE5TVcAvIh8mEsePIK7
         dkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702464822; x=1703069622;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9AVoR1uUGIhIdM0n8dOyva32mu3rDmn4zFFnMFBtCJg=;
        b=KYmdTmJ1/0fitHAkGMCs4w++ShDnPOrF4eQkH43qnNOb+bL6ahikWRotAw6NCBlC6C
         qPM+WwKxHfMNHRJZ/rKWUhiGViYJ7yguEPPqSmqNIEfcT2peDIsdawr9Uk3l3wmHFUPC
         OZjpV75Wn3z5+I82mOhjqRbI35a9plWvgnyNl7MNPJyDdqyC22mgHhmXn2dd1bNBVDJI
         /NgjxOHyu3kXJSXYiWQQxcXAdZkF2GBl3WNMIxZI3fK1cHTXbndxAG6mIce05bdX/dfa
         We2hvJiwmOFy+E+PAPMzbDoPNmrre9OZVg1uO7JukJ7JR+53tFB5AXi3E/0LmWe/QknH
         M/wA==
X-Gm-Message-State: AOJu0YzN4L/3d/JY3W0UkBAo4F5TnIkOWlVt/EY6cAiMExc95Kg5+LDw
        WVVLsfQQgXgsJazcgcLV0oOubg==
X-Google-Smtp-Source: AGHT+IGuvTKym5GzSffelzfLsWJCS5S1+vASIQD6/JxyNREq8dMO2z30KqWMSeSA3exaeQI7tcTbNg==
X-Received: by 2002:a5d:6811:0:b0:332:ea44:8989 with SMTP id w17-20020a5d6811000000b00332ea448989mr4509472wru.30.1702464821704;
        Wed, 13 Dec 2023 02:53:41 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id dd14-20020a0560001e8e00b003364277e714sm374761wrb.89.2023.12.13.02.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:53:41 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        David Heidelberg <david@ixit.cz>
Cc:     Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231212200934.99262-1-david@ixit.cz>
References: <20231212200934.99262-1-david@ixit.cz>
Subject: Re: [PATCH v2] dt-bindings: panel-simple-dsi: move LG 5" HD TFT
 LCD panel into DSI yaml
Message-Id: <170246482066.875647.5449342592487224704.b4-ty@linaro.org>
Date:   Wed, 13 Dec 2023 11:53:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 12 Dec 2023 21:09:17 +0100, David Heidelberg wrote:
> Originally was in the panel-simple, but belongs to panel-simple-dsi.
> 
> See arch/arm/boot/dts/nvidia/tegra114-roth.dts for more details.
> 
> Resolves the following warning:
> ```
> arch/arm/boot/dts/tegra114-roth.dt.yaml: panel@0: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
>         From schema: Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> ```
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)

[1/1] dt-bindings: panel-simple-dsi: move LG 5" HD TFT LCD panel into DSI yaml
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=fa97e21e74df5ef63a442e4cfd13fd113fc8196e

-- 
Neil

