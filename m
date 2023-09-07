Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591307978F0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242670AbjIGQmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242368AbjIGQmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:42:22 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC5D2689
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:41:00 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fef56f7248so12554265e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694104801; x=1694709601; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lqxj3pSoF3AncMZtWDxjZ9oVaxPbB+dicJk5XWNSvPg=;
        b=j0j55UnGmTFatg5uqWDTetuMrrq3fBOTRosxtvhnIYNAZ4aGW43Ppx6weKkW1cxhnx
         mHhCXdJTi+8dRCJqQZrnfOEC+87nQm+mFd8q7ogr6dXwwKsMrVH/Vs4RaasGKf+MBrpo
         ApSVMFKo3hbnujiRpFJ6QVinWfOxOf/wKnuNLkLr58ZWnOGZ9cf+qrIIPnOe9+XF2yNt
         cPWi1WYZARqp4BLPI3qzTS7b4chhoGUT8av3o8X9bAz7pGHAL4H+1lYN5H3ZsZNa7BFZ
         FgeD/Ok+HjosKr8Nws/SQhUXgzXob27msr3icq9mTTF2pX4bppfWb7rmVtNrS++ElgP9
         iK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694104801; x=1694709601;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lqxj3pSoF3AncMZtWDxjZ9oVaxPbB+dicJk5XWNSvPg=;
        b=giDznDhqk/sKYfBPfEJxyCEdQ8bSR9YQdGJ1FA9nZ8EaUK1tTGmdlXEM6yUKUxJ7Qj
         MoXI7E7Kdw4fV2MWuFizBxgTD3Ac7QDqrBn6lK2v0sNdGel7qUm3SpBdXo3FqFDfDrPj
         67dXfZEXvkqgaEwmDT+UguGiqSSVPTTC/FEWZ/WX7CMzHbbO0bC16zyelQsqcWQ8cAo2
         E2E1FquLQfjP3GWWaosm2LB7H0fzH+A65ccki3BoW5tciwlzAYL5CY1smha76NHn1ajd
         oM3Cu2W1pWgy6OSuZpr78tM7r581giW1McZViXHhyEKLp4EFMckYR2mWaK5jM2JOKlyp
         r5dQ==
X-Gm-Message-State: AOJu0YzvRVhxnr6/zIsgH+NtuzgKNXlU6LACzO4rHwHKV7gLk3g8Jzyw
        JQxC6x0efNgPSagQnmJWcL+pcN+58g==
X-Google-Smtp-Source: AGHT+IEy/HRU1XAIY+5pAYgaWfxafmWtqRzIwp+xXAW8RkZHPytOs+Mm+poMzJsx84uTlLOoNDM7vw==
X-Received: by 2002:a2e:8613:0:b0:2bd:2056:ceed with SMTP id a19-20020a2e8613000000b002bd2056ceedmr4344734lji.25.1694085014795;
        Thu, 07 Sep 2023 04:10:14 -0700 (PDT)
Received: from p183 ([46.53.253.206])
        by smtp.gmail.com with ESMTPSA id f27-20020a170906391b00b0099cd1c0cb21sm10129076eje.129.2023.09.07.04.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 04:10:13 -0700 (PDT)
Date:   Thu, 7 Sep 2023 14:10:12 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Stefan Roesch <shr@devkernel.io>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH] proc: fix smaps_rollup test after KSM changes
Message-ID: <725e041f-e9df-4f3d-b267-d4cd2774a78d@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/${pid}/smaps_rollup is not empty file even if process's address
space is empty, update the test.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/proc-empty-vm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -267,6 +267,7 @@ static const char g_smaps_rollup[] =
 "Private_Dirty:         0 kB\n"
 "Referenced:            0 kB\n"
 "Anonymous:             0 kB\n"
+"KSM:                   0 kB\n"
 "LazyFree:              0 kB\n"
 "AnonHugePages:         0 kB\n"
 "ShmemPmdMapped:        0 kB\n"
