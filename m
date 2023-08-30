Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845CD78E1B4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243544AbjH3V4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjH3V4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:56:39 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4AECFC;
        Wed, 30 Aug 2023 14:56:14 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34ca860051fso851995ab.2;
        Wed, 30 Aug 2023 14:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693432512; x=1694037312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw4l7vffGQ7DFvoP/Hb8EaSev5ofO+RAhmjDHMGDV2o=;
        b=RY03xWnaUoSY6kUEjm1bkusBwm0MkPxllry0AXDsbYPbJP01Bu8C38JMqMSNmPBqtg
         KW8Oy1kSUfaQwchJoULF9a+lmyAZ6nZ7bbmv302HM32fwA/9w7BJBhfVKkH3YkmrRxIi
         ZeLZqzn9FM+5uvZTyR6sqE9xkTFf/6x44xuySVXzf7Gs79WqeTARlW5bp22qU5T7rDFI
         aXuJTBCnJDWwb/4V2I0CmihPO304/iyIYDiZsCXgSrtAJqjpJ99c4ucBgknpiwsHIoR+
         8z+e6eXgoPhJ5RG5uJNlvKLwvD2jcp4aJs7VxT6v2HPuQvc6jOYbz+fmK74nFN8mkK60
         SVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693432512; x=1694037312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tw4l7vffGQ7DFvoP/Hb8EaSev5ofO+RAhmjDHMGDV2o=;
        b=VilVybIa7tFus4+mYbmjz255+3eE2dG7hOe7SYLYvrqgpUBarcldjpdkCtzRKrnq1z
         u65kMk8usafnSVJFozeJeAMclOW2BtHpfNFmTlSMBGGDQg8i61exa+8oXOlw8h+FNXqk
         EsHnfcRAJteqVsBTbXBK4yfk2GKorr5VCZW74Pq1Hwv3NMp95yCO9u3HC+ubOdXffD1y
         UZePa53nZAODbb6u7t925OcQ2iWbzE/jX4OuNUiFxIAmWPuxR+2RJm8y81+H9DWzp22s
         /Jxvn08Z2hKjhEFNfsNJWZdY9Ez59sdzg1WujUq+pMOB6jSDffkETMImCeVgwocSZES9
         iNwA==
X-Gm-Message-State: AOJu0YzYBAF68YthTOKVFe7nisCIRPjetpPJrPfMk6d0Pa5hA0jWfRQ3
        GPrZ9ef/oWfGTwlERI5KSIk=
X-Google-Smtp-Source: AGHT+IEZOM0oFGMV4UO92u8JK/496OKYhdek1cjlp4iV8zcc+Cb4xipD2vv/A1r3IBGt/odAlh5h4g==
X-Received: by 2002:a92:da4e:0:b0:34d:ed6e:ca5b with SMTP id p14-20020a92da4e000000b0034ded6eca5bmr3568492ilq.20.1693432512573;
        Wed, 30 Aug 2023 14:55:12 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id v8-20020a92c6c8000000b0034ab6f53e23sm50527ilm.28.2023.08.30.14.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 14:55:12 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 1/2] ocfs2: Replace module_param_call with module_param_cb
Date:   Wed, 30 Aug 2023 21:54:25 +0000
Message-ID: <20230830215426.4181755-2-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230830215426.4181755-1-azeemshaikh38@gmail.com>
References: <20230830215426.4181755-1-azeemshaikh38@gmail.com>
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

module_param_call has been marked obsolete [1], so replacing its usage with
module_param_cb instead.

[1] https://elixir.bootlin.com/linux/v6.5/source/include/linux/moduleparam.h#L296

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 fs/ocfs2/dlmfs/dlmfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 81265123ce6c..33e529de93b2 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -83,8 +83,11 @@ static int param_get_dlmfs_capabilities(char *buffer,
 	return strlcpy(buffer, DLMFS_CAPABILITIES,
 		       strlen(DLMFS_CAPABILITIES) + 1);
 }
-module_param_call(capabilities, param_set_dlmfs_capabilities,
-		  param_get_dlmfs_capabilities, NULL, 0444);
+static const struct kernel_param_ops dlmfs_capabilities_ops = {
+	.set = param_set_dlmfs_capabilities,
+	.get = param_get_dlmfs_capabilities,
+};
+module_param_cb(capabilities, &dlmfs_capabilities_ops, NULL, 0444);
 MODULE_PARM_DESC(capabilities, DLMFS_CAPABILITIES);


--
2.42.0.283.g2d96d420d3-goog

