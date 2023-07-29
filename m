Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1A1767E62
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 13:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjG2LAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 07:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjG2LAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 07:00:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F86E2727;
        Sat, 29 Jul 2023 04:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1690628392; x=1691233192; i=georgmueller@gmx.net;
 bh=twRf4TMZi9E5NNBIM2ex+mG1+qx5hpiMfP5wNhXXNVs=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=V44Ip/hewjtHV58EtLzKVVP2vt99FjogX51rcQIMGR8pV1tI69pWt5FoYJyiYCjkzQpKCu+
 KoaQ6Hk5j+Nb6vixMPCLmwKIEzygOn9eKiEtPhHZfqxJXARplkNz1YzSTZ9roI7GX3EI1hE7b
 Q02ywFcmEuKUjRffnVIEH2NELCCMQEwCUVwEIrS7t/aOzHbb7nZFSTfV3XXUQ9q0djbQ1tuHM
 SLEAi7H+vMaHB3Rkt67xTdbRYV8lqbdy9ipNWZm62+J1ba8jDye9uSW5f0McAv4P9oKLkjcMQ
 sL4oBCUHB1SPjPGP4ikc/mTIDNMkad1X534sQNwW1opEv7KgsQdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.15.55] ([109.104.34.147]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXGrE-1qMqfe1YCM-00YiCc; Sat, 29
 Jul 2023 12:59:52 +0200
Message-ID: <4085b352-f5e8-c0e8-42cf-7a6ecf23282f@gmx.net>
Date:   Sat, 29 Jul 2023 12:59:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] perf probe: skip test_uprobe_from_different_cu if there
 is no gcc
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230728151812.454806-2-georgmueller@gmx.net>
 <20230729093814.d48a7b4fb51fdd74ad50ba42@kernel.org>
From:   =?UTF-8?Q?Georg_M=c3=bcller?= <georgmueller@gmx.net>
In-Reply-To: <20230729093814.d48a7b4fb51fdd74ad50ba42@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7zgsdN/9IIYrwP1nrwUUW6u1/E/vOCO59+XBSn1MMZYpLYl+g3S
 4ucIPIrcA5FgvAj3TRFyPzjlALyBL+ZZYpoDzcrg/qi9T2+hIudkVf19NfRkPKwlwI+Qsab
 Nd8htf00gOqj6fmtkqyxRKYh/UBloeyrBYitU+zWFsz+BjUCbYmi9ZpPa9UcAlLB/Kme6QV
 /eeC4uoK8pWmZRqSK7oLg==
UI-OutboundReport: notjunk:1;M01:P0:S4Ja4+tS/ME=;UBlXlKdJxaVVRwJZJZlTpljPLLc
 xpA+aZqqRNlsKYhasqW8kSr7jpsdKkcDgYScCUXM7glStjF1N/BZnTPIXuSFd8fW3DBOinQT9
 cN64koOe5mavIckKYErNBm3SkGZ8vx1D4NOUpKGRbIg3Bpy7GGnCthNDywgOTaMBkkurW4Csa
 MtXBqoYbI5VAyDuc3m1xI47QPreTWcQiSJggGoJIcUkJ3x/ZhWcYI/TkLRrG6qOJYy5NQ1GE4
 lzKIMy711FKdarlQMS0Ehr+3QubR50/7gTmHxyx06NGo5JlLCmBmnFO1KkAXWKFKVB3d8kuJi
 e3jmTyfHEUJ8lWExmSabduAxGpUSqu/2Sdt/+xUmHhnz4Lr613iuq3wwp9BwsvdKAPYt8FAnF
 e5TuMSy+VBZ5smir8nJSwWgEXv4j6ahsziummmTiRgv7r8lNT1RNhh0tj8FKWHYpR25f1J0Hh
 rp1Tp26msSPfDsnZFDurO9p0z/nQcfuaKbKnINjtNsvQ3PKGioUYe0wgwtqq4ENYnps+/e6mC
 D5ep8p0bwiXXx2kuHUTS/2HUjn7YDj4RC0eurFld046kEdQaIjFH0avZ/X4svRdb15d0+VSLW
 AVr39WX5ITiuFTLMBgN2M5c8Dz7+aIY8wT5M8zVbyf4nuJDVLRCPLhRzio3MD2rvf8mbPXk6s
 uW9+SG7qPcqgZHAx23AJ1YSMVWIi4qmBeLCTd4+2+mfC7JN1J58LftVrWmB7TF77l+WmWBl7O
 IgER3T/tCHg6KDnzIL7kzTD4+uvfG3/3+Nb0+BxLZU7MMh0NS5NDDTUnTr1LlZXQU70wL1gEY
 2NxfTwVJBSpUHvMHXVD0v59tr843+VAPYOcPfiayzqX2LTvwVFtCf+OBkaFkP6uCpSC9ktxgE
 3Zv4H0iZdarUQDBUrpnOofT0bj9GKG8VHvU85YxfcSELfPhDGEqywMMWGApg74hzMnpWePCzE
 7932nFElZ5vpl6aKmd8pM4uaNHE=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 29.07.23 um 02:38 schrieb Masami Hiramatsu (Google):
>
> Interesting, so clang will not generate DWARF or perf probe is not able =
to
> handle clang generated DWARF?
>

clang does not accept mixed -flto and non-lto CUs and the problem is not
reproducible by this sample code using clang if using -flto for all CUs.
There might be (bigger?) examples where the same issue is triggered by
clang and bigger examples (like systemd on fedora) where I ran into the
bug, but this small example only shows the problem when using gcc and
mixing -flto and non-lto CUs.
