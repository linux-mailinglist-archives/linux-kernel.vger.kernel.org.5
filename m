Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130F07A27E5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbjIOUPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237480AbjIOUP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:15:29 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7414359D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:14:51 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68fbd31d9ddso2142523b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808891; x=1695413691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1xGkWgfRY1FFenR3ao2iGiE7ihw6UgGIpPkGx6sQMQo=;
        b=HZ0rIowYUTVVWy3LYido/krpVX9tAq/M/M7OGlLIjnsQmgGqIm7CQ3HMq+8KVJ95PC
         q11K0DCnWRHm8pogfhfsIxOLqBtQ0+juYcIkjg6pdYIE4xXbNVsurtPopkACvK5M2avB
         0Gv6JzAUn2XeLpcHSTtR2Hn9ILmZ8IQU4kyMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808891; x=1695413691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1xGkWgfRY1FFenR3ao2iGiE7ihw6UgGIpPkGx6sQMQo=;
        b=TX/0GCOzXyf9XIAzAwGx57ahS9tOMfVYA5PoAyJ01cvP3THdesIhP2l8zEkMp5jS3M
         qp78nmPV9QjUm/pe4SpeFWPcDz83uR3pyjg92D+63BQi/is4n2qy8o4eJxprSYHzDsdW
         9Qzrbmq7RkqFT7UHq1GJNOxN9tk3fA0cL7URUcJ5vV9TdUiSvolH9A/AJKCZMStpICez
         6PX8SexOo/bw0MCtrzY557CWVQOQySAV4qyZKnqVHFto8PIn7/C5Qe4VtYb64hyRuOj7
         EHtumLqt7dQ/PLNJnQ5wuJBxRpAYi7v63ya73iQvfTwFfRkUNyYKTD7QgFST2B19WWTp
         oYUQ==
X-Gm-Message-State: AOJu0YwwdkcqnBkD7xXfblbe9kZ9QhmTH3gJWBdUd7d8R+yju5pQhcj7
        W4Mb+Tq4v5bO5Fpqu6NfItC99E/64ceFLCBUztw=
X-Google-Smtp-Source: AGHT+IFActFxqjNHL2Z2ACBNmaLGRxovnNhDBzSm4cH+4lZA8OB0mKUJRqzlNq0CY0idCNVsG33h8w==
X-Received: by 2002:a05:6a00:2283:b0:68e:2d2d:56c1 with SMTP id f3-20020a056a00228300b0068e2d2d56c1mr2998461pfe.9.1694808891307;
        Fri, 15 Sep 2023 13:14:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f21-20020a633815000000b0056c24c2e23dsm3093252pga.25.2023.09.15.13.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:14:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] afs: Annotate struct afs_addr_list with __counted_by
Date:   Fri, 15 Sep 2023 13:14:49 -0700
Message-Id: <20230915201449.never.649-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1274; i=keescook@chromium.org;
 h=from:subject:message-id; bh=nx9DBuOnb63mlStsb3tbldEXi6Y6SJspSK6UFXdI6Sk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLs5PIeqUuA4Rx4q3V8agIZDkHEwkyC0zaJOp
 Ra86jrJLxGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS7OQAKCRCJcvTf3G3A
 JiPID/oDSfiAd3Q3sGUrqDk53kbTWkVQVfsSh/b+0xP/N4i79R/PwYTmJA6QuNp7508t97ZFRzc
 hCZ1OFY+nPpWZgXbdW/wXDZqURZY35x7vvjdsS9pf+48qjtmnpwpFcSjWtv22r3AGVnuSp1zlQ7
 R2Q4iyXi4dBpYtGvqizxexU0zb+6QLyqoxr0nqBvW4p+LVGJTnmQB3wehEYz8szS++1+g58eHPt
 B9hT3wYjWe2OlkpPddcU7EymwlLQ0md8aZ+BH3fPs1po0pU9YJKwmKNEmpVR4ko/9uDmopjcN1X
 tY+o6/gOJBSh8yWLMQskxrH1tM8e3i246Y0IERv1siFkzN03ZogEMjV4Du1jMoCsv438ZojD7bA
 u2DPp8rVewnmEHkI6OwtfvOqMpjYF0eDmqr1hHe0qM/sUZRNLF5RvaSrMhR7Wo/y4zUOosLdpqX
 Ba6bfcZhDFTAUBsIw0LI1ePqNBMgbxPZv2xzEoTEAVbzHf+cZU4YrNScilylpqBBrTRQds9RusO
 cV6Z1XJ3QeR863KVWVpyE1rpLdiAWIXgUO8j9L02tikqomEu+dKM9J59wdRSY9Gn5qTxOJPYJo6
 HmtSTkt4DX607SF5mCwl8+CzoYpPAO0xPTE/t8JQw5E1zLJXcFSx8OmwbNVHm8d6u1sEO6KDmmy
 DvY8NFb aaz9mW+Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct afs_addr_list.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>
Cc: linux-afs@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/afs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index da73b97e19a9..07433a5349ca 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -87,7 +87,7 @@ struct afs_addr_list {
 	enum dns_lookup_status	status:8;
 	unsigned long		failed;		/* Mask of addrs that failed locally/ICMP */
 	unsigned long		responded;	/* Mask of addrs that responded */
-	struct sockaddr_rxrpc	addrs[];
+	struct sockaddr_rxrpc	addrs[] __counted_by(max_addrs);
 #define AFS_MAX_ADDRESSES ((unsigned int)(sizeof(unsigned long) * 8))
 };
 
-- 
2.34.1

