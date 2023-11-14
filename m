Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0BE7EAD63
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjKNJwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjKNJwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:52:32 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8FD191
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 01:52:27 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so5560829b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 01:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699955547; x=1700560347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pW2g3h0YSixWVQuQUxLWfTqlFixwduolLwJaUX59Vl8=;
        b=tEG9WnEI0+cXqq1HCDkxg4cxXGvoUXzGTO7JQotLBx2orCDCFOyD0j13ffspo5+FfG
         ds53uXcSnlbJNlUTBWO/+WU1NIFqfxkPTdezE3uylf/kpKoUiznV9C3/DTKgHzD0AjPP
         yog+XQ06DrUyx+RBvW7O21HTY4Lz8rnqhmGw+Ue/vRvrp2ASRmYx/qg2jW/R4Ch444OC
         hEVSdi035W7jPxc7EC5bxlkTRkst8F3b6sc/6OzH0eNDRAACnb/KMvQKuLFzbim6RzLn
         4XMFBY4bFpJA8Te9W3D9S7F2nenp2IZ8Ff+20lwYwzb+XFlmBb2QFkGq6CPyqoeU7M6P
         Xqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699955547; x=1700560347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pW2g3h0YSixWVQuQUxLWfTqlFixwduolLwJaUX59Vl8=;
        b=IPwBmm2+Gazoq7rlrpzVQzhb1BuT2LvWPyJ+9ngxrMoVin2RCG3wF9RTE99J/x6g9D
         Kob76xJrF5/Vh16S2Qj7QM5CaWiNJxsa9lmWhMYfcKlfsY2/9Ia0pam0s2BZiwQg0hOW
         /uWWal4sQes86GlC2MkxxjnNO6nIjVnuFxvClUOH6W0TtkOEX38vTshzOoVSeDelkwuy
         I9cQkbxTVfXDtUEKfWgYUoBVKaq50LEwC6gOHGimqydnPnGsvji/RjeXD/tZOQd9ND4s
         AKi1AmroAJSt6fwb9bcl3TNlT033KbURDpFxpUKVWuHzHSYiAP59e5pfkHCwCdR6FVDn
         z79A==
X-Gm-Message-State: AOJu0YwAqJNT/mCRdqSvfOc1kU+qzWXd3D/Agqu5OyDDPqPpVbmEknuV
        IW4wud0e381YqZcowXlKv9TMnyA6Ax/4qgOJ528=
X-Google-Smtp-Source: AGHT+IGulTBPou3swbKe/8ItCjG4L/qYNuL+sh/4MGasmite0+AHatY0TzqK/LDYTbfI85TpjFli6Q==
X-Received: by 2002:a05:6a00:1c83:b0:6c3:4c72:8b81 with SMTP id y3-20020a056a001c8300b006c34c728b81mr10004017pfw.3.1699955547055;
        Tue, 14 Nov 2023 01:52:27 -0800 (PST)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id h10-20020a056a00218a00b006c34015a8f2sm874749pfi.146.2023.11.14.01.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 01:52:26 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Shyam Saini <shyamsaini@linux.microsoft.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v3 0/2] OP-TEE kernel private shared memory optimizations
Date:   Tue, 14 Nov 2023 10:52:15 +0100
Message-Id: <20231114095217.1142360-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set optimizes OP-TEE driver private shared memory allocated as
dynamic shared memory (not from the static shared memory pool). The first
patch handles kernel private RPC allocatations larger than one page and the
second changes from alloc_pages_exact() instead of alloc_pages() for more
efficient memory usage.

v1->v2:
* Split into two patches as requested

v2->v3:
* Simplified optee_pool_op_alloc_helper() by always doing the same thing

Thanks,
Jens

Jens Wiklander (2):
  optee: add page list to kernel private shared memory
  optee: allocate shared memory with alloc_pages_exact()

 drivers/tee/optee/core.c    | 44 +++++++++++++++++++-----------------
 drivers/tee/optee/smc_abi.c | 45 +++++++++++++++++--------------------
 2 files changed, 44 insertions(+), 45 deletions(-)


base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
-- 
2.34.1

