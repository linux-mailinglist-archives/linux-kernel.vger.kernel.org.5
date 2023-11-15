Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4EA7EC908
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjKOQ72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKOQ71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:59:27 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B72318D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:59:24 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77bac408851so90961585a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700067563; x=1700672363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XNv5c7iU2hI6ghC00LRA79XwFr7LnW8ceDW1TiDNSy0=;
        b=pZMEMauyBQev6kw2y3HygaW++nXr1Wg5OK7I9eIa74p059UUSMsnK4g3hHjEwwtDdh
         oK9Evz+D7rorv81RhJ+dCIMZ2qW7aqdmILba8rlTertIA8VtJdD7n0vBoWWcAzPdNC4n
         58A8CBe5AqNCj0GPXQljYLH2xGOmWgjzrwGFkee4Y0hv2Fac7gfFeh2EkhFgcp3tHpKL
         jvL8CILAffDLcRlieMXw0CLSdNQlDZ4PpCkGUlrT7PFOttVSgA3GEFm6sHs0GMSZ9SqI
         DE7uJB9X6xBvCQIcWMUodVXe/Rriu5Rpb8xrkES7mNSEdvXlzm/M0Li0YMimQm0o/XoF
         TneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700067563; x=1700672363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNv5c7iU2hI6ghC00LRA79XwFr7LnW8ceDW1TiDNSy0=;
        b=ak8+gDLeFEZGQ2a7n63k0Hhc+wFTjATqUYu24N5rz2rjXDhfZWhtVY+4KyEiLX1Fyu
         bc2LZJejFX+zYkTzHH/p6fdwnfkBnhnWzZLi5aL/pYCuUvF9lC+JxbNP3UtcsdnTxdUm
         iN/+oosFPyBvviFqV7C/+dX2SbnCTU7snow5BCW/uRbOY5ucRQEEnBMh4eUYIR9WaAjE
         y8lKKMLvI7czsn66qxyAom0nZtTCFhb3dU/ZtBMEaQ82RNt13iRXFxD+145AuibLAJVZ
         4JIDzNXnIjDa4hKSR0xp36C9rkKfWXg2dQP4ttgXTB/9/Xn5B2VuOU6uBVcK7oUuiAx9
         PuMw==
X-Gm-Message-State: AOJu0Yzi7hhpa9n5XPmOVnXURjWppKLRLqRaxOzbtyX5S71T5kyVCeeg
        f9u6GJBc/+0TOyySi2ymdPjOpBgzXt8tFHOKCPxMWQ==
X-Google-Smtp-Source: AGHT+IHGLVHQmm3aPUnsHwqUFedvCOgWo3TAh291r77vapR79AlKzlSTTm58S5i6UNilTlcmXaPazg==
X-Received: by 2002:a05:620a:304:b0:778:8f26:6846 with SMTP id s4-20020a05620a030400b007788f266846mr7192148qkm.37.1700067563410;
        Wed, 15 Nov 2023 08:59:23 -0800 (PST)
Received: from brgl-uxlite.. ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id x19-20020a05620a449300b0077772296f9dsm3572219qkp.126.2023.11.15.08.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 08:59:23 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH v2 0/4] genirq/irq_sim: misc updates
Date:   Wed, 15 Nov 2023 17:59:11 +0100
Message-Id: <20231115165915.2936349-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Here are a couple of updates to the interrupt simulator. Two are minor:
remove an unused field and reorder includes for readability. The third
one simplifies the error paths by using new cleanup macros. To that end
we also add a cleanup definition for dynamic bitmaps.

Resending rebased on top of v6.7-rc1 and with tags collected.

v1 -> v2:
- add a NULL-pointer check to the bitmap cleanup macro as advised by
  Peter Zijlstra
- initialize managed pointers when declaring them to create a clear pairing
  between the type and the cleanup action

Bartosz Golaszewski (4):
  bitmap: define a cleanup function for bitmaps
  genirq/irq_sim: remove unused field from struct irq_sim_irq_ctx
  genirq/irq_sim: order headers alphabetically
  genirq/irq_sim: shrink code by using cleanup helpers

 include/linux/bitmap.h |  3 +++
 kernel/irq/irq_sim.c   | 30 ++++++++++++------------------
 2 files changed, 15 insertions(+), 18 deletions(-)

-- 
2.40.1

