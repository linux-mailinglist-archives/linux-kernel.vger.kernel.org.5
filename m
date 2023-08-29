Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACCC78C9DD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbjH2QqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbjH2Qpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:45:54 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E713219A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:45:49 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-64b3ae681d1so23636606d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693327549; x=1693932349;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gd7wbDLNyz8eBHL7fGCPyOOExG5MY/ZyAjupuh5K/2U=;
        b=HaXmMM9EX6NG/E/ePntVX4MvLS/9Bx4fRXcv7ussLeXTZOdZOS/LqfmjBM8ohryTt9
         wvBkhAnaAh9sYZ8KMb9StpU5wQ78P4J//rF2vCmv6OtBEmW4y6c0ZPzOV8Z92s1j465E
         6BJQVeujYC6QBknB+9VhksHfV8vWWR+U56HltBfS8MYs341LnooqP6sfzTMVDYPr7/j5
         5fYnCGD1dMdnL5Tp+f4DSIgcqd59EKNU52fLtXhcp8O8EhE0UZEjnk2CPXe36aIcNIvM
         BV7URAe3NbqVPg1m+61uFXuXgFuaxlMuqD2P2cHRbRALOrQUMeU1ntTM7eY2AQVVmjhM
         ukoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693327549; x=1693932349;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gd7wbDLNyz8eBHL7fGCPyOOExG5MY/ZyAjupuh5K/2U=;
        b=gQ5uVoAqzc2tk2gEW7KnHVVXHqSQnvd7pUVKw+otPn7viYv7JQ5SqW2NtGRZg9v1b7
         k73oipgQWN/8itYV6qxeKkgISW7F9W6nF6ODo45pudGCJjE8adD99EbPvw3AILl59bHe
         e3gsp12sqJ+kDAtLNThJanP15B8Cfqpr0XlcgEoatr1J5JXG0r/hy47M1yw5C8XWDRXN
         7seShCQt6pt3Q+2euIxksF6vyW4VpZZMR9OGBDTgWecd0bzwRUnSKZrNP7ASXaA39/tD
         mfblYH25OlVtwGSWCXH8UVh0gZJrPMGU91ayxzAj8zVjOCUNc93oSuklwIVTKYhpQSuE
         6f4A==
X-Gm-Message-State: AOJu0YzGysYP5RjgFquYN5jCOMbxLkBCWmMIcx22V81OmokNrGVGLSVT
        psd/MQK9uvrqF7RE8VDCyY5S9iEXm9a2VFz9uZnZjg==
X-Google-Smtp-Source: AGHT+IFMxQxI9GFxNCtBrC7GsH5CSI9yib7ImtOZtC9YNFMY9C889/jaH2b0JivfMTd74M/lUF+8Hsx7eUcoq7MLAFE=
X-Received: by 2002:a0c:e451:0:b0:64f:91de:2ece with SMTP id
 d17-20020a0ce451000000b0064f91de2ecemr7657913qvm.21.1693327548975; Tue, 29
 Aug 2023 09:45:48 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 29 Aug 2023 09:45:38 -0700
Message-ID: <CAKwvOdn0xoVWjQ6ufM_rojtKb0f1i1hW-J_xYGfKDNFdHwaeHQ@mail.gmail.com>
Subject: truncation in drivers/video/fbdev/neofb.c
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helge,
A recent change in clang made it better about spotting snprintf that
will result in truncation.  Nathan reported the following instances:

drivers/video/fbdev/neofb.c:1959:3: warning: 'snprintf' will always be
truncated; specified size is 16, but format string expands to at least
17 [-Wfortify-source]
drivers/video/fbdev/neofb.c:1963:3: warning: 'snprintf' will always be
truncated; specified size is 16, but format string expands to at least
18 [-Wfortify-source]
drivers/video/fbdev/neofb.c:1967:3: warning: 'snprintf' will always be
truncated; specified size is 16, but format string expands to at least
17 [-Wfortify-source]
drivers/video/fbdev/neofb.c:1971:3: warning: 'snprintf' will always be
truncated; specified size is 16, but format string expands to at least
17 [-Wfortify-source]
drivers/video/fbdev/neofb.c:1978:3: warning: 'snprintf' will always be
truncated; specified size is 16, but format string expands to at least
18 [-Wfortify-source]
drivers/video/fbdev/neofb.c:1985:3: warning: 'snprintf' will always be
truncated; specified size is 16, but format string expands to at least
17 [-Wfortify-source]
drivers/video/fbdev/neofb.c:1992:3: warning: 'snprintf' will always be
truncated; specified size is 16, but format string expands to at least
18 [-Wfortify-source]

https://github.com/ClangBuiltLinux/linux/issues/1923

Clang is right here.  `info->fix.id` is declared as `char id[16];` so
indeed string literals like "MagicGraph 256AV+" indeed lead to
truncation. But this is declared in include/uapi/linux/fb.h; I assume
those headers cant be changed? Can the strings be shortened then? Is
it perhaps time to delete this driver?

I see AKPM mentioned alluded to this in
commit 0e90454 ("neofb: avoid overwriting fb_info fields")

(Also, snprintf probably isn't necessary for string literals that
don't contain format strings)
-- 
Thanks,
~Nick Desaulniers
