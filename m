Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A52B7A279A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbjIOUEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237086AbjIOUEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:04:00 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56469211E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:03:55 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c337aeefbdso23495005ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808235; x=1695413035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yl8emKrmc/KfUuXy2E3tRAOG2iLFA4b4JMVH2AzKln0=;
        b=C9dZmy3wuLpOhsdwWwAGaoNiyrWDYFOotOg+CrPiTqjOeAxiqm5NoE2m7bWbl2x/5t
         UpoCaHvtUKpCUI63V2B9Oz0iWGNCRlHVbeH7AbRPpo4Arfy8sEJBNkdAnGQ5zNtnTcc9
         ybth8bRfd/P7fimWvpwlRJGNzbukmtcqvt6Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808235; x=1695413035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yl8emKrmc/KfUuXy2E3tRAOG2iLFA4b4JMVH2AzKln0=;
        b=lY9iDy7dAvDQeri2ALIP1RNINKcCeYp1lmn5qcfLduuwaHx3F8TQVsdhtxmQIvKsGC
         eYo5p+Zn9Dfb4pUT2pBRoEkhS+eORHg5AiggQKg2mb+Jj3L6TkpKio11Hzai27/0H9/g
         ljXOPCCh11YHZv+AkCcn79qpvdwvnMGK+Aw6PsTMOfiHVtyCKevEgX8sN+FbwZINBn1c
         nKcc8mpyX0gMzMzDKuYcNnyRj4FXxrRirS9i1dHxz9aLd9rWeFMVF9cq1C637t4EkY+K
         SlFNqDTwZX8ycgF0/d4HGxTwS0uKs37w56tqYdIuF6MVHWKkcgQBN3WhJ+AczQfN6pJB
         agoQ==
X-Gm-Message-State: AOJu0Yy1HOfys/voP6WFUyjASopYXaCe2zdXzwlwGdiY9/GFIqeO5eW6
        IfOsgzxeFbnazyJZfPzMwuW8ww==
X-Google-Smtp-Source: AGHT+IF2oW6I05JFC4LbqC0C/xSZFuoVK2mMBPB/lgVhfx8bqpQ8L6rQW3zyLUX7mUdezD2I/Z5UzA==
X-Received: by 2002:a17:903:24e:b0:1bc:6799:3f6c with SMTP id j14-20020a170903024e00b001bc67993f6cmr2435450plh.35.1694808234867;
        Fri, 15 Sep 2023 13:03:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jc19-20020a17090325d300b001c4247300adsm2521123plb.276.2023.09.15.13.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:03:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] dm: Annotate struct stripe_c with __counted_by
Date:   Fri, 15 Sep 2023 13:03:53 -0700
Message-Id: <20230915200352.never.118-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=keescook@chromium.org;
 h=from:subject:message-id; bh=vOEysGbU/jyBebBE5nHunAiTa99HsxKjPw7GE7dUesk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLip2KpsBUO/hCQjlCTSWf2rc87i8jMHzNeSE
 Q8UaPFCOvWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS4qQAKCRCJcvTf3G3A
 JpnJD/44Xz/i8BNUv0MMMNLHpqKkkGXhsnX3/oK7sG9t5GcOmsd2TGoGmk+Mi0lfFizMo1Wu4rd
 D1aP5qTGM3Ufj8/4nIvQUnuJ3fTsDiuJGvyZidtO2mhY4z0sDqDFwq0iWQQEec4kD+wxSGPnSd3
 s+RmtXzI2BuE5DXDc1Y9jCZbMi9sQqJJq3Dp+l+vOGr+ovc/TSK4hL5tLKy3x4pyR+OL9xZbp5S
 OcnrtzlmHhv/+gzQh1TdQXFXKiZP0JpGye/uLGzm/JLBBh4O6BUf1WqE+JuZJXdyxm9IzsWyi6m
 VpTxDakDYjz3OY5vNgdASvDfGeA4tlf0faus+ogRlMXiyFWCpYxfiPCgLjLKd8j/qDY6fNFrfn2
 fMopN7jzzjuDuQKwLvwo0WreafHn/87Npf0vrNSgxxVSIDcn1xagASs2Dc+tzhrhaovAV0vg/b2
 /1k2Oi2JiXX6i+wNfGmUIBmUJC+5EggoLK9bSp8Krg5X9TWkzK5BWxIsEIFy4fChFtGDfPx/zrl
 6RE1NFzGHIuHI/9gkAs+Pd7SzewGh/0sFbi7aEB4mh9lO+nc4NikCrdZsu9L1BNxFCjwPsGL/D0
 CMh9MqgB/q+43pEGchjFoK3DQp3hz1cSDRUDWidEdAIjizb1sw6N5ohw8hOyYZ7YWMl6Jk/Zdfv
 1L0V1+E HhwIYZFg==
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

As found with Coccinelle[1], add __counted_by for struct stripe_c.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@redhat.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/md/dm-stripe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index e2854a3cbd28..5e70f5ae394d 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -44,7 +44,7 @@ struct stripe_c {
 	/* Work struct used for triggering events*/
 	struct work_struct trigger_event;
 
-	struct stripe stripe[];
+	struct stripe stripe[] __counted_by(stripes);
 };
 
 /*
-- 
2.34.1

