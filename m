Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9F07CD485
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjJRGe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjJRGe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:34:28 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EB5FD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:34:26 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7b65004396fso1848425241.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697610866; x=1698215666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvhtsIpX6Tz25oR+Wmg24DRV09zwdRaSqOygIYnIWik=;
        b=GQzTmUNPlklPotz3ek95YJtffLBVSzMpCKPjbGq46pOTqG0zXFiTABLe81ZPHONNln
         5/vPXLsxagh2p72D6DHrdnoOHoPm9WX6ZJBWUQG/frSxgVl+OSeeLkiyxLB8Nj/KeRcO
         SuiiJoEfm1klApYy+XFD+aVYRTwQRI5UY8ank63WrDMyocL1E816DhH7r0fb8S7MAP2W
         ctnjxEisdTy3+O69n+rHYVzoYa1pg8KmYjlqA0ttBXYXg03bMYnT+b6lDqwYHlIFYowC
         d1f7BfV6FDPxURKQBS+4737YRPkoXbyslG1poZZdfx64gFsMvJXyzOit3rWRhkBZ5ng3
         bkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697610866; x=1698215666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AvhtsIpX6Tz25oR+Wmg24DRV09zwdRaSqOygIYnIWik=;
        b=V7ZDejiIh4uShL7++BKHxxKkJX86oX3vl7mEk2CxUKzXgi5lHyYK5tqjoUbJFs3DXt
         HrByIC3K/ufdTkE1UwbhgTMH+PURNiMGMqKamLyOcWEQ1n+TG9j2T74x3t455cytbbNH
         +3MpArgzbPPamvRJGvclxjLNhuPCBEvhC1CaiARMyyGBXGdtkP5q2TwueXvdsV5ArSiR
         24o8gHZDICpygWEmUjSf5C42+nswZbkwQ8NTY+//Ecvqddeyz5RIFKPZDJaHWSaJvgnU
         TIsIlv6VkNF3tO8p8yi5I1WAoVoLre2dSDequprjflYGHxint5d8FhuoSFiyderBtprX
         DHBw==
X-Gm-Message-State: AOJu0YxlDTwxtvswaq1U0nb8N+/BO4D9HysKB1EAFkcHMkPFVO+wvD7G
        qMUFw3h1zB+UY+KhYLwCOhLTpQvugLW99zVmTEo=
X-Google-Smtp-Source: AGHT+IHEiNDU4HCWR3okxDci/owx5eK8w/DH00Sqjzjbs8UDHbs7kygqNjRvzNCdzy+DsWdoqLcl+KQ5LNjtRCq4FX4=
X-Received: by 2002:a67:e006:0:b0:457:c52e:deda with SMTP id
 c6-20020a67e006000000b00457c52ededamr4300092vsl.34.1697610865597; Tue, 17 Oct
 2023 23:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231017154439.3036608-1-chengming.zhou@linux.dev>
In-Reply-To: <20231017154439.3036608-1-chengming.zhou@linux.dev>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Wed, 18 Oct 2023 15:34:14 +0900
Message-ID: <CAB=+i9Sw1YSdUKrjygA5cOsVjQMVmS8-KJ+ku4AG9Fw_2guENQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] slub: Delay freezing of CPU partial slabs
To:     chengming.zhou@linux.dev
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 12:45=E2=80=AFAM <chengming.zhou@linux.dev> wrote:
> 4. Testing
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> We just did some simple testing on a server with 128 CPUs (2 nodes) to
> compare performance for now.
>
>  - perf bench sched messaging -g 5 -t -l 100000
>    baseline     RFC
>    7.042s       6.966s
>    7.022s       7.045s
>    7.054s       6.985s
>
>  - stress-ng --rawpkt 128 --rawpkt-ops 100000000
>    baseline     RFC
>    2.42s        2.15s
>    2.45s        2.16s
>    2.44s        2.17s
>
> It shows above there is about 10% improvement on stress-ng rawpkt
> testcase, although no much improvement on perf sched bench testcase.
>
> Thanks for any comment and code review!

Hi Chengming, this is the kerneltesting.org test report for your patch seri=
es.

I applied this series on my slab-experimental tree [1] for testing,
and I observed several kernel panics [2] [3] [4] on kernels without
CONFIG_SLUB_CPU_PARTIAL.

To verify that this series caused kernel panics, I tested before and after
applying it on Vlastimil's slab/for-next and yeah, this series was the caus=
e.

System is deadlocked on memory and the OOM-killer says there is a
huge amount of slab memory. So maybe there is a memory leak or it makes
slab memory grow unboundedly?

[1] https://git.kerneltesting.org/slab-experimental/
[2] https://lava.kerneltesting.org/scheduler/job/127#bottom
[3] https://lava.kerneltesting.org/scheduler/job/131#bottom
[4] https://lava.kerneltesting.org/scheduler/job/134#bottom

>
> Chengming Zhou (5):
>   slub: Introduce on_partial()
>   slub: Don't manipulate slab list when used by cpu
>   slub: Optimize deactivate_slab()
>   slub: Don't freeze slabs for cpu partial
>   slub: Introduce get_cpu_partial()
>
>  mm/slab.h |   2 +-
>  mm/slub.c | 257 +++++++++++++++++++++++++++++++-----------------------
>  2 files changed, 150 insertions(+), 109 deletions(-)
>
> --
> 2.40.1
>
