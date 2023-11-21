Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AC57F30A0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbjKUOZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbjKUOZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:25:17 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29727D56
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:24:38 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6c396ef9a3dso4714362b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700576677; x=1701181477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rO5gvBC9Yj9Gj9iwFUnYV9+FlJPZ82+bI2tRklE6bkQ=;
        b=M/kuTVt87qu0ZVJhQdMlOZPBlWefKfiRPkds/vddzN4iL6j32QUXBT68wPQRj6qWuy
         41gGIlSFf9+s0p8J+B+ZSNX+C+bBq66hdA9w71LyXK3/KFSMdXSI6FNZc35F3Vh9DvA7
         J8JOOS2+GQE6CQkS92puHF/BaXzAcqCIfZD8aRimjqnw6Zy/SUHykh4b6t1KtVYvnAw5
         3a6D3C7nh8z9qXxaWySLKMqqtFs+gQ1hVzdNnbDUL7odkMKyh65O03idtJrhAuW0uMHb
         +s+ndXS4XblI6bQ6g6e7XNxgSBKBa0gB4I+Tq2hd/TbVl2iaoDm0u0QM1EyQG/JW5lgC
         J5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700576677; x=1701181477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rO5gvBC9Yj9Gj9iwFUnYV9+FlJPZ82+bI2tRklE6bkQ=;
        b=iSFsnU+jQJw/iGKHXTBVdCyejaQIhdKs6xTXHMvP3e7r9rGCgWfXpLWvbULc1mXZg0
         7Y4rgHZZjIYwkMzhc/MOPEhg/jSbzyXelrlrU9OZ4BUIlDDtk/vQFu9JOD2csbVa9yDG
         r9W2hM1UuSjEu1/2GEPksJeJVUbdDueUWb0r47c981AVHCpVC8hiSoDda8j2Acef2Mrh
         dZ6gejqAbzS2w1YIQDOmPR5mNA4i87NpIJ/1WiqFqviiq6wQV7cYir6Nlc2FMk3sHC0C
         TxYuXewWbX2XTmYNgra6Srp8ZdSiufafxo+LzUfZdPz+h8MjmFSjFbHyUtmQaAG/IpYH
         JQSg==
X-Gm-Message-State: AOJu0YwOyBNoQHH+Z94CmMGpxE/cTlOPf4P9AHrK+g3C2fMrbvL82E5V
        c1dCh9zyxX3NPVwHbfy74O+ObA==
X-Google-Smtp-Source: AGHT+IGZ0cj3qTxHGElldELTLLVk70f7H8QJHy0DgUxvrRtGVlmmImJxGtalz8fEj5aiHrvaElF8fg==
X-Received: by 2002:a05:6a20:1591:b0:18a:716d:4ac with SMTP id h17-20020a056a20159100b0018a716d04acmr6231274pzj.47.1700576677576;
        Tue, 21 Nov 2023 06:24:37 -0800 (PST)
Received: from devz1.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id d13-20020a056a00244d00b0068842ebfd10sm7923193pfj.160.2023.11.21.06.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 06:24:36 -0800 (PST)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     ubizjak@gmail.com, mark.rutland@arm.com, vgupta@kernel.org,
        bcain@quicinc.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        chris@zankel.net, jcmvbkbc@gmail.com, geert@linux-m68k.org,
        andi.shyti@linux.intel.com, mingo@kernel.org, palmer@rivosinc.com,
        andrzej.hajda@intel.com, arnd@arndb.de, peterz@infradead.org,
        mhiramat@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mattwu@163.com, linux@roeck-us.net,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v3 0/5] arch,locking/atomic: add arch_cmpxchg[64]_local
Date:   Tue, 21 Nov 2023 22:23:42 +0800
Message-Id: <20231121142347.241356-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Archtectures arc, openrisc and hexagon haven't arch_cmpxchg_local()
defined, so the usecase of try_cmpxchg_local() in lib/objpool.c can
not pass kernel building by the kernel test robot.

Patch 1 improves the data size checking logic for arc; Patches 2/3/4
implement arch_cmpxchg[64]_local for arc/openrisc/hexagon. Patch 5
defines arch_cmpxchg_local as existing __cmpxchg_local rather the
generic variant.

wuqiang.matt (5):
  arch,locking/atomic: arc: arch_cmpxchg should check data size
  arch,locking/atomic: arc: add arch_cmpxchg[64]_local
  arch,locking/atomic: openrisc: add arch_cmpxchg[64]_local
  arch,locking/atomic: hexagon: add arch_cmpxchg[64]_local
  arch,locking/atomic: xtensa: define arch_cmpxchg_local as
    __cmpxchg_local

 arch/arc/include/asm/cmpxchg.h      | 40 ++++++++++++++++++----
 arch/hexagon/include/asm/cmpxchg.h  | 51 ++++++++++++++++++++++++++++-
 arch/openrisc/include/asm/cmpxchg.h |  6 ++++
 arch/xtensa/include/asm/cmpxchg.h   |  2 +-
 4 files changed, 91 insertions(+), 8 deletions(-)

-- 
2.40.1

