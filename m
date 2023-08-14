Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC0E77B59D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbjHNJhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbjHNJgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:36:46 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B79E61
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 02:36:28 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso3649369f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 02:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692005787; x=1692610587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bJqXGCy/gpr1h/aO3Ck0Euv7gooGxx1elpuOZaq8EvE=;
        b=LyLXa2V4NI6PO4VZFVGTWc0e8Wsz3VR38cS1s9jSyivCPz8OQhvGMxWr4nQFpcKiTY
         yAgp53thwMTUdth1yteKIiiJzNMazdvc8BWgzvsT3Ow4ZSW/5VhzpClshf2l4aFJ3ORo
         7YM1Xp5sjHt5azbb7hOhNC59z0p51T0PHvRTCJiwgpK4epqqF0IymkbIlRIPGUKPhtPG
         yn+IvVSgzkna02IJzbvJeuPD08wbqsgj3nGVi+dPcWuJ6iBl6QXhLrxfsqBKgF47QRqI
         /iwyjYT1MQ1CJeJnnrU+ezPUMTrjSNBbCfxKc6HyqP8vTw/bpFSc7luYF3jgUlCNbFCN
         VjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692005787; x=1692610587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJqXGCy/gpr1h/aO3Ck0Euv7gooGxx1elpuOZaq8EvE=;
        b=LUrbP+Y8RhZ2GJir/4er+SvyEnlX0F7XYekW9bKh/YqOYmVfV5KR5dO5bsEA5AcaGU
         Odz7QnGX8KM6BsbshRFztcpkJICyCZZxdzkbYnj+/9RyM511XhFT4o7i9KQKbg0Y59G2
         vkZjiXDrmKf/tg44P3EFxzqv3dZ9k6yb+aooXIWX3H95X4PJrWUOSRlnJRicu9bHPhJc
         nwlYKEKFqh3nOETUzA7/XMUnAJDR86B06oors+0GjXw67mqqDngOtXhq2/yyFozNr16K
         2UDSsqbOKFWZ7qRH6B//Z1UCelWoCS+jLftoRLA+FW0mhByHu4OA8txBH3/WnQdSu8JB
         RPLA==
X-Gm-Message-State: AOJu0YwBmVPcF64jR9u8l26yCFFAPP26DNn8nG8po6FUAvway00eqUxx
        7z5t9oP0kq9k/6MwOGJkMDmxtQ==
X-Google-Smtp-Source: AGHT+IGXzpFP+wCix5rhry+kBUP3478TyP2zcbcYlIOJKV9gcRop9rco5u3EZKBVMLES/vkv3YrcZw==
X-Received: by 2002:adf:f590:0:b0:317:5ddb:a8bf with SMTP id f16-20020adff590000000b003175ddba8bfmr5819049wro.29.1692005786371;
        Mon, 14 Aug 2023 02:36:26 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d0cb:d23e:f2fb:62b4])
        by smtp.gmail.com with ESMTPSA id d17-20020adfe851000000b003197839d68asm2422140wrn.97.2023.08.14.02.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 02:36:26 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 0/2] genirq: don't leak handler procfs entries
Date:   Mon, 14 Aug 2023 11:36:19 +0200
Message-Id: <20230814093621.23209-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

When we remove the procfs entry for an irq desc that's still in use, we
leak the procfs entries created per handler. We need to go through the
irqaction chain and remove all entries before finally removing the irq's
top procfs directory.

First patch drops an unused argument from unregister_handler_proc(), the
second fixes the actual leak.

Bartosz Golaszewski (2):
  genirq: proc: drop unused argument from unregister_handler_proc()
  genirq: proc: fix a procfs entry leak

 kernel/irq/internals.h |  5 ++---
 kernel/irq/manage.c    |  6 +++---
 kernel/irq/proc.c      | 17 ++++++++++++++++-
 3 files changed, 21 insertions(+), 7 deletions(-)

-- 
2.39.2

