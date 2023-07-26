Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E001764176
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 23:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjGZVx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 17:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjGZVxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 17:53:25 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4771BD5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:53:24 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686f090316dso152547b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690408403; x=1691013203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7o3CN+su3di7WaA9bWuG9cZg9fmgR34kXAM5LCkUKN0=;
        b=RBiICJQzenyR3+D4KJZHLpmaQiqoWkKDAQ3LssNG4zdPxb5jhUUj0L6CQFhsgam7vg
         H+zqZacAXrPed3+5TdMOZxPocLkXrVM+FkX/MgCbp9E/kRSRfQ27NA9MPC9Rbu7GxcaK
         o32dURpNXqUP7bKtXqJ+6vcXTllE/LtWrn89Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690408403; x=1691013203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7o3CN+su3di7WaA9bWuG9cZg9fmgR34kXAM5LCkUKN0=;
        b=WsdJGU29RR4X+DXM6BRJJj++VrcfF7qE0p2hxP0kUNSltIi+zjwnwA7tKSCClqEh4r
         8EF4s3zmO3PF9BSF5VHauXJDAPVJ+vOQErtRI2GgykQPkpTKuLWJwaSYbm4oRRUagVXb
         lAv9peUgtZSQstVKp144V4zrGlA9ICkm0dnwGpx9EuW27z0ko6LvS77c51KFm3jqEc0y
         M8RO2DUNKjvbkqZjK9GuIvAkku4VfKzkY6jvribIxdOKKPBi50EJAZn9Mlj/hKRlRX7t
         KADkYgPHpAslu0ICFrd6gDIPbSuCOa3E4KtAlpUwzGInzaRrt6oa90h/Vp6sSeD5h10j
         qCzQ==
X-Gm-Message-State: ABy/qLZtZkksXACocceYBo488CQoGlLI3YKtun6n93Ch3fGKLzRy/Zkp
        Fe7TzZPsopMpHVEqK1vV1uyKGw==
X-Google-Smtp-Source: APBJJlHxmqHoJCbHhpHOLxLueAFUER7U20Jsnko71nzWTdplk4lISZJmwPL6ZD+DateuphlGdXMrCg==
X-Received: by 2002:a05:6a20:13d2:b0:13b:77e6:4fad with SMTP id ho18-20020a056a2013d200b0013b77e64fadmr2492621pzc.59.1690408403634;
        Wed, 26 Jul 2023 14:53:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c20-20020aa78e14000000b0064aea45b040sm64996pfr.168.2023.07.26.14.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 14:53:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Qiang Zhao <qiang.zhao@nxp.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: fsl: qe: Replace all non-returning strlcpy with strscpy
Date:   Wed, 26 Jul 2023 14:53:12 -0700
Message-Id: <169040838888.1782149.4842834187896840611.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523021425.2406309-1-azeemshaikh38@gmail.com>
References: <20230523021425.2406309-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 May 2023 02:14:25 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied, thanks!

[1/1] soc: fsl: qe: Replace all non-returning strlcpy with strscpy
      (no commit info)

Best regards,
-- 
Kees Cook

