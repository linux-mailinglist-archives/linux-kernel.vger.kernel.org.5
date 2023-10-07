Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DBC7BCA76
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 01:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344247AbjJGXh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 19:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344151AbjJGXh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 19:37:26 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE543B9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 16:37:25 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c8a1541232so4660475ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 16:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696721845; x=1697326645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AcoIRVvTXnvwMcYFSm/QUis00b0lHBXCtKWnoNH1HVY=;
        b=F5IoFsoGEYyCAfc0gtO8SZLxtrCcsKtvGmrUqB+8T90pE0ALDEh0cwDemwM50TxT+v
         oenKGp0T6kfEIY5VA/B1cjZn+XNXogHmBEoxl+Bye+5wsXXfpnoBNTCuxHUwZazsxLyg
         MVRvSQbp/SUehpLWcr+NVcGG0WY14F9Pf0zUR1mNMb7T3/XraCXBdaZjjtT8keiEVAAL
         iHSt2ntku+to18Jz8Mf68dKIXTvYDLvD6cQELQ9sRjvaa8ZywnLUTgBfoPEd6SghtGwa
         UcIysMAnqeC8PaUiX7m7V2zaHlOfp1WZyI9zI9wnDfoT1rO0nV8AQIGhbeeaynd54T1J
         BJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696721845; x=1697326645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AcoIRVvTXnvwMcYFSm/QUis00b0lHBXCtKWnoNH1HVY=;
        b=kPaRrCuzLS0EKOsD8Cmxt2XbS1eYXbbg6VXZR0QRkS1ucuf1zWA+ZvEvACExFClKM+
         g3GxL+8m5E1LNk7eAGIYnfcvjpXfj+3Z0BUJdqZXT8K459ZL1x9TZ7eWO1XEy2hfmN+7
         M+bSYTeWkeI0drJ66jBYmH7aaKfvUQiQ5MYcaaYlYHC07zRoNkfwcLLf70/wtD06BqAT
         As+igXMZG0gFHanjA9MMQtlcjqk2DyELGYCWv5/GSRFx0kim3d0Sy5f+4DUbXSAQSLti
         hm3ofl8hPg2K22Y3Pv6gg7j1gi39w4HqVNh2kiN3ZzWqk+BboTAFvWQ/jeYns5WMJG24
         2R3g==
X-Gm-Message-State: AOJu0YyRvHdtV2RcvX+Ilk5GaoTVNxkVIzi+PVkROko2yPWbZ6GgOQEA
        GZv3K6xvb/3IBzV4yF1acFu69CxuYFC4uA==
X-Google-Smtp-Source: AGHT+IGEgBTKBBGlcmYQCZU8UlL4mu4x4m/hwsuXWOII8d8HRGGcLOiL5k7qYo4NVVwBKsDpm+k11w==
X-Received: by 2002:a17:903:2348:b0:1c5:fab7:70ac with SMTP id c8-20020a170903234800b001c5fab770acmr15607353plh.27.1696721844719;
        Sat, 07 Oct 2023 16:37:24 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902b28100b001bd28b9c3ddsm6424021plr.299.2023.10.07.16.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 16:37:24 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Seo <james@equiv.tech>, Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Marco Elver <elver@google.com>,
        Mark Brown <broonie@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Rae Moar <rmoar@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 0/2] lib: unload lib/bitmap.c
Date:   Sat,  7 Oct 2023 16:35:08 -0700
Message-Id: <20231007233510.2097166-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file is intended to hold functions to operate on bit arrays, but
this days, more than 1/3 of bitmap.c is helpers for bitmap-to-string
converters, plus some wrappers for device.h.

So move those out of lib/bitmap.c in sake of readability and
maintainability.

Functionally, this series is a no-op.

Yury Norov (2):
  lib/bitmap: move bitmap allocators for device to linux/device.h
  lib/bitmap: split-out string-related operations to a separate files

 MAINTAINERS                |   2 +
 include/linux/bitmap-str.h |  16 ++
 include/linux/bitmap.h     |  25 +-
 include/linux/device.h     |  30 ++
 lib/Makefile               |   2 +-
 lib/bitmap-str.c           | 510 ++++++++++++++++++++++++++++++++++
 lib/bitmap.c               | 545 -------------------------------------
 7 files changed, 560 insertions(+), 570 deletions(-)
 create mode 100644 include/linux/bitmap-str.h
 create mode 100644 lib/bitmap-str.c

-- 
2.39.2

