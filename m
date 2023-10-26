Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66147D87A7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjJZRlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjJZRld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:41:33 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74791A1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:41:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso187977166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698342087; x=1698946887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ITpuqAIYuX9E93fc5T+jENg/qhVTutVfi31bFRSkPpE=;
        b=hMS7lZJY42kGVD1I4aZRXm9n5ykApC4j5/FOunDHWh3HSgmdvH8NuG+VgZRGeROnhD
         78AIcKVubnyxfnTatVT4pOwiEA2QmcBr04MNgmYa8pzyWTubjrv+R/hVO/q/vdSYIXbv
         r9iNxtLMQkP2uZHDwVvDvfd+yAL0NLwj7zX9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698342087; x=1698946887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITpuqAIYuX9E93fc5T+jENg/qhVTutVfi31bFRSkPpE=;
        b=WNgXiTm5PmtmUpJntiENWk/XAKGvMWVIJybGoJPDpSUr1f1hH260cfDB89X1bxZTVy
         pCAGQ5DtDlQ01hdh0Wa+JRpU9hZ3PKW9z/kYKMFzMFFXcA3GVvlbcLo63JP/I/WH2j/9
         H+8/fjWOr9ayxFh3k0B1MJ8tZG20GC/s/Cr8dwsYezEX0vyG4c7LBmcIooEJ3IA2gFu6
         KebELZLmu7Tlg1WErzLHMcvtkvXm7KlhndbL+GjZ4Ubu2IpHpvo6zzNyxWvXITmdO/pK
         RTEsc5c2heI8BgX2eGlcjYgXXPXoiOkjo2MJBKZJn0x3eihc+ELz2NNZRmH9iTEUz9A2
         yPQA==
X-Gm-Message-State: AOJu0YwcXkqOQjJvtNPjcBybQF8COFSx6ybCVESXE/cGFN4nK76Lfvf1
        PINktRSVWQqQGAtOEic6HGfGUu/83JBjPFZaha4ORu+x
X-Google-Smtp-Source: AGHT+IFIdPfnqlpVgCNdGqIuBCNpYjt5umtIDDqBqkBNLX7FqsHIEoQ6H9E5VxoYEGUpK5G9f9gTIA==
X-Received: by 2002:a17:907:3603:b0:9b6:499a:172d with SMTP id bk3-20020a170907360300b009b6499a172dmr347736ejc.52.1698342086785;
        Thu, 26 Oct 2023 10:41:26 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id o1-20020a170906774100b009c6e58437dasm12034401ejn.37.2023.10.26.10.41.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 10:41:26 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso1891214a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:41:26 -0700 (PDT)
X-Received: by 2002:a05:6402:206c:b0:53e:ba3d:acb9 with SMTP id
 bd12-20020a056402206c00b0053eba3dacb9mr382618edb.24.1698342085802; Thu, 26
 Oct 2023 10:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <ecd2fc55-8135-4b70-be85-24dbc773fb70@app.fastmail.com>
In-Reply-To: <ecd2fc55-8135-4b70-be85-24dbc773fb70@app.fastmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 Oct 2023 07:41:07 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjjY4h1TFir3V3DWSboF4=7buYezo-ZiTvQmMDeAK+30g@mail.gmail.com>
Message-ID: <CAHk-=wjjY4h1TFir3V3DWSboF4=7buYezo-ZiTvQmMDeAK+30g@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC fixes for 6.7, part 3
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, 26 Oct 2023 at 05:23, Arnd Bergmann <arnd@arndb.de> wrote:
>
> ARM: SoC fixes for 6.7, part 3
>
> A couple of platforms have some last-minute fixes for 6.7 [...]

The "last-minute" makes me thinkyou mean 6.6?

The 6.7 merge window hasn't quite opened yet.

                Linus
