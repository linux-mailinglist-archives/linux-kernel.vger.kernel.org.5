Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C29F8139F1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjLNS1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjLNS1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:27:09 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C93111
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:27:14 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c3f68b69aso54201075e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702578433; x=1703183233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bctp29PdPWOavrokHMDmcicJ81XG4ASzLMzC7oVXid4=;
        b=g51dKcK5qmKbY8zbM3qwroKxhNP7GjRX6LvKuNN9WsDsjYNTdVfWMiJlU7fGEY46dK
         C3nJfF5FxcodXfsPPcThYLFQ3ZyGRvONMw5cRe/nVmxYmpbPEwRSU5A/iC1SNLgaDEF0
         f1Ksrv8IrjqgcDHBNaDG1yxQgOFAL8ajUSbve2HhYVRfpEUQE8JFJa1USrvGjA+B+vWk
         b5c47+4eKfWaagi6+voGTHuKiCdSzTENl1dPBBQjJ4wVF22nUaJIZjdLGJds718T6EOp
         qWVFiIiWKYoDPJlBZbE1YWBF2BseYvEByn5j0J4FEuK/wQiezwBpKwkkhLQILoz3m5+y
         hFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702578433; x=1703183233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bctp29PdPWOavrokHMDmcicJ81XG4ASzLMzC7oVXid4=;
        b=EFsEzrxdD7dAas4jIoCwit8xKlsY4bAZift56AuxzP8xS7cmfWA1F3Y2mmFRp/ZxLL
         BTUBmXJ2ArQWNmW77GdXJgwX3nAXGUQ2CWcrtALVxJSJ7b4Nyi4yyOwTMAJ7gH8tg5xQ
         cOE6eW9LBcFN7+FeYuWaXn0Q26Y09pBvdJTmJcmzM0hBnZNAQki6RTq5vxIdDJZO2cPk
         EnnUkoYswLE5qURHUOkQERgu1x5GEXSAQSM1g3fw8kOEk66/9tCyQ4F/FMJimULXNZKM
         W18hrgSDli5A2FCsI21LHB6DgRNbsM6c/exT+cxY4uKW7A8dffxCIhqyHmCD32P/usBc
         KWCA==
X-Gm-Message-State: AOJu0YyDL7aBCmLIDaDBoswR8szO4JPk2P8DPQThSW3Q7i7IjdLaSgZ7
        dJqP1jdyqVfqK9zJOto4STbMbbsLQtptO6cFVHCXBw==
X-Google-Smtp-Source: AGHT+IFuM1IrzBEHpj38CAahCxJQyrUeHqIS/+Q/Eg9MV8lQ3OJGIKYggwJSCqalFrBMPzAhxty+4Q4RQYH8p5iWAzQ=
X-Received: by 2002:a05:600c:3784:b0:40b:5e1b:54a8 with SMTP id
 o4-20020a05600c378400b0040b5e1b54a8mr5433555wmr.52.1702578433154; Thu, 14 Dec
 2023 10:27:13 -0800 (PST)
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-1-896763369d04@bytedance.com> <CAF8kJuPCPGdsT9Yxmeu1t9XT9xpsq2mSXcz1agcm5iKb13owPQ@mail.gmail.com>
In-Reply-To: <CAF8kJuPCPGdsT9Yxmeu1t9XT9xpsq2mSXcz1agcm5iKb13owPQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 14 Dec 2023 10:26:37 -0800
Message-ID: <CAJD7tkbmkUsNbtzrAS-ELANa_G3Qth=670A0zNu_K21QByJyZw@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm/zswap: reuse dstmem when decompress
To:     Chris Li <chrisl@kernel.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 9:59=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Tue, Dec 12, 2023 at 8:18=E2=80=AFPM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
> >
> > In the !zpool_can_sleep_mapped() case such as zsmalloc, we need to firs=
t
> > copy the entry->handle memory to a temporary memory, which is allocated
> > using kmalloc.
> >
> > Obviously we can reuse the per-compressor dstmem to avoid allocating
> > every time, since it's percpu-compressor and protected in mutex.
>
> You are trading more memory for faster speed.
> Per-cpu data structure does not come free. It is expensive in terms of
> memory on a big server with a lot of CPU. Think more than a few
> hundred CPU. On the big servers, we might want to disable this
> optimization to save a few MB RAM, depending on the gain of this
> optimization.
> Do we have any benchmark suggesting how much CPU overhead or latency
> this per-CPU page buys us, compared to using kmalloc?

IIUC we are not creating any new percpu data structures here. We are
reusing existing percpu buffers used in the store path to compress
into. Now we also use them in the load path if we need a temporary
buffer to decompress into if the zpool backend does not support
sleeping while the memory is mapped.
