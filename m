Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9437B75ED37
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjGXIRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjGXIRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:17:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A314BE40
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:17:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D88260FB5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5A5C433C8;
        Mon, 24 Jul 2023 08:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690186624;
        bh=Qi/DymkSC6mDUS+3IIFJJcXGnZB5VSfohCNuw53J69s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uB9tusxWtz2OC/IP+hp4pJTgoKnHXbz0Cv10cctchAB7XGxmXhWbaRW/VkAHr4Nzr
         NtKlx9d9REjD3ytXyfGZITZXCkDegadwn/pykN4AUIGZeee7JlG8RWJdW1wJOZHPfo
         j66WB7tbUntSL/YVboQ2a/NwaCbeQjm6S4FdZ4UP6QiucXN5YjorCysA6qqCGP2NlC
         El7aokJc3Wj6A7MI8HpMnWP/Ainxq6XrfZm43eNgWC7raE4ZyVQyRqmIbbWpeRtli6
         w6qrWRjw80cJlN7OgTv+bDpVrqaEMd8YY0xp5KXYfZCvcdXP0750pACYbVW1wteCis
         8pmr7cqYg2A7A==
From:   Robert Foss <rfoss@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Xin Ji <xji@analogixsemi.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Jonas Karlman <jonas@kwiboo.se>
Cc:     Robert Foss <rfoss@kernel.org>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        David Airlie <airlied@gmail.com>
Subject: Re: [PATCH v2] drm/bridge: anx7625: Drop device lock before drm_helper_hpd_irq_event()
Date:   Mon, 24 Jul 2023 10:16:56 +0200
Message-ID: <169018660964.606978.4469347765082724733.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710085922.1871465-1-wenst@chromium.org>
References: <20230710085922.1871465-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 16:59:21 +0800, Chen-Yu Tsai wrote:
> The device lock is used to serialize the low level power sequencing
> operations. Since drm_helper_hpd_irq_event() could end up calling
> .atomic_enable, which also calls power sequencing functions through
> runtime PM, this results in a real deadlock. This was observed on an
> MT8192-based Chromebook's external display (with appropriate patches [1]
> and DT changes applied).
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: anx7625: Drop device lock before drm_helper_hpd_irq_event()
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=f2cca20f1fa3



Rob

