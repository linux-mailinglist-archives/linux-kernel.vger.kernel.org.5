Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7375B78AD85
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjH1KtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjH1Ksh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:48:37 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F348FC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:48:25 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-5219ceead33so2373065a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693219703; x=1693824503;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=phn8WusQ/2+glt4bRRsEQXCtZZReUGFgblYyJRKf5Po=;
        b=GFuup1MGJRUkG1P8N469gD0uIyioKkpXXdaHIwLBn9zp4jpZHnPCabTNzKIMkvngCE
         efLqMtK+bsODFnTy8pPYa96/vr/acZ9NQZ1rXsv8U1pDSWiWnlTLtWlexDJF+JMB50LN
         jNfjeIPqg8zYTlpklUuVXpb19Cre6aXEqlUlOtPvkuZy0JebKEbRNHG8Lo5yJi0nZ7ql
         Vdb57T8pe+vusaWx70f1LRYSIokFStQOCqLHkiafzqaG1xFoQBw/muwgUkNrxZtKqpnE
         2jEWfut/08tKpnpi+gpb3YRo9b1ooTFdz1gKZrI+TgynH1ape5TvDPTJ8/jvPODypjU2
         wqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693219703; x=1693824503;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phn8WusQ/2+glt4bRRsEQXCtZZReUGFgblYyJRKf5Po=;
        b=GrsmqA4SSOj47PvJmRdVD6j23j2szWLODaaQksouMhenExxXT608V1yeVifOeGEVR6
         032e6P/iQuax+alOmUewVMVF95BbfIxDsjF9hVxFmWWPNY+j5Z8Vh47ELspqKQocq6g3
         WLeSuzo265ZlGe7amuyacJmtBnJXfVobFd+maoI26RJDbgeK3qGczlWAl+JW0/L4fMWb
         zPDvX8utcmBSsX4d6Wgbv0YlPDwmfY2XM+HZvHmUm3rqt4qTHD3kotnkKWHRvGY3hU6j
         d2m30Cuk9A1X6A3XYlR79S/efEczPCQmuLRJ74l8cuOBjal+MprHk6SxgvtU92Tx7TGa
         y5Wg==
X-Gm-Message-State: AOJu0Ywy5HjtarnTa9HX4BIF7GyaLWSBg3sc1/DzxCEl8qtz6V77U3zX
        U2hPLMEM61Zxeil9vqKYzC/A5RcWNAwer08=
X-Google-Smtp-Source: AGHT+IFlKbd+StOuT2cwBajLbBRIWvpPRXWrwlNiRZgLn+CYc2DdKicVqK6mw+3HktcA5RJUAHtt8hdAMRRzYJw=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a50:cd5e:0:b0:527:247d:8a03 with SMTP id
 d30-20020a50cd5e000000b00527247d8a03mr456270edj.3.1693219703413; Mon, 28 Aug
 2023 03:48:23 -0700 (PDT)
Date:   Mon, 28 Aug 2023 10:48:00 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230828104807.1581592-1-aliceryhl@google.com>
Subject: [PATCH v4 0/7] rust: workqueue: add bindings for the workqueue
From:   Alice Ryhl <aliceryhl@google.com>
To:     rust-for-linux@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains bindings for the kernel workqueue.

One of the primary goals behind the design used in this patch is that we
must support embedding the `work_struct` as a field in user-provided
types, because this allows you to submit things to the workqueue without
having to allocate, making the submission infallible. If we didn't have
to support this, then the patch would be much simpler. One of the main
things that make it complicated is that we must ensure that the function
pointer in the `work_struct` is compatible with the struct it is
contained within.

The original version of the workqueue bindings was written by Wedson,
but I have rewritten much of it so that it uses the pin-init
infrastructure and can be used with containers other than `Arc`.

This patchset depends on the patch [1] that changes `Opaque` to be
`!Unpin` for correctness. The patchset is based on the rust-6.6 tag,
since that tag includes that patch.

Changes v3 -> v4:

 * Use `offset_of!` macro from standard library, and drop patch with
   custom implementation.
 * Add name parameter to `work_struct` constructor, and drop patch with
   __INIT_WORK_WITH_KEY.
 * Various improvements to documentation and comments.

More detailed changelogs can be found on the individual patches.

Previous versions:
v1: https://lore.kernel.org/all/20230517203119.3160435-1-aliceryhl@google.com/
v2: https://lore.kernel.org/all/20230601134946.3887870-1-aliceryhl@google.com/
v3: https://lore.kernel.org/all/20230711093303.1433770-1-aliceryhl@google.com/

[1]: https://lore.kernel.org/all/20230630150216.109789-1-benno.lossin@proton.me/

Alice Ryhl (5):
  rust: workqueue: add low-level workqueue bindings
  rust: workqueue: add helper for defining work_struct fields
  rust: workqueue: implement `WorkItemPointer` for pointer types
  rust: workqueue: add `try_spawn` helper method
  rust: workqueue: add examples

Wedson Almeida Filho (2):
  rust: sync: add `Arc::{from_raw, into_raw}`
  rust: workqueue: define built-in queues

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  |  13 +
 rust/kernel/lib.rs              |   3 +
 rust/kernel/sync/arc.rs         |  46 ++-
 rust/kernel/workqueue.rs        | 679 ++++++++++++++++++++++++++++++++
 scripts/Makefile.build          |   2 +-
 6 files changed, 741 insertions(+), 3 deletions(-)
 create mode 100644 rust/kernel/workqueue.rs

base-commit: 4af84c6a85c63bec24611e46bb3de2c0a6602a51
-- 
2.42.0.rc1.204.g551eb34607-goog

