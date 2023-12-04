Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E5F803632
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345036AbjLDOQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjLDOQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:16:35 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5518AA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:16:39 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c9f413d6b2so20016551fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701699397; x=1702304197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3j2KS0gi+TQKxkDP6iL7961UxDW9BTF2XTenr3SsKs=;
        b=EJ25Xt0zy3/QQgVyOTWmxxWXlUOPh04x9AOdCvcxSrT1PZP60E7S2bVHzGcCqApQke
         c5J1pLM8ce2jOuAhg0s9giS99J0i5hxyyQjZYEoComMVNs77DjnGizzECv+8K5l7jsbF
         X/8jxgkkDXH51m/tyk5HAJWZqHvAAqgC22NG36exXg+Q7DlvOWqTaS4xXt1WMEoCwSXA
         MyXCuA7S6x13sKz330V/+/c8bim+ww2oHK1v+nwPe2B0ecq5DXAvU2tGYKuIdF1Wmxur
         iAZewF2Bh0vhciVMFy7dWXzZbK+B/h5AFUiaPyZ3eYHogL59PBLRmIt+qumA42jNgkTc
         C2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701699397; x=1702304197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3j2KS0gi+TQKxkDP6iL7961UxDW9BTF2XTenr3SsKs=;
        b=u4+A0uDcFXSTSbOdbPRejZbWnzZtxBWlNIWsbuDNXHjLRdPICgI2ryP6jNg2MXPk0v
         18S9xjQjFL5kzQ8JH5D87kfv/zheZ9QBpQ4ohifmdVMFdRPiJheSUWWqV4ylLBs7BRV9
         6zCkPUQWsGp6XSkfoEECwoOeoN2aq0/A7QoUj0QDIq+/e00xlviRG9VyCRhr/kb6STXx
         GOXgH8j4mBI74LWc0ffwO0GMc3BlHkMargkkoT9o9sQy11sUB/GNXs67UG8koqxWWRuX
         erEuAirdTM2jZ8oKlWsCVAYljdFclehrk4MahY+EX4wWh+DUPSiJGhJYM6308PQ8wt73
         mOhQ==
X-Gm-Message-State: AOJu0YxtF9FdFqL9BXMSffW2i+tO3el09YxBmYZvUA88lrvqBNBsboKX
        bGrQkmIXRmfn04mXIbPynGekBw==
X-Google-Smtp-Source: AGHT+IHaX1+G4i2MHGUFU1uKjK7P9+tYQt3ynolw+mKE5HNt183VLmBxt8CMyqeuATitU4WX+RO4SA==
X-Received: by 2002:a2e:b009:0:b0:2ca:4b7:a933 with SMTP id y9-20020a2eb009000000b002ca04b7a933mr468155ljk.51.1701699397424;
        Mon, 04 Dec 2023 06:16:37 -0800 (PST)
Received: from eriador.lan (dzdqv0yyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::227])
        by smtp.gmail.com with ESMTPSA id v3-20020a2e9243000000b002c9fda71acesm487033ljg.127.2023.12.04.06.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 06:16:36 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        quic_parellan@quicinc.com, laurent.pinchart@ideasonboard.com,
        andersson@kernel.org, jani.nikula@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: improve the documentation of connector hpd ops
Date:   Mon,  4 Dec 2023 16:16:32 +0200
Message-ID: <170169936702.76859.18234919578150833329.b4-ty@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920201358.27597-1-quic_abhinavk@quicinc.com>
References: <20230920201358.27597-1-quic_abhinavk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023 13:13:58 -0700, Abhinav Kumar wrote:
> While making the changes in [1], it was noted that the documentation
> of the enable_hpd() and disable_hpd() does not make it clear that
> these ops should not try to do hpd state maintenance and should only
> attempt to enable/disable hpd related hardware for the connector.
> 
> The state management of these calls to make sure these calls are
> balanced is handled by the DRM core and we should keep it that way
> to minimize the overhead in the drivers which implement these ops.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/1] drm: improve the documentation of connector hpd ops
      commit: a5b2dcb96d6acb286459612a142371b0d74543bf

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
