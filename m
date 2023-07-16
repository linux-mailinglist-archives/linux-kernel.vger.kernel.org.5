Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21E9754CEC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 02:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjGPAmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 20:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGPAmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 20:42:36 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5DE101
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 17:42:35 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-263036d4bc3so2268952a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 17:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689468155; x=1692060155;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AAaGB1X6RygPg8U02LFiZuYkbefG8qTpwEsQCQX7xEY=;
        b=UfPATQBTYcKeHUD0z4Rmm35SobEX5Hfj1yTAeU9epG0mxGURcVMfCXxbd74iHOfI1u
         ZXbeMbfoQbiSijPJk6SeDbSioFhSRUBeUHSGcCL9xX3o32pC3G4ZJ6qrBop6mng4gzjX
         sLw4QHxrhqNhhBRqk1xTHeeN40IJ7gU7SHXd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689468155; x=1692060155;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AAaGB1X6RygPg8U02LFiZuYkbefG8qTpwEsQCQX7xEY=;
        b=l5rlpHQNiusX3iu5wOjSRVjqK+JZxo4JMi/YF00VpNRW9TSb6Fgfl02zHW6EIz1wMM
         8HfEMKuvaS3RdSlpMaQdv+3vPgFrV5neUfOGb0yZONmAdWxi+AqPJnU12V/4gnYaMVeV
         4XkOvk4QQ+YPRxNftHgBwEmK7JB+218t5zS//Mt19BdQDZWC9HlQ55nK0cvp2g+Po3lZ
         5x4mU35XgrDcYFlS9L+Adj5H4K3NM/XxqiCWau2FArsbeAyTKwvhS8c0hqvDY9CPX/xp
         syz/bJilKcGsXVZm4pV25+rluyPTFbXG/JinnoKnRbv8z9Zz4rps/8D/WAqi3z2NYciF
         egNw==
X-Gm-Message-State: ABy/qLYiYvaZ5Yr05m/7vGkaO8akRu97+Sflmt3ttJobxBan9aMzQqlq
        4/O8t5AlTj1PnHh9inBiIi87aQ==
X-Google-Smtp-Source: APBJJlE8gsKYVfeITsL0y52M9jiq1vcBbeR2lAmW9CEF/SmXU8duSr7qR9T5J3xpByl5fsFxslHzTg==
X-Received: by 2002:a17:90a:a38d:b0:261:2a59:dc38 with SMTP id x13-20020a17090aa38d00b002612a59dc38mr7968107pjp.25.1689468154854;
        Sat, 15 Jul 2023 17:42:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090ad98e00b002630bfd35b0sm2888301pjv.7.2023.07.15.17.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 17:42:33 -0700 (PDT)
Date:   Sat, 15 Jul 2023 17:42:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Petr Pavlu <petr.pavlu@suse.com>,
        Sam Ravnborg <sam@ravnborg.org>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: [GIT PULL] hardening fixes for v6.5-rc2
Message-ID: <202307151737.BF9E8B84@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this odd collection of hardening fixes for v6.5-rc2. I
included the somewhat unrelated sparc fix[1] since no one else had picked
it up yet, it was Acked, it had been pinged by the regression tracker,
and I was on CC. :)

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/20230628094938.2318171-1-arnd@kernel.org/

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.5-rc2

for you to fetch changes up to ec7633de404e7ce704d8f79081b97bca5b616c23:

  sparc: mark __arch_xchg() as __always_inline (2023-07-13 09:54:32 -0700)

----------------------------------------------------------------
hardening fixes for v6.5-rc2

- Remove LTO-only suffixes from promoted global function symbols (Yonghong Song)

- Remove unused .text..refcount section from vmlinux.lds.h (Petr Pavlu)

- Add missing __always_inline to sparc __arch_xchg() (Arnd Bergmann)

- Claim maintainership of string routines

----------------------------------------------------------------
Arnd Bergmann (1):
      sparc: mark __arch_xchg() as __always_inline

Kees Cook (1):
      MAINTAINERS: Foolishly claim maintainership of string routines

Petr Pavlu (1):
      vmlinux.lds.h: Remove a reference to no longer used sections .text..refcount

Yonghong Song (1):
      kallsyms: strip LTO-only suffixes from promoted global functions

 MAINTAINERS                         | 5 ++++-
 arch/sparc/include/asm/cmpxchg_32.h | 2 +-
 arch/sparc/include/asm/cmpxchg_64.h | 2 +-
 include/asm-generic/vmlinux.lds.h   | 1 -
 kernel/kallsyms.c                   | 5 ++---
 scripts/kallsyms.c                  | 6 +++---
 6 files changed, 11 insertions(+), 10 deletions(-)

-- 
Kees Cook
