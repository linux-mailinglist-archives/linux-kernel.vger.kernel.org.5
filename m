Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDA47750CB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 04:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjHICOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 22:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHICOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 22:14:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75C71BCE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 19:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691547235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rTa9TiH+Nbxa2120Ikd+iVzWMSduN4Wn5JO47t6FkLU=;
        b=QxU9vY3YCrbvtFW5O2Iq+gUkiyUv1O19LvS+kAtsUWwJOMCj6iXIKDv3AhbBxVsjPZ/8+M
        zNuEKomhbGVZSUZRutItkTdorcQTacXI7ERpNVPewYH+Lo+7SgTfCj70AuFuRPzVqEVB7u
        i1HT3uCkV0cQoEsmeW0TLxSa2pJscK4=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-_7mIaaktPMWItDvMJeR5YQ-1; Tue, 08 Aug 2023 22:13:53 -0400
X-MC-Unique: _7mIaaktPMWItDvMJeR5YQ-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1b728bfb372so10757970fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 19:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691547233; x=1692152033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rTa9TiH+Nbxa2120Ikd+iVzWMSduN4Wn5JO47t6FkLU=;
        b=T9M5rS8Myu53yxQ6er6Xx8CAftPunnUAgqiICL4GAKO4D/g0dBuEc5FJwhDrtUag0y
         mvKZuwvZ7rf7hPJUDwMqiSyWxw4fqOLi1syIc4DiYuIp9lyDzwFaOnXlh12rHzumz7QP
         KCOHBVW/65XD5yoCnDLe4tbisEHuejwNKivWihOY32xTJFxRT9hW70GksT6aWO5uEzaK
         7walY2gRcGG3RrnFsOHF1bHLEw3ralVikNS22c8EMfhtEdk8n9J/cVKraFhJ+EFF/ffq
         VTjVIluvKuzBk42+qdsNhOAlneCc8wPXSzyxyXu43AdknoqmOCkuycF2J1Vt/gSULvOw
         1p/Q==
X-Gm-Message-State: AOJu0YzrEFQres7iMHm+VCLQwHj8zz+GnZydkMSqWxMWy++Zgr9uknBW
        fqtcNfb3nnEZ9H/2N8XlJgl6GtbUTaDLKKtund5ti4EihvPdZtrTKmTdvWkP3V09xHg3XaUuLya
        9zP82thUyo/CDAj0tj/OX6TPV
X-Received: by 2002:a05:6870:7021:b0:1c0:937:455d with SMTP id u33-20020a056870702100b001c00937455dmr1416398oae.47.1691547232928;
        Tue, 08 Aug 2023 19:13:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqkpT1KmB1FHQPpHFcKjNk/v3gmX17a9n9hY2y6PuFc72hYlrXkYhDcUn67exIN3jxg/2rEw==
X-Received: by 2002:a05:6870:7021:b0:1c0:937:455d with SMTP id u33-20020a056870702100b001c00937455dmr1416382oae.47.1691547232692;
        Tue, 08 Aug 2023 19:13:52 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7ec:e667:6b7d:ed55:c363:a088])
        by smtp.gmail.com with ESMTPSA id v10-20020a4a8c4a000000b0054fba751207sm6475518ooj.47.2023.08.08.19.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 19:13:52 -0700 (PDT)
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
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [RFC PATCH v4 0/5] Rework & improve riscv cmpxchg.h and atomic.h
Date:   Tue,  8 Aug 2023 23:13:05 -0300
Message-ID: <20230809021311.1390578-2-leobras@redhat.com>
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

Thanks!
Leo

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
 arch/riscv/include/asm/cmpxchg.h | 394 ++++++++++---------------------
 2 files changed, 195 insertions(+), 363 deletions(-)

-- 
2.41.0

