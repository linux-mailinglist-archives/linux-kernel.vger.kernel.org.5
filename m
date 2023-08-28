Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BCC78B501
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjH1QA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjH1QAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:00:03 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789FFCA;
        Mon, 28 Aug 2023 09:00:00 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d7260fae148so3329989276.1;
        Mon, 28 Aug 2023 09:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693238399; x=1693843199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVKo28epBiUG3SEESqk0GaOO1fQ+tGlFjow4pbPvDOc=;
        b=f7mZjlRSsKdEAJTd2HmQUIXry+VBbv9QBjhY3v0GISsyaOpNoNxowo85p8cxej0pL9
         DMZu7WRuL9pSQbMsetk5rbEPm9AbQE7prX+9aAoppUp35BkVnQDKAMUhc9cusSiGnreS
         poouBn10o8J9dkv+dvdoKhTMDPtTUrgCKMbUkGnPbTgL4UQLYBzem7l8cuFeeQAYCFwe
         tBMMiJfQowBrfmlxrinSnjVVFC/Ee3up4T12wDSgHfgoSyhWkEY+R9f3yC3/LbtabCuw
         S40Qfk60bXr8eLohUhxJ+Bdx6wgPEwbDX3ys9/q6vk03o1et8yXv/MGDCwYsR9Qj2qrg
         z/yA==
X-Gm-Message-State: AOJu0YzTwy2sRDZ+jBSaT1fzYTrLbRhjLuRzk9uyUapuQKs68rYHKucq
        wAlRjwruayLr8cr2SBvvMcybwHGWoMQIgA==
X-Google-Smtp-Source: AGHT+IH+AFBVI3DPXh919wgqnRzEPxzRq+uwunyVsV2JXLy5zIepDPTI+3vWzY5m60dUrLlmwZ6Erw==
X-Received: by 2002:a25:d807:0:b0:d71:5afb:7741 with SMTP id p7-20020a25d807000000b00d715afb7741mr25038389ybg.60.1693238399368;
        Mon, 28 Aug 2023 08:59:59 -0700 (PDT)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id f205-20020a25cfd6000000b00d05bb67965dsm1723919ybg.8.2023.08.28.08.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 08:59:58 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, hch@infradead.org, hawkinsw@obs.cr,
        dthaler@microsoft.com, bpf@ietf.org
Subject: [PATCH bpf-next 0/3] Clean up some standardization stuff
Date:   Mon, 28 Aug 2023 10:59:45 -0500
Message-ID: <20230828155948.123405-1-void@manifault.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Documentation/bpf/standardization subdirectory contains documents
that will be standardized with the IETF. There are a few things we can
do to clean it up:

- Move linux-notes.rst back to Documentation/bpf. It doesn't belong in
  the standardization directory.
- Move ABI-specific verbiage from instruction-set.rst into a new abi.rst
  document. This document will be expanded significantly over time. For
  now, we just need to get anything describing ABI out of
  instruction-set.rst.
- Say BPF instead of eBPF in our documents. It's just creating
  confusion.

There is more we can and should do. For example, we should create a
maps.rst document that will be a proposed standard for cross platform
map types, and remove any relevant content from instruction-set.rst.
This can be done in a subsequent patch set.

David Vernet (3):
  bpf,docs: Move linux-notes.rst to root bpf docs tree
  bpf,docs: Add abi.rst document to standardization subdirectory
  bpf,docs: s/eBPF/BPF in standards documents

 Documentation/bpf/index.rst                   |  1 +
 .../bpf/{standardization => }/linux-notes.rst |  0
 Documentation/bpf/standardization/abi.rst     | 25 ++++++++++++
 Documentation/bpf/standardization/index.rst   |  2 +-
 .../bpf/standardization/instruction-set.rst   | 38 ++++++-------------
 5 files changed, 38 insertions(+), 28 deletions(-)
 rename Documentation/bpf/{standardization => }/linux-notes.rst (100%)
 create mode 100644 Documentation/bpf/standardization/abi.rst

-- 
2.41.0

