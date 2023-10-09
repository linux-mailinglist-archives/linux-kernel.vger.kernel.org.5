Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58317BD9CD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346221AbjJILaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346307AbjJILaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:30:00 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5015BF2
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 04:29:38 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c5db4925f9so32277875ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 04:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696850977; x=1697455777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Tdfc33f4Wm5FyFF+cSLn1Dj1lOMRUny12yMiSOCHJc=;
        b=WJPm4UrVBQxCMc5Yha1Jv3On1e+7JRDxt/VPAk5AWWsjsgntsYvFRtutw60szaHsGo
         LbXrZ5ahVJ5hQMSMfWDarTEn3uzPjpjuM0Tv/JgBV7JB6z9ZJcrygJHnVsYXtmLZHBmv
         9fQ5Y0qo7wjyqPvP0eN7VxXixZ6NkfEIwVPnGiE4ulWfziwx+mtbOshpt4JGYCdn5GMO
         R5lLJyxGeWB8pfJYQZeUGKZKZTBBbJjzepZjIa5dj3sQng2Lr1JUTLphUTUmIBCoR7CO
         FIilT+W5bzPDZ5rW16GCnXDv7g3g8mvevm/KDxVtOp9egQrRzQKuhZoOmTj+RSrOykiM
         b9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696850977; x=1697455777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Tdfc33f4Wm5FyFF+cSLn1Dj1lOMRUny12yMiSOCHJc=;
        b=ISDF/yJhgnpslSqP2U886IeJsn5zL6ev4Mf+8xZbXTjvnRokKi0uMZomlIhWwUvRup
         Nzvcf4zc3No4pMR5emRGEY7KaY9WL33SezQlJqh3kWBUeoUxG2bXoWyceYb5ARwtm3tO
         RLZNd9MYS7zgUd/GXmf/WZys2R4DjuIVMHYvW494AjvGeU8oyHm8D40QgUE5enLJPUFn
         7P1mkjwCC3SlJD3g4vVDNHiOfQXg8HQGQXCCi3FjQQlk6+VVzV/JCFdNitfTf9tZmfkl
         FWjvFKHLLPrbKa0YYMofomE2nLM3zmtdW/TtVOQGDZ98kQp4YZsNne+WUd8o7765BoC+
         WM9A==
X-Gm-Message-State: AOJu0YzXve5rzG8VxK5j+ZKES0hcTDFOSbm8pjtlFiD4CvZjz5BBG6Gc
        5J2aBepVuUJxMN52539HEmxyWQ==
X-Google-Smtp-Source: AGHT+IH3QKti6SrLc7Vbwklr4lokjNXQqdplcm3TYHJl/kWr314EMtmtgjCJcVE1fLl4T8F1t7doZw==
X-Received: by 2002:a17:902:c70b:b0:1c6:2866:5aeb with SMTP id p11-20020a170902c70b00b001c628665aebmr11765287plp.9.1696850977501;
        Mon, 09 Oct 2023 04:29:37 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id b10-20020a170903228a00b001b03a1a3151sm9357515plh.70.2023.10.09.04.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 04:29:36 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH V3 0/2] xen: privcmd: Add ioeventfd support
Date:   Mon,  9 Oct 2023 16:59:23 +0530
Message-Id: <cover.1696850733.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Now that irqfd support (backend to guest interrupt) is already merged, this
series solves the other part of the problem, i.e. ioeventfd (guest to backend
interrupt).

More details inside the commits.

--
Viresh

V2->V3:
- Remove explicit barriers and depend on spin lock instead to take care of it.
- Move check for empty ioeventfds list to privcmd_ioeventfd_deassign(), which
  could earlier call ioreq_free() even when the list wasn't empty and so we
  returned without printing a warning in v1 earlier. V2 implemented it
  incorrectly.

V1->V2:
- Increment irq_info refcnt only for valid info.
- Use u64 type for addr.
- Add comments for use of barriers.
- Use spin lock instead of mutex as we need to use them in irq handler.
- Add a warning when kioreq is getting freed and ioeventfds list isn't empty.
- Use struct_size().
- Validate number of vcpus as well.

Viresh Kumar (2):
  xen: evtchn: Allow shared registration of IRQ handers
  xen: privcmd: Add support for ioeventfd

 drivers/xen/Kconfig               |   8 +-
 drivers/xen/events/events_base.c  |   3 +-
 drivers/xen/evtchn.c              |   2 +-
 drivers/xen/privcmd.c             | 405 +++++++++++++++++++++++++++++-
 include/uapi/xen/privcmd.h        |  18 ++
 include/xen/interface/hvm/ioreq.h |  51 ++++
 6 files changed, 479 insertions(+), 8 deletions(-)
 create mode 100644 include/xen/interface/hvm/ioreq.h

-- 
2.31.1.272.g89b43f80a514

