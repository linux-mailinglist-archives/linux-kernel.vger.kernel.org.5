Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9738D79DCB4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 01:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjILXeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 19:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjILXet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 19:34:49 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FD31702
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 16:34:46 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c382f23189so59435ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 16:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694561685; x=1695166485; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H500R7KXtKHiSjqNGrh9ix7Bt5gTMBgVSxiIDYkrDUs=;
        b=Xb3/w3uWRU7MkLKS7YkV95QqQ1GIauD3Sf704dfn7BkJhWfMdSp7MBJgC52038+OWM
         6B7ajYjAcpS/DVlZyXtwurKbsyf6tLhOKN5deDPnOHGhDIKhSRMore/2xJ+qK/KKqgxA
         gE/zQmSCaTwHjQS+0gEQtbbP//O+2gnUlCb42YzJN+HC7WHIsDNavGZ66iEwMHnWd/na
         y9fnQ+2JhU5lwgB0xOaAbYiQDdApS32s8mVJ8I+Onpmkca/suwqC6B66vQM2hewj76uv
         BQ+3PQdYn1DNUyRVQMkEVPuzOxB/hPVmIU6HQIgABBqUo3Vi9sN/tU7+v5L4H/pYgDiL
         0RTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694561685; x=1695166485;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H500R7KXtKHiSjqNGrh9ix7Bt5gTMBgVSxiIDYkrDUs=;
        b=UYpmy6YEOKaV/2R+7pMbMN4wqjYL2iYfPXXTxtPTz8Ze7PcIISj91KTq3I2w2zGFa2
         OdJZ/AZil87kphkRNITRn/0tf2v8vSPRnBtx5PhNuft66tGXEhbx3dCzcxTsQWM3qqFS
         VIVRXpUkhw1M+6/0oYp5WiS3eT8wXOzczQH1Oa/1+Zwf1BN8NgmchyJd9IOSEUkBIAB1
         Mvh8O4CHBpS4l8JYkK3NC21IXpdkhHcStozq5WqO6I+M2UrjDMuA/bwodVX3sYhOJzWk
         QH96C9uZrbHHkk254SzTQsJXzSARvGBvzb/PDFAE9QGijQhnb/p+9IXC321uPgtmR1g+
         MtpA==
X-Gm-Message-State: AOJu0YybE/rdKhcI4/yFdud6POzeh37OMubP04j1V7Aa0LxXxsLzL7tU
        a5EGoME3D3N59Kz3Fs/uzuQBFQ==
X-Google-Smtp-Source: AGHT+IEOSomxv+JSs0gTTEy/GpNE7HFvipjdqNezdLOo+qdj7aoqFTtvQct64/g6MlRQUG4OnJrypA==
X-Received: by 2002:a17:903:283:b0:1af:90ce:5264 with SMTP id j3-20020a170903028300b001af90ce5264mr41414plr.27.1694561685058;
        Tue, 12 Sep 2023 16:34:45 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:205:94b7:2050:b571:8164])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902bc4800b001bf846dd2ebsm9002100plz.303.2023.09.12.16.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 16:34:44 -0700 (PDT)
Date:   Tue, 12 Sep 2023 16:34:36 -0700
From:   Fangrui Song <maskray@google.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v9 6/6] riscv: Use --emit-relocs in order to move
 .rela.dyn in init
Message-ID: <20230912233331.zejmknzcm5mwzzcz@google.com>
References: <20230329045329.64565-7-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230329045329.64565-7-alexghiti@rivosinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-29, Alexandre Ghiti wrote:
>To circumvent an issue where placing the relocations inside the init
>sections produces empty relocations, use --emit-relocs. But to avoid
>carrying those relocations in vmlinux, use an intermediate
>vmlinux.relocs file which is a copy of vmlinux *before* stripping its
>relocations.
>
>Suggested-by: Björn Töpel <bjorn@kernel.org>
>Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
>Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>---
> arch/riscv/Makefile          |  2 +-
> arch/riscv/Makefile.postlink | 13 +++++++++++++
> arch/riscv/boot/Makefile     |  7 +++++++
> 3 files changed, 21 insertions(+), 1 deletion(-)
>
>diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
>index 860b09e409c7..7dc6904a6836 100644
>--- a/arch/riscv/Makefile
>+++ b/arch/riscv/Makefile
>@@ -8,7 +8,7 @@
>
> OBJCOPYFLAGS    := -O binary
> ifeq ($(CONFIG_RELOCATABLE),y)
>-	LDFLAGS_vmlinux += -shared -Bsymbolic -z notext -z norelro
>+	LDFLAGS_vmlinux += -shared -Bsymbolic -z notext -z norelro --emit-relocs
> 	KBUILD_CFLAGS += -fPIE
> endif
> ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
>[...]

(Not subscribed.
b4 am https://lore.kernel.org/all/20230329045329.64565-7-alexghiti@rivosinc.com/
neomutt -f v9_20230329_alexghiti_introduce_64b_relocatable_kernel.mbx)

This commit 559d1e45a16dcf1542e430ea3dce9ab625be98d0 introduced --emit-relocs to arch/riscv/.
I am concerned that --emit-relocs's relocation-type-changing behavior may not be desired and
any new use could become problematic.

https://sourceware.org/bugzilla/show_bug.cgi?id=30844 "ld riscv: --emit-relocs does not retain the original relocation type"

If either -mno-relax or --no-relax is used, --emit-relocs should be fine.
