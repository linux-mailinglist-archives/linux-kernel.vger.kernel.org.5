Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD407AC74B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 11:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjIXJXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 05:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjIXJXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 05:23:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31979E8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 02:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695547279; x=1696152079; i=efault@gmx.de;
 bh=fCav+hXXYnwjsiNIU9RojW168WrUMdyKljggKJsLRtg=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=ULDF5IX0qJjOAFDZjLGBsBN1Fq6yh+YnvTJNVQ/V81alNpt8kFWUdbo3w+5sKV4L9q/vbjrbrqu
 EiXH9TLFt2KT5Sd6+KyeKMPm2dccgJqloJE/HWFSX1ltFwN16EgKKdOd/GGWkf5buaThzR2d5sihM
 RzeoZhcoRfsglsb/ynkCOorUlHELlu0vPG3mnLlDx1P1mYmCSwwdfwphnFY400i23ztvYpPWxTiY4
 cX288qb/Z+A5G+KCa6g3FPZEia67L36TC+ZmVCgmlEPilybbzxcyWdCIP+xqXeBczQdsIKRRwldIX
 90n5OoV8BnJ5sFuW/Oh1hSopBKP9TfEb1zgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.218.12]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzyP-1rFGGe1wi7-00dYg8; Sun, 24
 Sep 2023 11:21:19 +0200
Message-ID: <f50dc661b53c93bd161b0f60fc4685c4d9f7cdbb.camel@gmx.de>
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
Date:   Sun, 24 Sep 2023 11:21:15 +0200
In-Reply-To: <10cd16558e47ccb43e00261b18e38f4ec2f61690.camel@gmx.de>
References: <20230915124354.416936110@noisy.programming.kicks-ass.net>
         <20230915124822.956946622@noisy.programming.kicks-ass.net>
         <10cd16558e47ccb43e00261b18e38f4ec2f61690.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V5xSePKkboNXV0z01vzFU/djfRpNjqaPQIityqas9xPMukH5mBU
 f8REwSSxhaUnpgChFAoeQMHh2QMTKCkK5oJOytg1X5T5SlDBBMzxGA/GyWHBsBhqn7+E55r
 ZbHyq22yJ+e7rs70md/7Iun1Xx9wOrprJAvdx2RhnKtkUy20/cnp5yHCAOtRpYHAg2BKW7f
 99MMC6OsmO6SWF0QWfBjw==
UI-OutboundReport: notjunk:1;M01:P0:V21mRqY7CiQ=;jzjqIthrqLL5hw4BsAkZEm7Py5k
 949Mlhc+fkw/6xRLVcD8A/zJPeWsNPvq5WCqkFSYwFQWme8YWwVBwsQTVERg+hHoXOaK9AXQF
 3ZvMgh7cSMMY0IL8GWVZ9sSFeYjlZUCObMvhR+JTc/FTV2ugJuyDrDkEc/uydj3O7FGwkJjsK
 9ZRe/bGlGx0EFDoV6NA0QXkouHtuilvNfpqVMCgI7LfjpNn87Jp85kmKhpdPBmmkOiMa6aqIY
 CkhGpJ+hDK+wL+bAQbA1RLxxvb7nsUo8OwZFTtO4jGkIwbQlpVDRIH2cQYaTc4W4sR/i5WDTO
 lhwVXUXkjy0/RPQmbEzjrsU1mc4vBDlymISByue57VszoGICH5+H/LVh4dizZE0EXw0puNgid
 ZS2FA+MfmrgFmbIiHXHA610QLuXW4UtEQ35uUCwDkuXFixDBNYmzL4XFJYlMYbzY8/fKiFm1r
 sMGxZ8gg5+rluddLvtmF3NTTkWG1v5XFj2P0AiP//TvUb8cUo4d4dEBoaFc5VAUSq93FvR1BK
 jbUX3fxtALF2fOGbvWFdovgF71mWDJNephK5Tt1VfrRbkuO4NagKYsCwlCtmZFpxutjTmcok9
 l2BHxAzPmyRo8F4My0qK1+SX7otN3378Gx0uvTOnCQydStu3+HIuUDkzG1GkqreuNV4C+hEKp
 0otjJXUl3e2c7oBfLstgGyncvEnrOwQbvSRQiyoi4GdcmT2Dmd1MkxlJgdRkWAkOELmWAp81a
 /Yra5umjYhuJ6Q8jAslXtzZIey0ym3xTPi89NR+LU0wxDtuhIEHkL7tzTJPaXc2Hwnrup8o7V
 2ZNPVfXXB6lkG+SSBqq9i1dwBAEs0pCwHQ6+vzaBEFzS6mPPah6gd2MwCLCIqCfU2ah65rnEq
 ZcervpBvcS7r390x/zTEcGZsPS787aYR7dmsdPMnSlrQYll9ICjGAhAOmVa2Z7qz8mKbXKfQz
 58BaV9NXK6eaMjgCmun2SrHgbQ8=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-19 at 09:53 +0200, Mike Galbraith wrote:
> On Fri, 2023-09-15 at 14:43 +0200, peterz@infradead.org=C2=A0wrote:
> > Allow applications to directly set a suggested request/slice length us=
ing
> > sched_attr::sched_runtime.
>
> I met an oddity while fiddling to see what a custom slice would do for
> cyclictest, it seeming to be reasonable target...

For the record, that cyclictest oddity was the mixed slice handling
improvement patch from the latency-nice branch not doing so well at the
ultralight end of the spectrum.  Turning the feature off eliminated it.

Some numbers for the terminally bored below.

	-Mike

5 minutes of repeatable mixed load, Blender 1920x1080@24 YouTube clip
(no annoying ads) vs massive_intr (4x88% hogs) with cyclictest -D 300
doing the profile duration timing in dinky/cute rpi4.  Filenames
describe slice and feature settings, fudge in filename means feature
was turned on.

perf sched lat -i perf.data.full.6.6.0-rc2-v8.stock --sort=3Druntime -S 15=
 -T

 -------------------------------------------------------------------------=
---------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     |
 -------------------------------------------------------------------------=
---------------------------------
  massive_intr:(5)      | 816065.611 ms |   917839 | avg:   0.255 ms | max=
:  42.579 ms | sum:234075.309 ms |
  chromium-browse:(16)  |  59428.589 ms |   138489 | avg:   0.507 ms | max=
:  28.546 ms | sum:70262.946 ms |
  ThreadPoolForeg:(49)  |  32962.888 ms |    57147 | avg:   0.916 ms | max=
:  35.043 ms | sum:52354.576 ms |
  mutter:1352           |  24910.265 ms |    52058 | avg:   0.556 ms | max=
:  21.166 ms | sum:28945.039 ms |
  Chrome_ChildIOT:(14)  |  23785.517 ms |   132307 | avg:   0.345 ms | max=
:  30.987 ms | sum:45657.621 ms |
  VizCompositorTh:30768 |  14985.421 ms |    64769 | avg:   0.432 ms | max=
:  24.620 ms | sum:27981.948 ms |
  Xorg:925              |  14802.426 ms |    67407 | avg:   0.339 ms | max=
:  23.912 ms | sum:22844.860 ms |
  alsa-sink-MAI P:1260  |  13958.874 ms |    33127 | avg:   0.023 ms | max=
:  15.023 ms | sum:  756.454 ms |
  cyclictest:(5)        |  13345.073 ms |   715171 | avg:   0.271 ms | max=
:  19.277 ms | sum:193861.885 ms |
  Media:30834           |  12627.366 ms |    64061 | avg:   0.339 ms | max=
:  29.811 ms | sum:21687.561 ms |
  ThreadPoolSingl:(6)   |   9254.163 ms |    43524 | avg:   0.405 ms | max=
:  21.251 ms | sum:17617.750 ms |
  V4L2DecoderThre:30887 |   9251.235 ms |    63002 | avg:   0.302 ms | max=
:  16.819 ms | sum:19000.280 ms |
  VideoFrameCompo:30836 |   7947.943 ms |    47459 | avg:   0.300 ms | max=
:  19.666 ms | sum:14254.378 ms |
  pulseaudio:1172       |   6638.018 ms |    43467 | avg:   0.219 ms | max=
:  14.621 ms | sum: 9535.951 ms |
  threaded-ml:30883     |   5358.744 ms |    29193 | avg:   0.349 ms | max=
:  12.893 ms | sum:10175.289 ms |
 -------------------------------------------------------------------------=
---------------------------------
  TOTAL:                |1109784.680 ms |  3029507 |                 |    =
   42.579 ms |    845307.017 ms |
 -------------------------------------------------------------------------=
---------------------------------
  INFO: 0.001% context switch bugs (13 out of 1909170)

perf sched lat -i perf.data.full.6.6.0-rc2-v8.massive_intr-100ms-slice --s=
ort=3Druntime -S 15 -T

 -------------------------------------------------------------------------=
---------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     |
 -------------------------------------------------------------------------=
---------------------------------
  massive_intr:(5)      | 861639.948 ms |   812113 | avg:   0.277 ms | max=
: 138.492 ms | sum:224707.956 ms |
  chromium-browse:(8)   |  51307.141 ms |   125222 | avg:   0.530 ms | max=
:  42.935 ms | sum:66314.290 ms |
  ThreadPoolForeg:(16)  |  26421.979 ms |    45000 | avg:   0.873 ms | max=
:  35.752 ms | sum:39306.544 ms |
  Chrome_ChildIOT:(5)   |  22542.183 ms |   131172 | avg:   0.336 ms | max=
:  51.751 ms | sum:44091.954 ms |
  mutter:1352           |  21835.334 ms |    48508 | avg:   0.566 ms | max=
:  37.495 ms | sum:27446.519 ms |
  VizCompositorTh:39048 |  14531.018 ms |    63787 | avg:   0.463 ms | max=
:  56.326 ms | sum:29522.218 ms |
  Xorg:925              |  14497.447 ms |    67315 | avg:   0.397 ms | max=
:  36.714 ms | sum:26735.175 ms |
  alsa-sink-MAI P:1260  |  13935.472 ms |    33111 | avg:   0.020 ms | max=
:   6.753 ms | sum:  677.888 ms |
  cyclictest:(5)        |  12696.835 ms |   653111 | avg:   0.425 ms | max=
:  38.092 ms | sum:277440.622 ms |
  Media:39089           |  12571.118 ms |    67187 | avg:   0.335 ms | max=
:  26.660 ms | sum:22498.438 ms |
  V4L2DecoderThre:39125 |   9156.299 ms |    66378 | avg:   0.301 ms | max=
:  23.828 ms | sum:19991.504 ms |
  ThreadPoolSingl:(4)   |   9079.291 ms |    46187 | avg:   0.377 ms | max=
:  28.850 ms | sum:17422.535 ms |
  VideoFrameCompo:39091 |   8103.756 ms |    50025 | avg:   0.290 ms | max=
:  33.230 ms | sum:14518.688 ms |
  pulseaudio:1172       |   6575.897 ms |    44952 | avg:   0.259 ms | max=
:  19.937 ms | sum:11630.128 ms |
  threaded-ml:39123     |   5367.921 ms |    29503 | avg:   0.339 ms | max=
:  24.648 ms | sum: 9993.313 ms |
 -------------------------------------------------------------------------=
---------------------------------
  TOTAL:                |1127978.646 ms |  2802143 |                 |    =
  138.492 ms |    920177.765 ms |
 -------------------------------------------------------------------------=
---------------------------------
  INFO: 0.000% context switch bugs (8 out of 1773282)

perf sched lat -i perf.data.full.6.6.0-rc2-v8.massive_intr-100ms-slice-fud=
ge --sort=3Druntime -S 15 -T

 -------------------------------------------------------------------------=
---------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     |
 -------------------------------------------------------------------------=
---------------------------------
  massive_intr:(5)      | 855426.748 ms |   777984 | avg:   0.266 ms | max=
: 111.756 ms | sum:206723.857 ms |
  chromium-browse:(8)   |  51656.331 ms |   122631 | avg:   0.531 ms | max=
:  36.305 ms | sum:65094.280 ms |
  ThreadPoolForeg:(16)  |  27473.845 ms |    43053 | avg:   0.972 ms | max=
:  34.973 ms | sum:41833.237 ms |
  mutter:1352           |  21412.313 ms |    47476 | avg:   0.541 ms | max=
:  33.553 ms | sum:25685.892 ms |
  Chrome_ChildIOT:(5)   |  20283.623 ms |   119424 | avg:   0.395 ms | max=
:  31.266 ms | sum:47164.449 ms |
  VizCompositorTh:36026 |  14643.428 ms |    63979 | avg:   0.464 ms | max=
:  34.832 ms | sum:29708.794 ms |
  Xorg:925              |  14296.586 ms |    67756 | avg:   0.410 ms | max=
:  23.774 ms | sum:27811.107 ms |
  alsa-sink-MAI P:1260  |  13977.823 ms |    33116 | avg:   0.023 ms | max=
:   5.513 ms | sum:  750.004 ms |
  cyclictest:(5)        |  12365.030 ms |   645151 | avg:   0.475 ms | max=
:  35.084 ms | sum:306236.764 ms |
  Media:36076           |  12256.872 ms |    60848 | avg:   0.378 ms | max=
:  26.714 ms | sum:22978.110 ms |
  ThreadPoolSingl:(4)   |   8983.939 ms |    43538 | avg:   0.401 ms | max=
:  21.137 ms | sum:17468.417 ms |
  V4L2DecoderThre:36101 |   8910.124 ms |    58505 | avg:   0.316 ms | max=
:  22.654 ms | sum:18503.766 ms |
  VideoFrameCompo:36081 |   7851.251 ms |    44655 | avg:   0.325 ms | max=
:  24.662 ms | sum:14532.619 ms |
  pulseaudio:1172       |   6671.226 ms |    44172 | avg:   0.332 ms | max=
:  19.466 ms | sum:14673.304 ms |
  threaded-ml:36099     |   5338.302 ms |    28879 | avg:   0.379 ms | max=
:  20.754 ms | sum:10944.051 ms |
 -------------------------------------------------------------------------=
---------------------------------
  TOTAL:                |1115349.047 ms |  2703902 |                 |    =
  111.756 ms |    959507.323 ms |
 -------------------------------------------------------------------------=
---------------------------------
  INFO: 0.000% context switch bugs (4 out of 1763882)

perf sched lat -i perf.data.full.6.6.0-rc2-v8.cyclictest-500us-slice --sor=
t=3Druntime -S 15 -T

 -------------------------------------------------------------------------=
---------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     |
 -------------------------------------------------------------------------=
---------------------------------
  massive_intr:(5)      | 847672.515 ms |   951686 | avg:   0.233 ms | max=
:  30.660 ms | sum:222000.736 ms |
  chromium-browse:(8)   |  53628.292 ms |   133414 | avg:   0.456 ms | max=
:  30.414 ms | sum:60792.606 ms |
  ThreadPoolForeg:(17)  |  26765.405 ms |    43894 | avg:   0.869 ms | max=
:  43.268 ms | sum:38131.378 ms |
  mutter:1352           |  22161.746 ms |    49865 | avg:   0.514 ms | max=
:  24.773 ms | sum:25639.654 ms |
  Chrome_ChildIOT:(7)   |  20878.044 ms |   122989 | avg:   0.315 ms | max=
:  44.034 ms | sum:38735.550 ms |
  Xorg:925              |  14647.685 ms |    66766 | avg:   0.326 ms | max=
:  16.256 ms | sum:21785.616 ms |
  VizCompositorTh:34571 |  14304.582 ms |    64222 | avg:   0.401 ms | max=
:  23.334 ms | sum:25767.033 ms |
  alsa-sink-MAI P:1260  |  14006.042 ms |    33136 | avg:   0.022 ms | max=
:   4.851 ms | sum:  724.564 ms |
  cyclictest:(5)        |  13404.228 ms |   731243 | avg:   0.217 ms | max=
:  28.997 ms | sum:158740.145 ms |
  Media:34626           |  12790.442 ms |    63825 | avg:   0.327 ms | max=
:  30.721 ms | sum:20853.022 ms |
  V4L2DecoderThre:34651 |   9278.538 ms |    62619 | avg:   0.284 ms | max=
:  18.678 ms | sum:17761.070 ms |
  ThreadPoolSingl:(4)   |   9226.802 ms |    42846 | avg:   0.389 ms | max=
:  18.563 ms | sum:16684.938 ms |
  VideoFrameCompo:34627 |   7788.047 ms |    46681 | avg:   0.285 ms | max=
:  14.102 ms | sum:13327.258 ms |
  pulseaudio:1172       |   6643.612 ms |    42393 | avg:   0.186 ms | max=
:   7.567 ms | sum: 7873.616 ms |
  threaded-ml:34649     |   5402.911 ms |    28737 | avg:   0.313 ms | max=
:  13.276 ms | sum: 9007.151 ms |
 -------------------------------------------------------------------------=
---------------------------------
  TOTAL:                |1114449.900 ms |  3009626 |                 |    =
   44.034 ms |    740410.836 ms |
 -------------------------------------------------------------------------=
---------------------------------
  INFO: 0.000% context switch bugs (8 out of 1873597)

perf sched lat -i perf.data.full.6.6.0-rc2-v8.cyclictest-500us-slice-fudge=
 --sort=3Druntime -S 15 -T

 -------------------------------------------------------------------------=
---------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     |
 -------------------------------------------------------------------------=
---------------------------------
  massive_intr:(5)      | 838981.090 ms |   880877 | avg:   0.262 ms | max=
:  28.559 ms | sum:230982.334 ms |
  chromium-browse:(9)   |  55497.942 ms |   128916 | avg:   0.520 ms | max=
:  39.331 ms | sum:67042.536 ms |
  ThreadPoolForeg:(20)  |  27669.981 ms |    41272 | avg:   0.990 ms | max=
:  29.775 ms | sum:40857.370 ms |
  mutter:1352           |  22455.332 ms |    47362 | avg:   0.562 ms | max=
:  19.838 ms | sum:26611.559 ms |
  Chrome_ChildIOT:(7)   |  22295.707 ms |   123559 | avg:   0.344 ms | max=
:  29.449 ms | sum:42479.505 ms |
  Xorg:925              |  14894.399 ms |    65930 | avg:   0.353 ms | max=
:  17.650 ms | sum:23303.557 ms |
  VizCompositorTh:37170 |  14567.478 ms |    62477 | avg:   0.438 ms | max=
:  25.008 ms | sum:27366.073 ms |
  alsa-sink-MAI P:1260  |  14207.866 ms |    33134 | avg:   0.022 ms | max=
:   4.092 ms | sum:  744.586 ms |
  cyclictest:(5)        |  13483.280 ms |   697504 | avg:   0.375 ms | max=
:  20.859 ms | sum:261834.795 ms |
  Media:37224           |  12890.016 ms |    62641 | avg:   0.343 ms | max=
:  14.333 ms | sum:21510.222 ms |
  ThreadPoolSingl:(4)   |   9095.635 ms |    42121 | avg:   0.383 ms | max=
:  17.168 ms | sum:16116.408 ms |
  V4L2DecoderThre:37261 |   9079.051 ms |    63220 | avg:   0.291 ms | max=
:  18.144 ms | sum:18421.175 ms |
  VideoFrameCompo:37226 |   8049.344 ms |    46145 | avg:   0.309 ms | max=
:  18.575 ms | sum:14252.577 ms |
  pulseaudio:1172       |   6767.263 ms |    42736 | avg:   0.205 ms | max=
:   8.202 ms | sum: 8781.668 ms |
  threaded-ml:37262     |   5404.490 ms |    28428 | avg:   0.332 ms | max=
:  17.758 ms | sum: 9424.566 ms |
 -------------------------------------------------------------------------=
---------------------------------
  TOTAL:                |1115092.327 ms |  2896377 |                 |    =
   39.331 ms |    881443.337 ms |
 -------------------------------------------------------------------------=
---------------------------------
  INFO: 0.001% context switch bugs (12 out of 1845612)


Peeks out window at lovely sunny Sunday, and <poof>
