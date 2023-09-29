Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1DC7B2FA4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjI2KCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjI2KCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:02:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5521A4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 03:02:17 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c5db4925f9so3561615ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 03:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695981737; x=1696586537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/dcw9ZT8JKLzzG4Y/QBvOkYw2j2/eNx49mOmDCD4Ko=;
        b=X1tS0Of1lro2BXS6gOOB6i/z+TfCN/pxQmy9hgEShonWGT9Tott106AFsUXcG4HyGa
         PNb0h0+eDh67cO/AbmKQs2rlHN8OMbUYcVEse9Ns5soKK4nLyhwbQ19k7Ya84wxLNhUf
         GNuo057MVel23cLvdKzm7S+xC7gPcIKyySIDGf1JFdPXJcHmaBhT82Sr+Hf1KfZ6WZMh
         nAqZK+IT4BCxxmkd8ouGIFJXo/ydZm9DMapNGG8PFJJsmuvghtL+RkizXbYhoQ45S9m1
         pkwZRy3YYo8W8b7bZUBiKFc4okhdH6tqnclGxLug7VySsKEr9anaLl810TsaYuNHvF57
         wh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695981737; x=1696586537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/dcw9ZT8JKLzzG4Y/QBvOkYw2j2/eNx49mOmDCD4Ko=;
        b=IRr7+S4SxcCWqR9vu8w7ZSDFTilRahfHzGUn8NvLvrTth3ZOu6ucR+QEHl3UzVOILV
         vV1enGBbJRPhxQU6YBEh7ksMjDOEpLPojXj6j1iJpm5gjMe6+W8jQsY3a6zXes7xYre0
         LJt3fOuXiZaa05Tjnr3Krny5dZC9mXZNy5eORqQwvEuMQIJgOmbgblkWTbnlPp0ajQmf
         UZS4aAU5t2SnlCStfTt4F4pKZJCRwpq223xf4aHoi5mzKAosDJF6o5AiidLuPreHrbhq
         aqhsfonH+LUTJI/vlnp4MIPH3GGkuZLXpkMeYQ+jvMQ1hC9mnXIURXBLeTv95T8pjA7K
         8jUg==
X-Gm-Message-State: AOJu0YyVOw7aLAZt+cr5PBMCocHGzg+IAMs5OdaO8awiNSAgDipHjyF9
        RLrEbndaEXp8yDm9dLVXC3yXysuHzLr27Qn6
X-Google-Smtp-Source: AGHT+IEsTj/2jI4gPTpIYC3RVNZHeJphdPDRhTWYlAF7sWlUBOha1hqRYO47qSnv51rGQwoJgcV50A==
X-Received: by 2002:a17:902:e545:b0:1c5:cf7c:4d50 with SMTP id n5-20020a170902e54500b001c5cf7c4d50mr5459105plf.18.1695981737162;
        Fri, 29 Sep 2023 03:02:17 -0700 (PDT)
Received: from sagar-virtual-machine.localdomain ([103.69.217.155])
        by smtp.gmail.com with ESMTPSA id s18-20020a17090330d200b001c6052152fdsm11991603plc.50.2023.09.29.03.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 03:02:16 -0700 (PDT)
From:   Sagar Vashnav <sagarvashnav72427@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sagar Vashnav <sagarvashnav72427@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] add kernel docs for dc_dmub_caps
Date:   Fri, 29 Sep 2023 06:00:51 -0400
Message-Id: <20230929100055.17563-1-sagarvashnav72427@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <215ed02d-1dab-480f-84fb-a828b294f716@infradead.org>
References: <215ed02d-1dab-480f-84fb-a828b294f716@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel documentation for the dc_dmub_caps structure.

Signed-off-by: Sagar Vashnav <sagarvashnav72427@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8125839..14b4c50 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -208,6 +208,16 @@ struct dc_color_caps {
 	struct mpc_color_caps mpc;
 };
 
+/**
+ * struct dc_dmub_caps - DMUB (Display Microcontroller Unit) capabilities
+ * @psr: support for PSR (Power Saving State Residency)
+ * @mclk_sw: support for MCLK_SW (Memory Clock Switch)
+ * @subvp_psr: support for SUBVP PSR (Sub-Viewport Power Saving State Residency)
+ * @gecc_enable: GECC (Global Error Correcting Code) enablement.
+ *
+ * This structure describes the capabilities of the Display Microcontroller Unit (DMUB).
+ * It specifies whether certain features like PSR and MCLK_SW are supported.
+ */
 struct dc_dmub_caps {
 	bool psr;
 	bool mclk_sw;
-- 
2.34.1

