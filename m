Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8B77B7FF8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242515AbjJDM53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242505AbjJDM51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:57:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D916798;
        Wed,  4 Oct 2023 05:57:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFC4C433C7;
        Wed,  4 Oct 2023 12:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696424243;
        bh=ectF9UM9nsuyhPQEzGjpDSsG7n+9AFSouVvBvBRz4RU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aWYNO4ih2/gLk3G6T2FcpuBf9c0kV2zijLkIMF9GTTQ+nepdEMGBdrvfmFYWFhRUW
         KVRDHP7aFL9dv9Lpxp0FxDQ/2EnVhHsKAAB2VwwjCdgy5wnut2pHjpvxPGTZeAFQDH
         dx3Ofes5pgXTfpQpA+49sMtyVkJ6wUe9nt7h00/0Tpa4gxY+gTTXr1y0nZKaKDh7RT
         qN8W7ur4vnfKDJ4kOnzxobzVRviDf6TDCnfv1GD2dRoq6TeFgSAIHqeXzMQlavsBvb
         lWldeHfhdjuv1mXF9zoGO2eE5MpCaETqwWDx9UwtRdisxi7UpFY614fbhZ52U42njQ
         DHldIsd1FJBWA==
From:   Kalle Valo <kvalo@kernel.org>
To:     =?utf-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felix Fietkau <nbd@nbd.name>,
        Felipe Negrelli Wolter <felipe.negrelliwolter@silabs.com>,
        Olivier Souloumiac <olivier.souloumiac@silabs.com>,
        Alexandr Suslenko <suslenko.o@ajax.systems>
Subject: Re: [PATCH v2] wifi: wfx: fix case where rates are out of order
References: <20231004123039.157112-1-jerome.pouiller@silabs.com>
Date:   Wed, 04 Oct 2023 15:57:19 +0300
In-Reply-To: <20231004123039.157112-1-jerome.pouiller@silabs.com>
 (=?utf-8?B?IkrDqXLDtG1l?=
        Pouiller"'s message of "Wed, 4 Oct 2023 14:30:39 +0200")
Message-ID: <8734yq7dg0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
> Since the device always applies rates in descending order, the
> workaround is to drop the rate when it higher than its predecessor in
> the rate list. Thus [ 4, 5, 3 ] becomes [ 4, 3 ].
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
> Fixes: 9bca45f3d692 ("staging: wfx: allow to send 802.11 frames")
> Tested-by: Olivier Souloumiac <olivier.souloumiac@silabs.com>
> Tested-by: Alexandr Suslenko <suslenko.o@ajax.systems>
> Reported-by: Alexandr Suslenko <suslenko.o@ajax.systems>
> Co-developed-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
> Signed-off-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
> Signed-off-by: Felipe Negrelli Wolter <felipe.negrelliwolter@silabs.com>
> ---
> v2:
>   - Fix malformed tags in commit body. (checkpatch still complains about
>     missing Close tag, but the bug tracker is not public and I don't have
>     the exact URL)

Just out of curiosity why does the checkpatch complain about a missing
Close tag? I don't get it why there should be one.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
