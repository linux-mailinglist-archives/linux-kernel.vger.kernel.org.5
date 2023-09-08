Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23A4798A26
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244733AbjIHPny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbjIHPnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:43:51 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A013313E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 08:43:47 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-770ef96aa01so6356785a.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 08:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694187826; x=1694792626; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAbqY1cEwNYR2Hdp5jO+8518fCgaxRWgrEKpGgN0FMc=;
        b=WkXxmld+Jj1HdGWBoCBjscS4g6WPQ430hRCOll9QUMs86mJYYOvAZoCGASEHTF8gRM
         JnIdrd44ZFr+CWP0h7JGnPDclor/dwNk1aS9YgIWH9ZkFJCC2RdG73WAVNx8dRXrMyiy
         5KSON19HyncFIk+R+a6366hDoG8CyTWv/x2wnQwWfgbydIpDoXX31haZtNeQvk6rKcA6
         s/roUGe+xAoADk2s0C37o9nIP9VkkPN36+lb5jpzB0+BurTuc4gBkNn1YbEDbMDxD3aa
         ijXoKM+0b+4PagDs44hk6HIJpJoTFa2xYZKR8SV/wcbSnfAXm8i+Qx4BTL3BsA83XeR3
         kuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694187826; x=1694792626;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAbqY1cEwNYR2Hdp5jO+8518fCgaxRWgrEKpGgN0FMc=;
        b=UEl0olUa8IC6R4NSPgQVwN0f4UYjzx9877zKJEbox7hCkGSJtgB6LsPe0JZT4YGe/B
         XZd35Q8xDMAM2j/bIyKhBm00lzAMu4FtpMSp14QE8fji4BF2VHLert20+ws+fFqRQURd
         M4qOmrKMZ2tRJd6aM7gX0QUkPEHc9VMHtgP+Jp7TmT9Z2glz9jlT+HYRKSVpKf1HppEB
         QY0nbsK2EXUfBKKoTHHZdYl9NKJko+SvZZxMe++7EGKmiDMJERN9ODfCfQkL5aWOJrmt
         IlOOd3i47iBTo9ng6/yL/ia/Np1BfsJgem9vLz5nr3M8iDfr2gZUknaWaxihKltI2eG9
         bovg==
X-Gm-Message-State: AOJu0YyQ0k3TkAD7I7l9B4GNo7mcaHptVHHzA+IkQUOQvNz0cGSe+xoN
        SYgH2eJQ46KI1XIWLuhMCAA=
X-Google-Smtp-Source: AGHT+IFaLMV77/KVlfAvaPC+0ooDdOx76C1N+s2dvPgaXCOpZ/r1rLgjNg84TMxVgV/HNdoXI8VV2A==
X-Received: by 2002:a05:620a:44c8:b0:76e:e9b4:ff44 with SMTP id y8-20020a05620a44c800b0076ee9b4ff44mr3207992qkp.67.1694187826385;
        Fri, 08 Sep 2023 08:43:46 -0700 (PDT)
Received: from smtpclient.apple ([2601:189:8480:9a90:2102:7c79:a2b0:6525])
        by smtp.gmail.com with ESMTPSA id pj48-20020a05620a1db000b0076d9f2d4fabsm667235qkn.15.2023.09.08.08.43.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Sep 2023 08:43:46 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: Memory protection keys: Signal handlers crash if pkey0 is
 write-disabled
From:   Robert Kueffner <r.m.kueffner@gmail.com>
In-Reply-To: <4c49c85a-2b2e-e408-534d-586f06a8e485@intel.com>
Date:   Fri, 8 Sep 2023 11:43:34 -0400
Cc:     Kyle Huey <me@kylehuey.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F12A9E98-41F5-4A81-8B04-C96B0CDEC406@gmail.com>
References: <FF299375-B46F-46D0-90A9-333959FE9380@gmail.com>
 <c0159d08-e69d-0329-5ca9-68fd26cab0c8@intel.com>
 <E821837A-22AD-420C-A290-8511344E7EAF@gmail.com>
 <4c49c85a-2b2e-e408-534d-586f06a8e485@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> There are tons of complicated ways to fix this.  But the easiest way =
is
> just to say that you need to keep PKRU set so that the signal frame =
can
> be written at any time.

Just for completeness sake, the signal frame was actually written =
successfully since I moved the stack pointer to pkey-1 associated memory =
before any exceptions, details in unix.stackexchange I =
<https://unix.stackexchange.com/questions/755160/memory-protection-keys-ex=
ception-handler-crashes-if-pkey0-is-write-disabled> posted in the =
beginning.
And it=E2=80=99s probably that the kernel wants to write something else =
into pkey-0 associated memory.=20

I understand that there is no easy solution, so my idea of isolating a =
user from corrupting pkey-0 memory is probably moot.

Thanks Dave, that helped me a lot to understand the problem=
