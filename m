Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB1E7B3BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 23:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbjI2VMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 17:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2VMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 17:12:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2551B1A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:11:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81a47e12b5so22936248276.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696021918; x=1696626718; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qI6+evphp8TRNLDsXrgWEBj/E5cavHWN+P8xd8/8MDM=;
        b=y/UdG2MqC5fvONoyKdRitZqNs15vbQ817qWjX4HOBdQJgESSeOOMmSBjA/onQo2GS0
         eP1AfXZRsbFcCXkEzMPhXldDWlHGu4gOnZEemkqXmtU8DfFQg5Kn46Di+w14c39C3C8l
         1tEQDjPST0Gbm5WXMPHT6ahp9+qgggG/lykFw48LHwBRZcwUxkNNz8g5Rf2F7NKPO4Av
         nY9HZJ3Yw0wemkNts32PjdQ7r675gPFTgkcLHkN6NsthWWRQHPiqHYMkzfXJgnfVAUF6
         9pgyluQW/14RDjOFPZBVGPLtG/BX0okXM+tCzsQUh76XcHCZbI6/fj5efpPrp7egJ/0v
         j+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696021918; x=1696626718;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qI6+evphp8TRNLDsXrgWEBj/E5cavHWN+P8xd8/8MDM=;
        b=H7j14BebSF/1U0miTAGb0qkIaajwlFR2dx/rPeQ79r2gy3HfsGHJI/KMLRBBmxWQ12
         dP3znhgkmpoEYuNUGma1xwo89O6xpVQFvWYU/XFzYd9Cf0DUynY2YZEWf/U97xk5IS/K
         9Scg1cmLpg8qkc6xwqdqsmqOwr50M8DTUJoM+Fsf/LSqAAhlAt7jfvzKj51Q6Jidk28d
         PxJYJ9Gc7jhqpAlrH6DlpOMOhehIGRlA19+sBOyJBjN2eFbFz63lyfXhopxANvXPM+pn
         Y34MQ9FO0w5jXepZk8ZIRi/38gV1v1z9Kuoy+dnDUlAusq0aohQ7x5dYqWMM7iD+94Km
         +lhg==
X-Gm-Message-State: AOJu0YxZp2oYz64zoWXqqAfxwBrkZySiKj0qKBuJm9zAvM6YhCM7z1jO
        6BhuxwAE0TS0fZnMmCZ0Xd4VJqHqRSmgKQrvRx4=
X-Google-Smtp-Source: AGHT+IGjD5ILJnbbyCB0lpaKNSDkrgUS5mwaokgtSD8CjgjpWZhKS+xQi/ZyvDLcSGZs4gGR5Nixr3sWaAppp9HPVPc=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a25:ad0a:0:b0:d7b:8d0c:43f0 with SMTP
 id y10-20020a25ad0a000000b00d7b8d0c43f0mr85777ybi.11.1696021918263; Fri, 29
 Sep 2023 14:11:58 -0700 (PDT)
Date:   Fri, 29 Sep 2023 21:11:56 +0000
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=727; i=samitolvanen@google.com;
 h=from:subject; bh=Ko6nN36PGlYW1laUEIPPBze9YPFWfBooBOFzOjRaBRQ=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBlFz2b825e14pVS6UiwTyLbmjRM7MleUeCEvyhI
 HQ9Yi7cABWJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZRc9mwAKCRBMtfaEi7xW
 7p9uC/9v8/6JNqB5Fbep/hRFQKiCO/kScjQBMmlHvInQfP3gwUfbFCkkKYSVRSOR4Pxeo+/um1b
 AFvQRu8TawGoy7GtfAlC2T/3RZQcj6xNwU/+K5WHsVdfqZNa6xsNhtBstdrsW91ELm7X4wBhnPs
 9dYkZsrMXL8JtJvTDL1VQ3EjQ/tTab3SiJiqIF2J694+4vXbP83KGUAsC8z11QRsfCkb9V0cHNb
 qMaWfvoF2E3/MtrWUF/VlddoLs+4VfwsIz2eTQZm1X5Ll3CAeOMw8TmTQqQ3OT2OM1kJ1GKFGjs
 kpo/58zC+ziTSyL0rCbs4jrdHHMyEYwJ50108kvKlUuWGKE1joh0omULdtzfezNnIwzMPwuVnD+
 4eCKnZSAXhZxbKFAC20jcgErpJusDmn0lx2CNHUYsVuPL58GkYaK49lTYq09WuoCRWjrP+iv4BO 5JlmAMEmM6FrNg93Mj3ALgwQi7uUk7LHPkg8Rs7a3cO1p1MoInq21V6B5zk6DfXYcBSdA=
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230929211155.3910949-4-samitolvanen@google.com>
Subject: [PATCH 0/2] riscv: Increase mmap_rnd_bits_max on Sv48/57
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We noticed that 64-bit RISC-V kernels limit mmap_rnd_bits to 24
even if the hardware supports a larger virtual address space size
[1]. These two patches allow mmap_rnd_bits_max to be changed during
init, and bumps up the maximum randomness if we end up setting up
4/5-level paging at boot.

Sami

 [1] https://github.com/google/android-riscv64/issues/1


Sami Tolvanen (2):
  mm: Change mmap_rnd_bits_max to __ro_after_init
  riscv: mm: Update mmap_rnd_bits_max

 arch/riscv/mm/init.c | 6 ++++++
 include/linux/mm.h   | 2 +-
 mm/mmap.c            | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)


base-commit: 6465e260f48790807eef06b583b38ca9789b6072
-- 
2.42.0.582.g8ccd20d70d-goog

