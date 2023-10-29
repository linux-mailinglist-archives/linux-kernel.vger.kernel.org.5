Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CC77DACF0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 16:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjJ2PH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 11:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJ2PHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 11:07:55 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA2FB8;
        Sun, 29 Oct 2023 08:07:50 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc394f4cdfso2584095ad.0;
        Sun, 29 Oct 2023 08:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698592069; x=1699196869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rq2lTx4r6AxRWMwoBx4OQjZx3mpwnDbM/buzeUwRHtY=;
        b=fFR/S4T+NgyUIelowbgLRBRp6x4H1D6CG4UvrSoSXWadNTByEBsK2eXxA2PZ+raML1
         PpKUD+TYbAv4st77nWYZ//WtiF3OhNSx+kzOeZKS5JuiCgocs2OSOYLsGljHcu1EC2ig
         bffHgCuqaI8fsdatcj5HV1Y704APE27ZnQv5tTxlb0tN643iEkZYumW4b156/oxSa3HO
         WeQPQZWrsaG73C8F4rYfTuFuALtWB3zx2qZOno4HZs/UQ732yJ0kECxJ2NsGrtItCqBK
         Vp4Qlm6I6lDSMVkXdXlodtxhPjZgXUmYULMkUGBm9nYxAAnbS2RZW1oF4L63K2rhcLxc
         3LiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698592069; x=1699196869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rq2lTx4r6AxRWMwoBx4OQjZx3mpwnDbM/buzeUwRHtY=;
        b=mao/j7ELAN+p7UlPd/pju7RjnZ4ZnBwjnSN16CPkOUbV+ZjmFGLTRUyxckbx3u4Ypk
         /wGQLEofZ4XRoudKkuVpTJaKd2f5WUVc2XfODhZI/6115zQgq/VGgsWqI8ncqrGTU31X
         ZhCe3oUheQGZXwL+2osUUn4C0JlKH4nejpP6PnRY/vI0LhF56jg3EUls3OYsNrxQSl1S
         01bADBaTIhZH2f4TUKJoWdj221MTEjxuuPbxFi4nU4zpUvGefpQ5HtPD81TLQj6lyAyP
         EEtTvfHLq+V/QsmlldqX0tBEWp2nIe1yHulymQZmndunSRUzJe1WSoK8Ab+zqWpSVnbw
         zebA==
X-Gm-Message-State: AOJu0Yz/wZemfBCJNBSR9bcjYsio56qwBM+rmZTn8MGqKrvxHrV3ZPQf
        lcPET+yaFpcmPYesa7KHDLA=
X-Google-Smtp-Source: AGHT+IHqEqQMKupQeBAJEYNFdKsCoTID1AbZp8zrduE+qBv97MGFQtDmaZUFOCmKTxG5w1vSOlteIg==
X-Received: by 2002:a17:902:c641:b0:1cc:2bd9:1b2d with SMTP id s1-20020a170902c64100b001cc2bd91b2dmr3052186pls.43.1698592069312;
        Sun, 29 Oct 2023 08:07:49 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001c5eb37e92csm4640408plx.305.2023.10.29.08.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 08:07:48 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniels@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
        aka swsusp)), Marijn Suijten <marijn.suijten@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sean Paul <sean@poorly.run>
Subject: [PATCH v2 0/2] drm/msm/gem: Add metadata uapi
Date:   Sun, 29 Oct 2023 08:07:36 -0700
Message-ID: <20231029150740.6434-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027194537.408922-1-robdclark@gmail.com>
References: <20231027194537.408922-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Add metadata mechanism to provide a back-channel to communicate image
layout information between vk and gl, because EXT_external_objects
doesn't support explicit modifiers and "OPTIMAL_TILING_EXT" is not
enough information for the importer to deduce the layout.

Rob Clark (2):
  drm/msm: Small uabi fixes
  drm/msm/gem: Add metadata

 drivers/gpu/drm/msm/msm_drv.c | 59 +++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/msm/msm_gem.c |  1 +
 drivers/gpu/drm/msm/msm_gem.h |  4 +++
 include/uapi/drm/msm_drm.h    |  2 ++
 4 files changed, 64 insertions(+), 2 deletions(-)

-- 
2.41.0

