Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35E47FCE53
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 06:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376938AbjK2FfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 00:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjK2FfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 00:35:00 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1DCF4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 21:35:06 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-285699ebabcso426004a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 21:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701236105; x=1701840905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GJGmlFULS4N3cRIVwIVFin2/kLWvs6W8jV9MYbo68hI=;
        b=kLG/c7mZRd7qR471EyrLEerx03r1QjoKevv7dwmPeDjUVEro9hUecoulm/k9EF2jQP
         AGCv1xl2A5xdmTKh4rl6a7S1a46grgoTK/DonWi45bpE7ZfLTae+Lhsp5YecOHEjoXpt
         EZ81gFzo8IMUj76OAs8hJWdNFmtxbZff+COcqb8629sXrIYb/GdGeXS+Sgb0ozDp1UNt
         ZHX1eXeuwDgNZ4/PXdQ+Y27H0qfgBEjPhscM0v5B41KcSR+3RbwfW4A3X5bSTsrXX0xR
         lmc6+44CAEv7hf4R/9cp38p1hr3HIq9nCj1G+embe1scrnWaXmjfKryfafNXZE39rGH5
         50Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701236105; x=1701840905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJGmlFULS4N3cRIVwIVFin2/kLWvs6W8jV9MYbo68hI=;
        b=cLFpuJhDWCneWlWSExa3VX0uN/4WGjZBgOT0MlSkVQrt59PDjSR9yUJW5Dl7ESRYqJ
         tmQBH0BbPs5FQepo//sMKhnPRbqK1a6HqRsl9O0zrBX+n68oi5JBhKhpvJ4PaAiwVoxI
         1f62DEN7x9EwIEX8gluMSGkHHfmkgZKSvWoC+qkBr9ivYey65cJhPvxjFH1OoNk0ZYUC
         4UlV79WLPgdRzFegomkCs2BTB3OizQgpiBQEzPk44iWkfiFuQ1wr30fIsihb1ecwCY3a
         3jGjvbd/OSS/up8O3yIUOZxs6DfUlans10m/JkunlSFdHq0n2pSpDJsmasdftMQhC86C
         TKcA==
X-Gm-Message-State: AOJu0YycfCY65Ofn5LBPs4dwuYp8eVPkLtioq5dLg8ztQR71w2wFpTvG
        aJy+vCkDd+dV1NRpKvY2FH328WHeUV0x3A==
X-Google-Smtp-Source: AGHT+IE1Sb8kGBNhnveKfaCk17GnHhZ6bdw+oI2Z6WmVdgIWensZ2NzTEWWPokGqZ9hdy6OVYP/7JQ==
X-Received: by 2002:a17:90a:ce81:b0:281:3a5:d2ec with SMTP id g1-20020a17090ace8100b0028103a5d2ecmr29192777pju.8.1701236105524;
        Tue, 28 Nov 2023 21:35:05 -0800 (PST)
Received: from ubuntu.. ([43.132.98.44])
        by smtp.googlemail.com with ESMTPSA id gj6-20020a17090b108600b00285a2d14184sm660717pjb.0.2023.11.28.21.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 21:35:04 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
        alexyonghe@tencent.com, hengqi.chen@gmail.com
Subject: [PATCH v3 0/3] seccomp: Make seccomp filter reusable
Date:   Wed, 29 Nov 2023 05:34:37 +0000
Message-Id: <20231129053440.41522-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This patchset introduces a new operation and a new flag
to split the SECCOMP_SET_MODE_FILTER process into two steps:
load filter and attach filter. Thus we can reuse the filter.

The new SECCOMP_LOAD_FILTER loads the filter and returns a fd
which can be reused for different processes via UDS.
With this new operation, we can eliminate a hot path of JITing
BPF program (the filter) where we apply the same seccomp filter
to thousands of micro VMs on a bare metal instance.

The new flag SECCOMP_FILTER_FLAG_FILTER_FD is used to attach
a filter which is loaded via SECCOMP_LOAD_FILTER and represented
by a seccomp filter fd.

Change logs:
  v2 -> v3:
    - Stick to cBPF, don't interfere with bpffs

  v1 -> v2:
    - Add a flag to attach filter from fd
    - Update selftests

  RFC -> v1:
    - Addressed comments from Kees
    - Reuse filter copy/create code (patch 1)
    - Add a selftest (patch 4)

Hengqi Chen (3):
  seccomp: Introduce SECCOMP_LOAD_FILTER operation
  seccomp: Introduce new flag SECCOMP_FILTER_FLAG_FILTER_FD
  selftests/seccomp: Test seccomp filter load and attach

 include/linux/seccomp.h                       |  3 +-
 include/uapi/linux/seccomp.h                  |  3 +
 kernel/seccomp.c                              | 78 ++++++++++++++++++-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 71 +++++++++++++++++
 4 files changed, 151 insertions(+), 4 deletions(-)

--
2.34.1
