Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2AF805DD5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345900AbjLES0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjLES0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:26:17 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF86137
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:26:24 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6ce4d4c5ea2so2057350b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701800783; x=1702405583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wDRhZuKBW48GNQpmqmsxTIXOsczpKCnXSPXQeVWHtu0=;
        b=n0avSz/z224SxrSvzjKua1cEjnDTx652lT1Wd72I758HRmP8EMlL6mwqj7fl/7soED
         HacBSedNon5QPWTt/HDAYPsxJyuCg96iV+k9LEXHGD9Q0bmPXVZVTEVBnuSCu/Ttbydh
         ZsrqMQcM0ZYrE8WA96dzH37pJj0SSlyMDzidU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701800783; x=1702405583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDRhZuKBW48GNQpmqmsxTIXOsczpKCnXSPXQeVWHtu0=;
        b=DlxncKzRM6tYVrx63Ik3geeOkGRP/KIf7hRxbJncECVYWTS4cqth3qvXyd3G08gftK
         O1DNq2UmOHI0w6mK965Y1AoZ7K088agyP669y/ugd6LGtAVEGxK3xvavGTMyqjDcFDZd
         wSfrcPRn9IOHkOR6ytH1h1NJ2d/dsIYEuB5HmpyjjBg0oOCbPwsrGkk2E2LWKqOEAAEA
         lZ8fXy29RXw8ZE1w+Y0KVtJJSATpx9JOSb4i6Vg/beN50GPZ9nX21P/V0P+ELych/2jZ
         5f5UYmfzji1ni0uah5xjgxIlvZptHgenVuPrd4fCIYzZ7Snwf5sObViRK82FBn3GVOCB
         8qiQ==
X-Gm-Message-State: AOJu0YzZSYNOyTTo28z95JJl1PSHUSoR4IFa0Fo2OvzeK8MioZotSpoc
        Wv5nZjIjPJH5UCnZ9Df/79NYFQ==
X-Google-Smtp-Source: AGHT+IE9mqxJSNzT6TFZok8X88x8mUH3rdWZu33j0pIAsT9/mSpN34lnJveLP/vd6PmvljkIXSQKAw==
X-Received: by 2002:a05:6a00:e0a:b0:6ce:412a:2a60 with SMTP id bq10-20020a056a000e0a00b006ce412a2a60mr1571653pfb.38.1701800783659;
        Tue, 05 Dec 2023 10:26:23 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fa20-20020a056a002d1400b006a77343b0ccsm6378089pfb.89.2023.12.05.10.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:26:23 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/4] pstore: Initial use of cleanup.h
Date:   Tue,  5 Dec 2023 10:26:13 -0800
Message-Id: <20231205175449.work.110-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=745; i=keescook@chromium.org;
 h=from:subject:message-id; bh=u5o9ZYed+uCk13yI3FyCPjzN9M5C8/cwuxOhPLAexWg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlb2tIGWTs9ttimKCsudZhkbcLzZrHFzhiLJ9Ts
 HSrqeuud5+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZW9rSAAKCRCJcvTf3G3A
 JuYED/9C9IsZbrt7Zi8cQNhlHe59fqiWojAo+adAp3XPPVwluXxWNtJ1TpkoBoX56J5+8oiOgHN
 YEi5p65yPI30AMiMwzz9oJ/snalo9ql7BjqYOYSdDSPuzJqQJAao5ka3AnwEwidqSe4YnLhbJYX
 KqUOo+MTiQg9K9K3LBYkceKevz+JCHlQvkPQoEDGpMLXdrO15FCMYn56IAU6bhj3IfYT4pog/uZ
 c3DA1ToL7j32MiM7EPYyh92FMDURwensMoxlr6nhDTRPb6CkkW+I/SzJKIm6qbOEVDBqlLEcaGj
 Z67RiPnguQuQnHcBZZlWvF/nH9xjvrflCT+JSVL3LkGcsIwAnfpsXHQMjELaFvGof452MuWDWHO
 t6AwzHZoBEJiuooiEIyzURsI3bcw66y1nLVAjFdM6CFEJZfKFV1mO83u003E+huXyxfUYPS2/kA
 AgPtHeILCWymngXokDYX7HPF6aeEPkRpgTC8XijRXHnl23J3MPgJe2jjA4otstBpLkAyNuu28J2
 bgwfCZaKgHLiKNPNmR+6FatYts9yNLBboM9Se1G5MzF7cc5EPrjlhB6rekuaiF+Ox31+PGYRHri
 xMFHQEyjlxsilZo9l9gVm2rxEHCAjSFgi3bV1twFGCyHxs45MVtr8MIr5pp3nRKX5ih6Ccrzprv
 X0czXlQN FW2UCUA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Mostly as practice for myself, I rewrote a bunch of the error handling
paths in pstore to use the new cleanup.h routines. I'm enjoying this part:
"44 insertions(+), 65 deletions(-)"

It also passes basic testing. :)

-Kees

 v2: do not add a global iput macro
 v1: https://lore.kernel.org/lkml/20231202211535.work.571-kees@kernel.org/

Kees Cook (4):
  pstore: inode: Convert kfree() usage to __free(kfree)
  pstore: inode: Convert mutex usage to guard(mutex)
  pstore: inode: Use __free(pstore_iput) for inode allocations
  pstore: inode: Use cleanup.h for struct pstore_private

 fs/pstore/inode.c | 109 +++++++++++++++++++---------------------------
 1 file changed, 44 insertions(+), 65 deletions(-)

-- 
2.34.1

