Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A607A7EE717
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjKPTCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKPTCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:02:17 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C9A1A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:02:14 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-41cc56255e3so6594411cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1700161333; x=1700766133; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cTZRS6E1stUa5VfVWTXY6gCfHF4Ty1fwKaHUbqfnKZ0=;
        b=XyORbKjMUX7sR430SmOJeMZZOV3u4O+gHmk/a5C4Kz7aVr9O1HnO9JV0iuYOKJH5ub
         7Nu96ACH8BwMcO88PfuUJpER3d0E8a2/wq+jJ1cPj6FVtdFaiAt5PrtawHO+rFztum95
         j36/Z3tp1wTqFBpih5TrdWsekHxd06txDck0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700161333; x=1700766133;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTZRS6E1stUa5VfVWTXY6gCfHF4Ty1fwKaHUbqfnKZ0=;
        b=EMMoyXjbYGMyOrKRBwnHkuc6n24qgBWyBYGaKok5+2OnvKZMESS+lhV/ve3hX4ibsj
         XxrQT9qWMYyYenr4+xAlNJ3kUlVpRoxTT0LA+nB4J9NKeSPN7SXlxYgxKZ6Rjgh3DM0P
         9x03p6CwV2azpUAO5cxJzvSQRewkKxfsRjEmS7kumc3Nw6yi9w7HM/g90QW0pJr8R6PN
         OEB/iS9YiYjdJY3+0pV+GEHzE5PSi9r7fkDvoxru7DufAe7jga0XHSqrlMVCAeZ+XIRt
         SYEb9QAdVJKlZIis93cv6cka1HSRkXBdHIZDFmGjw0LGycwY/Gw74bkdil1jiRyScUn0
         DZ4Q==
X-Gm-Message-State: AOJu0Yw9y7TYniDpHjV1oqwWJeg08TRztpJB2IDYLrVumqKlXHFGMmKi
        Sl+ctn8BGE1/VNOOig+sSsaOcw==
X-Google-Smtp-Source: AGHT+IHnvGL0LbJdBpYvMAtNyGljlbf1uEBve6n+MeRHtmRKjedAiVcYxChIiIuYH8QJmDj1dv8wPQ==
X-Received: by 2002:a05:622a:1647:b0:421:c3a9:1e50 with SMTP id y7-20020a05622a164700b00421c3a91e50mr11428568qtj.65.1700161333172;
        Thu, 16 Nov 2023 11:02:13 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id m13-20020ac807cd000000b0041b7f89ad19sm4353468qth.53.2023.11.16.11.02.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Nov 2023 11:02:12 -0800 (PST)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     Zheng Hacker <hackerzheng666@gmail.com>,
        Kalle Valo <kvalo@kernel.org>, Zheng Wang <zyytlz.wz@163.com>,
        <aspriel@gmail.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <johannes.berg@intel.com>,
        <marcan@marcan.st>, <linus.walleij@linaro.org>,
        <jisoo.jang@yonsei.ac.kr>, <linuxlovemin@yonsei.ac.kr>,
        <wataru.gohda@cypress.com>, <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <SHA-cyfmac-dev-list@infineon.com>, <linux-kernel@vger.kernel.org>,
        <security@kernel.org>, <stable@vger.kernel.org>
Date:   Thu, 16 Nov 2023 20:02:06 +0100
Message-ID: <18bd9830bb0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <87h6llmu7t.wl-tiwai@suse.de>
References: <20231106141704.866455-1-zyytlz.wz@163.com>
 <87o7g7ueom.fsf@kernel.org>
 <CAJedcCytuGmvubqbSZgsU3Db=rg=xM+kSuLZn8BSvA18Yn+9Jw@mail.gmail.com>
 <18ba5520da0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAJedcCxoL+L1QPaZty27k6kqR2JRjxPVY=BV5xn7BSPojbxe=A@mail.gmail.com>
 <fa0e7536-9b05-42fb-9fff-acd2ffad9af9@broadcom.com>
 <CAJedcCzj9SFbx-=xDymqJyV2fu0xjmz2RH4+gT+Gxsqubg35ZA@mail.gmail.com>
 <18bd95c97f0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <87h6llmu7t.wl-tiwai@suse.de>
User-Agent: AquaMail/1.48.0 (build: 104800386)
Subject: Re: [PATCH v5] wifi: brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000005a6c8d060a49a8dd"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000005a6c8d060a49a8dd
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On November 16, 2023 7:25:16 PM Takashi Iwai <tiwai@suse.de> wrote:

> On Thu, 16 Nov 2023 19:20:06 +0100,
> Arend Van Spriel wrote:
>>
>> On November 15, 2023 4:00:46 PM Zheng Hacker <hackerzheng666@gmail.com> wrote:
>>
>>> Arend van Spriel <arend.vanspriel@broadcom.com> 于2023年11月13日周一 17:18写道：
>>>>
>>>> On November 8, 2023 4:03:26 AM Zheng Hacker <hackerzheng666@gmail.com>
>>>> wrote:
>>>>
>>>>> Arend Van Spriel <arend.vanspriel@broadcom.com> 于2023年11月6日周一 23:48写道：
>>>>>>
>>>>>> On November 6, 2023 3:44:53 PM Zheng Hacker <hackerzheng666@gmail.com> wrote:
>>>>>>
>>>>>>> Thanks! I didn't test it for I don't have a device. Very appreciated
>>>>>>> if anyone could help with that.
>>>>>>
>>>>>> I would volunteer, but it made me dig deep and not sure if there is a
>>>>>> problem to solve here.
>>>>>>
>>>>>> brcmf_cfg80211_detach() calls wl_deinit_priv() -> brcmf_abort_scanning() ->
>>>>>> brcmf_notify_escan_complete() which does delete the timer.
>>>>>>
>>>>>> What am I missing here?
>>>>>
>>>>> Thanks four your detailed review. I did see the code and not sure if
>>>>> brcmf_notify_escan_complete
>>>>> would be triggered for sure. So in the first version I want to delete
>>>>> the pending timer ahead of time.
>>>>
>>>> Why requesting a CVE when you are not sure? Seems a bit hasty to put it
>>>> mildly.
>>>
>>> I'm sure the issue exists because there's only cancler of timer but not woker.
>>> As there's similar CVEs before like : https://github.com/V4bel/CVE-2022-41218,
>>> I submit it as soon as I found it.
>>
>> Ah, yes. The cancel_work_sync() can also be done in
>> brcmf_notify_escan_complete().
>
> AFAIUC, brcmf_notify_scan_complete() is called from the work itself,
> too, hence you can't issue cancel_work_sync() there (unless you make
> it conditional).

Hi Takashi,

You are obviously right. Let's wait and see what v6 will look like ;-)

Regards,
Arend



--0000000000005a6c8d060a49a8dd
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCNDP153oM3vCC3pua8
9AWNirCVUAQEOkhPVyt21DwVQTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzExMTYxOTAyMTNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAwEMheTLeUWkv9XDuNz9JYUdufRMMll6kvIDT
BKWJJUnw8U+C8a2myciPH6oBTEk3wLP+8ipccNgx6riLOvjOQfaXk6HD8mjdv5p1P0LH2C84e2Dy
7LaRpx/wSMRMrd41o5sB9gfQ4xiaTmsS6miSwm9/hEfhKJap9nsB7/k+VLWA/cs9yVDbk3Yom2yR
MEsyYSlvcNd5ZP9+Jg6wDOa/NVdHRlo6TxBIQv2DsPHMrxAV1qoo0UOKvVpIA2EZhQrE2ap5a+XB
1goQgYCpTAzsIHjCAucufpO8PS8p1FIYNg13k8SUdkZt10osZkK+5iPBvg2YMRpi6BKnce+uv/Aq
Lw==
--0000000000005a6c8d060a49a8dd--
