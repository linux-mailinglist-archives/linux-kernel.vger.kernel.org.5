Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0835878F36E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347189AbjHaTil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjHaTik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:38:40 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF391BF;
        Thu, 31 Aug 2023 12:38:38 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-792717ef3c9so43532039f.3;
        Thu, 31 Aug 2023 12:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693510717; x=1694115517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ki/OwjIU18DtuVHU8h+/teFMT7QJKmhWe1t8w4B3+I=;
        b=GeAGRMMNGNTuk3oMQ1YPb8/QzisV2xZjEo8h/lkYfwHNEfAxFKiNFvWczvUP0xIzHp
         UVetJc58Mxb1J9DndYsOvf7ovYWBH0/Z/uFpmrEZIS1iNqJNV40j5FGQZ0f7Gp5GPolL
         6nzLmAUGwV4dPKZiqZ5V1jYbq1D08P9GCHpxxzM0saNCeXsMRi0EKIzg3uOCb6FkHrmH
         xIKlzBU8vUuyIhdVJ4SkxPWxzR5s9jyH/pSf5cIV61YyJlrYYdIwcI4drcfvW+pnRxwc
         lTvg6zAbuEtSQp44PH7lcxNNS/d7+KdePDw+R2ih1b7PkGmKyhivDnHqoFYdLBcKDjcr
         9NGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693510717; x=1694115517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ki/OwjIU18DtuVHU8h+/teFMT7QJKmhWe1t8w4B3+I=;
        b=OoISb+PI9fb9PSDuZpDASpK9PJu2c58tr9YMgO0dzY/sf+YW77AczfKDL9YhkP5J8A
         6FJjdLdcBBvfZVbyaGNxtPJ9ks23rFJuDROQwV9y9sRLrEMDwlh0KPg1vYPSZ0uGdBg3
         bttRVgM1bG+8KeIs54ehz2908MdW+dl9AYjOK695gOli3NHoLFmvVxH9J6w0dCNghsgS
         5A3BMAYLzUFeW/8uCvShhRSl4FAV7/FwokKDUb7c+mr71kmEqW6AWebAUtXjKyYXuZBs
         ULDBVYU0bGV8hiHbXwFSvVYHF31Wg+WxwEwoaqT2ojr9z1Wxgx+6wzXl7vC3UIXyLlde
         wS1g==
X-Gm-Message-State: AOJu0YyDtOAtxR2xGldoQFXi6jjw1afbDliyYO/oBY5q1bJZ3l1TQ63z
        8o4tW+IeTimKfza0XPHk3zM=
X-Google-Smtp-Source: AGHT+IGvlsa8+EI3f6HZsE4SZNDJ3JjIgHosSPzt0rFM0ScC3i7qQ67POY4bnNCVUgtcIdCO4Em9Cw==
X-Received: by 2002:a5e:c80f:0:b0:783:5209:c01 with SMTP id y15-20020a5ec80f000000b0078352090c01mr224313iol.17.1693510717430;
        Thu, 31 Aug 2023 12:38:37 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id gc10-20020a056638670a00b0042b39f1c3d2sm579001jab.144.2023.08.31.12.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 12:38:37 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2] fs: ocfs2: Replace strlcpy with sysfs_emit
Date:   Thu, 31 Aug 2023 19:38:27 +0000
Message-ID: <20230831193827.1528867-1-azeemshaikh38@gmail.com>
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

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with sysfs_emit().

Direct replacement is safe here since its ok for `kernel_param_ops.get()`
to return -errno [3].

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89
[3] https://elixir.bootlin.com/linux/v6.5/source/include/linux/moduleparam.h#L52

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
v2:
 * Removes patch [1/2] which replaced module_param_call with module_param_cb.
 * Use sysfs_emit instead of strscpy.

v1:
 * https://lore.kernel.org/all/20230830215426.4181755-1-azeemshaikh38@gmail.com/

 fs/ocfs2/dlmfs/dlmfs.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 81265123ce6c..b38776ba3306 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -80,8 +80,7 @@ static int param_set_dlmfs_capabilities(const char *val,
 static int param_get_dlmfs_capabilities(char *buffer,
 					const struct kernel_param *kp)
 {
-	return strlcpy(buffer, DLMFS_CAPABILITIES,
-		       strlen(DLMFS_CAPABILITIES) + 1);
+	return sysfs_emit(buffer, DLMFS_CAPABILITIES);
 }
 module_param_call(capabilities, param_set_dlmfs_capabilities,
 		  param_get_dlmfs_capabilities, NULL, 0444);
--
2.42.0.283.g2d96d420d3-goog


