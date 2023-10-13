Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F477C7E29
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjJMGwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjJMGwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:52:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208CCDE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697179848; x=1697784648; i=efault@gmx.de;
 bh=ctb0gjh0Sxb2BO766SXB3xkIjURNTH7ff9uxbeu/Nks=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=lNrpXnMYfbl+X5hcqIjbIxht3m3XS+DeAphCcj3QF5nm9lh3A1xfI23O+gxSV4t4vuaCLhNhpxO
 WqRuhaHPNFNEmQPIXU1yKDcjkXLonwLtRsSLB2kUVMtSiBc6huG9C7VXN1y+Is6J/ML+1mVyVLg4o
 OUAwgv+lwgybfLCEmIShzfDWMieB3s33WYE5xv9iHPvMlNWkqq6xWPch/HT77VxZp+pVzz+LCpYxc
 RrJtq2SCip0ZpVmEbkEweXOUOzGy046bzSbHcmuh2+2MD3vlleBoSnX/4YGstdPIQAq3uGR+ZNEFG
 OCCSVE0vYFo1avKMdJpo2+wum3qUvkUr8PzA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.218.116]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK4f-1ri3g12hCz-00rDCL; Fri, 13
 Oct 2023 08:50:48 +0200
Message-ID: <982d5b9c54625938db7b67778466a0d4dd38c334.camel@gmx.de>
Subject: Re: [PATCH] sched/eevdf: Toggle eligibility through sched_feat
From:   Mike Galbraith <efault@gmx.de>
To:     Youssef Esmat <youssefesmat@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     peterz@infradead.org, bsegall@google.com, mingo@kernel.org,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, joel@joelfernandes.org, tglx@linutronix.de,
        wuyun.abel@bytedance.com
Date:   Fri, 13 Oct 2023 08:50:42 +0200
In-Reply-To: <20231013030213.2472697-1-youssefesmat@chromium.org>
References: <20231013030213.2472697-1-youssefesmat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iBFHPufNZg/jTxXbojh4lQ4v0amcMJSeBg8kPEykNettpb9Jpoa
 a3NIcW9g+u5gCbL3xDWXsv1c7ffSfcA25ntYMobyiDSZ36gdOQ61DbQ+0tBMdntfA8gj1Ro
 MFZvx5At8QnMs0uc1waTwj/iZLuGSAa4l4fWEhhg+GFRi+R6vZw9Bs7PuRCdY3IAdwf4nag
 UxZT22LavUAEK4FTDXMJA==
UI-OutboundReport: notjunk:1;M01:P0:R8uMc+4H2ow=;nLUQxxxTtL9MZP2UQp1eYFxOWKk
 vGZCtpsR7pVfFgbQfFOxoXMpy2xJBvmJdwXZa1RS1UtXl5JBp+3G3MfIEc0Fnmq0u8zt4P+NI
 rVQmU+uGhi+hH6jAzD/n/VC+KHg1BHdComxeguPUK2KQ9CD15QmjntFUxUKC4PXKX01pDq9wW
 R7u+W8t8V2Ev9P2Ty0Dt0fZdkGIsQd1mxa7mckQ2IJo6m27fxp5LiCXV4wNwTROfNob6lubIN
 rwuQF6VOcNjVkSedHeBTCKC/BtpSQ/z6ZsRpGoybpEGOc50VBDHMxyUze3knUMZR7XwFVWzTO
 TyUDIm+2eEk1Ae+iDj5Xd0DwAt+AASJveeTZfiKcqLwciBaRsrNiWqErICc5h9GJWkSjevhz+
 8dgwIQLT0lBqJZS+qZy3oFczpmGA3nx4EePWZixzE/KbcDmt8DoChPFkYjOpkZkbRiBh5Jtxg
 FUtNslAr9DKcsCldc/+gcLQOaZMnrn+Z2g3P7IWeFrWEx+GV0rAIDjQMiH179FyhAHJV1lSSj
 7SNw0l+aztlCY/4tfOm4Ekzwmgdnu2xKg8basPZqwCkGeUHBKGMy5kePrb/2QNPGjpIChxo0G
 4QBIfF8BusSx7+uSF6D0t6nnwnoVfUO9IuOre7hqe0ZQyPrvvvBc2VWBl0X8sTAduWGsgQ8r1
 UcxiJX+PWr3JHDPRCTTRlkUoRb/SIAMtGfJecM5jNZnlCyEl0jyuTVRWpZrIG7xOTiY/GM0fZ
 jDMHBcRxNOaEYT/bX8qHoyZKZpix4XsrX4P+zelrroLZvjTq+7AIwSP/3MpLoeiUi2MSj9ulY
 hPrOQ6qSDQ2pTwC6WyRNj7qd/nGDykfs2rLh4SN0qDzXex+KiXuUO8EFU1LoW+Nfk9lXka7TU
 m2+2sdOvQ9++Lwo7tPjYfN/Vz3SW8WgDq8j82HlCf+wEVuQLh+jrnJ4DdSPT/qswtMbfSlBI4
 +WEWnC9lhHmGLHZy1HSVTiW1T00=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-12 at 22:02 -0500, Youssef Esmat wrote:
> Interactive workloads see performance gains by disabling eligibility
> checks (EEVDF->EVDF). Disabling the checks reduces the number of
> context switches and delays less important work (higher deadlines/nice
> values) in favor of more important work (lower deadlines/nice values).

For some definitions of both interactive and benefit, both being a bit
too slippery to nail to the floor.

> That said, that can add large latencies for some work loads and as the
> default is eligibility on, but allowing it to be turned off when
> beneficial.

The only contra I would mention WRT the feature is that features having
no abi or thou shalt not regress protections makes them.. suboptimal
tuning knobs for userspace.

WRT patchlet, I tried same yesterday for grins (but spelled it "EVDF")
and fed it my favorite mixed load of youtube vs 8ms run 1ms sleep
massive_intr as a vaguely kbuild like competing "compute" component. It
didn't do anything lovely for the "interactive" bits, in fact did some
damage when letting the CPU do the rendering (something I have good but
irrelevant reasons to do at times;).  With or without RUN_TO_PARITY,
EVDF skewed distribution toward "compute".

Some numbers, these from my old i7-4790 box:

Executive summary
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Sum delay ms     |
stock
  massive_intr:(9)      |1827981.908 ms |  9163472 | avg:   0.040 ms | max:  13.026 ms | sum:366012.231 ms |
  chrome:(8)            |  33240.153 ms |   231301 | avg:   0.167 ms | max:   9.843 ms | sum:38606.462 ms |
  TOTAL:                |2307670.845 ms | 25693098 |                 |       19.050 ms |   1110835.993 ms |
evdf
  massive_intr:(9)      |1882920.417 ms |   575899 | avg:   0.536 ms | max:  31.997 ms | sum:308728.289 ms |
  chrome:(12)           |  33353.359 ms |    79764 | avg:   1.082 ms | max:  22.964 ms | sum:86266.324 ms |
  TOTAL:                |2289006.437 ms |  5105092 |                 |       31.997 ms |   2748046.342 ms |
evdf+no_run_to_parity
  massive_intr:(9)      |1853786.765 ms |  7939307 | avg:   0.043 ms | max:  14.061 ms | sum:340332.470 ms |
  chrome:(8)            |  32196.003 ms |   213646 | avg:   0.257 ms | max:  16.000 ms | sum:54881.879 ms |
  TOTAL:                |2329645.888 ms | 23157228 |                 |       16.475 ms |   1340188.243 ms |

nomodeset
stock
  massive_intr:(9)      |1618277.030 ms |  1762657 | avg:   0.339 ms | max:  15.149 ms | sum:597323.918 ms |
  chrome:(17)           |  44370.796 ms |   130519 | avg:   0.385 ms | max:  15.948 ms | sum:50216.546 ms |
  TOTAL:                |2366021.752 ms |  6242921 |                 |       20.655 ms |   1633058.780 ms |
evdf
  massive_intr:(9)      |1794662.731 ms |   533364 | avg:   0.760 ms | max:  32.242 ms | sum:405150.225 ms |
  chrome:(16)           |  32630.283 ms |    76394 | avg:   1.276 ms | max:  25.762 ms | sum:97491.996 ms |
  TOTAL:                |2338042.935 ms |  2756565 |                 |       32.242 ms |   3230287.162 ms |
evdf+no_run_to_parity
  massive_intr:(9)      |1697254.229 ms |  1584416 | avg:   0.321 ms | max:  19.086 ms | sum:508946.014 ms |
  chrome:(16)           |  39621.161 ms |   125058 | avg:   0.500 ms | max:  18.078 ms | sum:62565.629 ms |
  TOTAL:                |2376861.778 ms |  6325320 |                 |       24.005 ms |   1714658.200 ms |

Full perf summaries below (tl-dnr unless bored), end of filename describes setup.

perf sched lat -i perf.data.full.6.4.16-eevdf.stock --sort=runtime -S 15 -T

 ----------------------------------------------------------------------------------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Sum delay ms     |
 ----------------------------------------------------------------------------------------------------------
  massive_intr:(9)      |1827981.908 ms |  9163472 | avg:   0.040 ms | max:  13.026 ms | sum:366012.231 ms |
  ThreadPoolForeg:(19)  | 171104.054 ms |  1929317 | avg:   0.101 ms | max:  19.050 ms | sum:195506.036 ms |
  Compositor:19163      |  49069.470 ms |   239950 | avg:   0.140 ms | max:  12.894 ms | sum:33621.049 ms |
  X:2146                |  46323.935 ms |   428673 | avg:   0.070 ms | max:   9.189 ms | sum:30078.222 ms |
  VizCompositorTh:19249 |  41340.942 ms |   264742 | avg:   0.155 ms | max:   8.100 ms | sum:40944.049 ms |
  chrome:(8)            |  33240.153 ms |   231301 | avg:   0.167 ms | max:   9.843 ms | sum:38606.462 ms |
  VideoFrameCompo:19257 |  21586.135 ms |   164881 | avg:   0.159 ms | max:   7.957 ms | sum:26136.556 ms |
  kwin_x11:2580         |  17878.786 ms |   197481 | avg:   0.111 ms | max:   9.070 ms | sum:21872.000 ms |
  kthreadd:(18)         |  14951.452 ms |  2671846 | avg:   0.009 ms | max:   8.010 ms | sum:23349.382 ms |
  Chrome_ChildIOT:(5)   |   7253.392 ms |   206688 | avg:   0.117 ms | max:   7.288 ms | sum:24099.171 ms |
  cyclictest:(9)        |   5707.305 ms |  1058199 | avg:   0.171 ms | max:  13.533 ms | sum:181391.599 ms |
  kworker/7:1+eve:18761 |   5201.144 ms |   957751 | avg:   0.008 ms | max:   8.909 ms | sum: 8113.339 ms |
  perf:(2)              |   5025.244 ms |     1865 | avg:   0.107 ms | max:   7.227 ms | sum:  199.488 ms |
  kworker/0:0-eve:18017 |   4967.620 ms |   916589 | avg:   0.007 ms | max:   9.728 ms | sum: 6758.811 ms |
  Media:19256           |   4964.743 ms |    83078 | avg:   0.177 ms | max:   9.663 ms | sum:14695.510 ms |
 ----------------------------------------------------------------------------------------------------------
  TOTAL:                |2307670.845 ms | 25693098 |                 |       19.050 ms |   1110835.993 ms |
 ----------------------------------------------------------------------------------------------------------

perf sched lat -i perf.data.full.6.4.16-eevdf.evdf --sort=runtime -S 15 -T

 ----------------------------------------------------------------------------------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Sum delay ms     |
 ----------------------------------------------------------------------------------------------------------
  massive_intr:(9)      |1882920.417 ms |   575899 | avg:   0.536 ms | max:  31.997 ms | sum:308728.289 ms |
  ThreadPoolForeg:(30)  | 165069.668 ms |   470614 | avg:   0.639 ms | max:  29.031 ms | sum:300696.457 ms |
  Compositor:(2)        |  46785.446 ms |    60712 | avg:   0.858 ms | max:  31.196 ms | sum:52104.985 ms |
  X:2146                |  46547.283 ms |   107721 | avg:   0.513 ms | max:  17.115 ms | sum:55250.852 ms |
  VizCompositorTh:17683 |  40856.147 ms |    60474 | avg:   0.905 ms | max:  20.163 ms | sum:54729.452 ms |
  chrome:(12)           |  33353.359 ms |    79764 | avg:   1.082 ms | max:  22.964 ms | sum:86266.324 ms |
  VideoFrameCompo:17692 |  17277.120 ms |    53230 | avg:   0.853 ms | max:  15.759 ms | sum:45393.835 ms |
  kwin_x11:2580         |  13312.455 ms |    94547 | avg:   0.302 ms | max:  15.399 ms | sum:28526.434 ms |
  Chrome_ChildIOT:(9)   |   6318.114 ms |    94165 | avg:   0.902 ms | max:  16.436 ms | sum:84971.013 ms |
  Media:17691           |   4880.461 ms |    45385 | avg:   0.843 ms | max:  13.567 ms | sum:38262.166 ms |
  cyclictest:(9)        |   3559.891 ms |   666850 | avg:   1.982 ms | max:  20.180 ms | sum:1321503.199 ms |
  kthreadd:(13)         |   3474.286 ms |   602855 | avg:   0.074 ms | max:  17.846 ms | sum:44813.758 ms |
  alsa-sink-ALC88:2088  |   2583.063 ms |    41163 | avg:   0.005 ms | max:   0.515 ms | sum:  188.379 ms |
  plasmashell:(2)       |   2362.395 ms |    19626 | avg:   1.068 ms | max:  14.794 ms | sum:20955.374 ms |
  threaded-ml:17712     |   1487.397 ms |    17958 | avg:   1.165 ms | max:  16.443 ms | sum:20926.765 ms |
 ----------------------------------------------------------------------------------------------------------
  TOTAL:                |2289006.437 ms |  5105092 |                 |       31.997 ms |   2748046.342 ms |
 ----------------------------------------------------------------------------------------------------------

perf sched lat -i perf.data.full.6.4.16-eevdf.evdf_no_run_to_parity --sort=runtime -S 15 -T

 ----------------------------------------------------------------------------------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Sum delay ms     |
 ----------------------------------------------------------------------------------------------------------
  massive_intr:(9)      |1853786.765 ms |  7939307 | avg:   0.043 ms | max:  14.061 ms | sum:340332.470 ms |
  ThreadPoolForeg:(20)  | 167239.704 ms |  2256833 | avg:   0.113 ms | max:  16.475 ms | sum:254078.291 ms |
  Compositor:18389      |  48419.605 ms |   200778 | avg:   0.230 ms | max:  12.690 ms | sum:46259.813 ms |
  X:2146                |  45209.241 ms |   333263 | avg:   0.138 ms | max:  11.095 ms | sum:45850.493 ms |
  VizCompositorTh:18464 |  40724.452 ms |   246254 | avg:   0.219 ms | max:  11.846 ms | sum:53828.807 ms |
  chrome:(8)            |  32196.003 ms |   213646 | avg:   0.257 ms | max:  16.000 ms | sum:54881.879 ms |
  VideoFrameCompo:18474 |  19577.415 ms |   180778 | avg:   0.195 ms | max:   9.806 ms | sum:35266.517 ms |
  kwin_x11:2580         |  16396.662 ms |   197846 | avg:   0.125 ms | max:   8.634 ms | sum:24647.504 ms |
  kthreadd:(15)         |   6986.487 ms |  1231177 | avg:   0.015 ms | max:   9.100 ms | sum:18079.114 ms |
  Chrome_ChildIOT:(5)   |   6502.116 ms |   190137 | avg:   0.268 ms | max:  10.421 ms | sum:50981.430 ms |
  kworker/7:0-eve:18015 |   6253.830 ms |  1161609 | avg:   0.012 ms | max:  10.946 ms | sum:13745.498 ms |
  cyclictest:(9)        |   5898.072 ms |  1071596 | avg:   0.166 ms | max:  10.758 ms | sum:177833.361 ms |
  kworker/5:2-eve:17027 |   5685.599 ms |  1055878 | avg:   0.012 ms | max:   7.236 ms | sum:12585.682 ms |
  rastertospl:18767     |   5531.070 ms |   157164 | avg:   0.024 ms | max:  11.738 ms | sum: 3703.942 ms |
  kworker/6:1-eve:17794 |   4993.173 ms |   926425 | avg:   0.013 ms | max:   7.288 ms | sum:11719.453 ms |
 ----------------------------------------------------------------------------------------------------------
  TOTAL:                |2329645.888 ms | 23157228 |                 |       16.475 ms |   1340188.243 ms |
 ----------------------------------------------------------------------------------------------------------

perf sched lat -i perf.data.full.6.4.16-eevdf.nms_stock --sort=runtime -S 15 -T

 ----------------------------------------------------------------------------------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Sum delay ms     |
 ----------------------------------------------------------------------------------------------------------
  massive_intr:(9)      |1618277.030 ms |  1762657 | avg:   0.339 ms | max:  15.149 ms | sum:597323.918 ms |
  ThreadPoolForeg:(30)  | 206450.133 ms |  1290121 | avg:   0.189 ms | max:  20.655 ms | sum:243361.803 ms |
  X:2144                | 129827.318 ms |   211518 | avg:   0.271 ms | max:  11.946 ms | sum:57368.468 ms |
  VizCompositorTh:5013  |  60322.953 ms |   125632 | avg:   0.429 ms | max:   8.758 ms | sum:53893.618 ms |
  Compositor:(2)        |  60265.270 ms |   135041 | avg:   0.362 ms | max:   9.609 ms | sum:48833.756 ms |
  chrome:(17)           |  44370.796 ms |   130519 | avg:   0.385 ms | max:  15.948 ms | sum:50216.546 ms |
  VideoFrameCompo:5021  |  24456.245 ms |    83088 | avg:   0.366 ms | max:  10.572 ms | sum:30424.287 ms |
  llvmpipe-6:(3)        |  23094.705 ms |    75617 | avg:   0.504 ms | max:   9.767 ms | sum:38106.696 ms |
  llvmpipe-5:(3)        |  22518.782 ms |    75909 | avg:   0.506 ms | max:  10.071 ms | sum:38447.875 ms |
  llvmpipe-2:(3)        |  22515.065 ms |    77387 | avg:   0.506 ms | max:  10.304 ms | sum:39181.863 ms |
  llvmpipe-4:(3)        |  22348.397 ms |    76206 | avg:   0.512 ms | max:  10.878 ms | sum:38981.961 ms |
  llvmpipe-7:(3)        |  21449.893 ms |    72673 | avg:   0.545 ms | max:  10.080 ms | sum:39585.490 ms |
  llvmpipe-1:(3)        |  21445.333 ms |    77249 | avg:   0.511 ms | max:  10.577 ms | sum:39436.002 ms |
  llvmpipe-3:(3)        |  21385.809 ms |    76409 | avg:   0.514 ms | max:   9.779 ms | sum:39295.360 ms |
  llvmpipe-0:(3)        |  18373.092 ms |    76699 | avg:   0.540 ms | max:  10.070 ms | sum:41411.515 ms |
 ----------------------------------------------------------------------------------------------------------
  TOTAL:                |2366021.752 ms |  6242921 |                 |       20.655 ms |   1633058.780 ms |
 ----------------------------------------------------------------------------------------------------------

perf sched lat -i perf.data.full.6.4.16-eevdf.nms_evdf --sort=runtime -S 15 -T

 ----------------------------------------------------------------------------------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Sum delay ms     |
 ----------------------------------------------------------------------------------------------------------
  massive_intr:(9)      |1794662.731 ms |   533364 | avg:   0.760 ms | max:  32.242 ms | sum:405150.225 ms |
  ThreadPoolForeg:(20)  | 161341.055 ms |   445425 | avg:   0.729 ms | max:  25.981 ms | sum:324736.035 ms |
  X:2144                |  91358.513 ms |    80781 | avg:   0.668 ms | max:  23.512 ms | sum:53947.202 ms |
  VizCompositorTh:5628  |  53228.085 ms |    64676 | avg:   1.041 ms | max:  22.603 ms | sum:67298.785 ms |
  Compositor:5535       |  53070.756 ms |    64927 | avg:   0.978 ms | max:  21.131 ms | sum:63507.765 ms |
  chrome:(16)           |  32630.283 ms |    76394 | avg:   1.276 ms | max:  25.762 ms | sum:97491.996 ms |
  VideoFrameCompo:5636  |  18292.351 ms |    51680 | avg:   0.939 ms | max:  26.293 ms | sum:48545.469 ms |
  llvmpipe-2:(3)        |  12897.634 ms |    36193 | avg:   1.327 ms | max:  19.412 ms | sum:48042.017 ms |
  llvmpipe-5:(3)        |  12275.682 ms |    36512 | avg:   1.329 ms | max:  13.125 ms | sum:48509.590 ms |
  llvmpipe-4:(3)        |  12196.303 ms |    36457 | avg:   1.334 ms | max:  21.460 ms | sum:48620.630 ms |
  llvmpipe-7:(3)        |  12119.861 ms |    36633 | avg:   1.324 ms | max:  17.920 ms | sum:48514.587 ms |
  llvmpipe-0:(3)        |  12106.474 ms |    37216 | avg:   1.256 ms | max:  13.919 ms | sum:46752.353 ms |
  llvmpipe-3:(3)        |  11788.836 ms |    36487 | avg:   1.344 ms | max:  13.044 ms | sum:49047.686 ms |
  llvmpipe-1:(3)        |  11630.206 ms |    36582 | avg:   1.329 ms | max:  14.691 ms | sum:48600.821 ms |
  llvmpipe-6:(3)        |  11523.446 ms |    36457 | avg:   1.353 ms | max:  16.520 ms | sum:49325.031 ms |
 ----------------------------------------------------------------------------------------------------------
  TOTAL:                |2338042.935 ms |  2756565 |                 |       32.242 ms |   3230287.162 ms |
 ----------------------------------------------------------------------------------------------------------

perf sched lat -i perf.data.full.6.4.16-eevdf.nms_evdf_no_run_to_parity --sort=runtime -S 15 -T

 ----------------------------------------------------------------------------------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Sum delay ms     |
 ----------------------------------------------------------------------------------------------------------
  massive_intr:(9)      |1697254.229 ms |  1584416 | avg:   0.321 ms | max:  19.086 ms | sum:508946.014 ms |
  ThreadPoolForeg:(21)  | 185078.035 ms |  1677435 | avg:   0.171 ms | max:  24.005 ms | sum:286473.362 ms |
  X:2144                | 119097.420 ms |   180142 | avg:   0.296 ms | max:  12.004 ms | sum:53361.641 ms |
  Compositor:6108       |  59219.138 ms |   124003 | avg:   0.470 ms | max:  10.081 ms | sum:58341.411 ms |
  VizCompositorTh:6199  |  58309.342 ms |   115937 | avg:   0.561 ms | max:  11.647 ms | sum:64992.383 ms |
  chrome:(16)           |  39621.161 ms |   125058 | avg:   0.500 ms | max:  18.078 ms | sum:62565.629 ms |
  VideoFrameCompo:6208  |  22411.289 ms |    88274 | avg:   0.439 ms | max:  15.439 ms | sum:38730.863 ms |
  llvmpipe-6:(3)        |  20137.882 ms |    70402 | avg:   0.572 ms | max:  10.372 ms | sum:40297.152 ms |
  llvmpipe-7:(3)        |  19835.717 ms |    69843 | avg:   0.575 ms | max:   9.998 ms | sum:40176.008 ms |
  llvmpipe-5:(3)        |  19401.835 ms |    69728 | avg:   0.589 ms | max:   8.997 ms | sum:41069.559 ms |
  llvmpipe-4:(3)        |  18977.364 ms |    69932 | avg:   0.591 ms | max:  13.462 ms | sum:41361.608 ms |
  llvmpipe-3:(3)        |  18459.713 ms |    69809 | avg:   0.599 ms | max:  10.459 ms | sum:41800.434 ms |
  llvmpipe-2:(3)        |  18255.747 ms |    70021 | avg:   0.604 ms | max:  11.308 ms | sum:42259.431 ms |
  llvmpipe-1:(3)        |  17637.013 ms |    69658 | avg:   0.613 ms | max:  10.963 ms | sum:42710.066 ms |
  llvmpipe-0:(3)        |  15466.278 ms |    68809 | avg:   0.648 ms | max:   9.798 ms | sum:44575.145 ms |
 ----------------------------------------------------------------------------------------------------------
  TOTAL:                |2376861.778 ms |  6325320 |                 |       24.005 ms |   1714658.200 ms |
 ----------------------------------------------------------------------------------------------------------



