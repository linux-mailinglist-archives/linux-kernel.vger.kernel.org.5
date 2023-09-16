Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83C67A2D61
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 04:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbjIPCPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 22:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbjIPCPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 22:15:17 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AD11BF8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 19:15:12 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52a250aa012so3136658a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 19:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694830510; x=1695435310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FbufmgnpA0aesZB//HGaq/RO2Y/ticw2RyjyAED+2xY=;
        b=NanDQtzLSn56DbN41fh7mYp+Cdf7CmrHSQHG1DhofFoaQ9727yFGL0Qxo6F7P8BvJK
         5EGwqZn3/fUukro+ACcvUx1MMOAGJaJ9ZUfkS/VaAhLbXvBtUGoEk8MjlD3C+gJ68gUj
         FvQ0uFfbULzhZ5g/syv9gwlwjNIOxVN5i6GWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694830510; x=1695435310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbufmgnpA0aesZB//HGaq/RO2Y/ticw2RyjyAED+2xY=;
        b=Fq70BD74zql8HkOrATA9XONxDtMc9wWnWO54HIv+N8/gbJeGsTrsj9AZWP1wnut781
         rlKY5kX1YGGpDv4eiMRI+pYCDEFDum8w94Ij44cqrHQLld9lSmZAwODCJJE28KrRaCzd
         MhWRAuSpf+jpArzukx0AAhovw6Prv2qctDNbrlDnEUgz2DIeXWt9xI7KXFB7C+GjBY8c
         Uxk/SZPzG3AV81tGINlmZH2lS0Galc2uo5TUT1fOjeemEIzxNb83fgmR3PwMougfnfaj
         g4vJ4s5OssmJYTPW9XqOk48lwnVQdV6wWGv1gKi8qUw9AUczRJxWCOWlIX30Szf+cHKf
         tMag==
X-Gm-Message-State: AOJu0Yw/CVJTK5QFF+UDkaqHYHrXNn1p/saSkQE6jgLJTt4G9OxgJqEp
        axKxh/qkYf2oOJi0a0MbrmURSWBZd2hOW76t8p4Ri7Ld
X-Google-Smtp-Source: AGHT+IGmExX304UHUHjJj5k3BjRrg9PFpZXdGIcMvXWfjBmL2CmwqKd73gU1zk5fGHow8jYrIgG9SQ==
X-Received: by 2002:aa7:ca47:0:b0:52b:d169:b382 with SMTP id j7-20020aa7ca47000000b0052bd169b382mr2776531edt.29.1694830510488;
        Fri, 15 Sep 2023 19:15:10 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id l1-20020a056402028100b0052237dfa82fsm2876727edv.64.2023.09.15.19.15.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 19:15:09 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9a648f9d8e3so355323466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 19:15:09 -0700 (PDT)
X-Received: by 2002:a17:906:cc9:b0:977:ecff:3367 with SMTP id
 l9-20020a1709060cc900b00977ecff3367mr2903210ejh.40.1694830509066; Fri, 15 Sep
 2023 19:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230915183707.2707298-1-willy@infradead.org> <20230915183707.2707298-9-willy@infradead.org>
 <CAHk-=wgBUvM7tc70AAvUw+HHOo6Q=jD4FVheFGDCjNaK3OCEGA@mail.gmail.com>
 <ZQT4/gA4vIa/7H6q@casper.infradead.org> <CAHk-=whbj+pVGhJTcQCLhY8KZJNomWOKM=s-GZSpK_G=G4fXEA@mail.gmail.com>
In-Reply-To: <CAHk-=whbj+pVGhJTcQCLhY8KZJNomWOKM=s-GZSpK_G=G4fXEA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 19:14:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+QEzoiUjeUkYqkJe4mcTQCshaAje51PiAuJu+REYxSA@mail.gmail.com>
Message-ID: <CAHk-=wj+QEzoiUjeUkYqkJe4mcTQCshaAje51PiAuJu+REYxSA@mail.gmail.com>
Subject: Re: [PATCH 08/17] alpha: Implement xor_unlock_is_negative_byte
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 19:01, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> No, I think "mov src,dst" is just a pseudo-op for "or src,src,dst",
> there's no actual "mov" instruction, iirc.

Bah. I looked it up. It's actually supposed to be "BIS r31,src,dst".

Where "BIS" is indeed what most sane people call just "or". I think
it's "BIt Set", but the assembler will accept the normal "or" mnemonic
too.

There's BIC ("BIt Clear") too. Also known as "and with complement".

I assume it comes from some VAX background. Or maybe it's just a NIH
thing and alpha wanted to be "special".

              Linus
