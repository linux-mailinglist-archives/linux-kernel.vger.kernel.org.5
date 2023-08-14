Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D9B77C137
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjHNUCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjHNUCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:02:22 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C036910E5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:02:11 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1c4d67f493bso1215648fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692043331; x=1692648131;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vfRGFHRblVYm9a4Zjcxv2SCcEUrJ5g3lq6KKqWpPSec=;
        b=lDXYOI3eqyv2pAGd9fdn+sbA7tEtD1U4ZnyxWf5DmxG+/pG4TaMd9si5JjxV+Y4elW
         QvgOMxk3NY7c9BnKG22wjYy//1uPNmxeNb9pDlpqRqy8cAieAlY5mIjfXRi0Ut1Uh+1w
         5JQrpwcdY/7Ev4qoTy7WGyScS8UOWj9apJda3pbd2KkeO9zP9CVQjFBL+VzITKto60yk
         hhbdoUn7Vej+ExjmddY71eQ1JeHAyKipqNoT8sPuvBZDTfZFFRj/scEnEu4uRwc4Mr3l
         5gGyuCkGmIkee0EzLlxak+SxDLmi+DKJZMjYb1+hi2RfaiKUGgHwYojlM/stqeS1ZaXD
         kSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692043331; x=1692648131;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfRGFHRblVYm9a4Zjcxv2SCcEUrJ5g3lq6KKqWpPSec=;
        b=OmghxXMqN+1HC3ZLyZXjJL7MVgfzRVLzoQiTi13UYlWF/Um2JhS5byv4Aj/HK1Vod2
         4CrCUP86bAkqA/xYecDCeVjGz+utN/fKxq8yh7rr2PfhGRE+pkz8RoYUM6mAqzKSIhYT
         iX4fNpVF7r+KP3UmkYBz2CPRQ3ajS1wf/dIiYVJ4y26igbB2vLYN8cUkkvSIa2OEzHh7
         7uNQ5KcNFfAP6h1ER92Kipd3APPwpWgv9/QYV2tPe7GBU6x0W1JYJZiepD9riaSvyABT
         AJQYEG65KSjpyQgLgXsThvah4OX5xktu8O3VNxwIaF9dj1Z2xnvTx+KpcrDZWgnI57bI
         Itng==
X-Gm-Message-State: AOJu0YwYeckL2Us4kvDMb6vPF1tlw7S1DEyeTJ+GwIi9sxDlhpUlPEKs
        sv/LnfumKzUsx+I9PHcaDGeeSg==
X-Google-Smtp-Source: AGHT+IHC+0qdqxsysM02okguYcvI1jvs0bLxTCBtuuiFTVTXL1MJdj93jH7snfqXUjweHqeLCIdazQ==
X-Received: by 2002:a05:6870:e990:b0:1bb:8483:a807 with SMTP id r16-20020a056870e99000b001bb8483a807mr11104238oao.44.1692043330522;
        Mon, 14 Aug 2023 13:02:10 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d63-20020a0df442000000b0057042405e2csm2970168ywf.71.2023.08.14.13.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 13:02:10 -0700 (PDT)
Date:   Mon, 14 Aug 2023 13:02:08 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 3/3] mm,thp: fix smaps THPeligible output alignment
In-Reply-To: <dc264fd6-40bb-6510-db36-9340a5f01d94@google.com>
Message-ID: <cfb81f7a-f448-5bc2-b0e1-8136fcd1dd8c@google.com>
References: <dc264fd6-40bb-6510-db36-9340a5f01d94@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract from current /proc/self/smaps output:

Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:    0
ProtectionKey:         0

That's not the alignment shown in Documentation/filesystems/proc.rst:
it's an ugly artifact from missing out the %8 other fields are using;
but there's even one selftest which expects it to look that way.  Hoping
no other smaps parsers depend on THPeligible to look so ugly, fix these.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 fs/proc/task_mmu.c                           | 2 +-
 tools/testing/selftests/proc/proc-empty-vm.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 51315133cdc2..15ddf4653a19 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -855,7 +855,7 @@ static int show_smap(struct seq_file *m, void *v)
 
 	__show_smap(m, &mss, false);
 
-	seq_printf(m, "THPeligible:    %d\n",
+	seq_printf(m, "THPeligible:    %8u\n",
 		   hugepage_vma_check(vma, vma->vm_flags, true, false, true));
 
 	if (arch_pkeys_enabled())
diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index dfbcb3ce2194..b16c13688b88 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -82,7 +82,7 @@ static const char proc_pid_smaps_vsyscall_1[] =
 "Swap:                  0 kB\n"
 "SwapPss:               0 kB\n"
 "Locked:                0 kB\n"
-"THPeligible:    0\n"
+"THPeligible:           0\n"
 /*
  * "ProtectionKey:" field is conditional. It is possible to check it as well,
  * but I don't have such machine.
@@ -112,7 +112,7 @@ static const char proc_pid_smaps_vsyscall_2[] =
 "Swap:                  0 kB\n"
 "SwapPss:               0 kB\n"
 "Locked:                0 kB\n"
-"THPeligible:    0\n"
+"THPeligible:           0\n"
 /*
  * "ProtectionKey:" field is conditional. It is possible to check it as well,
  * but I'm too tired.
-- 
2.35.3

