Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF64B804CC4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344822AbjLEIkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjLEIkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:40:14 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99519C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:40:20 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d05199f34dso23335205ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 00:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701765620; x=1702370420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcOt9kZ7JwOzYfmxC1M3J+r83lE9sNFYqBWrLheYTEI=;
        b=jwF+DbD/Ephd//3womWRnnglgslTXg9EV1kA/dzvVrofRK595jZhBGK6pNn0ygtRw8
         JrNX5JiTIygh9k2WEElLWBs30cpyX/kQPibKqIz+TH4GL12s7A7XFfENW5w/ajac8ojA
         WF9m0DkV33c77Q5/EANrL7ohXnbrOKeYDu0+nk0IzMAK5kJNhf4kqroe1BnjNdfPhHoM
         B9dWRZxd+fKUCkmgq1iICtGI84VpihDGtKM9Ai2fq/9apYBMpr2iX9738rSmcvY8j/8U
         RzIB3i85yCuPvndWJ16D5CpyqTNml0G4Iqdk5qJD5zZLSQRcBt9cLHrsDbXkBUayj4GC
         N3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701765620; x=1702370420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcOt9kZ7JwOzYfmxC1M3J+r83lE9sNFYqBWrLheYTEI=;
        b=flD9c2PCFT6ra0tEA15ovRRcnfE0QnmLBd/0NCPPaTU7Rd+GLxFFtHb5vOMQ8Std5f
         MbrjmQBnH7oCulQ9Yddjoq+jiPCwSNXCVz76JjeqaK+kGxZtnfcf7gJOUjkTQttqvplX
         vw0wjpBTV5NGd4THKlk3tkMVC4+gLWv+bOcAFtr+aEEdY+r8QMdEz/nvhgM+8FhsoWwD
         gb4qIvOuLh9B2NhEj/XorOqhHxiHCyoggMh+wyB8bAuOAcOic2vNFtremb63wZJG4vlz
         yO1BLOemdhzscmuRzZ67As6FZqU5+uXcSb03QcPi7iKilQmJuxQjIM9s5wHOq1nyFtjM
         Yq0Q==
X-Gm-Message-State: AOJu0YzvoRRXYdIzXHbzS2a9v2VL4ZtxPPBXXdKA0GEAlH8TW4HnjTUv
        NdqsmuP6BtgtR7aEJlOIjvk=
X-Google-Smtp-Source: AGHT+IHmnuPSA5vDhvTN2q7m76YrUL9IBN13qxkP8NbJPkMPDB5t7fk1kexsJFn//w1XFxKTXX4Idw==
X-Received: by 2002:a17:902:ec8f:b0:1d0:6ffd:6e55 with SMTP id x15-20020a170902ec8f00b001d06ffd6e55mr2466177plg.77.1701765620061;
        Tue, 05 Dec 2023 00:40:20 -0800 (PST)
Received: from DESKTOP-4R0U3NR.siflower.com ([2a09:bac5:6249:183c::26a:82])
        by smtp.gmail.com with ESMTPSA id h14-20020a170902f54e00b001cfd2cb1907sm2998238plf.206.2023.12.05.00.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 00:40:19 -0800 (PST)
From:   Qingfang DENG <dqfext@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] riscv: introduce RISCV_EFFICIENT_UNALIGNED_ACCESS
Date:   Tue,  5 Dec 2023 16:39:24 +0800
Message-Id: <20231205083924.48933-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203135753.1575-2-jszhang@kernel.org>
References: <20231203135753.1575-2-jszhang@kernel.org> <20231203135753.1575-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You may as well remove the -mstrict-align CFLAGS in the Makefile, if
this option is enabled:

--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -108,7 +108,9 @@ KBUILD_AFLAGS_MODULE += $(call as-option,-Wa$(comma)-mno-relax)
 # unaligned accesses.  While unaligned accesses are explicitly allowed in the
 # RISC-V ISA, they're emulated by machine mode traps on all extant
 # architectures.  It's faster to have GCC emit only aligned accesses.
+ifneq ($(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS),y)
 KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
+endif
 
 ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
 prepare: stack_protector_prepare
-- 

- Qingfang
