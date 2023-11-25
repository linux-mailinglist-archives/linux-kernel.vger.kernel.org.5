Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C0C7F8956
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjKYInC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKYInA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:43:00 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19DEE6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 00:43:06 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b844357f7cso1631276b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 00:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700901786; x=1701506586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7HH2pxIh3nFi6PgmibuEVDY9PSlg1zWmdehxfnJOthE=;
        b=HozOdHTidnvXz+6zbgktJW2ePFhpn3MzoGuGF+AEc4ueOTzg68BVWj5IyR0dYsmvDO
         7EZ/UgKmStDBuxM+FU6nvjYVSLA+GDuJYakqYLKzvVFEf7IqgN5MoWzzbpEaf9pzRtA7
         e5aP0lEglX0R0o3Ck4o2TR0PXe371+wwkJN+UTre+XST547MrcvKhSBkZYwxllrFjKWI
         m5gk51cgJx6rQKnqgrBz2yzFW6A9cp5quM9uktbqfIsEL4+uNgYq1W8y6qaQbNKNu/pE
         uXEVpgBMN/uZx4UTtVvd3pe13tRbOwAdWJYuRL8ECikdP5POJ1AXqr1d48IA5I2GT/+q
         CZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700901786; x=1701506586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HH2pxIh3nFi6PgmibuEVDY9PSlg1zWmdehxfnJOthE=;
        b=GR5oNNWMgez4w56+a62YCTpY/qyvJ07n44TLc+HM1UjIh6rhXtYMTM4TFtwyO8U53m
         DdDjDGdNTuB5MaSMC1Ch4O+2S7tKCcsGYQpByv2bf7GpY1KvyuRQSHd8xVAy0yGhj6KO
         AszF6AXHQcMJauKDIxjB+0YOHujgFscCsadJUESVbNMZHp/QUAtsct+AZgCEvsQf+sSY
         F8YAEDpDSortIIGIfgQ3NPvTBZj/3ZsICtAzzll9Q5yaj/jyOmzzghVc14+j7eE19/hV
         7kc4aiZreoH2wbtJD7eUsbJTt8JNt4A/cWAkF8g/ZhfTCbodnSQWDNTB+F1BFYZOe8g3
         DMwA==
X-Gm-Message-State: AOJu0Yy2bmVK0WUyML951BFqT5pKSWXFoHYfQ7yjTrGF/Vw9Bms8L8+U
        TVSNX8TzMMeEFXNlKSp5Y+Od6A==
X-Google-Smtp-Source: AGHT+IFmZhHL5cLpP2WUD/tuxlPb1Nw3FRYAI7O7Swcj6l2uZNuYbQz1/jSNINvtK+tOhi1SIoMNZg==
X-Received: by 2002:a05:6870:7028:b0:1e9:e97e:24e5 with SMTP id u40-20020a056870702800b001e9e97e24e5mr1002542oae.20.1700901786025;
        Sat, 25 Nov 2023 00:43:06 -0800 (PST)
Received: from localhost ([157.82.205.15])
        by smtp.gmail.com with UTF8SMTPSA id e13-20020a170902d38d00b001cf5c99f031sm2451130pld.283.2023.11.25.00.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 00:43:05 -0800 (PST)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Nick Terrell <terrelln@fb.com>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH bpf-next v5 0/3] selftests/bpf: Use pkg-config to determine ld flags
Date:   Sat, 25 Nov 2023 17:42:49 +0900
Message-ID: <20231125084253.85025-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When linking statically, libraries may require other dependencies to be
included to ld flags. In particular, libelf may require libzstd. Use
pkg-config to determine such dependencies.

V4 -> V5: Introduced variables LIBELF_CFLAGS and LIBELF_LIBS.
          (Daniel Borkmann)
          Added patch "selftests/bpf: Choose pkg-config for the target".
V3 -> V4: Added "2> /dev/null".
V2 -> V3: Added missing "echo".
V1 -> V2: Implemented fallback, referring to HOSTPKG_CONFIG.

Akihiko Odaki (3):
  selftests/bpf: Choose pkg-config for the target
  selftests/bpf: Override PKG_CONFIG for static builds
  selftests/bpf: Use pkg-config for libelf

 tools/testing/selftests/bpf/Makefile   | 14 +++++++++-----
 tools/testing/selftests/bpf/README.rst |  2 +-
 2 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.43.0

