Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71D17F5540
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 01:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjKWAUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 19:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWAUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 19:20:08 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBB3189
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 16:20:04 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-db37c6a4d48so359144276.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 16:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700698803; x=1701303603; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=57/CYGuuC1Jp62J8XUITJ0fJw251XS6cutEtxQsqThw=;
        b=Ez3ikaSNhhEb5i2bJyoviC0tKVu5nN+hGs7OwTRM5ZNsW3Iqt0WW1ylC5XA/TkV3f2
         kCjmyk5s4tJKp8gS1EiizGdQ6U5MP22qh4Zy5l+D3UolWrUnwvEGCuU3x8vFGaVW7mjv
         FgidpDUM1mVGbu+Ih/TB1sPvkrrDbFje/uMvOS9CzwsQi4si3V8xe10B3UQmgsXdppcN
         3FVA8DU4/5lZmbRX+jiwOZUfsmWLTEUA4SrnLai7JQn39trC1yQdQkXiFRAkvGNeugke
         Po+bL2AWxF+VQL7wCfjHLtlLadQjmfMa62+d1f+YBZQh79hbZjll2yNuncLzxKxd6jsZ
         snsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700698803; x=1701303603;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=57/CYGuuC1Jp62J8XUITJ0fJw251XS6cutEtxQsqThw=;
        b=QEXZZdWPA5Pdv3xJiaWkTJOMMNFPypgGSciL37y9nhLbIyThq6CZJE4o7H4gdXFNbM
         hvFXWIihMuzVuqW8SKcbSNoBPbrndy4rCyfZ6byP5PFPmYryg7M8bP/L7zhbGxm6yYPV
         cMokfz1Ir4S2uaNYwnmVZsdFyaeXKGHXGjFhTGH+iOwuVrR8vRBqrvzD/S6GLMqaq56W
         KbjfbZJ+EA26shAdOg0ai9XLTNBxHZIpDJ+jLsFDKsCgtSAHt5rH4jDQXt7YFetA06lg
         Z491Ru9mcK2E5tvO+N2xl+0Nbas04GBjgVAOgOt2X9/3mz/Cjnn8us6D0HvlcZ42RztV
         ZCFQ==
X-Gm-Message-State: AOJu0YwRe5NeHB390FZGLbsdFNhp9ZGUq/+DTJ5rwH5BcRxNmfw3zYM8
        urY/hZHRgbbfrK7vas6b4chDX5O//xaBc9yzWnK7xQ==
X-Google-Smtp-Source: AGHT+IFQ7E+RPA49zew6xKM9QvTj09O4FF9RYYpfaLznYb7JBVZq6vcQkBQvuTK8o1dnHcQouresec4UzBgFcaoLkyI=
X-Received: by 2002:a25:77c4:0:b0:daf:bf76:f5c0 with SMTP id
 s187-20020a2577c4000000b00dafbf76f5c0mr3843424ybc.48.1700698803371; Wed, 22
 Nov 2023 16:20:03 -0800 (PST)
MIME-Version: 1.0
From:   Deepak Gupta <debug@rivosinc.com>
Date:   Wed, 22 Nov 2023 16:19:51 -0800
Message-ID: <CAKC1njRkpaqbAFWrZpz75u4M-T8mniY2QHVZEENameqnHOOGPg@mail.gmail.com>
Subject: Shadow stack enabling from dynamic loader v/s kernel on exec
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Kito Cheng <kito.cheng@sifive.com>
Cc:     linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't want to divert focus from patch specific comments on shadow
stack patches that're being
discussed in the mailing list. And that's starting this separate
thread about enabling the shadow
stack in the dynamic loader v/s kernel. I've put relevant folks in
"To" and "kernel" and "libc" in CC.

We've beaten this record many times but I think this is the first time
I am getting into weeds.

Per this https://lore.kernel.org/all/20220130211838.8382-1-rick.p.edgecombe@intel.com/,
all
the binaries that were marked with shadow stack are ready to break as
soon as new kernel enables
shadow stack by default based on ELF bit. And thus the reason to let
it be decided up in user
mode and making the kernel oblivious about this decision making during exec.

It looks like it was done because libc changes landed in userspace
binaries from major distros before
the kernel changes could be merged and kernel-user interface changed
as kernel changes matured.

Such an issue doesn't exist for non-x86 (at least risc-v because
that's what I am focussing on). And
have been wondering that if doing below would be a better choice:

- On `exec`, the kernel looks at the ELF bit and sets up a shadow stack
- Dynamic loader (or statically built binary) starts life with shadow stack
- Dynamic loader can disable shadow stack if it wants if it sees some
compat issues
  [This last step of figuring out compat issues, anyways dynamic
loader is performing today]

This has many advantages
- dynamic loaders (and static binary) are protected from loader
specific ROP attack in a small window
- stack and shadow stack are always balanced

One disadvantage I can see is that enabling the shadow stack is split
but I really don't see it as a big
disadvantage. Please note that enable/disable/get status prctls can
still exist. And thus user space still
has all the enabling / disabling control with itself depending on
configuration.

Larger question and opinion / input that I am seeking here is that
(from kernel / libc community)

"Was there any other reason other than supporting ELF binaries that
went ahead of kernel changes that
led to decision of delegating of shadow stack enabling in dynamic loader"

If there are other complications that can happen due to kernel
enabling of shadow stack based on ELF bits,
I would like to know about them.


-Deepak
