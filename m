Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C407BF62A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjJJIjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbjJJIiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:38:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315EA10D7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:37:55 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so4904796f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696927073; x=1697531873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bM0cR+jHfOI2qILAaNh+9FecRjTICMAQmR3rcDSCM5s=;
        b=ziMYtP6XnI5X/X6u8l48fDfTYxSLpHEFDr2dB9HbzIKq7cXqaLwKgdxFBl4ybt8QOW
         10fefAIih7+o8LMm7Sz/kCzKGEvHkpxj53+n2ubkbi1TNtwSX1qWqdJl9LkSrrhdCipu
         TvSJdVxRQ5nFm/kDIl/vPbOIlWsCoIudxboJFMY3ig4arnA6OZAc9eArWpmRwSG3ob2p
         dejqCdCtacNZFQUi46NL2IPtPBJMlmUb+KIFZjkv6gihpgSH31z2nhn2nYXf272aN4e0
         yP9DnVvScFtB+DFnGew3hBeSrdljBgyUemBCBGMKOby2WHLZ+yUTfT3DmclCH5fFWyOC
         /vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696927073; x=1697531873;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bM0cR+jHfOI2qILAaNh+9FecRjTICMAQmR3rcDSCM5s=;
        b=qyx06W6dHYCdzblGxwtHa8oaHXfJJ7Np0GJIH4q/v+qKedXOTD9TM3tYkS0MDmr95c
         G+bzCkPhGDgqlhTN76Xm9u/YXDYEn5m11rFyChJI/gbMpq2PSIItQ+INd8tnRR/3L0Yu
         9cVDKMk6BwuImI1Gb+6iyRF6OYzP74LryoaAqh7YrUIopsbJNih+0ZoNVCvjyKGh+8yd
         koqJQ0VDmGcKmRCpzUrp3sYBLtuF2fa9rQeGzmgqSKxShbbt1j5ww7vFYqwxBnCx4Dvs
         vqwGmejrvNJ4k/NNnRmNl6kYMSTTQgxjEIw/dLGE9MQN16UJPzUddybZNItCuD3T0zlJ
         ie8A==
X-Gm-Message-State: AOJu0YwZ6Ol+kuNLtDdg0z1Ws4V+cVzNmD/vbVlKZaLmndDovC8Nlf4W
        Cmy8q2wrNoFQNLnCU1fEQq193g==
X-Google-Smtp-Source: AGHT+IG9IppgKYYkVDqtUqADzSZdWZdWAucN7caZjsxQ4qL8cKRUnJM4yujPA6kDuAL7oB8yi8j+dQ==
X-Received: by 2002:adf:d1cf:0:b0:32c:d0e0:3e71 with SMTP id b15-20020adfd1cf000000b0032cd0e03e71mr1289947wrd.38.1696927073358;
        Tue, 10 Oct 2023 01:37:53 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id s4-20020a5d6a84000000b00327bf4f2f14sm11983147wru.88.2023.10.10.01.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 01:37:53 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     linus.walleij@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, Ma Ke <make_ruc2021@163.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231009090446.4043798-1-make_ruc2021@163.com>
References: <20231009090446.4043798-1-make_ruc2021@163.com>
Subject: Re: [PATCH v2] drm/panel/panel-tpo-tpg110: fix a possible null
 pointer dereference
Message-Id: <169692707268.2632460.16120897194118078768.b4-ty@linaro.org>
Date:   Tue, 10 Oct 2023 10:37:52 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 09 Oct 2023 17:04:46 +0800, Ma Ke wrote:
> In tpg110_get_modes(), the return value of drm_mode_duplicate() is
> assigned to mode, which will lead to a NULL pointer dereference on
> failure of drm_mode_duplicate(). Add a check to avoid npd.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/panel/panel-tpo-tpg110: fix a possible null pointer dereference
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=f22def5970c423ea7f87d5247bd0ef91416b0658

-- 
Neil

