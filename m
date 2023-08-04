Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3C276FC12
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjHDIbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjHDIat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:30:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1B44C04
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:30:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31768ce2e81so1641600f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691137846; x=1691742646;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAckcGQZs5adpjiStERN8wHvnjgweyITFA752Ae1t+M=;
        b=k/zVqT9T/LPYLDqyCC9ETpvweUt2i2pat5y+TuNqqYF1tBMDNfIh11FYXQb/o9FVVa
         Z3fng86fILMtLnynLJhMvopKO3aJd7glro6Umn/4/hx3H9gmVSrMnnxu1O8qANBf9FK4
         ZwC3q8qYDAT44YYXHTEK6JNosDn1/w7GHDnnoaLHvbb82xUZybjnjGBOnlVK4kCKt1ck
         td5niSI7/NvgI4SfmuG0fi69k/0C2SS3+RWVlsKOPdN1GobghuyDqc6Bqz4cPJUC7rxW
         6qRKDLz1jrwP261QDyxJhHWTP8X1jPSrSKtt1TggLlCjr18Vb818Kr/8dQ5Ft7xSH5aj
         2C1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691137846; x=1691742646;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAckcGQZs5adpjiStERN8wHvnjgweyITFA752Ae1t+M=;
        b=PrK0EFJR5nzDIMrY4r5LRcmrRttO53IciScEOekO3qm9gqn//m7VnGsRaUcEzYEQTv
         UltPXzViANm9KRq0Ayp0fPPhGJebD0yCrWsxAZtcZ3DlrmI2DPsCB4vZ41FR+o7BOUp5
         rhOHL42wIn5xguGOXppW79ULRrLK377LOVKdi/x0c5vf9EH71h93jDVGuZUp6hSHDMh6
         xrDAa1y3eFq01QEylDov4wjDF6ka5iOMnSG3ZfZuaUr2GE7mzlwblwK+2dqtHfRvKj61
         Qx5sWmdvv6TM1h+aOjNCtyWqkUuDcRgiMJBsEc4cgAKo1EuBNDC54b4z3gtCrah20kDS
         2Y0g==
X-Gm-Message-State: AOJu0Yy6/UPiAIix6qkGogGvZX8hEPwWfjTz/t112wPOF1+OrMKQs/2M
        OgPjFJtD718WvUhd3zbtBDgZiA==
X-Google-Smtp-Source: AGHT+IF9eAaJqnipO7W5MkWr5ZEFwnTeucI4Vruud1vG7qTA5kMfrWewbQZg2JIJGVcr7RgKiLIaRA==
X-Received: by 2002:a5d:668e:0:b0:317:58a8:baa with SMTP id l14-20020a5d668e000000b0031758a80baamr704840wru.28.1691137846053;
        Fri, 04 Aug 2023 01:30:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id o11-20020a5d670b000000b0031753073abcsm1892476wru.36.2023.08.04.01.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:30:45 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Amit Pundir <amit.pundir@linaro.org>
In-Reply-To: <20230802-revert-do-not-generate-hfp-hbp-hsa-eot-packet-v1-1-f8a20084e15a@linaro.org>
References: <20230802-revert-do-not-generate-hfp-hbp-hsa-eot-packet-v1-1-f8a20084e15a@linaro.org>
Subject: Re: [PATCH] Revert "drm/bridge: lt9611: Do not generate
 HFP/HBP/HSA and EOT packet"
Message-Id: <169113784495.3155201.7552146882174275208.b4-ty@linaro.org>
Date:   Fri, 04 Aug 2023 10:30:44 +0200
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

On Wed, 02 Aug 2023 10:52:22 +0200, Neil Armstrong wrote:
> This reverts commit [1] to fix display regression on the Dragonboard 845c
> (SDM845) devboard.
> 
> There's a mismatch on the real action of the following flags:
> - MIPI_DSI_MODE_VIDEO_NO_HSA
> - MIPI_DSI_MODE_VIDEO_NO_HFP
> - MIPI_DSI_MODE_VIDEO_NO_HBP
> which leads to a non-working display on qcom platforms.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)

[1/1] Revert "drm/bridge: lt9611: Do not generate HFP/HBP/HSA and EOT packet"
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3c6bd1b7e2043fb00ce6b622709d176609431406

-- 
Neil

