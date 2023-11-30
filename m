Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D977FFDA8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376966AbjK3ViS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376859AbjK3ViR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:38:17 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8171B4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:38:23 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-285e7c85b30so1342149a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701380303; x=1701985103; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tv/W2i+Ora8wm4sYpY7PJR8dJg+WnKNNi1TxcxV1QCY=;
        b=U4zLMavLwXkb/dMXeD8CEJDxk91k0NCqqb+fa+zq0MbpqzNzrjrFMlOJs5DD+Ox9RB
         59Z3PnrYw2rD1aXaMJ4dfcLZlN295BxGlMoNVzVLYK0o6ZMKGiX1vsZh1/yXAkXz7572
         vd62bSM/t8zY1s0PMwPQ2cWygrKBXaAs67Akk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701380303; x=1701985103;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tv/W2i+Ora8wm4sYpY7PJR8dJg+WnKNNi1TxcxV1QCY=;
        b=En3tUEw0XVA982Qrbuf/tz/6ijghCPTZ2thpYziqXTLIM98yjV7yOf2u90vvYV8NLO
         VKbBOmXOyCxTGyt5kyUvXo4JtsoJ/pedPdQKz+GB5cA1pVr4yJ9pC3+uGCqohuGaUHH3
         EzxV1jjtvl/SaHz6B6J6Ppkdg+uSB0Dwj/xDkTbGYRbWV1gv4/dy7jVo4cp06WM3WuSI
         KOStU5/pSVgAx/wI81dVe/4gpT8B/uprEXwV9evD2pG2U4g6FIM1M7DcHCFZBMUvUkga
         HQQyVLHBYaeGy+5iLLvABeSn9tJJ5/x32aCBH968F3kBCBzfPFX/j339GeBid3h5AatP
         icWQ==
X-Gm-Message-State: AOJu0YwMGECtMDdjOmnWCuiNG6HBex3qOMvT211SLdn8AYSlV+2PKQzK
        cYTGMKwXipKxNYX7aFyKskV7Yg==
X-Google-Smtp-Source: AGHT+IGqsVkpV5wrxMFi2BxZymWRA9gHXWOvj19d8T0m31HmSlaQNiIh70vhYcIrxWpMlhgnhGv2fA==
X-Received: by 2002:a17:90b:3a8b:b0:285:cc9c:75a6 with SMTP id om11-20020a17090b3a8b00b00285cc9c75a6mr17269552pjb.32.1701380285713;
        Thu, 30 Nov 2023 13:38:05 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z6-20020a17090abd8600b00285bb022192sm3685767pjr.20.2023.11.30.13.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:38:05 -0800 (PST)
Date:   Thu, 30 Nov 2023 13:38:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
        Dmitry Antipov <dmantipov@yandex.ru>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [GIT PULL] hardening fixes for v6.7-rc4
Message-ID: <202311301337.4070D0BEA3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these hardening fixes for v6.7-rc4.

Thanks!

-Kees

The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.7-rc4

for you to fetch changes up to d71f22365a9caca82d424f3a33445de46567e198:

  gcc-plugins: randstruct: Update code comment in relayout_struct() (2023-11-27 16:30:05 -0800)

----------------------------------------------------------------
hardening fixes for v6.7-rc4

- struct_group: propagate attributes to top-level union (Dmitry Antipov)

- gcc-plugins: randstruct: Update code comment in relayout_struct (Gustavo
  A. R. Silva)

- MAINTAINERS: refresh LLVM support (Nick Desaulniers)

----------------------------------------------------------------
Dmitry Antipov (1):
      uapi: propagate __struct_group() attributes to the container union

Gustavo A. R. Silva (1):
      gcc-plugins: randstruct: Update code comment in relayout_struct()

ndesaulniers@google.com (1):
      MAINTAINERS: refresh LLVM support

 MAINTAINERS                                   | 8 +++-----
 include/uapi/linux/stddef.h                   | 2 +-
 scripts/gcc-plugins/randomize_layout_plugin.c | 3 +--
 3 files changed, 5 insertions(+), 8 deletions(-)

-- 
Kees Cook
