Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9119C77B8F0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjHNMqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjHNMqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:46:17 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6569E5B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:46:16 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso3798470f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692017175; x=1692621975;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPg8mT0qGY6qbRMrFGYf6f8zh9YxV/m5DARJPVVyyy8=;
        b=uSd6lNXktTpohl+0hq6b6UEfImFdVbGSUns9LlDc46OwRy4ymGeZXPD7yMGUcCdSAJ
         ub5zTqP5aCTpWesGTQWRlwYVTxEjNb8yuCpjVGU4v8LggiPvBGLbyFmsHtwjGSWUd91R
         ucvFFzDHkhzSFQAZ+SR2ix+zWGnME0CVYJiM3HAPewoVWqHJ9Q3RomNAcNUSo8jKszRm
         m4VXfWe1CsofurF2N3TDLCvi72MdHr2bNBD2qsGFh1/w9/M6XUgr2VUVeOH8Z6zb+erx
         gc7+r6e44y2I0NbzBTUrf8Pdx1hsktuVTJszc2gslCRqZd2vbBOhgOL7wqFpmgrmIcZf
         QxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692017175; x=1692621975;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPg8mT0qGY6qbRMrFGYf6f8zh9YxV/m5DARJPVVyyy8=;
        b=HDqh1IYX3B1IgQMpUerKarAzk4l09coYK0yJJUkDzu9MwstXyGymfFHDA6kAHNQF8K
         p2vycPECKu3s+vQWM56QfP28hA5k7XzPVZ5rMy+ga2mvN5el7PfKEAwaRKXDExmK32h2
         UGJpVbzUFLkgvWuzkfPffZVh6j5zchKpeBg9h0gIl0ZZWX3cZ6jWmUVLUbzEdy//xpNd
         w1lUPLmyOexuK835Diy9fXG5jZ0iNbxE5lO+df95n3JKGfEvw9akiH3rlt3DPkrAhi9W
         /z7r59Rc+aSD/7XX2iaocCMZRhngKtInVuCgYeKeJD+5cqBcaLXtd2isihYdl964wCmr
         qkHQ==
X-Gm-Message-State: AOJu0YyUh2npKoo1vqWYZFwhEDfUs8RkEDcb/uE0qgT7bBzCFO95Sbin
        n1y3jUQ0kakGdTQ+qjNLUsjvi8woFA6HIKRC9qZ7Jg==
X-Google-Smtp-Source: AGHT+IHLvIZkW6GMLB2kk5tUZymEkm/TENegzimmE39RexsRxHeMXzQelswaRvh77Epb/xJjjjwzZQ==
X-Received: by 2002:a05:6000:11d2:b0:319:52da:8f0b with SMTP id i18-20020a05600011d200b0031952da8f0bmr7078941wrx.17.1692017175282;
        Mon, 14 Aug 2023 05:46:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d444d000000b00317f29ad113sm14249506wrr.32.2023.08.14.05.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 05:46:14 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Heidelberg <david@ixit.cz>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230812185239.378582-1-david@ixit.cz>
References: <20230812185239.378582-1-david@ixit.cz>
Subject: Re: [RESEND PATCH v2] drm/panel: JDI LT070ME05000 simplify with
 dev_err_probe()
Message-Id: <169201717460.1374248.10255563914094623765.b4-ty@linaro.org>
Date:   Mon, 14 Aug 2023 14:46:14 +0200
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

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/panel: JDI LT070ME05000 simplify with dev_err_probe()
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=f5d8f9c0d8b4bc8ad7e7b23a9f4d116e99202dd3

-- 
Neil

