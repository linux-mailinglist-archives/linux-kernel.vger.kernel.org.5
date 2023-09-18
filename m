Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34DE7A55D3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 00:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjIRWhU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 18:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIRWhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 18:37:19 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B891E8F;
        Mon, 18 Sep 2023 15:37:13 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-79266c8617eso191659139f.3;
        Mon, 18 Sep 2023 15:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695076633; x=1695681433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8DWlOzmfmJtffIuPHv5jAsQySyQJcrqEocN+MbaExo=;
        b=CT5pe3W4/x+5DDx1IJXHXoMxSisa6hl5MYSKXqRaBE7U8APFcCYjOO7wnSaqhza0sT
         7kSZY6s4Gi2kv9ywID0izZhf7YtPYYA8CM96XsUUN8DkLcNgplZ8F3Rj2i2jqs9Zy0oQ
         oLrVZHQaBjUZfirP4u7O752KTk7oRrM3HGBqaiQjjoLyQWRQsIGjQpJ9ZufpfZQp85lx
         ctHGnCMdOcKgpvsv0u4zsxmbtXaBNWQ2yYy9nK4sJ0lOOR0xsU4vzcqpCETjjBSGVbwG
         IxvilKGGUaKbQFnMer+Dnm/CmbVDZg4s4UnQZt04C8xMFfgWwbesmbGxQaOGZtbX6tNS
         re+g==
X-Gm-Message-State: AOJu0YyPjdBcByK87Is6vqaPUGBTuvC8LWs5i5jnUBL4wb93pdfofJ6l
        0vgP+ScmLQX+FD2REIVMI8Zemcu0pn3Nves4+xU=
X-Google-Smtp-Source: AGHT+IETQPwC+e3CZj4MsesBOt86B941j2lm4s/vXYKJwlTGgHzGiewnYFfv28W3XmGyEo9CutzbF2ertcfegGVdpJk=
X-Received: by 2002:a6b:f30b:0:b0:790:fa58:69d2 with SMTP id
 m11-20020a6bf30b000000b00790fa5869d2mr11685280ioh.20.1695076632752; Mon, 18
 Sep 2023 15:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230916091641.776031-1-yangjihong1@huawei.com> <CAM9d7ciuLiYRT0tyhXSrZLqe9uhLNw=zGK4Tj6-GG5WQALP3-Q@mail.gmail.com>
In-Reply-To: <CAM9d7ciuLiYRT0tyhXSrZLqe9uhLNw=zGK4Tj6-GG5WQALP3-Q@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 18 Sep 2023 15:37:01 -0700
Message-ID: <CAM9d7cjiwUPvjk=bA5Hc3HFNGKQWDrSRVrZ0FAAScfywz_2Gkw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix test-record-dummy-C0 failure for supported
 PERF_FORMAT_LOST feature kernel
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2023 at 10:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Sat, Sep 16, 2023 at 2:18 AM Yang Jihong <yangjihong1@huawei.com> wrote:
> >
> > For kernel that supports PERF_FORMAT_LOST, attr->read_format has
> > PERF_FORMAT_LOST bit. Update expected value of
> > attr->read_format of test-record-dummy-C0 for this scenario.
> >
> > Before:
> >
> >   # ./perf test 17 -vv
> >    17: Setup struct perf_event_attr                                    :
> >   --- start ---
> >   test child forked, pid 1609441
> >   <SNIP>
> >   running './tests/attr/test-record-dummy-C0'
> >     'PERF_TEST_ATTR=/tmp/tmpm3s60aji ./perf record -o /tmp/tmpm3s60aji/perf.data --no-bpf-event -e dummy -C 0 kill >/dev/null 2>&1' ret '1', expected '1'
> >   expected read_format=4, got 20
> >   FAILED './tests/attr/test-record-dummy-C0' - match failure
> >   test child finished with -1
> >   ---- end ----
> >   Setup struct perf_event_attr: FAILED!
> >
> > After:
> >
> >   # ./perf test 17 -vv
> >    17: Setup struct perf_event_attr                                    :
> >   --- start ---
> >   test child forked, pid 1609441
> >   <SNIP>
> >   running './tests/attr/test-record-dummy-C0'
> >     'PERF_TEST_ATTR=/tmp/tmppa9vxcb7 ./perf record -o /tmp/tmppa9vxcb7/perf.data --no-bpf-event -e dummy -C 0 kill >/dev/null 2>&1' ret '1', expected '1'
> >   <SNIP>
> >   test child finished with 0
> >   ---- end ----
> >   Setup struct perf_event_attr: Ok
> >
> > Reported-by: Namhyung Kim <namhyung@kernel.org>
> > Closes: https://lore.kernel.org/all/CAM9d7cgNH2+zhSAmA3en_6as915UsF25MoLbfjE350tAP43Bog@mail.gmail.com/
>
> I'll change it to follow the existing style like
>
> Fixes: d50ad02cb39a ("perf test: Add perf_event_attr test for record
> dummy event")
>
> > Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>
> Tested-by: Namhyung Kim <namhyung@kernel.org>

Applied to perf-tools-next, thanks!

Namhyung
