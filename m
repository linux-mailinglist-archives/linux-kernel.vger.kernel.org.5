Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A930278E1B2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243457AbjH3V4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbjH3V4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:56:23 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AECEA1;
        Wed, 30 Aug 2023 14:55:54 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7927f24140eso9842039f.2;
        Wed, 30 Aug 2023 14:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693432486; x=1694037286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KUNPpkTqaf/lW9ABpvSuRweB/pjWZbf+kRWJm858Ocg=;
        b=bjuTFJDEJBdGr9/BK1ziZzGf+uv7gZb4pcBUVq6Cyc0N/Q41FarsUZQjvuopCnVj9q
         7YhZwu4P8/Kd8oruT3QQaj0ION8duMhWCTBTxjGiLFjQ/FqEw8u14p+5jzDFNZmwVhHN
         L5D9DO8YuEYdEMJvwmBaHmoFp5H00sPkIEXVKZDgKH7v3pNn5GWSCc8kGA1z9tRD79JU
         oXuxRUyvrgPlKweV4JLMdk6dil9qarhTpCFK8l4jLoILsWZWz9Ee7lhgLKBLVkYHOx/M
         jnDlmaHvzIMqtkHuvVcKVf+Pi3b2WMfhSaqLtuoXm9Bh7Y3Z3NK1ZnzR1m/bvLOxDLkt
         3mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693432486; x=1694037286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUNPpkTqaf/lW9ABpvSuRweB/pjWZbf+kRWJm858Ocg=;
        b=IuqxJKQvpGka82xnk6fkVM4ZxsxMXj/9T0ycGY1c5dpc+J0yZ3i9tJ4b+e7P9gbqr8
         5zl4GpCSwkXaHB5AWjt4Twa2YT7ypMb1p+gjt14ei2dg3YEKUvBkkbVEQ5y6xN1n973x
         l82AHgbgKrQMFoUdXjosdQa7bSNscm32mXD5Z0ZP38nfR9udNhMscn/NKSmr2KF3tVna
         082DmyMAZSa57su+uGCkIUSWSSi7cmTJsXpjnuHHqBaGduPxqS12EYxw9jcAkDY3btRn
         ruivIi/UlziUwK/DMiAp+QYjSfYg6AiwRVMUnPzeofhaadBTxzuXB4n97AsEoaLX4XUD
         N+vw==
X-Gm-Message-State: AOJu0Yydq6lsSCbFR6792I6/ldTFCx+VCPh9tP2Eyid7bccSOB8oe7SC
        BRsRr6yP/oQa9W6v/RuoQO4=
X-Google-Smtp-Source: AGHT+IFFEt5A8+6W+g3EPKz1PjqQ+1HYln0EKu3eVvMd/FDUfOeH6MT6dPUbNlIKc68i/uwtuIFSEQ==
X-Received: by 2002:a92:cf47:0:b0:345:d4da:41d with SMTP id c7-20020a92cf47000000b00345d4da041dmr4015621ilr.8.1693432485985;
        Wed, 30 Aug 2023 14:54:45 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id v8-20020a92c6c8000000b0034ab6f53e23sm50527ilm.28.2023.08.30.14.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 14:54:45 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/2] ocfs2: Replace strlcpy with strscpy
Date:   Wed, 30 Aug 2023 21:54:24 +0000
Message-ID: <20230830215426.4181755-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The main patch this series is targeting is [PATCH 2] which replaces
strlcpy() call with strscpy(). However, while I was tinkering through
the code I noticed that `module_param_call` is marked obsolete and
`module_param_cb` is preferred instead. So I have included [PATCH 1]
which does that.

A crucial thing in [PATCH 2] I would like to bring to reviewer's
attention is that it changes behavior for the case where
sizeof(@buffer) < DLMFS_CAPABILITIES. Currently, this is silently ignored
but with the current change it returns -errno.

Thanks,
Azeem

Azeem Shaikh (2):
  Replace module_param_call with module_param_cb
  Replace strlcpy with strscpy

 fs/ocfs2/dlmfs/dlmfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--
2.42.0.283.g2d96d420d3-goog

