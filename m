Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6B77C57A6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjJKPBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjJKPBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:01:18 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2703A4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:01:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3226cc3e324so6782803f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697036475; x=1697641275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N4/qb0yLPpruhc/QAx2SOX18zRGpVS+sKQ26GEorrMM=;
        b=QoZB6JbsA5pcC7PpwRDaNpi7XXSDts8/U3+62BdiOE9yZF5mVzip/A4vbT97b0sNJa
         IxjezpOye3d2u3zgJU8qjlih9g0uMeCmUjCvtCff/lPKP06N1E+jliJKVciVfxHqfxrG
         YH2jQwvboWSOwehPkfY8d1xoHYByvavzR5MFfZpCOw88yHfTWWf7BO+ecpA/lxwCwAIO
         Z7qWGdin75jXzF3RgDFQeTt1Th9aNrOwfo632rP2oC6zhUG8aGpatorXoVkWefVD8tPv
         RP5hLVZj+14LiAW47nLPgqGUJyF9A2pPVOoXuYoh1mp/0CISdyUFUzPMzQNhO8oNM7n4
         /cJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697036475; x=1697641275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4/qb0yLPpruhc/QAx2SOX18zRGpVS+sKQ26GEorrMM=;
        b=bTWHsmLW3rkJ4KQk2qDA7dGiwa8q3UB4uEKAWKwu243gKK9qTCYRJeSbECnWxMNioQ
         v7ZSgrZmrhhYbSjIM7gGgVSb3LZ8TrfYHIdKwa4aZlET7oe+yf3wEHcYqJaPChc16831
         QUyI/nY9K4uXInL3zagFsWvkmcdpFe4grmt2J5ApHWe7ShqJG0Ut1RRjf108znvVg3Zs
         W3uV2KZWQnuZwWV2FOtSvcTzNC19Ss4Rio/X877Cb/KS4fuGMWSwkV3gXldA96/fsCZm
         a37w7ZouH22QIirb3qUCwbqsFPIzG/UHm/iBgc4KBY2iMFjAajr1QKRfrVioC0woBt0h
         EOsA==
X-Gm-Message-State: AOJu0YzbXK3SSztHo0sizYmMI/NcgdCvaLeXJ4zfrhTh0Ikp3wqxcUUc
        6K/xac/moMhUTr3q5KOY3Pgyyw==
X-Google-Smtp-Source: AGHT+IGjnUmrbBcbimc96BYG8xQsuqOe5b3J9on6ITmxaJEPOgZRPGPf89pDWvV9brpasKgr1oA8Jw==
X-Received: by 2002:a5d:664a:0:b0:31f:fa38:425f with SMTP id f10-20020a5d664a000000b0031ffa38425fmr20754394wrw.9.1697036475093;
        Wed, 11 Oct 2023 08:01:15 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w16-20020adf8bd0000000b0032d81837433sm2978568wra.30.2023.10.11.08.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:01:14 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Qais Yousef <qyousef@layalina.io>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Conor Dooley <conor@kernel.org>
Subject: [PATCH] mailmap: map my old address to the current one
Date:   Wed, 11 Oct 2023 17:01:04 +0200
Message-Id: <20231011150104.73863-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I no longer work for BayLibre but many DT bindings have my BL address
in the maintainers entries. Map it to the email address I use for kernel
development.

Suggested-by: Conor Dooley <conor@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index c80903efec75..0f55f81aaf15 100644
--- a/.mailmap
+++ b/.mailmap
@@ -87,6 +87,7 @@ Baolin Wang <baolin.wang@linux.alibaba.com> <baolin.wang@unisoc.com>
 Baolin Wang <baolin.wang@linux.alibaba.com> <baolin.wang7@gmail.com>
 Bart Van Assche <bvanassche@acm.org> <bart.vanassche@sandisk.com>
 Bart Van Assche <bvanassche@acm.org> <bart.vanassche@wdc.com>
+Bartosz Golaszewski <brgl@bgdev.pl> <bgolaszewski@baylibre.com>
 Ben Dooks <ben-linux@fluff.org> <ben.dooks@simtec.co.uk>
 Ben Dooks <ben-linux@fluff.org> <ben.dooks@sifive.com>
 Ben Gardner <bgardner@wabtec.com>
-- 
2.39.2

