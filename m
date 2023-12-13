Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE58281131C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbjLMNkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbjLMNka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:40:30 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4362C95
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:40:36 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3333074512bso4265440f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702474835; x=1703079635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AqI6GpSVQ+KOsq7aMEboneAXW3QEiN4V6nA9DvKqtyg=;
        b=Qqm7aIQYkZ5UKTONyYMCb6AA0xtqlk/9n8YEkH+J8B1JjrfiWbFZ3ZPXIT7lgZY/2u
         roT6y019g6pY0NNqEzP7cc4R+8GuknGideKciMWlbNIObnV2DKT6ZY/OPoRI1fDgt2f4
         Dlm9jpnRDBcFb3upHqydwBmGIrrLQEWdq6YHhssNq3CLJ8NnTN7s1b7yWDYKSBnQQi0T
         muyIVO6KqaD2Mmb3iOETE8EIalVuJeVtEzrue7TksA+dwqVCN1lyA6pXGnUV2vroL4kg
         RfKvuLNJP3tvoWidVX3rom54MkRc1sjN4UowE8cXFSCR2CW8lvlNKH+sz16hu4YRwfT7
         P+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474835; x=1703079635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqI6GpSVQ+KOsq7aMEboneAXW3QEiN4V6nA9DvKqtyg=;
        b=mXJp0gyLhkF+3MqKpLjeV10X9iT5mt7xQ5kUpxwNIdnPoZtCtuojzoIpXHYb1YG7io
         YRaKuEUafXZGNcgLcBBvk44IM+LkNvkZ/57HpHPDZZFK9f9/+pdz9QuDhPhLRradfv+c
         CDiympTImy31pL29Dbfcs1VkGV6JgWmpxyE+13eGtmJPlHSEBkETr5vaCxRZz+JL+ajD
         C95PW+iqOpWyjLaB/U+L1RzRGY1ljbeULWqyJ2Q/d1LIfa0mB1oABLLp64vXdwIqWPVR
         8+kr1kkJqgLyzXX0LW7loD6Ph6czy7eOgKdeiCauzty4EiFM5G/zqmSuRb45B8DNZgvs
         pEDw==
X-Gm-Message-State: AOJu0YxPVgxSPQXacrGX2QsgP1gycYw0SQyd4lWMRw31EadZzFL1JQvx
        dMb/Z3OF127PSW5jiy4PNu2bqw==
X-Google-Smtp-Source: AGHT+IFin2DG3KbOxzu8WGx9JWd1F8tLUwCZ8e4XQByR94yAhouvmUlh/NTRcf4WjOUyvcSF1HxEPg==
X-Received: by 2002:a05:600c:2a41:b0:40b:5e56:7b67 with SMTP id x1-20020a05600c2a4100b0040b5e567b67mr4163912wme.176.1702474834584;
        Wed, 13 Dec 2023 05:40:34 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id b16-20020a05600c4e1000b0040c310abc4bsm20892540wmq.43.2023.12.13.05.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:40:34 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes 0/2] Fix WX mappings in the linear mapping after module unloading
Date:   Wed, 13 Dec 2023 14:40:25 +0100
Message-Id: <20231213134027.155327-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I fell onto a bunch of WX mappings in the linear mapping after a module
gets unloaded, this is because our module_alloc() does not set the
VM_FLUSH_RESET_PERMS flag (patch 1) and that
set_direct_map_default_noflush() must clean the X bit (patch 2).

Note that the Fixes tags are correct but patch 2 will fail to apply
since a change in this function just landed in 6.7.

Alexandre Ghiti (2):
  riscv: Fix module_alloc() that did not reset the linear mapping
    permissions
  riscv: Fix set_direct_map_default_noflush() to reset _PAGE_EXEC

 arch/riscv/kernel/module.c | 3 ++-
 arch/riscv/mm/pageattr.c   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.39.2

