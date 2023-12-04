Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EACA80362D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344957AbjLDOQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjLDOQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:16:33 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABF4B9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:16:39 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c9fe0ef02aso11414241fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701699398; x=1702304198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaBZHQpZqDG2XfMQ4dp5yLxoXxp+aROTaKcGQwWYDB8=;
        b=R9Ub2suE9lMkXsUOdv5LBcHkYonNl3y+neL3Ms79kIfirlOHwiTT4JoJqE7ajKxRBV
         QM+vXVv05PefXrECMNS8+5+ojlJRbHRNlVUahzzyjiSbPVqJuEFXyHYb6j0BRPBHeDW3
         wP+1wT4+X044/gjtJhW3uU4RbrQuyL6Jz0mdBrpfRZwGx2zRj2Icc+O5cfQLsiIcOehE
         06xWr5ZKdMgq1JKYCawVMmhG7ztnzdUfXF2qPRwyZ4KT3cyoBGsukmhsAU5/XFzRrvQv
         zjhZmHdFOQGoZ6V/VuGytYpxYEs0Km64qDcxYwDxNpzwFWjN9nmJuWKbTZHsW86qDdXN
         PdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701699398; x=1702304198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZaBZHQpZqDG2XfMQ4dp5yLxoXxp+aROTaKcGQwWYDB8=;
        b=fNNE3bnafnq+U2XByqudRLSufxe4oTBJJW+HPcuQWymxuLrflVh17HrNkSThM9ItL5
         VQVNPpeq6Chlt6+75QCF4PN0Q83sEq/mEqedLCNzcnwWn9SwqaC+bQ6kY9Fw4B5xXkwF
         hjjursey+s/Xz8eBI+gTSGpG2gHqx27ICVCLNrTRBS11sMbZ5dMIWoex1zOoMGRfwJvi
         GSL5ChkqgkmAPE8kh673OH5tdjlbvNv9gWE89Ooi6knlJefnJ1ivYegZSp4U775JnkKZ
         JT6kVcpK4O1euS0aTrMx/0s8dXk4Slyvay70eUQNGy6DS+vMMqCaXChOmXYC3jYYbZu2
         tXhQ==
X-Gm-Message-State: AOJu0YzxrhVtifPv0sLzDg6V1vIxrX+ODgpzeGRsDt2jOkxoLecmjoB1
        rtGcuEmYTFPQN2rZ/O0/Sd3RkQ==
X-Google-Smtp-Source: AGHT+IFhbnCuBV0JCw7uGD7qCiHyX7TJPwxSzrjLdzNKuV7GNJId7BTvK6QFl+pUyF8nsnegDyQuUQ==
X-Received: by 2002:a2e:7a14:0:b0:2ca:135:2204 with SMTP id v20-20020a2e7a14000000b002ca01352204mr1307465ljc.16.1701699398333;
        Mon, 04 Dec 2023 06:16:38 -0800 (PST)
Received: from eriador.lan (dzdqv0yyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::227])
        by smtp.gmail.com with ESMTPSA id v3-20020a2e9243000000b002c9fda71acesm487033ljg.127.2023.12.04.06.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 06:16:37 -0800 (PST)
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
Subject: Re: [PATCH] drm: remove drm_bridge_hpd_disable() from drm_bridge_connector_destroy()
Date:   Mon,  4 Dec 2023 16:16:33 +0200
Message-ID: <170169936702.76859.2850036545937110756.b4-ty@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919174813.26958-1-quic_abhinavk@quicinc.com>
References: <20230919174813.26958-1-quic_abhinavk@quicinc.com>
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

On Tue, 19 Sep 2023 10:48:12 -0700, Abhinav Kumar wrote:
> drm_bridge_hpd_enable()/drm_bridge_hpd_disable() callbacks call into
> the respective driver's hpd_enable()/hpd_disable() ops. These ops control
> the HPD enable/disable logic which in some cases like MSM can be a
> dedicate hardware block to control the HPD.
> 
> During probe_defer cases, a connector can be initialized and then later
> destroyed till the probe is retried. During connector destroy in these
> cases, the hpd_disable() callback gets called without a corresponding
> hpd_enable() leading to an unbalanced state potentially causing even
> a crash.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/1] drm: remove drm_bridge_hpd_disable() from drm_bridge_connector_destroy()
      commit: f730e7adfd69d7ac859d8fe4d67e980cbad1e445

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
