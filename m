Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A82B7A5BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjISHzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjISHzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:55:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F267100
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 00:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695110028; x=1695714828; i=efault@gmx.de;
 bh=j1Hob52NSsePmsOwioeNCg/WmJRg6bX3WsJNszGJHhY=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=Z5DwvFRjhkWWkq0NN3zJ2EGGCp/0zm/p0rp9Gkg//wgXEVvmbhFWsRbSulDnIvLiw3JLZ9sm70t
 qpMuuMXUnXMZ7HvbAbFJFw5YSd812bxZseaHfcF268whkXu7ETNfcj13ql2Fve/HG82AuMijT1KRp
 82odX9KPf4BXK61LFYhyuvu14YKJelVpUuVTM2ItT6L2MdOV4V40D1VOH2mw51m1yxnh/ionec2ew
 6Mav8vKdd1kTcMKTsTWbWOXRx/JaMBe4JYylA9/j33bRt4gOjHkL8XHFlu6v1SRnlMYhjP8/0cCmd
 F+3udalCNj4euvX08iPScnNShlPx3pGJBEYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.104]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GQs-1rmac82MyW-014DKc; Tue, 19
 Sep 2023 09:53:48 +0200
Message-ID: <10cd16558e47ccb43e00261b18e38f4ec2f61690.camel@gmx.de>
Subject: Re: [PATCH 2/2] sched/eevdf: Use sched_attr::sched_runtime to set
 request/slice suggestion
From:   Mike Galbraith <efault@gmx.de>
To:     peterz@infradead.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, tglx@linutronix.de,
        daniel.m.jordan@oracle.com
Date:   Tue, 19 Sep 2023 09:53:45 +0200
In-Reply-To: <20230915124822.956946622@noisy.programming.kicks-ass.net>
References: <20230915124354.416936110@noisy.programming.kicks-ass.net>
         <20230915124822.956946622@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:N4OA0uNOczmDTP/Sy+gce26zcwxy/j74yHyFNy9Q/wWsz0DKbg1
 ghejTdE3lb0MkLd28dRr7qrxIDCRAiFRU997PqU4ujdWTIeK8jh2ILE4OaV1kwQzKYxMsSU
 CJNtzOkv84fqa0xJH7Lt1zLafq2wTpdfO/hHO1+A6KF9BUcWvYclgIEnsRUIEHyqBKyzMCx
 VgA3y7q2c+bqQDkRH4rQw==
UI-OutboundReport: notjunk:1;M01:P0:36wndeWj+4E=;5iYi8lZHyd4/yk0RNs084974Lgf
 4ULv8cO0q1pJaJ2AG+Mb89ayuGTgujX0KdPJpb2x1tBK93qmxz5jXNnbyGe2ENyNdipP3cMnJ
 v8cAzAw2xRCPpYKauIL2RMCgwGLJ2XrZwxE+L7Y+nxAUU933SkGv9dpHJGx7Hv1GLz0Ofg0eA
 mIK6z8GPqRnSZKEEYm+77BrxqilAU8Xn0G7jOJaiKedthKktZ5e9ZK9JuTTue7brSTT7Te3XZ
 bH5HuORFG0dOzAh9iyzD0tcMLmMGr7C/zDJjGEQTugFaLjqzfxzChRYwJ90rHS/ns/JgFfg2F
 el7xWmhOx7m2bppXQhffZCrYcAavZ4VhpamarwnuSQIjBkc7t7QMikj1ecKGrKWXktqcD3Gzj
 eVS0RhVwb0aWWoxKG+O8v/yYS3gP54gfIcxRxy8PrZnQamS4av/PRHvbUVwnp4aASH+OiYSy4
 XfFheQY6dc81lLKQg9T8ozzEXqY3DSTieqmkT1apSRLm6ddY2JJaCtKgPbpYFOoeN42VjmyD0
 3ccybzThaVvkz/RiTVxixF7Mu6du87R28+5MTP806vVOEtcLXflTD4a0FhQFChalnZjH6zfSn
 cLfTDYuOM+geVUgq18aEQpIG4V3rpnO8Fqm7MOc/Khyk15UUEzg+Nq0RDy2IyjdBOyFcU1gEE
 8G0BZMrrYjXroOFZlEMG+31CAk9lNIF72DQN9vmsHmDS19fQjBNywrrMLQ4l1pAhFaT2WrosQ
 ze2JPaWdigLhPK6gVYFwBbWFw/CJiYvaRuOPYx+QDa9teXQldLmYuF4gezrDKLKrOXYYR5nSS
 IaeXxA+zNXQWbwK8vyIpkJJM+Fg/A9c00ZA7y5JbOjrVIQ7PWO1vhWetmcB77ZGd9iR6lRZNH
 Ulwg9N/fP9VLChXI1k0dpU3jK+SJifyKuCgAhm7PWs4j83btJHj+WDb5jZNlTm8lwBIZifVMf
 DQrUl6FwQXMgksrdA88JvXxG7ug=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-09-15 at 14:43 +0200, peterz@infradead.org wrote:
> Allow applications to directly set a suggested request/slice length using
> sched_attr::sched_runtime.

I met an oddity while fiddling to see what a custom slice would do for
cyclictest, it seeming to be reasonable target.  $subject seems to be
working fine per live peek with crash, caveat being it's not alone in
otherwise virgin source...

homer:..kernel/linux-tip # make -j8 vmlinux && killall cyclictest

Elsewhere, post build/kill...

instance-a, stock
homer:/root # cyclictest -Smq
# /dev/cpu_dma_latency set to 0us
T: 0 (17763) P: 0 I:1000 C: 297681 Min:      2 Act:   51 Avg:   66 Max:   10482
T: 1 (17764) P: 0 I:1500 C: 198639 Min:      2 Act: 3159 Avg:   70 Max:    9054
T: 2 (17765) P: 0 I:2000 C: 149075 Min:      2 Act:   52 Avg:   78 Max:    8190
T: 3 (17766) P: 0 I:2500 C: 119867 Min:      2 Act:   55 Avg:   77 Max:    8328
T: 4 (17767) P: 0 I:3000 C:  99888 Min:      2 Act:   51 Avg:   90 Max:    8483
T: 5 (17768) P: 0 I:3500 C:  85748 Min:      3 Act:   53 Avg:   76 Max:    8148
T: 6 (17769) P: 0 I:4000 C:  75153 Min:      3 Act:   53 Avg:   92 Max:    7510
T: 7 (17770) P: 0 I:4500 C:  66807 Min:      3 Act:   55 Avg:   81 Max:    8709

instance-b, launched w. custom slice, and verifies via live peek with crash.
homer:/root # schedtool -v -s 100000 -e cyclictest -Smq
PID 17753: PRIO   0, POLICY N: SCHED_NORMAL  , NICE   0, EEVDF_NICE   0, EEVDF_SLICE 100000, AFFINITY 0xff
# /dev/cpu_dma_latency set to 0us
T: 0 (17754) P: 0 I:1000 C: 297014 Min:      1 Act:   51 Avg:   79 Max:    9584
T: 1 (17755) P: 0 I:1500 C: 198401 Min:      1 Act: 3845 Avg:  118 Max:    9995
T: 2 (17756) P: 0 I:2000 C: 149137 Min:      1 Act:  103 Avg:  125 Max:    8863
T: 3 (17757) P: 0 I:2500 C: 119519 Min:      1 Act:   52 Avg:  218 Max:    9704
T: 4 (17758) P: 0 I:3000 C:  99760 Min:      1 Act:   51 Avg:  134 Max:   11108
T: 5 (17759) P: 0 I:3500 C:  85731 Min:      1 Act:   53 Avg:  234 Max:    9649
T: 6 (17760) P: 0 I:4000 C:  75321 Min:      2 Act:   53 Avg:  139 Max:    7351
T: 7 (17761) P: 0 I:4500 C:  66929 Min:      3 Act:   51 Avg:  191 Max:    6469
                                                               ^^^ hmm
Those Avg: numbers follow the custom slice.

homer:/root # schedtool -v -s 500000 -e cyclictest -Smq
PID 29755: PRIO   0, POLICY N: SCHED_NORMAL  , NICE   0, EEVDF_NICE   0, EEVDF_SLICE 500000, AFFINITY 0xff
# /dev/cpu_dma_latency set to 0us
T: 0 (29756) P: 0 I:1000 C: 352348 Min:      1 Act:   51 Avg:   67 Max:   10259
T: 1 (29757) P: 0 I:1500 C: 229618 Min:      1 Act:   59 Avg:  121 Max:    8439
T: 2 (29758) P: 0 I:2000 C: 176031 Min:      1 Act:   54 Avg:  159 Max:    8839
T: 3 (29759) P: 0 I:2500 C: 139346 Min:      1 Act:   52 Avg:  186 Max:    9498
T: 4 (29760) P: 0 I:3000 C: 117779 Min:      2 Act:   54 Avg:  172 Max:    8862
T: 5 (29761) P: 0 I:3500 C: 101272 Min:      1 Act:   54 Avg:  180 Max:    9331
T: 6 (29762) P: 0 I:4000 C:  88781 Min:      3 Act:   54 Avg:  208 Max:    7111
T: 7 (29763) P: 0 I:4500 C:  78986 Min:      1 Act:  143 Avg:  168 Max:    6677

homer:/root # cyclictest -Smq
# /dev/cpu_dma_latency set to 0us
T: 0 (29747) P: 0 I:1000 C: 354262 Min:      2 Act:   51 Avg:   65 Max:    9754
T: 1 (29748) P: 0 I:1500 C: 236885 Min:      1 Act:   43 Avg:   56 Max:    8434
T: 2 (29749) P: 0 I:2000 C: 177461 Min:      3 Act:   53 Avg:   75 Max:    9028
T: 3 (29750) P: 0 I:2500 C: 142315 Min:      2 Act:   53 Avg:   74 Max:    7654
T: 4 (29751) P: 0 I:3000 C: 118642 Min:      3 Act:   51 Avg:   78 Max:    8169
T: 5 (29752) P: 0 I:3500 C: 101833 Min:      3 Act:   52 Avg:   75 Max:    7790
T: 6 (29753) P: 0 I:4000 C:  89065 Min:      3 Act:   52 Avg:   76 Max:    8001
T: 7 (29754) P: 0 I:4500 C:  79323 Min:      3 Act:   54 Avg:   78 Max:    7703

