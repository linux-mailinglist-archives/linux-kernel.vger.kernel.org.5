Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2293180931B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443934AbjLGVIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbjLGVIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:08:50 -0500
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56D21716;
        Thu,  7 Dec 2023 13:08:56 -0800 (PST)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7b701f86c3aso27832539f.3;
        Thu, 07 Dec 2023 13:08:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701983336; x=1702588136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5ItdRbOqpANKaixOSJQmbB0WAG359l9deHn4U60E+o=;
        b=Lmg5BMDar17AVm6TSYea0Y4KW8SB/XL3hDipufb3z/+i72guz/j2SbqQpBBZA29vT/
         wjdcR6DM332daH+gx2+oey6oDZuIMBwnVC20+7JwYJeMCPDCnpPZbS5/ZfIE6c7zHAZS
         RG4syzkUGRRK/homcAsg6BfW6aT3NbV4hQalO8px3gjap1yScw12xN4G5sZ4Fy/qrJf5
         qbvk/5Ym48mP5ICzuzeTl/3EDdezOmCdRUd++JEbtpaxsGZX2pWHKzDhfwWy+M19gZE0
         86MBr4dl7bgmtir5DkoyAd2eCQRmFMazPOycTz0hIoeaBATasFW1kOHlrV33hAa/3WjN
         tsxg==
X-Gm-Message-State: AOJu0YwBGL+9fPJ7rd/RbCPF24oQqhHUN4E2hgUXPJCeTiVNTO0ilQ1d
        ikmve6r5PUIPhyTw14PJV9zxWQoZIU2MP1F8
X-Google-Smtp-Source: AGHT+IEm+k29lpdyAM/25MP/3vYQ4ardejaj/bMf6jxfTyZCm14FlRtYeKcYn5o7OkuSDQK/TVKBRA==
X-Received: by 2002:a05:6602:29ca:b0:7b3:7caf:4645 with SMTP id z10-20020a05660229ca00b007b37caf4645mr4253142ioq.5.1701983335546;
        Thu, 07 Dec 2023 13:08:55 -0800 (PST)
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id w10-20020a02394a000000b0046685d57f00sm117977jae.110.2023.12.07.13.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:08:55 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 0/2] Add new bpf_cpumask_weight() kfunc
Date:   Thu,  7 Dec 2023 15:08:41 -0600
Message-ID: <20231207210843.168466-1-void@manifault.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be useful to query how many bits are set in a cpumask. For
example, if you want to perform special logic for the last remaining
core that's set in a mask. This logic is already exposed through the
main kernel's cpumask header as cpumask_weight(), so it would be useful
to add a new bpf_cpumask_weight() kfunc which wraps it and does the
same.

This patch series was built and tested on top of commit 2146f7fe6e02
("Merge branch 'allocate-bpf-trampoline-on-bpf_prog_pack'").

David Vernet (2):
  bpf: Add bpf_cpumask_weight() kfunc
  selftests/bpf: Add test for bpf_cpumask_weight() kfunc

 Documentation/bpf/cpumasks.rst                |  2 +-
 kernel/bpf/cpumask.c                          | 12 ++++++
 .../selftests/bpf/prog_tests/cpumask.c        |  1 +
 .../selftests/bpf/progs/cpumask_common.h      |  1 +
 .../selftests/bpf/progs/cpumask_success.c     | 43 +++++++++++++++++++
 5 files changed, 58 insertions(+), 1 deletion(-)

-- 
2.42.1

