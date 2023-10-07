Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A9A7BCA5F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 00:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344214AbjJGWWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 18:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344151AbjJGWWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 18:22:40 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDEA9F
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 15:22:38 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53406799540so6030886a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 15:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696717357; x=1697322157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0yaMn2Inorx6J5jbXWZ4lv04z9p9knuEMsnSJqco5r8=;
        b=H430qdauCj4nwGuYkP25DsSTfOxRuEpxXREAYLmWweOEwDaq+Q8lQc04ut223ujwGv
         33drcXdcAujz7UeqmEy6lHeztNHy/X1lWbdhEF2hFsGzwrZRbZJPk3NVcYVUEaPnU0qT
         0cHQDGsN0Ch3VQT7/bdez1IycYeH0VV5bkJg5UDFKANR4lBd9RnDf9tE+jD7F0fDBgY2
         2uYGpfmxu1rCLwbXeT63GwlrxggjT+Hjk+KYiSKHUr6upHjbQgYZLtdxac7L6TDpl1RR
         izF5YZqWbGElSwkBwnFcUi4vbf4wIKSDzOh1ca+eeDHG6oDrkwHx0lf/VcWtIVDa1szs
         SAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696717357; x=1697322157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0yaMn2Inorx6J5jbXWZ4lv04z9p9knuEMsnSJqco5r8=;
        b=F5O6Xd3q9CQ4Qd2+JT6orH5pv1Yj5VokVmKVQOh6hi4OkNzFrQrUV/tUbs2e8AWpI2
         Osep5ULxqlDT5f/jtX6cMRJO8QxwSMtquKDJjKcx3+IgR1l8OFFpmGyUHR8/9IrcaFKi
         NjOPB++b4qPzlQh0EXTUBl0rV9iC7ARioUTFWwSl53X5BbktQ3EmAZ/lZlREQvFL5PGv
         R98Z+YXClLE+aKbH5u1/5pljPutFz6DOM6gxN+QOUWLDzJ8sp2YLlR68rfvrLm36JGjc
         dX1dotZs4nzc49BH0debMNdPGNAPDWLi5+SPbowiI+FCvXhCy4RkB0bVVP2DXhk7pVmc
         K7AA==
X-Gm-Message-State: AOJu0Yzq2wNEw19/WZNfJ99XC/ZBoosi4ACDZ6grO8rhx8BdBHA72N2d
        TQUKGRFt9thAt1SgmBM5n0xPITEGH6ADGJBj
X-Google-Smtp-Source: AGHT+IHtu3HnanV7rXLGs6uxTJkkuhW6srImpswGLZ4J0MS5G0alet6JeZIVBHsE+E6Tka0OowL8fA==
X-Received: by 2002:a05:6402:3445:b0:52f:a5d4:1f5b with SMTP id l5-20020a056402344500b0052fa5d41f5bmr9517743edc.9.1696717356617;
        Sat, 07 Oct 2023 15:22:36 -0700 (PDT)
Received: from Slimbook.. (181-251-201-31.ftth.glasoperator.nl. [31.201.251.181])
        by smtp.gmail.com with ESMTPSA id p7-20020a056402074700b0052f3471ccf6sm4315631edy.6.2023.10.07.15.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 15:22:36 -0700 (PDT)
From:   Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
To:     maarten.lankhorst@linux.intel.com
Cc:     boukehaarsma23@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm: panel-orientation-quirks: Add quirks for AYN loki zero/max
Date:   Sun,  8 Oct 2023 00:22:04 +0200
Message-ID: <20231007222205.316032-2-boukehaarsma23@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add orientation quirks for AYN loki devices:
- Ayn Loki Zero
- Ayn Loki Max

The quirks have been tested by the JELOS team and ChimeraOS
who have been patching their own kernel. This has been
confirmed working by users in the ChimeraOS discord
servers.

Since there are additional Ayn Loki devices I have
made separate matches for the devices.

Bouke Sybren Haarsma (2):
  drm: panel-orientation-quirks: Add quirk for Ayn Loki Zero
  drm: panel-orientation-quirks: Add quirk for Ayn Loki Max

 drivers/gpu/drm/drm_panel_orientation_quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.41.0

