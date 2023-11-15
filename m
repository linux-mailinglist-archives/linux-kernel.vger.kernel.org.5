Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A58F7EC796
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjKOPss convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Nov 2023 10:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjKOPss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:48:48 -0500
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081AF101;
        Wed, 15 Nov 2023 07:48:45 -0800 (PST)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5b980391d7cso4399869a12.0;
        Wed, 15 Nov 2023 07:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700063324; x=1700668124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s12ncDJyYBjbloau2hqKY3l51l8J95ntKc21brrMHWk=;
        b=JTzAkZWWif28ou269nxN2gjUZpODn48PGCy8ryAaeq4khORLum9MxX3XHZFiqqGqQX
         WCW1koDNS+d/5+60yPsUhZsdxNJ9uP10EZjCW4rc0tHyThAJj5oRuWq4BrBTAnWPO3S1
         gdSUhNIS/JPd4VGrmQ904SZ8+BgeplOWlQmntLqFrKZNjN/mJUfSjHEKI3zcUvNqO1W/
         +isEg4rzGEWLSPXXq9ujVeF47O8nifiouUVa+0Q5WXtVIeTrCSgGjGPd/I3S44Z41s4z
         csKjaIla+qVvmBxEew01vA4G8ccX979S29pA5WLPdYm49srepLpHQiNXF9DG8QE86vgt
         FFRg==
X-Gm-Message-State: AOJu0YyMnmIxfSw1TJcuMi0BGKrFfFNdV/ASspI8Q7FB/PuX/voIrJfS
        MnDvyuztWIH9rb40DXT8hamNy/sAoeFXZ/s9mVpIJPXC
X-Google-Smtp-Source: AGHT+IHMHtFlPPJC84HxBvE2A3+UnswOmZf3CXlHH3EuX8+wNQSNfn/YuI2EWDNXPjf9K9O9Wit7EJA0tpzYWgXPxGk=
X-Received: by 2002:a17:90a:cb95:b0:27c:f1f8:261f with SMTP id
 a21-20020a17090acb9500b0027cf1f8261fmr9728656pju.20.1700063324412; Wed, 15
 Nov 2023 07:48:44 -0800 (PST)
MIME-Version: 1.0
References: <449fb8d2.27fb.18bcc190021.Coremail.00107082@163.com>
 <76d75357.6ab6.18bce6b7d5b.Coremail.00107082@163.com> <20231115103241.GD3818@noisy.programming.kicks-ass.net>
 <407a06f8.632a.18bd2a2ece1.Coremail.00107082@163.com>
In-Reply-To: <407a06f8.632a.18bd2a2ece1.Coremail.00107082@163.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 15 Nov 2023 07:48:33 -0800
Message-ID: <CAM9d7cgdUJytP31y90c5AuQAmR6FgkBWjj4brVjH8Pg+d00O+Q@mail.gmail.com>
Subject: Re: [Regression or Fix]perf: profiling stats sigificantly changed for
 aio_write/read(ext4) between 6.7.0-rc1 and 6.6.0
To:     David Wang <00107082@163.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 3:00 AM David Wang <00107082@163.com> wrote:
>
>
>
> At 2023-11-15 18:32:41, "Peter Zijlstra" <peterz@infradead.org> wrote:
> >
> >Namhyung, could you please take a look, you know how to operate this
> >cgroup stuff.
> >
>
> More information,  I run the profiling with 8cpu machine on a SSD with ext4 filesystem :
>
> # mkdir /sys/fs/cgroup/mytest
> # echo $$ > /sys/fs/cgroup/mytest/cgroup.procs
> ## Start profiling targeting cgroup /sys/fs/cgroup/mytest   on another terminal
> # fio --randrepeat=1 --ioengine=libaio --direct=1 --name=test  --bs=4k --iodepth=64 --size=1G --readwrite=randrw  --runtime=600 --numjobs=4 --time_based=1
>
> I got a feeling that f06cc667f7990 would decrease total samples by 10%~20% when profiling IO benchmark within cgroup.

Oh sorry, I missed this message.  Can you please share the
command line and the output?

Thanks,
Namhyung
