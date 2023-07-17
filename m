Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF3D7561C3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjGQLmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjGQLmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:42:08 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E85ABF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:42:01 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b741cf99f8so64790871fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689594120; x=1692186120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKTphFs/0fUMI6x6m+ZFbX49TRFXCAOA52jjQxvzeo8=;
        b=QYSbwMA+9+0U1iPPhZdTiMrew32RjYNuoUXQ6XvY6T4k4RDyS+EpVKrFJNRbwyLBhm
         feXtYMeVmswrIvAsVK2UZKlPxXhoLtpKIhZ1zgv3WtUAyQxe4TEmoaVCiALplF8mIWsC
         4hCW/LKPlzZGxI3cgrxkgXqrUnm0sw2jstpQabiy8OBmcfhY/qRhJLrFWjCBC0BlFZKC
         e3/mS3uLLida7lprgFw766suZ2akD1y/OfKdrUqsoUKDoGljr2zDC2OyGKgwTjbJwCak
         Svr+Pu7MxeI148S7BrhN1CSfEYfahmvMM2ysCsZrD0peo/sH0Bba6HJ4H5CnEreKMpWe
         cuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689594120; x=1692186120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKTphFs/0fUMI6x6m+ZFbX49TRFXCAOA52jjQxvzeo8=;
        b=Wtk0fO5PvUybaodXuJPpRZPp0jxYHJPYTVOWYiU5pqhgUAJTzGiQMZviP4pCGXGrra
         O2XUUjfEWkITLgXlgvoeeyLOZXoupPdDmHNvnpgC3l1vQLrUinAuJedB2V4Enjv5yA1/
         kRll0ioCLLOMVilnNWvbQRnjETBqht3qu1lAJZaMfFf3wqs6JPKvxTrlWwJc5U3e8a8p
         w04AxT3xAHAs+O61J46ac7pAhiIhz2AvjB39c6udyXWR+GAPiTI51q5JrBAPeXvXy1zq
         QBeitLSZ4dW1/6Kyq0Rc1kmgb/XFXbheB+wgBSqx/wJwmlJ4maj4wZH+yDXT65/nDMmn
         CnFw==
X-Gm-Message-State: ABy/qLYE5vGmYhJnSP9P2s2rKk81hfgPQrRILXiAY4uOCJwMc9oJ10zi
        J/bmLDF1AHf4fv44PcJMBoLQoQ==
X-Google-Smtp-Source: APBJJlHeN55tBawncVr5tu42dzS7p0WojvWXsY3Kb4DCWYVOCu2IrI86RSLJaFiFCJGBK57jWHlvgg==
X-Received: by 2002:a2e:9c93:0:b0:2b6:e618:b593 with SMTP id x19-20020a2e9c93000000b002b6e618b593mr8066901lji.31.1689594119785;
        Mon, 17 Jul 2023 04:41:59 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c214900b003fbc9371193sm7946725wml.13.2023.07.17.04.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 04:41:59 -0700 (PDT)
From:   Anton Protopopov <aspsk@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Brian Vazquez <brianvv@google.com>,
        Hou Tao <houtao1@huawei.com>, Joe Stringer <joe@isovalent.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next 0/2] fix setting return values for htab batch ops and docs
Date:   Mon, 17 Jul 2023 11:43:05 +0000
Message-Id: <20230717114307.46124-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small follow up to the conversation with Hou in the following
thread:

  https://lore.kernel.org/bpf/20230705160139.19967-1-aspsk@isovalent.com/T/#u

Namely, the conversation was about that comments in <linux/bpf.h>
describing the return values from the batch operations are not 100%
obvious. I tried to make comments more clear. While doing this I also
found that this is better to patch how __htab_map_lookup_and_delete_batch
sets return values: the output parameter count could be set to non-zero in
case of error, which may confuse some userspace apps (as errno && non-zero
counter is considered a partially successful operation for batch ops).

Anton Protopopov (2):
  bpf: fix setting return values for htab batch ops
  bpf: update uapi/linux/bpf.h docs on the batch map ops

 include/uapi/linux/bpf.h | 22 ++++++++++++----------
 kernel/bpf/hashtab.c     | 14 +++++++-------
 2 files changed, 19 insertions(+), 17 deletions(-)

-- 
2.34.1

