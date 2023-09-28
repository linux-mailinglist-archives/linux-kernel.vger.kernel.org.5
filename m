Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D96F7B1158
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 05:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjI1Dzo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Sep 2023 23:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1Dzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 23:55:42 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C07811F;
        Wed, 27 Sep 2023 20:55:40 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-79fc3d32a2fso287766239f.1;
        Wed, 27 Sep 2023 20:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695873339; x=1696478139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/OzhfHVlcZiP/xhGzt+v7586DoOfydkysKYz+Cs7o8=;
        b=prg0cy6LQocL6FFKPT+tvyDgBlCCjkxqVrgg/8zqyV9DlWzPnKePjgk9RrVs1Vwbtl
         7rego5xExyWUqcVMA9prftiGE9P/bG7lDr55FTviXID1zWDPU1DmxnvRkZvdtMlsi1yE
         H07WMgl+3lqg1DPBFDEzIYLiqGCe0bk23Wugt64BPYJ9XpjHtc2yoh7ybTgq+hx50JMK
         yV4aGBtwZ4dSdPStmR5lMs/GDhrXJMZrmSd+2opQpmhI5rj3/nqw1FiviXfFH0qyphsP
         VQK6PjCOkv1HxLWDE5G11OCH7VD2Htiav2UKa3GQyqcNgrRg7aw3Yk4oB9cyu73rZifX
         lTyA==
X-Gm-Message-State: AOJu0Yyas8dk4Wh4X5T6eVX9VBEoMpdFqTbYFeMtpNQ3slQYf0RmO8Dt
        qQzr+/XOhQW+jKVVfwBctrbpTY8nqPOj4YZPX4s=
X-Google-Smtp-Source: AGHT+IHz2z4mAy3XZ/WHE+p4e5VJp2T67Qc4ze7etKKMzX3Fz8Q7faUdl5T5Y8mdepAIlpnqG2n+YM48IDOJ+0ztBaQ=
X-Received: by 2002:a6b:fe18:0:b0:792:9a1a:228b with SMTP id
 x24-20020a6bfe18000000b007929a1a228bmr107318ioh.2.1695873339289; Wed, 27 Sep
 2023 20:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230923093037.961232-1-yangjihong1@huawei.com>
In-Reply-To: <20230923093037.961232-1-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 27 Sep 2023 20:55:28 -0700
Message-ID: <CAM9d7cg=k4sLLgA-EODxxRCg1EQjvWWaNOpm=VMRWokmqxiuew@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf bench messaging: Kill child processes when exit
 abnormally in process mode
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 2:32 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> If perf bench messaging in process mode exits abnormally, the forked child
> processes does not exit.
>
> The test result is as follows:
>
>   # perf bench sched messaging -l 1000000 -g 1 &
>   [4] 553
>   # Running 'sched/messaging' benchmark:
>   # kill -15 533
>   # ps -ef | grep perf
>   root         425     371  0 09:11 pts/0    00:00:00 perf bench sched messaging -l 1000000 -g 1
>   root         426     425 17 09:11 pts/0    00:01:56 perf bench sched messaging -l 1000000 -g 1
>   root         427     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
>   root         428     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
>   root         429     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
>   root         430     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
>   root         431     425 17 09:11 pts/0    00:01:56 perf bench sched messaging -l 1000000 -g 1
>   root         432     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
>   root         433     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
>   root         434     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
>   root         435     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
>   root         436     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
>   root         437     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
>   root         438     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
>   root         439     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
>   root         440     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
>   root         441     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
>   root         442     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
>   root         443     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
>   root         444     425 17 09:11 pts/0    00:01:54 perf bench sched messaging -l 1000000 -g 1
>   root         445     425 17 09:11 pts/0    00:01:55 perf bench sched messaging -l 1000000 -g 1
>   root         446     425 16 09:11 pts/0    00:01:50 perf bench sched messaging -l 1000000 -g 1
>   root         447     425 16 09:11 pts/0    00:01:49 perf bench sched messaging -l 1000000 -g 1
>   root         448     425 16 09:11 pts/0    00:01:50 perf bench sched messaging -l 1000000 -g 1
>   root         449     425 16 09:11 pts/0    00:01:49 perf bench sched messaging -l 1000000 -g 1
>   root         450     425 16 09:11 pts/0    00:01:50 perf bench sched messaging -l 1000000 -g 1
>   root         451     425 16 09:11 pts/0    00:01:50 perf bench sched messaging -l 1000000 -g 1
>   root         452     425 16 09:11 pts/0    00:01:50 perf bench sched messaging -l 1000000 -g 1
>   root         453     425 16 09:11 pts/0    00:01:49 perf bench sched messaging -l 1000000 -g 1
>   root         454     425 16 09:11 pts/0    00:01:49 perf bench sched messaging -l 1000000 -g 1
> <SNIP>
>
> Capture signals SIGINT and SIGTERM to kill child processes in signal handler
>
> Yang Jihong (4):
>   perf bench messaging: Fix coding style issues for sched-messaging
>   perf bench messaging: Factor out create_worker()
>   perf bench messaging: Store chlid process pid when creating worker for
>     process mode
>   perf bench messaging: Kill child processes when exit abnormally in
>     process mode

Applied to perf-tools-next, thanks!
