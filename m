Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48FE7E28FB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjKFPs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjKFPs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:48:27 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADB0C9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:48:24 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9d2d8343dc4so682773966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 07:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1699285703; x=1699890503; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PDhJGUPnShGv76mGhRwGgWp9KWnoXCyoiJQqJM+6hUw=;
        b=J8D3Toy8dDdlKMwWyKQD4n89Xz4WtLwPH6iD8kzGB1dp9oba+SusP2ub6uGvG9zkzl
         7at++kI3UlRCp5YLFHJBsESeALaqfCZkWwdi5PxszJKocxCzVL3K73o1Tlr+72gdVV5j
         nfDDy2hPhEkrGWloEllO9RU4+G1SyA0C4cCoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699285703; x=1699890503;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDhJGUPnShGv76mGhRwGgWp9KWnoXCyoiJQqJM+6hUw=;
        b=wXSuqzQnzalHsv4PQn+LYQKyDk33/FMn7qbT24AgYZwDWdGLdFhK3znw6LazyFvVUh
         YQn7FhCeTO8rqgyyRUg1+xIUpyPk7lBB7YNJonGx6UMuYWyIuwvDexFgyWkr0uB1F1yL
         5XY74XJIcGiI58E1Kcz1nCicMsk/zY+TtEpj0FiAy/mECKEKNCChHB3KQq9+NER0YFhD
         rInAmrWdeyfGSlDL9ceJ5ahHby02ZgKBnz6TOkj9sVdBSI0XdKpE91V2Vq+1sPRznC3L
         vPwWFsQRRysadpfD2+NLReRKksRz2vFnuiAvXRH1OMudKGJIG5ZKd0OWS/kZuLTgCSgZ
         nTHA==
X-Gm-Message-State: AOJu0YwvnbkSY+vNMof5zoJCW/6RE/h6/DI4Nf7O7o8t3goxqO3B9yxY
        OPyMhQhIS0tPOm13RFuf+cs76A==
X-Google-Smtp-Source: AGHT+IFvoAa2pldGLkkvgKDcw7GOym0iaaWkhkSTSam/sEQOidDnmBKH8uFTb6+ySiPmE6jfr/lysg==
X-Received: by 2002:a17:907:969f:b0:9be:466c:1824 with SMTP id hd31-20020a170907969f00b009be466c1824mr14276225ejc.11.1699285702666;
        Mon, 06 Nov 2023 07:48:22 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id n4-20020a170906378400b009c764341f74sm4250097ejc.71.2023.11.06.07.48.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Nov 2023 07:48:21 -0800 (PST)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Zheng Hacker <hackerzheng666@gmail.com>,
        Kalle Valo <kvalo@kernel.org>
CC:     Zheng Wang <zyytlz.wz@163.com>, <aspriel@gmail.com>,
        <franky.lin@broadcom.com>, <hante.meuleman@broadcom.com>,
        <johannes.berg@intel.com>, <marcan@marcan.st>,
        <linus.walleij@linaro.org>, <jisoo.jang@yonsei.ac.kr>,
        <linuxlovemin@yonsei.ac.kr>, <wataru.gohda@cypress.com>,
        <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <SHA-cyfmac-dev-list@infineon.com>, <linux-kernel@vger.kernel.org>,
        <security@kernel.org>, <stable@vger.kernel.org>
Date:   Mon, 06 Nov 2023 16:48:20 +0100
Message-ID: <18ba5520da0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CAJedcCytuGmvubqbSZgsU3Db=rg=xM+kSuLZn8BSvA18Yn+9Jw@mail.gmail.com>
References: <20231106141704.866455-1-zyytlz.wz@163.com>
 <87o7g7ueom.fsf@kernel.org>
 <CAJedcCytuGmvubqbSZgsU3Db=rg=xM+kSuLZn8BSvA18Yn+9Jw@mail.gmail.com>
User-Agent: AquaMail/1.47.0 (build: 104700356)
Subject: Re: [PATCH v5] wifi: brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b2deb006097dc8e0"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b2deb006097dc8e0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On November 6, 2023 3:44:53 PM Zheng Hacker <hackerzheng666@gmail.com> wrote:

> Thanks! I didn't test it for I don't have a device. Very appreciated
> if anyone could help with that.

I would volunteer, but it made me dig deep and not sure if there is a 
problem to solve here.

brcmf_cfg80211_detach() calls wl_deinit_priv() -> brcmf_abort_scanning() -> 
brcmf_notify_escan_complete() which does delete the timer.

What am I missing here?

Regards,
Arend

>
> Kalle Valo <kvalo@kernel.org> 于2023年11月6日周一 22:41写道：
>>
>> Zheng Wang <zyytlz.wz@163.com> writes:
>>
>>> This is the candidate patch of CVE-2023-47233 :
>>> https://nvd.nist.gov/vuln/detail/CVE-2023-47233
>>>
>>> In brcm80211 driver,it starts with the following invoking chain
>>> to start init a timeout worker:
>>>
>>> ->brcmf_usb_probe
>>> ->brcmf_usb_probe_cb
>>> ->brcmf_attach
>>> ->brcmf_bus_started
>>>  ->brcmf_cfg80211_attach
>>>    ->wl_init_priv
>>>      ->brcmf_init_escan
>>>        ->INIT_WORK(&cfg->escan_timeout_work,
>>>          brcmf_cfg80211_escan_timeout_worker);
>>>
>>> If we disconnect the USB by hotplug, it will call
>>> brcmf_usb_disconnect to make cleanup. The invoking chain is :
>>>
>>> brcmf_usb_disconnect
>>> ->brcmf_usb_disconnect_cb
>>> ->brcmf_detach
>>> ->brcmf_cfg80211_detach
>>>  ->kfree(cfg);
>>>
>>> While the timeout woker may still be running. This will cause
>>> a use-after-free bug on cfg in brcmf_cfg80211_escan_timeout_worker.
>>>
>>> Fix it by deleting the timer and canceling the worker in
>>> brcmf_cfg80211_detach.
>>>
>>> Fixes: e756af5b30b0 ("brcmfmac: add e-scan support.")
>>> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
>>> Cc: stable@vger.kernel.org
>>> ---
>>> v5:
>>> - replace del_timer_sync with timer_shutdown_sync suggested by
>>> Arend and Takashi
>>> v4:
>>> - rename the subject and add CVE number as Ping-Ke Shih suggested
>>> v3:
>>> - rename the subject as Johannes suggested
>>> v2:
>>> - fix the error of kernel test bot reported
>>> ---
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 ++
>>> 1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c 
>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>> index 667462369a32..a8723a61c9e4 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>> @@ -8431,6 +8431,8 @@ void brcmf_cfg80211_detach(struct brcmf_cfg80211_info 
>>> *cfg)
>>> if (!cfg)
>>>        return;
>>>
>>> +     timer_shutdown_sync(&cfg->escan_timeout);
>>> +     cancel_work_sync(&cfg->escan_timeout_work);
>>> brcmf_pno_detach(cfg);
>>> brcmf_btcoex_detach(cfg);
>>> wiphy_unregister(cfg->wiphy);
>>
>> Has anyone tested this on a real device? As v1 didn't even compile I am
>> very cautious:
>>
>> https://patchwork.kernel.org/project/linux-wireless/patch/20231104054709.716585-1-zyytlz.wz@163.com/
>>
>> --
>> https://patchwork.kernel.org/project/linux-wireless/list/
>>
>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches




--000000000000b2deb006097dc8e0
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCClYw1OTDcnKsyNpyO1
PIBWXMaD3VZemGpk9RXnJDpuMTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzExMDYxNTQ4MjJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAcniUdIFbd3WnKY79xfXiSZDOrxc1sAKIvx6F
Q/utJKEGw9hSYIENjzrXS7vZNFWyU2PieLDB6f42euUyx79K1wA59wg5T06/I2vV/33OtIH8It1Q
IjSRpqHFlkJpjUMMiZ7rnQCSp/L8B/fxZeGoxr2Vch0Tfr9RLBlW70ID+WuU/jO67LJLomFLytAl
eNBXhr6bMSSQ9it8qyhzbh1jVlPCy2SrIG/uhw+9M3HUpODMxBToDSC2RhBL7zr2w/JMlHz8UDUu
6gi30Z9y3ys358vgPUqwjAw7TtmH6AFGRXbIobZlrKWbYreeflwLpUYB+Gh5HQti64XlOPGteCf2
cg==
--000000000000b2deb006097dc8e0--
