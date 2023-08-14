Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593EF77B909
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjHNMuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjHNMuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:50:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C52394
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:50:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe4b95c371so24769295e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692017409; x=1692622209;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64XOobM12qUFrM2PGUblEKGDaFnRYmV14FiLNgEhwBY=;
        b=rqdlXFOUGvs1lY5LrK7gqX3vDlA8JIzbWrWp/HafRbXaOVo0saPl+r1pytUC9KThed
         UokJ5Sxz5eIrj8uvsLYsLusYEfeL8Iu/ZRjdA6jjG2fDU9cSIWYMDqhrepF9TQy+VEhe
         J4zWUgVriKWMeV3YgRDRfMePNtLDkYJuqcPLJW/K8tqC9ic8Z4Ljf8Od0xLrJO9peUFN
         gFTe9AH9sShKirce0MrRZAysJ3WtnzaX7SUCxhsKlrSrhOcaokadVV0Bp7GeaKC99GSO
         /5OUEMBqRChgU3vn1N6IxpDez7CJ00SdvjvdkTS84uc3RCJ0LyaC0BuJA6LyUXiw3/By
         /oQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692017409; x=1692622209;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64XOobM12qUFrM2PGUblEKGDaFnRYmV14FiLNgEhwBY=;
        b=G4VwbIvCbjQHf5iuv/LwhRScOoXL7KjcOh9rrlgB2rMNW2EM89DnnKz4M00fqKXVj3
         Sb00WXG29HEpq5HcxpnaV2tJ8IfuSdX8zp4HbJxqAybRikBLW+l1UH+WySnlqd7eyjYo
         mF7l8XVHBn2GE0V37okY5x0OTwAl07ttIIAcAlLM8SZ0wELrP7TwIx7cZXza/H3z2f1e
         MB1kvnzZA3UVUL3wFX78bvx9Mt4iStuwZduT4orVGvDteFC0MvhZxRH66JsAywarAFhB
         J0bp4nYH9QeZtjjidDoLICih7L8U3ddXMeJi2YVQlAbKuqkeAv5mLcbDwgcMXY7APiNd
         xkgw==
X-Gm-Message-State: AOJu0YxdO1mrRhJeAtiRLgeCJ6Jz0/N3RysiDD3bgbpj2FMysUorSIgr
        ZxkZA+lJfJLRlDimB/ORDGXNWQ==
X-Google-Smtp-Source: AGHT+IF4Y4fV2ioh2t22KoSy4G3HWMdFuiqgxjY+jZ6GbDr4OhJ2bG8ZjW18r9eQGVCZhHN9kuLDMw==
X-Received: by 2002:a05:600c:3b03:b0:3fb:c257:9f48 with SMTP id m3-20020a05600c3b0300b003fbc2579f48mr10413863wms.16.1692017408939;
        Mon, 14 Aug 2023 05:50:08 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c378d00b003fe2de3f94fsm14183872wmr.12.2023.08.14.05.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 05:50:08 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Heidelberg <david@ixit.cz>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230812185239.378582-1-david@ixit.cz>
References: <20230812185239.378582-1-david@ixit.cz>
Subject: Re: [RESEND PATCH v2] drm/panel: JDI LT070ME05000 simplify with
 dev_err_probe()
Message-Id: <169201740818.1405695.2158426262781517183.b4-ty@linaro.org>
Date:   Mon, 14 Aug 2023 14:50:08 +0200
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

On Sat, 12 Aug 2023 20:52:39 +0200, David Heidelberg wrote:
> Use the dev_err_probe() helper to simplify error handling during probe.
> This also handle scenario, when EDEFER is returned and useless error is printed.
> 
> Fixes error:
> panel-jdi-lt070me05000 4700000.dsi.0: cannot get enable-gpio -517
> 
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)

[1/1] drm/panel: JDI LT070ME05000 simplify with dev_err_probe()
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=ae6546835efaa7195aaaa10e5ff4e695cd82a816

-- 
Neil

