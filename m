Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B3F77994F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbjHKVT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjHKVT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:19:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465101FED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:19:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d67a458ff66so669911276.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691788765; x=1692393565;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RFrxluOoy6twC+BtLwdF7yyyJ9Z+VqsYDm8spFvMc3o=;
        b=KEeT3bwgLFy9nncUtsA1DUMJ+lw/0tWaAcyjIIb1nTbBe9h5TbDkdkoFdWj0klLLdY
         NjGjXqqFdce2YstjTQv4AXniOjzoMu28xyT5D4d0ahEoSsaQv2JPfHwpqA0NmS6hSaoj
         Ks8ws9d3oxBF4ffFqKww/GZSfMSB6ylltuLMG9B8Zg6oRBC7xMlGlNK4jl0ZbhOlbG98
         etWolJ0AzSzpyRaHQuKDNmGQpHcuo17dYYBylyaUCsXRYpGHnXKDfJYQCid8aAq7N5vB
         /wlg08oiFa/ZVqNwZCHx7vqYFQ8UxrMpuYeUotCGkC4b8VLq5VoF7oCeCmmk9oSwMEZp
         Ds4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691788765; x=1692393565;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RFrxluOoy6twC+BtLwdF7yyyJ9Z+VqsYDm8spFvMc3o=;
        b=hiFuQZE9OEXtucTW6Gz+MQ0XTrx+DMhMJhQeKvrozTiyhFbTJF5ToUlYM5QvXoDxPy
         zgdGJBx5PrWOS7sc1/4a64ixAFfj+Bnl2aGLAmkk370naAIkj3oB4pU1ROGWu/hYcYjN
         bfFtpFdfMleOwm9PZ0cJGtF2rBa9qXdWvB9m0orHK/TaR6a0N2tZm7Z1t9WLvBfThi3k
         AQq/cT9MfqRZEHyStBfGUgp361y61XhpN0hnyY162+UfcoDJe0UZpGMxvqzOLKutk1wz
         S7aKwxQU6o9cgcOHf1vVyXlEt2QXINLJw0pEw6m/yZ8/PdglCMr4h08Et9ldfABI0ryv
         qAJg==
X-Gm-Message-State: AOJu0YzIEJPAnWEetiObsRJ8CdXtRl13MSS6FCjgdN4z7e8Et/eiyv7E
        U5d0qr2Bgf9neOQAAr5fcIBPI+KAO7SRIfC2Hw==
X-Google-Smtp-Source: AGHT+IF9Br69ecsKGahyXfFLxWcygWeL+6PwYxobiySkMHlx9q6Oc6i4K3Yd/3AjaZeOGXX0GHjRyimm9VjmKK5cbg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:ad55:0:b0:d4d:8ade:4dfa with SMTP
 id l21-20020a25ad55000000b00d4d8ade4dfamr48994ybe.1.1691788765541; Fri, 11
 Aug 2023 14:19:25 -0700 (PDT)
Date:   Fri, 11 Aug 2023 21:19:18 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANal1mQC/x3NTQrCMBBA4auUWTvQpIg/W8EDuJUu0mRqBzQZZ
 opWSu9ucPlt3lvBSJkMzs0KSm82LrnC7RqIU8gPQk7V4FvftUfn0GbNUb4YNE4o5UMqEeUZ5rH oy1Csw/0huJgGH9JpgBoSpZGX/+QOt+sF+m37AXk5aSh5AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691788764; l=1075;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=UEYyh0BWz2Miih72wZBvRAC+rwc0jWuEQ2qNUTkM5XU=; b=Zlh1YTXz73wMqDpXUvsEhgcdl9DyMmUzchwKzmOb2URaBWyy4LBJQTuQT9BtWkgTvdP5uJxVy
 20A8c1diBa9BvaWKvZttQDKCDc7IH26PulJT/j+2/N0g1J73S5NClwP
X-Mailer: b4 0.12.3
Message-ID: <20230811-strncpy-arch-powerpc-platforms-ps3-v1-0-301052a5663e@google.com>
Subject: [PATCH RFC 0/3] powerpc/ps3: refactor strncpy usage
From:   Justin Stitt <justinstitt@google.com>
To:     Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Within this RFC-series I want to get some comments on two ideas that I
have for refactoring the current `strncpy` usage in repository.c.

When looking at `make_first_field` we see a u64 is being used to store
up to 8 bytes from a literal string. This is slightly suspect to me but
it works? In regards to `strncpy` here, it makes the code needlessly
complex imo.

Please see my two ideas to change this and let me know if any other
approaches are more reasonable.

Link: https://github.com/KSPP/linux/issues/90
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Justin Stitt (3):
      [RFC] powerpc/ps3: refactor strncpy usage attempt 1
      [RFC] powerpc/ps3: refactor strncpy usage attempt 2
      [RFC] powerpc/ps3: refactor strncpy usage attempt 2.5

 arch/powerpc/platforms/ps3/repository.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)
---
base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
change-id: 20230811-strncpy-arch-powerpc-platforms-ps3-57a1cdb2ad9b

Best regards,
--
Justin Stitt <justinstitt@google.com>

