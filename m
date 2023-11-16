Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735727EE737
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345379AbjKPTOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjKPTOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:14:16 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECE9D4B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:14:12 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6c4eaa5202aso1165445b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700162052; x=1700766852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eVfmF+WaYqBufuKhkvOgsH1LmjL21XWKZ2k2AqPWwJc=;
        b=jrz29i05WeKnFRnsktJywCIU05aehODjeHgybSUHh0dVMkoFZIn7qDZHxN3GywAqdT
         HdCDtB8FebsS8XhF/FNSBItdCv/r1kMivRi8hJTGePQP7hp3+sL8VukrrBZYDEQEc4yT
         mBx1lkB1Kvej0FIFuuHg1UXlX2FIzYKOpuXWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700162052; x=1700766852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eVfmF+WaYqBufuKhkvOgsH1LmjL21XWKZ2k2AqPWwJc=;
        b=q08uKYBvI3VHCmhTi7fmhlUEIp9ZKSZmFB7h2egaULUjWxluhpYVSC6LGo6VjYZfFI
         aT1iTkA7TwTt8tXfTdQEqnar0yRYmaq5gBPRkuXDR9qFKauTLPGMhO7lkckt+VpmwTBv
         oh6zXldChNUUWG7Skvb28rSeTFUXLI79HJn0hdnzYU8Amlz7FMHkYa1lJFLeY7KXBupk
         9r+CaQK6znmrHBTrbsxlRfGNFzbDSNC0Z2q6f2WnedAieHJaC//A9KAViSxTLhLW1BwT
         Q2yQrSgxPlJ46CWe2mBU7Y180LwoA8BVWmn/Nuzv1BbGj8Mn2ZkWrehCDSQHzPRm6ZLI
         ynrw==
X-Gm-Message-State: AOJu0Yz9zUrwqaobbJpR6LbhHncawyzwn0Oy5YnV/Td9R4o3drFqDLA4
        Ujfw7OaFjwNSLuIQPglIYqgTXA==
X-Google-Smtp-Source: AGHT+IEhiV51XKMD1zOBA5sD1OXQnyONH1asnHIR7eOg2pPSelrDFt5DBTV7MXEVihwsOKosOCrQ0A==
X-Received: by 2002:a05:6a20:8421:b0:185:876f:4f4d with SMTP id c33-20020a056a20842100b00185876f4f4dmr20888854pzd.32.1700162052390;
        Thu, 16 Nov 2023 11:14:12 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id it14-20020a056a00458e00b006c8721330fesm83721pfb.74.2023.11.16.11.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:14:12 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Sumit Semwal <sumit.semwal@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] dma-buf: Replace strlcpy() with strscpy()
Date:   Thu, 16 Nov 2023 11:14:10 -0800
Message-Id: <20231116191409.work.634-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1603; i=keescook@chromium.org;
 h=from:subject:message-id; bh=ujMUNo3RU3wpVThFuzKIZ2gb6sD3uJtU27PlSfCQHtw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlVmoBZbJJwqB7WG04tbh2/UJo2fxHw9dAlFGyu
 eEfMPCM8D+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZVZqAQAKCRCJcvTf3G3A
 JtT+D/9ZzA0yA7kvOO/Y+64NFTRleFpB8MdlXKFS7ysgcMx4Q/lTBKhkKLD6qvD9NiIXGTKSGrh
 3GGTQlSXtD3gnP9vhfnsdQPxm7Nme0HfgCADjlK12TQqmzTEluquxp57OqhgDPqrFwjp8zEkEHB
 Hznzi9UF9cqj/T63wcAuGjXC8mx550cZDOzWaKfsxIIwENsPZLrbekUNeZsgQPN8un/mTeTasXh
 Dim2vXCq1wg+zmIYt4wb3MFHvAeNDMdbudLjwnaxS7KH4SAhXIV+iQTJjOW5gj+CnOEliIjO0eP
 fctBuohDOYWiyPZ/b5LKRsaNIaNLhlsKrsXW7qpvTi8NTdNME/ndlbETv7KqumwjSQtiDoIqNmf
 t4ZH9yrrcuYCaDcaA0D5Mh7Z3fyLsNgiO5WZ5JDwGOfxsVz5Ux99LctSgV9M1T6ygM6fYkp3X5/
 jHoeIUVCzQ/rFkZqtLD3RMj0C94i6hEM9oWm1/HyfB+sFVvdNn7zG+RyuryDoT2rOjrig1Y4IES
 i8Zu0UB9f03CJHQeC9RkPMDoG4U+ZEA9wgMwqQ2eNX8M3t3UGzFepxFW11XLyXTfEq8GKLh8Qxd
 qYRKZLWDQkcbtBf6aRIGrTkqc3Xw6N6aymKwpizpCz/BphPJrIy5TIkEpZI9xYTbwzO+eW77/2H
 cTml0Zt rnUC/efg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first. This read may exceed
the destination size limit. This is both inefficient and can lead
to linear read overflows if a source string is not NUL-terminated[1].
Additionally, it returns the size of the source string, not the
resulting size of the destination string. In an effort to remove strlcpy()
completely[2], replace strlcpy() here with strscpy().

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
Link: https://github.com/KSPP/linux/issues/89 [2]
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma-buf/dma-buf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 21916bba77d5..8fe5aa67b167 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -46,12 +46,12 @@ static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int buflen)
 {
 	struct dma_buf *dmabuf;
 	char name[DMA_BUF_NAME_LEN];
-	size_t ret = 0;
+	ssize_t ret = 0;
 
 	dmabuf = dentry->d_fsdata;
 	spin_lock(&dmabuf->name_lock);
 	if (dmabuf->name)
-		ret = strlcpy(name, dmabuf->name, DMA_BUF_NAME_LEN);
+		ret = strscpy(name, dmabuf->name, sizeof(name));
 	spin_unlock(&dmabuf->name_lock);
 
 	return dynamic_dname(buffer, buflen, "/%s:%s",
-- 
2.34.1

