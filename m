Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865187BD3D5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345319AbjJIGyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345305AbjJIGyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:54:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EFBA4;
        Sun,  8 Oct 2023 23:54:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE01C433C8;
        Mon,  9 Oct 2023 06:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696834474;
        bh=rZrIcDQhefr0DHgoymWmiWlPeKqu+JDo4LZvNnP0GxI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=SWGMwF5l5eeF+ti9rjZXEHhfcSF0LGQYWh8xIPYIGoj8pM/LqfHI5Cf56YARyJXiz
         qqFHxhaWOMPc2Ip/YEUPbdK6p4HpVLderIYYmvqlGDn2fxj6jnAUhDIulH/Q5dXXTw
         +d7ODVAAmKNZWBG3NbTAg0m2LCVgMxWxWP64OXhyn+D58IMKnGqXWtM0KoeXfpT/Y8
         JuutbfY3TxgbVMHwyFlGOh7c2YlCrGJOqCg31PPTxnw+GqNWful9vnrHT9gVwKT6ND
         9+Lqp/0vlZtdkQIvlkJo/0MKzv2ubXVSE2zhEWCTF5G4zWGqT/cBghNkYIJQtppym2
         Y3JAUPFb4CvHQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] wifi: wfx: fix case where rates are out of order
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231004123039.157112-1-jerome.pouiller@silabs.com>
References: <20231004123039.157112-1-jerome.pouiller@silabs.com>
To:     =?utf-8?b?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felix Fietkau <nbd@nbd.name>,
        Felipe Negrelli Wolter <felipe.negrelliwolter@silabs.com>,
        Olivier Souloumiac <olivier.souloumiac@silabs.com>,
        Alexandr Suslenko <suslenko.o@ajax.systems>,
        =?utf-8?b?SsOpcsO0bWUgUG91aWxs?= =?utf-8?b?ZXI=?= 
        <jerome.pouiller@silabs.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169683447045.2071896.3998375753268021178.kvalo@kernel.org>
Date:   Mon,  9 Oct 2023 06:54:32 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jérôme Pouiller  <jerome.pouiller@silabs.com> wrote:

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
>                   best    ____________rate__________    ____statistics___    _____last____    ______sum-of________
>     mode guard #  rate   [name   idx airtime  max_tp]  [avg(tp) avg(prob)]  [retry|suc|att]  [#success | #attempts]
>     HT20  LGI  1       S  MCS0     0    1477     5.6       5.2      82.7       3     0 0             3   4
>     HT20  LGI  1          MCS1     1     738    10.6       0.0       0.0       0     0 0             0   1
>     HT20  LGI  1     D    MCS2     2     492    14.9      13.5      81.5       5     0 0             5   9
>     HT20  LGI  1    C     MCS3     3     369    18.8      17.6      84.3       5     0 0            76   96
>     HT20  LGI  1  A   P   MCS4     4     246    25.4      22.4      79.5       5     0 0         11268   14026
>     HT20  LGI  1   B   S  MCS5     5     185    30.7      19.7      57.7       5     8 9          3918   9793
>     HT20  LGI  1          MCS6     6     164    33.0       0.0       0.0       5     0 0             6   102
>     HT20  LGI  1          MCS7     7     148    35.1       0.0       0.0       0     0 0             0   44
> 
>   With the fix:
> 
>                   best    ____________rate__________    ____statistics___    _____last____    ______sum-of________
>     mode guard #  rate   [name   idx airtime  max_tp]  [avg(tp) avg(prob)]  [retry|suc|att]  [#success | #attempts]
>     HT20  LGI  1       S  MCS0     0    1477     5.6       1.8      28.6       1     0 0             1   5
>     HT20  LGI  1     DP   MCS1     1     738    10.6       9.7      82.6       4     0 0            14   34
>     HT20  LGI  1          MCS2     2     492    14.9       9.2      55.4       5     0 0            52   77
>     HT20  LGI  1   B   S  MCS3     3     369    18.8      15.6      74.9       5     1 1           417   554
>     HT20  LGI  1  A       MCS4     4     246    25.4      16.7      59.2       5     1 1         13812   17951
>     HT20  LGI  1    C  S  MCS5     5     185    30.7      14.0      41.0       5     1 5            57   640
>     HT20  LGI  1          MCS6     6     164    33.0       0.0       0.0       0     0 1             0   48
>     HT20  LGI  1       S  MCS7     7     148    35.1       0.0       0.0       0     0 0             0   36
> 
> We can notice the device try now to send with lower rates (and high
> success rates). At the end, we measured 20-25% better throughput with
> this patch.
> 
> Fixes: 9bca45f3d692 ("staging: wfx: allow to send 802.11 frames")
> Tested-by: Olivier Souloumiac <olivier.souloumiac@silabs.com>
> Tested-by: Alexandr Suslenko <suslenko.o@ajax.systems>
> Reported-by: Alexandr Suslenko <suslenko.o@ajax.systems>
> Co-developed-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
> Signed-off-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
> Signed-off-by: Felipe Negrelli Wolter <felipe.negrelliwolter@silabs.com>

Patch applied to wireless-next.git, thanks.

ea2274ab0b18 wifi: wfx: fix case where rates are out of order

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231004123039.157112-1-jerome.pouiller@silabs.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

