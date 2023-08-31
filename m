Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C501378F4D9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347632AbjHaVu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjHaVu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:50:56 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE45107
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:50:53 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so23367991fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693518651; x=1694123451; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EPx5/ATJMbBSBhsCKGXeOai9NzMe/gTGeUbJTlA7YoI=;
        b=cmDTeSBpI8VOpTKH+8Aw4BkQAgdeVxdi/L31C1ur12Bje9AMlcQDDzQj9wn33Rpwl2
         WgvLhk4VMhGNITamyGZpk1AvPMBniyGnX++EA2FVje2zULlwCUDjnDnia1bTu3ripDjx
         1EhkqrpKRKoyo/qcLYMkDmFDOjH/4z6OJnKHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693518651; x=1694123451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EPx5/ATJMbBSBhsCKGXeOai9NzMe/gTGeUbJTlA7YoI=;
        b=Nq59eflU7n/xoOeCvKtLbXgZp1MEY4rR3ta+c4HJjIeZH//SBCYFR3e8KEGIjFuvka
         AtTF2/aQe/CJpM7pCje+Z9gvK9AqKPT9UG15jhfYnGUu1obZ236RtTFw6LYvp1pbhelf
         hKcenZdQEjIamRphxrE2+STYrIbAVCIdlW8d8RyGTJLGpiD9oAZ1F1srk0RabP6TI8fO
         DojLTXq8b7aZpsOPkuCMoaiqKDdYQ0lnKriNYuTRivzlmYuJPl/XdEl1vWNtylOqWXXf
         vBMNtZ6qDsPxcm4bp13yxEYjMFIUnYvOOXQDJBW4dq9g63qIlTjt71olcA3hmf52ktYc
         oYjg==
X-Gm-Message-State: AOJu0YwKFaNp9IzD2lJXbprEf4ztn3SzOaD0sI8MXM6f+nR2MKMcnnym
        0Um80TW/3X6cft8at66DfrXwU+jwXd7/wIYxlUmTD0sL
X-Google-Smtp-Source: AGHT+IG06Vxu6eyy0h4kiOxy5t1lWpWzphsQ4tzS9wH+uV48kmJlFsn3jWWfSwblGVhGDbRL+FiiBw==
X-Received: by 2002:a2e:3c02:0:b0:2bc:f39b:3c38 with SMTP id j2-20020a2e3c02000000b002bcf39b3c38mr312383lja.40.1693518651362;
        Thu, 31 Aug 2023 14:50:51 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id g20-20020a1709067c5400b00999bb1e01dfsm1187689ejp.52.2023.08.31.14.50.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 14:50:50 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-52713d2c606so1721706a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:50:50 -0700 (PDT)
X-Received: by 2002:aa7:da17:0:b0:522:560d:d691 with SMTP id
 r23-20020aa7da17000000b00522560dd691mr562043eds.25.1693518650308; Thu, 31 Aug
 2023 14:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230830234752.19858-1-dave.hansen@linux.intel.com>
 <CAHk-=wipDVFEfSJxbnUSDqENs5i8RzSsgJOFdb69pH=b7BOFiQ@mail.gmail.com> <ZPEFw1XGrI69ZbJ6@gmail.com>
In-Reply-To: <ZPEFw1XGrI69ZbJ6@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Aug 2023 14:50:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_2w6kggqeGV=tmmh3LqxZSZrHyyNwh8fw46G-XEXbdw@mail.gmail.com>
Message-ID: <CAHk-=wh_2w6kggqeGV=tmmh3LqxZSZrHyyNwh8fw46G-XEXbdw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Fix pud_mkwrite() definition after pte_mkwrite()
 API changes [was: Re: [GIT PULL] x86/shstk for 6.6-rc1]
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 14:27, Ingo Molnar <mingo@kernel.org> wrote:
>
> I believe there's one semantic conflict you missed, which breaks the powerpc64
> build: recent changes to arch/powerpc/include/asm/book3s/64/pgtable.h created
> a new semantic conflict due to the changes to the pte_mkwrite() API:

Ack. Patch applied (with mightily changed commit message).

           Linus
