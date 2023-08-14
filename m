Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EE777B8ED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjHNMqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjHNMqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:46:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6274E52
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:46:13 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-317b31203c7so4050569f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692017172; x=1692621972;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MT4WIsJdIaKJmtpZrvoV9bGE/dt0RUZTjejJTMKrR68=;
        b=Jqiq4BJp44wWy2El0A6CsKSrG1sf+IKBoeejY/RUzOpsWTbo0kW8NRZNwt8TVy0M24
         4NAlhPnsYf4Lo3NQ3n7bi1mIC0Sltf1ogpx44uceqspe4YBOcC5JAIsydGXLpQupfbYf
         YwMilRXIfkbiu8R0F8dMTp9/vrOX6EsLGgFW0jCvq8lu99HbYZ6AZpCIo/TvVTv24aMN
         L+Ko+r1PxpyUTqPhg3uJBeXfZeLgUy8ELh38dtHJdS20lgk/CFlgFkCUhf+HaJe26o9H
         3GoJ3PXky3OsUuJCDnSWaYa3/kQ1RMoKcZjn3jUYyRnGlIf205gV6rVn5xsy3qdqBfhD
         4VZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692017172; x=1692621972;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MT4WIsJdIaKJmtpZrvoV9bGE/dt0RUZTjejJTMKrR68=;
        b=ZEmvKWVEV9/zovf+G8Y8XRLhgc0SmfsFkp6HkVBALQrgWa3ZFDhe+xiM/BQWOo/DKz
         6cYLbynwgCR4yqM1DMqkowJh9honHuCWi5icmrBhpIVjpOT0CCKSxHB3nhjdOFyFJvbh
         xkRCcBEN7ZxHp2cT8R8sNp4alY+Dbd4Wzwv2aywcetYq5yGgKFFqDzb4a3Ag95WI6F4c
         vnwx7CCLOl0jcwPcPGPB3AwJTsGJiroaVJt30/bVX+3BXtQeNvTxOWQK2H0ofq337rZN
         qffYoOz7JV2h7q3PQmilnZr742NEFkF6ABXtAb9ZPSzHBMDaIK+oursNxZWt4ZDM4GS4
         30Lw==
X-Gm-Message-State: AOJu0YzrFAN+HUtVoF22mIs9xYo1d6NqwSTRjSn+sP6I9AJ9QD3yx37v
        caWnLxfiWbkg+W/7dzsXCc2D5w==
X-Google-Smtp-Source: AGHT+IGuiHcTy126FM1AYZ1EsMq3UD4lAKjOVCjna8Vb8pLrk8pgmfSNPub/Y3opmRkGwujYR1uRSA==
X-Received: by 2002:a5d:4952:0:b0:315:7d2f:fc36 with SMTP id r18-20020a5d4952000000b003157d2ffc36mr7676022wrs.20.1692017172203;
        Mon, 14 Aug 2023 05:46:12 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d444d000000b00317f29ad113sm14249506wrr.32.2023.08.14.05.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 05:46:11 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Liu Ying <victor.liu@nxp.com>
Cc:     andrzej.hajda@intel.com, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        Ulf Hansson <ulf.hansson@linaro.org>
In-Reply-To: <20230807061115.3244501-1-victor.liu@nxp.com>
References: <20230807061115.3244501-1-victor.liu@nxp.com>
Subject: Re: [PATCH v3] drm/bridge: panel: Add a device link between drm
 device and panel device
Message-Id: <169201717119.1374248.4944625846885849850.b4-ty@linaro.org>
Date:   Mon, 14 Aug 2023 14:46:11 +0200
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

On Mon, 07 Aug 2023 14:11:15 +0800, Liu Ying wrote:
> Add the device link when panel bridge is attached and delete the link
> when panel bridge is detached.  The drm device is the consumer while
> the panel device is the supplier.  This makes sure that the drm device
> suspends eariler and resumes later than the panel device, hence resolves
> problems where the order is reversed, like the problematic case mentioned
> in the below link.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/bridge: panel: Add a device link between drm device and panel device
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=199cf07ebd2b0d41185ac79b895547d45610b681

-- 
Neil

