Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6D777FE66
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 21:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbjHQTP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 15:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354618AbjHQTPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 15:15:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1CC359B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 12:15:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58c561f4ac3so1767677b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 12:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692299699; x=1692904499;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bFN9dp01RtqHwqhQI1dVarxsGtiPL2F5fMs/c+uKdWk=;
        b=DjzAqPJrxIfw1BYw5i3FrieFrPSbaM+YcbWnz6sZAiIOz7zApNgX/BlsxaUITOB7iw
         yCnIS239SXQ+yTqLs6JZm/h3Jvfh3dh4+oOkiUGEnKp9cLL875BN2opF+m5WNDI/TG0J
         mPOdug1WnENIOFf5R7TJzlcr5pE5G7Gx/n0lWRxl9fk3MRMc/eWHeq+9IjPMT09mNcFa
         PsmRvN7tq4U1WIYX7DdU2daYJB49YcuvtbHqDDIEm1A8jv2TvEyyCqt2cWIzJBHINfOj
         cxrWVcT75yc6XmnLiK/PPsf/IBFO5mupHWPXQs3Z7Lf7+YN2wxPC8wJvtDQY27iF9rrS
         2Z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692299699; x=1692904499;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bFN9dp01RtqHwqhQI1dVarxsGtiPL2F5fMs/c+uKdWk=;
        b=XloQH7PcDiLfwevH89k0RoJli4IylKbtOvXyeOJqOwxbgQYCd5BRa4zHKh9oOKwcyw
         q0xzb5EdQ3mBq4+wYJePj3+6a3eA+mEiQiAUBhOYVvgkmljOuwvA9vdzrRPCGhk2uKV8
         Fz84DaGbF+7zTQDZlCIsZWltzQF80b8BCg+KWnwVlbg3wmNMi7D14JOR4rMbKgwJJIJA
         qhesyNxbYsV9aVMVdTQq4q+pCBhUZkSXWhvUsNsiw5f6saXlcfnFXuE7ZLz3uSLFlfD2
         Dla0FcA8Lwk3vKmQf7oFBiQtUo1weHAr2VQQsT5oSMdAwynYpq9xEd/b1LmQefft7NO7
         wphg==
X-Gm-Message-State: AOJu0Yzs1rzRmOjxG8pe9LwvB/Ipt4jcKhlw5fQ2GSC/0rJxzIZP+0Il
        62omOdK0TVKw9BGnX7SdObm5f69rNA==
X-Google-Smtp-Source: AGHT+IGX5b4WQOsC3kP+cTVvJ7mVySPhcsavQyeEdDAUh6zcBnD/TXahce8aIDy43n9+rZRTSf81ojTVhw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:690c:707:b0:58c:9fda:d043 with SMTP id
 bs7-20020a05690c070700b0058c9fdad043mr4166ywb.10.1692299699585; Thu, 17 Aug
 2023 12:14:59 -0700 (PDT)
Date:   Thu, 17 Aug 2023 19:14:51 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230817191451.1026413-1-rmoar@google.com>
Subject: [PATCH] kunit: fix struct kunit_attr header
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add parameter descriptions to struct kunit_attr header for the
parameters attr_default and print.

Fixes: 39e92cb1e4a1 ("kunit: Add test attributes API structure")

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308180127.VD7YRPGa-lkp@intel.com/

Signed-off-by: Rae Moar <rmoar@google.com>
---
 lib/kunit/attributes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
index 5e3034b6be99..1b512f7e1838 100644
--- a/lib/kunit/attributes.c
+++ b/lib/kunit/attributes.c
@@ -30,6 +30,8 @@ enum print_ops {
  * attribute value
  * @filter: function to indicate whether a given attribute value passes a
  * filter
+ * @attr_default: default attribute value used during filtering
+ * @print: value of enum print_ops to indicate when to print attribute
  */
 struct kunit_attr {
 	const char *name;

base-commit: 582eb3aeed2d06b122fba95518b84506d3d4ceb9
-- 
2.42.0.rc1.204.g551eb34607-goog

