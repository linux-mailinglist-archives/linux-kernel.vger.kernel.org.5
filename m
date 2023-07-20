Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB0775AC1A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjGTKgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjGTKgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:36:04 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DC81701;
        Thu, 20 Jul 2023 03:36:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9922d6f003cso115598066b.0;
        Thu, 20 Jul 2023 03:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689849360; x=1690454160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SUzZiQbIbwXExbwyLXyL6QTtU7zKUZIs5oay+PeoQH4=;
        b=lbGAhI3TWPCeHfjuTvzHxUhuanEelb/heJ7SeHctCRYfm+QWF8GHn8Md+He+VbiGXZ
         QlGXhDQfXsHA5j6cRbnU2NnRAfxcjpMhA3LSuP/aDtd2nzHfqsIRN7ATOF6tJ9sGiiyE
         iX7nHni3ggsr7NLqwIjpCswqaHAUD/HUukm/BgAyx7qU7tumOpIcMYFrwkgYxgR3tpsb
         vhXmSj59goiwRwyY3OQKYqjAoUynyL/lf2bFSO5xinYswZL7bjBDVbRiegECwjTEoK0X
         f9SmgN/4g3reSciKakAhevHDI0Tet1HTmogQdn5QoMxmvAyRk1tWIOa0F2aD3ZeB37G9
         CtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689849360; x=1690454160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SUzZiQbIbwXExbwyLXyL6QTtU7zKUZIs5oay+PeoQH4=;
        b=f8aYa4xczfi+Z7pEvpdrVXLW/ChvnKieKPCiIy/nweSTLhqQILFSdUzlXDKasYmXjZ
         KOMW+CFyUOO3/I82cB2QNL5IPhv58JKvHb2NVvhf2xCDXqEkxEFMKi1b6FhgCkgy5evs
         5uspAjVJNxQmjeGebutzyX1eiLaJu4x7/m3/H1EK8kt+nq0QVuDKHfX/69bh/TNCdtb7
         +6KNN1XfKpyArUkl9t6uFWmCWz0IMCyfodm+LI8JGyOLaBYOUoS47+UsURSj2hS3fj9x
         qc40Q9EueYrdrPXIbg6LzRwRaXqmswVLRBmvjTAqNQ4and3B8TGQIzmZDXEDOXiTvmQd
         183A==
X-Gm-Message-State: ABy/qLZh52JN6wCU2j8QqaxrC0f47S2vUohWrDNg6UzXuKU2G/aRZzct
        nT8Vm9GSHU2WM786qeVo4kPD77eVuBRPQg==
X-Google-Smtp-Source: APBJJlHU7RWvGxx4xRhz7aGfsiE5xm9sPm1j5fol2plE9ifR8JSz0gNkRTG0N1XxmLaYU9NQHPhTyA==
X-Received: by 2002:a17:906:3f4f:b0:997:e7ce:1e8e with SMTP id f15-20020a1709063f4f00b00997e7ce1e8emr4858854ejj.55.1689849359620;
        Thu, 20 Jul 2023 03:35:59 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-188-137.77.8.pool.telefonica.de. [77.8.188.137])
        by smtp.gmail.com with ESMTPSA id z9-20020a1709064e0900b009886aaeb722sm496540eju.137.2023.07.20.03.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 03:35:59 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] selinux: log about VM being executable by default
Date:   Thu, 20 Jul 2023 12:35:49 +0200
Message-Id: <20230720103549.25255-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case virtual memory is being marked as executable by default, SELinux
checks regarding explicit potential dangerous use are disabled.

Inform the user about it.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/hooks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6f53fa71fbdb..3a7ece84c2cc 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7265,6 +7265,8 @@ static __init int selinux_init(void)
 	cred_init_security();
 
 	default_noexec = !(VM_DATA_DEFAULT_FLAGS & VM_EXEC);
+	if (!default_noexec)
+		pr_notice("SELinux:  virtual memory is executable by default - related checks disabled\n");
 
 	avc_init();
 
-- 
2.40.1

