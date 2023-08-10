Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F2E776EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 06:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjHJEE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 00:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjHJEE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 00:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE93A103
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 21:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691640249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2OLbepSphciEGJE4bJCxealOkUeL/9cWm3RUGVYxJgs=;
        b=LWj/ts4UvmvvpJSfaYsYD1v6D6s8t3QZmcGtZ47J2a83HTEweoormHfNMR2mOb8de9E2wz
        SWsksKCd/rASSYnuCOYLa+36j/GL8mVgLuO5m7Ce9bL7F0iXuDwjjmM1mmbiKSubzRnEOz
        WXOlt6jKZiOnsNkQMeH39PWjPpc3NHc=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-CdJ2hI0XO3S9TXdNuJ2XSQ-1; Thu, 10 Aug 2023 00:04:07 -0400
X-MC-Unique: CdJ2hI0XO3S9TXdNuJ2XSQ-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a1bcdd0966so585837b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 21:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691640247; x=1692245047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2OLbepSphciEGJE4bJCxealOkUeL/9cWm3RUGVYxJgs=;
        b=GjHTo0BkN5Ll8HjyYJSxHFI75w0XrH+TCt0g9hFhkR/C/EiNvyPDVKA61BiV3QUuKN
         AtSgwxaUI5ATDMgFrEBGdGaT+HE+hPJ1fbgiB7Ev9jKUydRIfQYUuyplf5oBNoUv64Mn
         iAe3JR23D3l9C3M882q46/oSAeXSGud7ETlDJ3SQ7iMrOPl3XVAVFIUZLxAMqkH//9Po
         0RA1+w+h/7iw2S5731X0wasdKV4AtsCit+xtBLTe8olUleBJQUm2MjwK1xg9W2GHRk28
         t2vDkCUqQtEKSs+ECcKJvt1jC4PzEbjevIS+VhrmLf2QZqC1Jeyq6FBk48mUdktK4bPk
         rc8g==
X-Gm-Message-State: AOJu0Yw15vgd8pAq8uuMyWgLOfiA4vcQKEbeDvu/L5ewdUpiu6ZdyDIk
        7nisT2BEhcWstMzDex8qoqlFSgYjCcVMZlntYr/+zRqDZAShV3ZG+XU8yt4KW5F6d8CRwDZ5qOI
        G9TXIXfQTgtroBSVTRxwblxGW
X-Received: by 2002:a05:6808:f8f:b0:3a7:b5ea:f5e7 with SMTP id o15-20020a0568080f8f00b003a7b5eaf5e7mr1590104oiw.39.1691640247259;
        Wed, 09 Aug 2023 21:04:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGrVTABi9DM/7BtIXxZ1gTcVgv3KREaNdRSut6DEtFrG77Otdfw7ErMXSR9FZjkKtmYK8ufg==
X-Received: by 2002:a05:6808:f8f:b0:3a7:b5ea:f5e7 with SMTP id o15-20020a0568080f8f00b003a7b5eaf5e7mr1590084oiw.39.1691640246996;
        Wed, 09 Aug 2023 21:04:06 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7ec:e667:6b7d:ed55:c363:a088])
        by smtp.gmail.com with ESMTPSA id b12-20020aca674c000000b003a7b5193909sm310087oiy.19.2023.08.09.21.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 21:04:06 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [RFC PATCH v5 0/5] Rework & improve riscv cmpxchg.h and atomic.h
Date:   Thu, 10 Aug 2023 01:03:42 -0300
Message-ID: <20230810040349.92279-2-leobras@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While studying riscv's cmpxchg.h file, I got really interested in
understanding how RISCV asm implemented the different versions of
{cmp,}xchg.

When I understood the pattern, it made sense for me to remove the
duplications and create macros to make it easier to understand what exactly
changes between the versions: Instruction sufixes & barriers.

Also, did the same kind of work on atomic.c.

After that, I noted both cmpxchg and xchg only accept variables of 
size 4 and 8, compared to x86 and arm64 which do 1,2,4,8.

Now that deduplication is done, it is quite direct to implement them
for variable sizes 1 and 2, so I did it. Then Guo Ren already presented
me some possible users :)

I did compare the generated asm on a test.c that contained usage for every
changed function, and could not detect any change on patches 1 + 2 + 3 
compared with upstream.

Pathes 4 & 5 were compiled-tested, merged with guoren/qspinlock_v11 and
booted just fine with qemu -machine virt -append "qspinlock". 

(tree: https://gitlab.com/LeoBras/linux/-/commits/guo_qspinlock_v11)

Thanks!
Leo

Changes since squashed cmpxchg RFCv4:
- Added (__typeof__(*(p))) before returning from {cmp,}xchg, as done
  in current upstream, (possibly) fixing the bug from kernel test robot
https://lore.kernel.org/all/20230809021311.1390578-2-leobras@redhat.com/

Changes since squashed cmpxchg RFCv3:
- Fixed bug on cmpxchg macro for var size 1 & 2: now working
- Macros for var size 1 & 2's lr.w and sc.w now are guaranteed to receive
  input of a 32-bit aligned address
- Renamed internal macros from _mask to _masked for patches 4 & 5
- __rc variable on macros for var size 1 & 2 changed from register to ulong 
https://lore.kernel.org/all/20230804084900.1135660-2-leobras@redhat.com/

Changes since squashed cmpxchg RFCv2:
- Removed rc parameter from the new macro: it can be internal to the macro
- 2 new patches: cmpxchg size 1 and 2, xchg size 1 and 2
https://lore.kernel.org/all/20230803051401.710236-2-leobras@redhat.com/

Changes since squashed cmpxchg RFCv1:
- Unified with atomic.c patchset
- Rebased on top of torvalds/master (thanks Andrea Parri!)
- Removed helper macros that were not being used elsewhere in the kernel.
https://lore.kernel.org/all/20230419062505.257231-1-leobras@redhat.com/
https://lore.kernel.org/all/20230406082018.70367-1-leobras@redhat.com/

Changes since (cmpxchg) RFCv3:
- Squashed the 6 original patches in 2: one for cmpxchg and one for xchg
https://lore.kernel.org/all/20230404163741.2762165-1-leobras@redhat.com/

Changes since (cmpxchg) RFCv2:
- Fixed  macros that depend on having a local variable with a magic name
- Previous cast to (long) is now only applied on 4-bytes cmpxchg
https://lore.kernel.org/all/20230321074249.2221674-1-leobras@redhat.com/

Changes since (cmpxchg) RFCv1:
- Fixed patch 4/6 suffix from 'w.aqrl' to '.w.aqrl', to avoid build error
https://lore.kernel.org/all/20230318080059.1109286-1-leobras@redhat.com/

Leonardo Bras (5):
  riscv/cmpxchg: Deduplicate xchg() asm functions
  riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
  riscv/atomic.h : Deduplicate arch_atomic.*
  riscv/cmpxchg: Implement cmpxchg for variables of size 1 and 2
  riscv/cmpxchg: Implement xchg for variables of size 1 and 2

 arch/riscv/include/asm/atomic.h  | 164 ++++++-------
 arch/riscv/include/asm/cmpxchg.h | 404 ++++++++++---------------------
 2 files changed, 200 insertions(+), 368 deletions(-)


base-commit: cacc6e22932f373a91d7be55a9b992dc77f4c59b
-- 
2.41.0

