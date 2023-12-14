Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1512B813677
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjLNQkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjLNQkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:40:11 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A94811A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:40:17 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d069b1d127so50319695ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702572017; x=1703176817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AOk13I10R4lBKheCrtggrgfT1riocLOootjug+SJCQs=;
        b=GLR/xjzWPaYpWb2HIK1Qax6Fn6KeSaYNulQ7iDfVe6cX397m6haVKBY2SntNfc2Ons
         mxDSDv7wDlLWbAu7u6QkmAxP5uU5WxP3rHYNDx6VgstSySPeLN9qxoyYqBBEuftSFnSF
         uouOkGJo8zpL1t0XyG4SHInAeF8qAEYon0tT0D9mLBBFEA3HGqduHF+9ceY7v+hsJ7sY
         sYEnr0Dy15NjBkEiVfKLPxgoet1eSv9LLjI57zvQhtxVkVMTEuWRCAlIW6CjrEnInNdU
         pfNDDNvxyuomuwaYSHmY9GAhjZwNS5uuXfJlN48MjIvVpb3QoTpji8hXNzMhWsNtG5bP
         Cgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572017; x=1703176817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AOk13I10R4lBKheCrtggrgfT1riocLOootjug+SJCQs=;
        b=RCbnqdCeMdjMGtKPsNMRsxAngASUX3mhUAjcAUsg3ISndhFqT9dI4MuU3QjR+szdpL
         8/3OwAgFqbIAAP7ujc/FSPRb/HCF+IjevPoQLY7pjnDDO3rFMR7YEaYrP1qIpNt8BlVX
         YGHZf/jaoE/Xj7GbwW/PUxuezUk+pCoZhUQLdEL2uRKXG+FmDmI/8U9TS5qwFWa9FcGq
         1F0uaKctdFMcnWQk2zWBQyoJNtt8ib6bI5YnlTufY10KF913QImaTx7ajKCa0EGnx2or
         UxiosCS/35sot7IFx03KI7Y41C6tDtM39cq82bdY0gcauSOPg1nvghR9z1rqWUtHrJQa
         NSqg==
X-Gm-Message-State: AOJu0Yy7dkvO0HnbV/FT7CIfOVB3m8Gq+6cUGanSHZSARAfs0LH1M9Cz
        cumNOsjsry7rK1Z0iAuuYm3bS1GjFAY=
X-Google-Smtp-Source: AGHT+IEv15T3vbTNgPRePzSi1Gr4nq/3Kcrr/A6XNLKzJvGz7deF8k+16E00KoU+/YCEenGeKgwwrg==
X-Received: by 2002:a17:902:b197:b0:1d0:c345:c1d7 with SMTP id s23-20020a170902b19700b001d0c345c1d7mr5503759plr.77.1702572016721;
        Thu, 14 Dec 2023 08:40:16 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902e74c00b001d0b32ec81esm12595897plf.79.2023.12.14.08.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:40:16 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Takashi Iwai <tiwai@suse.de>,
        Lianbo Jiang <lijiang@redhat.com>,
        Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 0/3] Some cleanups and fixes
Date:   Fri, 15 Dec 2023 00:38:39 +0800
Message-ID: <20231214163842.129139-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes two cleanups and one fix.

Yuntao Wang (3):
  x86/crash: remove the unused image parameter from
    prepare_elf_headers()
  x86/crash: use SZ_1M macro instead of hardcoded value
  crash_core: fix and simplify the logic of crash_exclude_mem_range()

 arch/x86/kernel/crash.c | 12 +++----
 kernel/crash_core.c     | 70 +++++++++++------------------------------
 2 files changed, 25 insertions(+), 57 deletions(-)

-- 
2.43.0

