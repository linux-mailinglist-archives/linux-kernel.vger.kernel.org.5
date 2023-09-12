Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B450079C6EA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjILGcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjILGct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:32:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F9EE75
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694500337; x=1695105137; i=efault@gmx.de;
 bh=nuIHS0Ni8crXNhVzrCs+py4QjluvVcl8qgxbKXCu9Xg=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=jiLamhHBL+hpm60DseLpNa3j9QpXthGBhwZbxlSHfjqcax4J5PLJ8NM3mj7BcWGfKBk93WY
 S+oJMlj9tdGwxEhsA+vM+7iXeDGw6y6o/8KWYUDAqDLu3RPOxEbrRG95ucTLL97+v69nptQTU
 kkiKPkezetn9uGDcia8xK0O2MG+lOfGBsjgWO7AjLb9QsJqwTBPAlqrtE1M7g9DJEce+jaZTG
 yFRmTVR1GNfULp/vmPYu1YEmlr0CayzM/m7vL3bhM6D9qLSejMIIPl3tAmyUcqnqZ3onPUNU2
 wRgCbp1TOoWvse0ljI7hkepx04+M3oaZC3yViZyp6WVm9RdN6Z8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.151.115]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3DJv-1qjWma2ngj-003dVt; Tue, 12
 Sep 2023 08:32:17 +0200
Message-ID: <030b279a19a2c5929972b9b56cce40f4f919ed20.camel@gmx.de>
Subject: Re: [RFC PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
From:   Mike Galbraith <efault@gmx.de>
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Chen Yu <yu.c.chen@intel.com>
Cc:     Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Date:   Tue, 12 Sep 2023 08:32:13 +0200
In-Reply-To: <31c910c2-717d-b86c-4e08-5c94383682e8@amd.com>
References: <cover.1694397335.git.yu.c.chen@intel.com>
         <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
         <31c910c2-717d-b86c-4e08-5c94383682e8@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EP3WJNbdA81CrlRkD8fNl0h6ZXHGAm0HApSK9GneZZd68s8bJZf
 IsULSibIJlK9OAgsfwiIzQ/SVSxoiEL96jsVSAKsQwnFC2V/9ZEUTcfv+g1INcXAPnADzUF
 LiNmXYxFo3yPxoI8aDfCk+3GXu0kt4JY2tK55egumKo/PJ3kOnTKjipjRC/XtnRUpvKCBcn
 6zElUfQMIhjUBqo/WszXw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l+XgMITDllE=;AlCVDOBJPJlF70r3iZ7myLOq3H8
 XDjJ01hYYljGPD9eZd/AtEs4IPGg+j7jCGKykd6C/AzhZ71AAwwvPjUvp4+Dip3SqIFDAmcbk
 PZ8OLayRF4RxWq0hDBCQR4YVRVs5tzHqde/NxwEQogqABVF+fBKP4fhKSP9jBZfKpx1dusI9c
 LmYZjYGxukYUJhvvjJGqDF6li9hZp6x8gLOTfMXzWeqsmtrVESbXH6/LBLKZDBXw5ixgqyg8i
 g0iv6hbcDDL2gIofXImhHDSIEW0LW6mz43YDOQYBPgkn3TaXbQ4NVMOu9JF6XoprK33/zcOeP
 K2cLZMTqiiMc0/2ec826xkR/yKxytX7+6XiXqirrOicDn+jjNJYbjKbL1iRTjfwDi8Rz0R1So
 XjPdCH+vtmC73es2fpV3Hl1RdnzO1+LjJVvS6joxUW+H7sMYko/8nG3c/TsuSxB0O2CaKOc9n
 2P7GZSQZhiHLfwwmIApqQ4o9jjhSoD3aSR3ybW87gPFsm1fYc9C0gYl8r+eKgqKnF/5Vxw2t+
 jpR15dzjk7sTsf6sw/1IJvKF9E6alQhhq5HSMoxnCbM8L2Fu4mzTZmZUd/I17+iXt4MRucY+s
 6uypBenJ/eEp00SNUv1XRjBt8BPNdp2rRBJJys4jCHgnrj7ywmfLiU5zSWWGodKbw3DG+XPqx
 GqwNWS1BOgpD5rQZpwAqO/oBEZF8Cd2oSX1TTd47XIswt4oVrT8uQyi9UMyxRoADSx7kQXkI7
 Mr6AbDQK4pJmjHAPW5Z3BHthwty0nZjRAIw416ctnsqPbwSn/QSsamEE7BLQHV5gzgGR5Tflp
 ulpPE1K1D3H/A6TFO9sF9FagZYO8N3bUnVfpNRStE3pVE9anZl/ug0szIc1ZGLIdzd5ORaiLn
 11xycioYdiTKGG9x20QAR+cr7tHQDiiRYCFycCUaTpYodNJySNehEcKPs9CLlhx2Sgti3tZla
 XQHJ6Z1LcwF0CilcdxjfiPGDoGw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-11 at 13:59 +0530, K Prateek Nayak wrote:
>
> Speaking of cache-hot idle CPU, is netperf actually more happy with
> piling on current CPU?

Some tests would be happier, others not at all, some numbers below.

I doubt much in the real world can perform better stacked, to be a win,
stacked task overlap induced service latency and utilization loss has
to be less than cache population cost of an idle CPU, something that
modern CPUs have become darn good at, making for a high bar.

> I ask this because the logic seems to be
> reserving the previous CPU for a task that dislikes migration but I
> do not see anything in the wake_affine_idle() path that would make the
> short sleeper proactively choose the previous CPU when the wakeup is
> marked with the WF_SYNC flag. Let me know if I'm missing something?

If select_idle_sibling() didn't intervene, the wake affine logic would
indeed routinely step all over working sets, and at one time briefly
did so due to a silly bug. (see kernel/sched/fair.c.today:7292)

The sync hint stems from the bad old days of SMP when cross-cpu latency
was horrid, and has lost much of its value, but its bias toward the
waker CPU still helps reduce man-in-the-middle latency in a busy box,
which can do even more damage than that done by stacking of not really
synchronous tasks that can be seen below.

The TCP/UDP_RR tests are very close to synchronous, and the numbers
reflect that, stacking is unbeatable for them [1], but for the other
tests, hopefully doing something a bit more realistic than tiny ball
ping-pong, stacking is a demonstrable loser.

Not super carefully run script output:

homer:/root # netperf.sh
TCP_SENDFILE-1  unbound    Avg:  87889  Sum:    87889
TCP_SENDFILE-1  stacked    Avg:  62885  Sum:    62885
TCP_SENDFILE-1  cross-smt  Avg:  58887  Sum:    58887
TCP_SENDFILE-1  cross-core Avg:  90673  Sum:    90673

TCP_STREAM-1    unbound    Avg:  71858  Sum:    71858
TCP_STREAM-1    stacked    Avg:  58883  Sum:    58883
TCP_STREAM-1    cross-smt  Avg:  49345  Sum:    49345
TCP_STREAM-1    cross-core Avg:  72346  Sum:    72346

TCP_MAERTS-1    unbound    Avg:  73890  Sum:    73890
TCP_MAERTS-1    stacked    Avg:  60682  Sum:    60682
TCP_MAERTS-1    cross-smt  Avg:  49868  Sum:    49868
TCP_MAERTS-1    cross-core Avg:  73343  Sum:    73343

UDP_STREAM-1    unbound    Avg:  99442  Sum:    99442
UDP_STREAM-1    stacked    Avg:  85319  Sum:    85319
UDP_STREAM-1    cross-smt  Avg:  63239  Sum:    63239
UDP_STREAM-1    cross-core Avg:  99102  Sum:    99102

TCP_RR-1        unbound    Avg: 200833  Sum:   200833
TCP_RR-1        stacked    Avg: 243733  Sum:   243733
TCP_RR-1        cross-smt  Avg: 138507  Sum:   138507
TCP_RR-1        cross-core Avg: 210404  Sum:   210404

UDP_RR-1        unbound    Avg: 252575  Sum:   252575
UDP_RR-1        stacked    Avg: 273081  Sum:   273081
UDP_RR-1        cross-smt  Avg: 168448  Sum:   168448
UDP_RR-1        cross-core Avg: 264124  Sum:   264124

1. nearly unbeatable - shared L2 CPUS can by a wee bit.
