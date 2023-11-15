Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1497EC886
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjKOQ2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjKOQ2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:28:47 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360DBD5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:28:44 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507bd644a96so9967929e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700065722; x=1700670522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jsVx/Q3YhVxHOvs8227jfNskpZuE2YqOrJ9wOZRuNEs=;
        b=WFuvjd7xuhCBhnJzRLvJiaDaDpenV7NQDapH0uL43DQC9r3vDlwdEULAfiYiGV3uRV
         4zYkTYj3R8rBHrJaBvuyP0WGvF3QOoMbfE89C8tp5MMqYjg5AVqD/Um3XbHDugLfRdui
         a2Lb9RNab2KQFGzcx5M6XKshzqUTNvYEVQwAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700065722; x=1700670522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsVx/Q3YhVxHOvs8227jfNskpZuE2YqOrJ9wOZRuNEs=;
        b=OQterUd0q0MjOMOzO0IOyb6z+EY1UueMHYCbW2FIfSeJJ1hPqeDj0ms9U/tP95Wz7c
         UV0UGx4copS3dad+uzfG0bSRx2wVe2cqeN6bUacJm5gauNkayKbe9Mxg9VwTh/ZKNn7F
         Ce4Qsd0pSXitUNExK2Ug3mRMKLjVP01s0a/tiBihm3b0MX364rzJk1FKDRm8OBTZoqQh
         ygz0pfUM3hB4yQVEO2FWi1qYkbQtZ+v5o87LWkJLVzENvD0PJalYX+YDy/r6wtM3TtTI
         8baJwp2I5qneerhAsqYy1xHTMD5cj0x7YwOh2UpD01jLVSRzMOEtEvmJeulDZ8CD2qKF
         R6jg==
X-Gm-Message-State: AOJu0YxQCVCdj2L43FbKlVsu1Z4qmDzk2Z+ybzNlw5khTeZf8P2jVZiM
        H+LJzx/t/l1cCxmlO3SfHUtONe+38pjrPr6F+uIteIdK
X-Google-Smtp-Source: AGHT+IEVEiwGiAzLNd6zIFTLXWbUxZkRtssvdu86O1kF2xlvZBfy2kD40cm6ud/W1m93ymNCqGxHZQ==
X-Received: by 2002:a05:6512:ad0:b0:509:4405:d5a8 with SMTP id n16-20020a0565120ad000b005094405d5a8mr10898763lfu.68.1700065722164;
        Wed, 15 Nov 2023 08:28:42 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id i16-20020a056512341000b00507ae0a5eb7sm1692203lfr.164.2023.11.15.08.28.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:28:40 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2c788f5bf53so81115711fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:28:40 -0800 (PST)
X-Received: by 2002:a05:6512:12cf:b0:503:3781:ac32 with SMTP id
 p15-20020a05651212cf00b005033781ac32mr12684125lfg.41.1700065720301; Wed, 15
 Nov 2023 08:28:40 -0800 (PST)
MIME-Version: 1.0
References: <20231115154946.3933808-1-dhowells@redhat.com> <20231115154946.3933808-9-dhowells@redhat.com>
In-Reply-To: <20231115154946.3933808-9-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Nov 2023 11:28:22 -0500
X-Gmail-Original-Message-ID: <CAHk-=wjytv+Gy-Ra0rhLCAW_120BvnzLC63tfkkZVXzGgD3_+w@mail.gmail.com>
Message-ID: <CAHk-=wjytv+Gy-Ra0rhLCAW_120BvnzLC63tfkkZVXzGgD3_+w@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] iov_iter: Add benchmarking kunit tests
To:     David Howells <dhowells@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Matthew Wilcox <willy@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 10:50, David Howells <dhowells@redhat.com> wrote:
>
> Add kunit tests to benchmark 256MiB copies to a KVEC iterator, a BVEC
> iterator, an XARRAY iterator and to a loop that allocates 256-page BVECs
> and fills them in (similar to a maximal bio struct being set up).

I see *zero* advantage of doing this in the kernel as opposed to doing
this benchmarking in user space.

If you cannot see the performance difference due to some user space
interface costs, then the performance difference doesn't matter.

Yes, some of the cases may be harder to trigger than others.
iov_iter_xarray() isn't as common an op as ubuf/iovec/etc, but that
either means that it doesn't matter enough, or that maybe some more
filesystems could be taught to use it for splice or whatever.

Particularly for something like different versions of memcpy(), this
whole benchmarking would want

 (a) profiles

 (b) be run on many different machines

 (c) be run repeatedly to get some idea of variance

and all of those only get *harder* to do with Kunit tests. In user
space? Just run the damn binary (ok, to get profiles you then have to
make sure you have the proper permission setup to get the kernel
profiles too, but a

   echo 1 > /proc/sys/kernel/perf_event_paranoid

as root will do that for you without you having to then do the actual
profiling run as root)

                Linus
