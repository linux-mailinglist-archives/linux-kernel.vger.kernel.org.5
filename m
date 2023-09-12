Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B646A79CAB7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjILI4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjILI4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:56:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57A4E7F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:56:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31aeedbb264so5672186f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694508959; x=1695113759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=92excXyJQFGvTN69dQAEa6GOS8kswxS2WllrOnDYM2A=;
        b=PHa0IMWBTjlM5dgie377KOyNLRChFEkeX+KKIlGhPTpOBYNBx4VX92MTBrVUG5OWzk
         9lXatET/wNai0Xy2PnsTma+O4kqzpFl46ZB4Z8pRA5FvBBn6Pb/233Qn8ecsOvWr7tU8
         +B1XabvzTsNjSETmTjSJr6IhII2LLapQnZsx4pjryDUlwc5hcDadGcvgpvthhdpOCk4O
         cyoaIWmBBE0PwbN45SeZY7iFX/KFAKA0/UJqWSTpKtDitkbwjNEU2bxB5F+CX+DYICa1
         mRIdsReK3DD+9DiV1kcBYoJKwgEtSa4LQ+CLyikzRtcvJV4JK+VJiLa0XQW9/ohK6/Yo
         BOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694508959; x=1695113759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=92excXyJQFGvTN69dQAEa6GOS8kswxS2WllrOnDYM2A=;
        b=gocjzPmgY0qHMeEvqHke2SNO5iKTqiogLLBvKDYb5XwzqeHXY9Je0j4CIUOvf+KNkd
         /gOS3HrBtmxnon7nXaEGRLHEMv/5RdpgZg03CqE24dB/V7f0Olavly/TTL1XgxUZoBJE
         MQ8wTiaCTeGXBmjeMLgCYJN9vG5O0TG1SzMS4ZpGpH2uZ3WfEOxmAFEv0JhT/EqN0WPp
         LbyMg4HTRm5BzXC3+YhPk7x7e46qx2vZrkmCIiut9iLK6QIVT0m33E+0mx5Br4m2aMHy
         AjLmkuIJ9E6bCGSIjIszV5l1sf+4lP2aczq/GjRKrvkvchnrLnagOBk2cN5eqUZ5t8dd
         Innw==
X-Gm-Message-State: AOJu0YynW96K62uNKZBqgQiLdAUC5ptXgdihGzebf+oEk6BgOzygoKa8
        6LRDocmwKIEpg35exgRvfPVyXcEvFZRZcb8sDFY=
X-Google-Smtp-Source: AGHT+IFRjI/x+Jmc5Q94OsQkHRLE8tyx0JeX29UHDrM4jo1OEYA8sbLfGy2CNeEOnfRK+0D16hH2GA==
X-Received: by 2002:adf:f6c6:0:b0:315:a1d5:a3d5 with SMTP id y6-20020adff6c6000000b00315a1d5a3d5mr9479120wrp.22.1694508959066;
        Tue, 12 Sep 2023 01:55:59 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:907f:4cd7:f0ae:6b2a])
        by smtp.gmail.com with ESMTPSA id d6-20020adfef86000000b00317ddccb0d1sm12310028wro.24.2023.09.12.01.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 01:55:58 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 0/4] genirq/irq_sim: misc updates
Date:   Tue, 12 Sep 2023 10:55:37 +0200
Message-Id: <20230912085541.13682-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Here are a couple of updates to the interrupt simulator. Two are minor:
remove an unused field and reorder includes for readability. The third
one simplifies the error paths by using new cleanup macros. To that end
we also add a cleanup definition for dynamic bitmaps.

Bartosz Golaszewski (4):
  bitmap: define a cleanup function for bitmaps
  genirq/irq_sim: remove unused field from struct irq_sim_irq_ctx
  genirq/irq_sim: order headers alphabetically
  genirq/irq_sim: shrink code by using cleanup helpers

 include/linux/bitmap.h |  3 +++
 kernel/irq/irq_sim.c   | 27 +++++++++++----------------
 2 files changed, 14 insertions(+), 16 deletions(-)

-- 
2.39.2

