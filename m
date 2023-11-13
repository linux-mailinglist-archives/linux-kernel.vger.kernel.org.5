Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1570D7E9BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjKMMMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKMMMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:12:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39108D75;
        Mon, 13 Nov 2023 04:11:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D2EC433CC;
        Mon, 13 Nov 2023 12:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699877516;
        bh=5gp7DoHA+vUU9ry2Kt97UnYD5nWLqN4A470cWdz48KY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=rmU0WSm3SSGv3pcP9pj9/IqbRpBhOl2X4aZhIynQcaEi1mDO1nBN7XW5Q7MKDV5dW
         lqEtrFkfE4WQ++F343EKPT54Os3Z17480xxg4f+B8laJb8REOnv6okROXyEDhW+S7c
         KjKq8Aq6LEIpUKp1YnVeW9gFC+ZbhDKfoxVjgTZDlT7RRgglrofZ+jUneAqiSp9rpP
         M3ol+hg6v2pequOZw+rdw1SmQhRWS7lKvU7E1CnxNYeuWxdU4fxmTI5d2gTB0f4GQZ
         vth6bS5uNoVfJ0anhWgeM0y5OHSsYn5+71vsDPMNbeq2THlmueBO0joTFq1Br82wDM
         Zaczlf0wN25LQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Zheng Hacker <hackerzheng666@gmail.com>,
        Zheng Wang <zyytlz.wz@163.com>, aspriel@gmail.com,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        johannes.berg@intel.com, marcan@marcan.st,
        linus.walleij@linaro.org, jisoo.jang@yonsei.ac.kr,
        linuxlovemin@yonsei.ac.kr, wataru.gohda@cypress.com,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        security@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5] wifi: brcmfmac: Fix use-after-free bug in
 brcmf_cfg80211_detach
References: <20231106141704.866455-1-zyytlz.wz@163.com>
        <87o7g7ueom.fsf@kernel.org>
        <CAJedcCytuGmvubqbSZgsU3Db=rg=xM+kSuLZn8BSvA18Yn+9Jw@mail.gmail.com>
        <18ba5520da0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
        <CAJedcCxoL+L1QPaZty27k6kqR2JRjxPVY=BV5xn7BSPojbxe=A@mail.gmail.com>
        <fa0e7536-9b05-42fb-9fff-acd2ffad9af9@broadcom.com>
Date:   Mon, 13 Nov 2023 14:11:51 +0200
In-Reply-To: <fa0e7536-9b05-42fb-9fff-acd2ffad9af9@broadcom.com> (Arend van
        Spriel's message of "Mon, 13 Nov 2023 10:18:06 +0100")
Message-ID: <874jhpvomw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> On November 8, 2023 4:03:26 AM Zheng Hacker <hackerzheng666@gmail.com>
> wrote:
>
>> Arend Van Spriel <arend.vanspriel@broadcom.com> =E4=BA=8E2023=E5=B9=B411=
=E6=9C=886=E6=97=A5=E5=91=A8=E4=B8=80 23:48=E5=86=99=E9=81=93=EF=BC=9A
>>>
>>> On November 6, 2023 3:44:53 PM Zheng Hacker <hackerzheng666@gmail.com> =
wrote:
>>>
>>>> Thanks! I didn't test it for I don't have a device. Very appreciated
>>>> if anyone could help with that.
>>>
>>> I would volunteer, but it made me dig deep and not sure if there is a
>>> problem to solve here.
>>>
>>> brcmf_cfg80211_detach() calls wl_deinit_priv() -> brcmf_abort_scanning(=
) ->
>>> brcmf_notify_escan_complete() which does delete the timer.
>>>
>>> What am I missing here?
>>
>> Thanks four your detailed review. I did see the code and not sure if
>> brcmf_notify_escan_complete
>> would be triggered for sure. So in the first version I want to delete
>> the pending timer ahead of time.
>
> Why requesting a CVE when you are not sure? Seems a bit hasty to put
> it mildly.

TBH I don't take CVE entries seriously anymore. I don't know what has
happened there.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
