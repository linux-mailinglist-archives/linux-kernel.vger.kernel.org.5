Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8F479CC17
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjILJkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjILJk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:40:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88B2CC3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694511597; x=1695116397; i=efault@gmx.de;
 bh=3LlqbtKm2Ooiid+7bcksAZg5xhp4yhAr1w3kwdcvgcY=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=e+Ys/n/Zq5wQDKJpJfDKASYrqSyo1wS+Sry6QIAAOK4QfvuVmA+4Py4QkcZo9Du6QRzGSvz
 t0Q1nHYkVn5CUvtKe/b5R/8Tu5SMTSuSXiZhrt+1cHARlRyuclnjzv/4b+CJueBI4svV8lPUn
 XdYBCxyJ6KEENTVXMxl3tN4v3g52kynV7PqNHhJLKsctudJH/WLt0bzfZEoe5uLcHXH3o9dX5
 xCvCdWuqRaHO8rFdvPRZFaV8UxJaaLvHqLwWD7Ln4IAASE2Yr9OZYKDA7ZxskmZI9zz6DpDtf
 X+GBeYbyGcaATOEY/Zravj2H/5ATs3nKKLB+/gTse/e6CaAF7wmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.151.115]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKu0-1r8db31K4e-00SfWp; Tue, 12
 Sep 2023 11:39:57 +0200
Message-ID: <a8c1b296a4ed444b9cab166a5a39aa11836903a8.camel@gmx.de>
Subject: Re: [RFC PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
From:   Mike Galbraith <efault@gmx.de>
To:     Chen Yu <yu.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
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
Date:   Tue, 12 Sep 2023 11:39:55 +0200
In-Reply-To: <ZP7ptt70uF10wxlg@chenyu5-mobl2>
References: <cover.1694397335.git.yu.c.chen@intel.com>
         <d49cf5748aa7c6d69580315d2373a9eafa21c21f.1694397335.git.yu.c.chen@intel.com>
         <31c910c2-717d-b86c-4e08-5c94383682e8@amd.com>
         <ZP7ptt70uF10wxlg@chenyu5-mobl2>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KB1l91isQSB6Oam/O2/3Gf+VfVbZFgUXoaA8edEuA6rL/tlWKU+
 1gH1I/WXUoogzwpnu6S780ZzH1IvtG7E7vG+Avr8K3YmeIj0V1+nkDNG7oY7eR7kCvAc3lo
 G09QQ1CywCTUeRfRyrMlDZCL7BynJCN6wD78l7k2TZswkx8BzwIwpLW0NC6z4I/AQS952K0
 Dr9vs4jM/oXCNk0ZKlXjw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pLOnFt3aonE=;1ZU57Y3w45Umng2I6FVB/x6AK8e
 HXmRcO3Z6v6kkXYCe3AzKqcBM29qeQ/J53utUYOp486rYjUqboAWZ8zJH7z+pF5lPvME9cqX4
 CtTMhSKw+7Fu8jlNTDWsHb+IUB8QGch2P7fmcQa5tTsrg6/dSTaFOZASiXI0MXG+H8FFYzgr/
 0alPpO1TMwvjRDu6JM+UR2TYtlHcGLHNOFGOsCfoAjjMaEDW/YGVcFJ/F2cn0kQdro0e4qWPb
 DqcYD1uDfc2mEkBLTWP7PXZpHsffgzvNli7bRw+tagJ5L/eC293NMSRpWGp/JB7S/v3xYV5zc
 4NTZvZi7RsTqFQ12Qw559s6VgPS7WT11u1OimnT1/TxI5+1afbp/sTk1beWJ24Ed+chmtYb+w
 58c5sZBlIDPgnOJ5PC+Qx9V0K2ReAmoTUG7Lza+sTrOtXE3RwGiNY7azysmg6ZZafrgFVBzPY
 ZLEpnHEDGg8busQhCJ8i49+nxfCnIVEg8YXjUCR1rtuNz7DGuqq3x4hjJCLspfVNUBZIPq+V/
 kvgvNr7YvJM8X9ff6QBKjwj9hv+IA58gTxv7El3dHZd77AxaH27rYz4R60XguPWCHEFK6c+28
 2u86yilawEHlPP0NZTOM35ofUlEohJCmcTzlqPiwMSzbP062CliYXUVZoa4wrLdRAruQ74H5I
 1q8ybKjhfNFEiHuWEKL+5f5WZadYK91PdVsaYr0aLdp4GVKgJlBLzi1uhEdqRL0TqMw+0Xc+6
 MJaGcb3BxiusoNXmoW1G/+r2+hZjMoHcvXAzRpRAw6mqDx6SzGCV44uKVWHviOygxXijr95gX
 ypdQ5NS0S3zvkaXKac+ahjd6F2WhxED2QT+t+0szdT0h13fIUfLJn/17zc0h9GgHVeXgLHtc9
 5Ad3qJTmR9y077A+6mIowmalKwOX4hYbPmClyPCZUIyvH89C6ZWX5Z4ZtsMKdTg/QEB4aUxA4
 ljRJ6WGSIhajnwDEKXrEkrzyiyo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-11 at 18:19 +0800, Chen Yu wrote:
>
> > Speaking of cache-hot idle CPU, is netperf actually more happy with
> > piling on current CPU?
>
> Yes. Per my previous test, netperf of TCP_RR/UDP_RR really likes to
> put the waker and wakee together.

Hm, seems there's at least one shared L2 case where that's untrue by
more than a tiny margin, which surprised me rather a lot.

For grins, I tested netperf on my dinky rpi4b, and while its RR numbers
seem kinda odd, they're also seemingly repeatable (ergo showing them).
I measured a very modest cross-core win on a shared L2 Intel CPU some
years ago (when Q6600 was shiny/new) but nothing close to these deltas.

Makes me wonder what (a tad beefier) Bulldog RR numbers look like.

root@rpi4:~# ONLY=3DTCP_RR netperf.sh
TCP_RR-1        unbound    Avg:  29611  Sum:    29611
TCP_RR-1        stacked    Avg:  22540  Sum:    22540
TCP_RR-1        cross-core Avg:  30181  Sum:    30181

root@rpi4:~# netperf.sh
TCP_SENDFILE-1  unbound    Avg:  15572  Sum:    15572
TCP_SENDFILE-1  stacked    Avg:  11533  Sum:    11533
TCP_SENDFILE-1  cross-core Avg:  15751  Sum:    15751

TCP_STREAM-1    unbound    Avg:   6331  Sum:     6331
TCP_STREAM-1    stacked    Avg:   6031  Sum:     6031
TCP_STREAM-1    cross-core Avg:   6211  Sum:     6211

TCP_MAERTS-1    unbound    Avg:   6306  Sum:     6306
TCP_MAERTS-1    stacked    Avg:   6094  Sum:     6094
TCP_MAERTS-1    cross-core Avg:   9393  Sum:     9393

UDP_STREAM-1    unbound    Avg:  22277  Sum:    22277
UDP_STREAM-1    stacked    Avg:  18844  Sum:    18844
UDP_STREAM-1    cross-core Avg:  24749  Sum:    24749

TCP_RR-1        unbound    Avg:  29674  Sum:    29674
TCP_RR-1        stacked    Avg:  22267  Sum:    22267
TCP_RR-1        cross-core Avg:  30237  Sum:    30237

UDP_RR-1        unbound    Avg:  36189  Sum:    36189
UDP_RR-1        stacked    Avg:  27129  Sum:    27129
UDP_RR-1        cross-core Avg:  37033  Sum:    37033
