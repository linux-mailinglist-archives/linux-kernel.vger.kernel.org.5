Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84ED47B7D19
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242165AbjJDK1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjJDK1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:27:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6496B0;
        Wed,  4 Oct 2023 03:27:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0909AC433C8;
        Wed,  4 Oct 2023 10:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696415235;
        bh=dcG5RxBw9qfIoGIbgz+2DfwsMimy/DM3rdmUIsB1jlw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=t1o8wIO6aKpD6cJLia0CqU/VtxlL33sKt//IyXqLu8yL02esJcZsn/usry4kTLqgp
         YtemuI5R6Qit5ljP2mRBA4vTWPBYJ/HLMJTG+xbMD/lRu6H4WfgUsTQ2G5MSQEJgTS
         xhUyynABWd3oJc38DpaX5+epQoylVEsSY3N4VW3bMOKuEJkf7rqPOc1w8Aa1119BQw
         ghsR6AQbHvO99X+6vQisZv0wBDw+V9IopwTWhBae8gS1wlS/M/2vvRcyKWAjtDyPf1
         9e12yosnxJ76CEFLv6uLT6gLtxUYtvgdmqJ2kBddVQTwYoxfxMXhQmaboYdLBSw8UH
         og6jDyYnmY+hQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     =?utf-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felix Fietkau <nbd@nbd.name>,
        Felipe Negrelli Wolter <felipe.negrelliwolter@silabs.com>,
        Olivier Souloumiac <olivier.souloumiac@silabs.com>,
        Alexandr Suslenko <suslenko.o@ajax.systems>
Subject: Re: [PATCH] wifi: wfx: fix case where rates are out of order
References: <20230928101048.5543-1-jerome.pouiller@silabs.com>
Date:   Wed, 04 Oct 2023 13:29:31 +0300
In-Reply-To: <20230928101048.5543-1-jerome.pouiller@silabs.com>
 (=?utf-8?B?IkrDqXLDtG1l?=
        Pouiller"'s message of "Thu, 28 Sep 2023 12:10:48 +0200")
Message-ID: <87lecihe9g.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com> writes:

> From: Felipe Negrelli Wolter <felipe.negrelliwolter@silabs.com>
>
> When frames are sent over the air, the device always applies the data
> rates in descending order. The driver assumed Minstrel also provided
> rate in descending order.
>
> However, in some cases, Minstrel can a choose a fallback rate greater
> than the primary rate. In this case, the two rates was inverted, the
> device try highest rate first and we get many retries.
>
> Since the device always apply rates in descending order. The workaround
> is to drop rate when it higher than its predecessor in the rate list.
> Thus [ 4, 5, 3 ] become [ 4, 3 ].
>
> This patch has been tested in isolated room with a series of
> attenuators. Here are the Minstrel statistics with 80dBm of attenuation:
>
>   Without the fix:
>
>                   best    ____________rate__________    ____statistics___=
    _____last____    ______sum-of________
>     mode guard #  rate   [name   idx airtime  max_tp]  [avg(tp) avg(prob)=
]  [retry|suc|att]  [#success | #attempts]
>     HT20  LGI  1       S  MCS0     0    1477     5.6       5.2      82.7 =
      3     0 0             3   4
>     HT20  LGI  1          MCS1     1     738    10.6       0.0       0.0 =
      0     0 0             0   1
>     HT20  LGI  1     D    MCS2     2     492    14.9      13.5      81.5 =
      5     0 0             5   9
>     HT20  LGI  1    C     MCS3     3     369    18.8      17.6      84.3 =
      5     0 0            76   96
>     HT20  LGI  1  A   P   MCS4     4     246    25.4      22.4      79.5 =
      5     0 0         11268   14026
>     HT20  LGI  1   B   S  MCS5     5     185    30.7      19.7      57.7 =
      5     8 9          3918   9793
>     HT20  LGI  1          MCS6     6     164    33.0       0.0       0.0 =
      5     0 0             6   102
>     HT20  LGI  1          MCS7     7     148    35.1       0.0       0.0 =
      0     0 0             0   44
>
>   With the fix:
>
>                   best    ____________rate__________    ____statistics___=
    _____last____    ______sum-of________
>     mode guard #  rate   [name   idx airtime  max_tp]  [avg(tp) avg(prob)=
]  [retry|suc|att]  [#success | #attempts]
>     HT20  LGI  1       S  MCS0     0    1477     5.6       1.8      28.6 =
      1     0 0             1   5
>     HT20  LGI  1     DP   MCS1     1     738    10.6       9.7      82.6 =
      4     0 0            14   34
>     HT20  LGI  1          MCS2     2     492    14.9       9.2      55.4 =
      5     0 0            52   77
>     HT20  LGI  1   B   S  MCS3     3     369    18.8      15.6      74.9 =
      5     1 1           417   554
>     HT20  LGI  1  A       MCS4     4     246    25.4      16.7      59.2 =
      5     1 1         13812   17951
>     HT20  LGI  1    C  S  MCS5     5     185    30.7      14.0      41.0 =
      5     1 5            57   640
>     HT20  LGI  1          MCS6     6     164    33.0       0.0       0.0 =
      0     0 1             0   48
>     HT20  LGI  1       S  MCS7     7     148    35.1       0.0       0.0 =
      0     0 0             0   36
>
> We can notice the device try now to send with lower rates (and high
> success rates). At the end, we measured 20-25% better throughput with
> this patch.
>
> Fixes: 9bca45f3d6924 "staging: wfx: allow to send 802.11 frames"
> Tested-by: Olivier Souloumiac <olivier.souloumiac@silabs.com>
> Tested-by: Alexandr Suslenko <suslenko.o@ajax.systems>
> Reported-by: Alexandr Suslenko <suslenko.o@ajax.systems>
> Co-developed-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
> Signed-off-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>

ERROR: Invalid format: Fixes: 9bca45f3d6924 "staging: wfx: allow to send 80=
2.11 frames"
ERROR: Missing Signed-off-by: felipe.negrelliwolter@silabs.com

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
