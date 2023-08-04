Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4B8770C1F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 00:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjHDWuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 18:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjHDWuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:50:02 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720DA10CA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 15:50:01 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-522ab301692so3344131a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 15:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691189400; x=1691794200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Oufc1x89nwlrXRNKkHYYKDDdEzz4I9gpw2oNWdbuYSU=;
        b=CGVX8W/VVvSHWfL5A7GP+IZxrflfeijBHYRepr/J7GPhpEacEiNrDxfRVAhOCTOTZ5
         lWQbzA3hD5LKIQ8J+TITYmh4mX2xKhu5hwjVYwXVjoAlJ4uFl8h4WPXJFcsymATXciZf
         ldVuRBkgp4WSW+mX41AW3WFIBW9dubdbt2rOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691189400; x=1691794200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oufc1x89nwlrXRNKkHYYKDDdEzz4I9gpw2oNWdbuYSU=;
        b=alPfEIqJX8DSlOduZ6Vi0nWZInsAnG042vkss6lv0OJTyaSVt2bP1L2ehAaqP/yVpg
         kYKpFZvrvypoihaTCDVRuW0CREaO8ETqewSaM4nvsnIFJPRX63YUBf8pPwOWUEujp7tU
         czZFIpz6LBRlO0d+4TaSHe4V9uOyxHn2mRMaWdrj0Pg51NK4DrJGY083BDHejrsXBqik
         NhK3R076dIC0hBOwuzefkV7zm0gnkjWsfDSWb+xtQ7GB4NeDrKdnSVty8oVfBTfY+L3v
         IEO2T2xhhGSfIYx9QkoATgKnzP0ofAE5mcZqq25NoCCyv0sG05vDObxjeesrWP1N8vRu
         VzmQ==
X-Gm-Message-State: AOJu0Yweh0T7BLPSMCmur0gIkmLC0ydAyOsQbU/X5X33JMQJ1+9O0a9c
        hzTL+tcCgUqBlqByLRpH2XmvAL+cqxV5fKBOovMrTw==
X-Google-Smtp-Source: AGHT+IE2tI55ssDVqeqh3or0wZkaOQlJweDL+lVIZ1Y9EPxBdIr9Hk6+ypPHm6OP7jHbFFm+Y0p+Iw==
X-Received: by 2002:a05:6402:656:b0:522:27ea:58b with SMTP id u22-20020a056402065600b0052227ea058bmr2482146edx.39.1691189399914;
        Fri, 04 Aug 2023 15:49:59 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id i22-20020a50fc16000000b0051d9de03516sm1825207edr.52.2023.08.04.15.49.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 15:49:58 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-52307552b03so3365820a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 15:49:57 -0700 (PDT)
X-Received: by 2002:a05:6402:514:b0:521:d75d:ef69 with SMTP id
 m20-20020a056402051400b00521d75def69mr2790287edv.31.1691189397521; Fri, 04
 Aug 2023 15:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230708191212.4147700-1-surenb@google.com> <20230708191212.4147700-3-surenb@google.com>
 <20230804214620.btgwhsszsd7rh6nf@f>
In-Reply-To: <20230804214620.btgwhsszsd7rh6nf@f>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Aug 2023 15:49:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiy125k1dBmQFTGpHwiOqEyrD6xnd4xKWfe97H_HodgDA@mail.gmail.com>
Message-ID: <CAHk-=wiy125k1dBmQFTGpHwiOqEyrD6xnd4xKWfe97H_HodgDA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fork: lock VMAs of the parent process when forking
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        regressions@leemhuis.info, bagasdotme@gmail.com,
        jacobly.alt@gmail.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        regressions@lists.linux.dev, Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2023 at 14:46, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I don't see it mentioned in the discussion, so at a risk of ruffling
> feathers or looking really bad I'm going to ask: is the locking of any
> use if the forking process is single-threaded? T

Sadly, we've always been able to access the mm from other processes,
so the locking is - I think - unavoidable.

And some of those "access from other processes" aren't even uncommon
or special. It's things like "ps" etc, that do it just to see the
process name and arguments.

            Linus
