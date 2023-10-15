Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969457C9D00
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 03:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjJPBr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 21:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjJPBrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 21:47:25 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB043DF;
        Sun, 15 Oct 2023 18:47:23 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso1525847b3a.2;
        Sun, 15 Oct 2023 18:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697420842; x=1698025642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hSKqSeuO60jQ7suM+oaQb4M4uYV7/Tl47jargmSs7Lg=;
        b=YA4fFmc5MhQGHEiS/MMMICIWHzS6Ze0W4gWwhDswvVd8UxzXyS1An2lxv/NRmCHSBX
         e6KchBDveTRzxhwq+vb7sNbSnuzlMJwqmdQwV6dDhREPlW8KqN4o/Llu4n0ZopgEFrFw
         ptTpVuR+smmYOQe/hrfeoXzkZ37EgN1T+P0bo7QkZ9AyEPfGmiG1YRFfmQkT9u6Jyhbi
         bi8KrS05pfcHCfBZ3KwNZNTjwbMN5D/mTQ/MZvDFJIxXoW4jZSQhfixUjGMBLobSQcdE
         ln6iEjLiFuH9rb+/XLtPw6Mm6kthE++5IWi0XMrHxNO6D41HPXkb+LytS8GNf4jHZgTs
         9Mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697420842; x=1698025642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSKqSeuO60jQ7suM+oaQb4M4uYV7/Tl47jargmSs7Lg=;
        b=E1Ew9xblItQd2xseQZuMg8HBwkwhNxfV7GG4pIZeF89g8ZhRjHFfPES4R40ZkSjTy9
         MSZ0jdf4EnieHiHifM7jjUmxzFtgh2nNTRP+VbNMukC8seQztiGAr2/I6yQaU1yyl59M
         6ofDaEOJPPrBzTgAR6NbX09alVlyjSEMfW4pnBb5vLmZqjT9daJgcOKyoSLJ8W46/mea
         Wu93vbS8thovpkBgtJex6BAr8qtWy7iS8waasEkmtvQg6G5RVIfNqE7QQeHT5lT5xLOz
         Gz40/FZUIHElV10qUGXa5bUe70i7kusKCTulXhNMT296RBErm93jOMjwC6L7AkVqYQPJ
         qUxQ==
X-Gm-Message-State: AOJu0YwrhL57Hc7wkNbu5TJekwHbDhn0yfSuU3TT20OvRgGjWM4W/4e4
        SnL8ipxIlBxf4Wh9OZXYvChVsJZ4ngzzUg==
X-Google-Smtp-Source: AGHT+IHMLIF7rf9pjwvioYRBIuzk2M7M+m2yoct3aQ1m26SK20BmGGAdrlyq5R3YgkSSwNphyVxj/g==
X-Received: by 2002:a05:6a20:9152:b0:14c:5fa6:e308 with SMTP id x18-20020a056a20915200b0014c5fa6e308mr29271328pzc.43.1697420842494;
        Sun, 15 Oct 2023 18:47:22 -0700 (PDT)
Received: from ubuntu.. ([203.205.141.13])
        by smtp.googlemail.com with ESMTPSA id pd17-20020a17090b1dd100b0027cfb5f010dsm3574377pjb.4.2023.10.15.18.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 18:47:21 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     keescook@chromium.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, luto@amacapital.net, wad@chromium.org,
        alexyonghe@tencent.com, hengqi.chen@gmail.com
Subject: [PATCH v2 0/5] seccomp: Make seccomp filter reusable
Date:   Sun, 15 Oct 2023 23:29:48 +0000
Message-Id: <20231015232953.84836-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces a new operation and a new flag
to split the SECCOMP_SET_MODE_FILTER process into two steps:
load filter and attach filter. Thus we can reuse the filter.

The new SECCOMP_LOAD_FILTER loads the filter and returns a fd
which can be pinned to bpffs. This extends the lifetime of the
filter and thus can be reused by different processes.
With this new operation, we can eliminate a hot path of JITing
BPF program (the filter) where we apply the same seccomp filter
to thousands of micro VMs on a bare metal instance.

The new flag SECCOMP_FILTER_FLAG_BPF_PROG_FD is used to attach
a filter which is loaded via SECCOMP_LOAD_FILTER and represented
by a seccomp bpf prog fd. The fd is either returned from
SECCOMP_LOAD_FILTER or obtained from bpffs using bpf syscall.

Change logs:
  v1 -> v2:
    - Add a flag to attach filter from fd
    - Update selftests

  RFC -> v1:
    - Addressed comments from Kees
    - Reuse filter copy/create code (patch 1)
    - Add a selftest (patch 4)

Hengqi Chen (5):
  seccomp: Refactor filter copy/create for reuse
  seccomp, bpf: Introduce SECCOMP_LOAD_FILTER operation
  seccomp: Introduce new flag SECCOMP_FILTER_FLAG_BPF_PROG_FD
  selftests/seccomp: Test seccomp filter load and attach
  selftests/bpf: Skip BPF_PROG_TYPE_SECCOMP-related tests

 include/linux/seccomp.h                       |   3 +-
 include/uapi/linux/bpf.h                      |   1 +
 include/uapi/linux/seccomp.h                  |   3 +
 kernel/seccomp.c                              | 170 +++++++++++++++---
 tools/include/uapi/linux/bpf.h                |   1 +
 .../selftests/bpf/prog_tests/libbpf_probes.c  |   3 +-
 .../selftests/bpf/prog_tests/libbpf_str.c     |   3 +
 tools/testing/selftests/seccomp/seccomp_bpf.c |  44 +++++
 8 files changed, 197 insertions(+), 31 deletions(-)

-- 
2.34.1

