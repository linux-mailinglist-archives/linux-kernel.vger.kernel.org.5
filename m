Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D2D7EFD4D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 03:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbjKRC6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 21:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjKRC6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 21:58:10 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC76D6C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 18:58:07 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-daee86e2d70so3209867276.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 18:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700276286; x=1700881086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QcqINJQ5diQHGOPsun01LVrGFl32Nw5/hV5eaRRLRg8=;
        b=tuNl5Lb5paQT0f052qeluQ+0tAGSdmaA/l4/8oASX0hOCpYfkhl30eZ7b/IQL0wQQl
         zXSOKlZy8pE3mjni/S0A1F5EC95HJ4exsuFi76fQR9wU8gCyEANaDN1uJCGtM+CVSacm
         Z8q6Hbo9ARDcAp+A/s/EunkKfcR2wB4oySt8s1gG2LUiDe+FKWGoZdaDO5ZQOXug2G9q
         AW5U9X6Kq5bYFCfDjkmoZuI2Eyj1kbJKSy2gL1Js6nep5EbeGxQRfDz4tA8gHABKUNhX
         bQu3MYQ0gPMUWFcNMtBdWx5FJM4FfstCMUkGb2jOaGTqGJs25RCPBbK4R9z0+K6CP2EN
         wAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700276286; x=1700881086;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QcqINJQ5diQHGOPsun01LVrGFl32Nw5/hV5eaRRLRg8=;
        b=LZ+KAibdtEagIn/1Zsh/vq+FHRDnW+4ULmxW4aNOWSQHj4su61n5MeZML2v0qiYzBN
         FefosD49QQ6fI1n08f6JvkeJaDR4Z5Z10r0f74E+y9iF5zGvVGeqqGjkKX2qlgZ/JTol
         zuZhdbz+QquyqL4/S6AaZc6P9RcIlcT7emRfcjlKX7ORUxfCVVGLKzoaCM//o6VpK7Y8
         Xs27TpH1wQ/xWO728q/cPPp2JtKps+mdCZCdBjgKGtN8al/PNmv1TLVK526JTU4ZXigR
         z9G5cQgUWCYKY+mesd73eDzuLdMjE537JZnZy1BiGj/NRTW0u5pozYOWn1rK/dwKARkQ
         LMhg==
X-Gm-Message-State: AOJu0Yw9F7H5MN8GtXi9lLeCDKoAL8GFV5dK8euknCpc1EoJl0vtJ05m
        NyxWvRX1dkdscHqsEAQ47VgFBs24JqNU
X-Google-Smtp-Source: AGHT+IEipLfYfNhkIRCz9BLTKi/Q07W5+qhbxpM56Qf4WuGm87G6Dh+mgTSQvuA9zn4iAz2ODTBXSWhTbmQj
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:abe3:0:b0:d9c:c9a8:8c27 with SMTP id
 v90-20020a25abe3000000b00d9cc9a88c27mr27045ybi.13.1700276286411; Fri, 17 Nov
 2023 18:58:06 -0800 (PST)
Date:   Sat, 18 Nov 2023 02:54:41 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231118025748.2778044-1-mmaurer@google.com>
Subject: [PATCH v2 0/5] MODVERSIONS + RUST Redux
From:   Matthew Maurer <mmaurer@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
        rust-for-linux@vger.kernel.org, Laura Abbott <laura@labbott.name>,
        Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this patch series is to allow MODVERSIONS and RUST to be
enabled simultaneously. The primary issue with doing this at the moment
is that Rust uses some extremely long symbol names - for those
unfamiliar with Rust, it may be helpful to think of some of the mangled
C++ names you may have seen in binaries in the past.

Previously, Gary Guo attempted to accomplish this by modifying the
existing modversion format [1] to support variable-length symbol names.
This was unfortunately considered to be a potential userspace break
because kmod tools inspect this kernel module metadata. Masahiro Yamada
suggested [2] that this could instead be done with a section per-field.
This gives us the ability to be more flexible with this format in the
future, as a new field or additional information will be in a new
section which userspace tools will not yet attempt to read.

In the previous version of this patchset, Luis Chamberlain suggested [3]
I move validation out of the version checking and into the elf validity
checker, and also add kernel-docs over there. I found
elf_validity_cached_copy to be fairly dense and difficult to directly
describe, so I refactored it into easier to explain pieces. In the
process, I found a few missing checks and added those as well. See
[PATCH 2/5] for more details. If this is too much, I'm more than happy
to drop this patch from the series in favor of just adding the
kernel-doc to the original code, but figured I'd offer it up in case the
added clarity and checks were valuable.

[1] https://lore.kernel.org/lkml/20230111161155.1349375-1-gary@garyguo.net/
[2] https://lore.kernel.org/lkml/CAK7LNATsuszFR7JB5ZkqVS1W=hWr9=E7bTf+MvgJ+NXT3aZNwg@mail.gmail.com/
[3] https://lore.kernel.org/lkml/ZVZNh%2FPA5HiVRkeb@bombadil.infradead.org/

Matthew Maurer (5):
  export_report: Rehabilitate script
  modules: Refactor + kdoc elf_validity_cached_copy
  modpost: Extended modversion support
  rust: Allow MODVERSIONS
  export_report: Use new version info format

 arch/powerpc/kernel/module_64.c |  25 +-
 init/Kconfig                    |   1 -
 kernel/module/internal.h        |  18 +-
 kernel/module/main.c            | 663 +++++++++++++++++++++++++-------
 kernel/module/version.c         |  43 +++
 scripts/export_report.pl        |  17 +-
 scripts/mod/modpost.c           |  37 +-
 7 files changed, 642 insertions(+), 162 deletions(-)

-- 
2.43.0.rc0.421.g78406f8d94-goog

