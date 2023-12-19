Return-Path: <linux-kernel+bounces-4925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DE08183E3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59BCE1F22409
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB67B134A5;
	Tue, 19 Dec 2023 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JpwNkNt+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A28012B71
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-67f296ecb2dso22315166d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 00:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1702975949; x=1703580749; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IWmzH+5wOkD/NzcVn1dwSiml+lZXUrC1ZWTyfzIDfOg=;
        b=JpwNkNt+WsC8b6Ii8h5qrGGpVS4Z2l8MjLxiHZ7ZdsH80p4jX6RDKBskkjkaffcRz2
         kge1Wj/ZYG4nyYReEpy4U75FPD/PcSR04DgLTr+5/bpgrhMrfj8rAIgS2lYcGHKN/d8x
         eFfUYwB6hl4QJS+mm3RT98JsswZWJFT6G5PAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702975949; x=1703580749;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWmzH+5wOkD/NzcVn1dwSiml+lZXUrC1ZWTyfzIDfOg=;
        b=AnSRX7rEe1Z502uhUAkdWOifbFozC+RH2tofD0MS77a7Y8Llstl9OooLDf3XqtPicy
         h3G0TTrvkrjJ3PjvkaMtEhkeVylWO8rnFdPCvNXbcbyb0ud+3yr6ocF/saUZ3auhaeMB
         6xEKikSaKFloer3YdhPxL5nvXZ6WDN9Bs+7k9q8oIWj8Z68NkNw9GNO9cOLKnQJKn59X
         0rleak3IRa4RxMLtG8x/xYAYkCL6Z3B7gXqyDjRmK9t4h++gybdPaubjDvXh3Va9H0lA
         RQlAHP3Nzjq2u3R0PJDUo4tq1RiDek6j59XNH+dLlG7eoUw6reTJ19Q1TNe6d/ECxMNe
         O26Q==
X-Gm-Message-State: AOJu0YwyFbW43GSOewpMOkaRkw+PdrJCK5xXp9DpKBRzMUZS7ePMtu4t
	K44xAeEFnh7Kfa2xf0843ZwB1VJPNJLt
X-Google-Smtp-Source: AGHT+IFaqg/n4f0EVV44W5gROz3eZzWjOEKMkfhPnM5YJa3auTudQfcuaV//K06MJVoO8ejIoUpc8A==
X-Received: by 2002:a05:6214:27eb:b0:67f:4752:2079 with SMTP id jt11-20020a05621427eb00b0067f47522079mr1150902qvb.35.1702975949255;
        Tue, 19 Dec 2023 00:52:29 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id l4-20020ad44bc4000000b0067f351d0305sm2387210qvw.103.2023.12.19.00.52.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Dec 2023 00:52:28 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@kernel.org>, Hector Martin <marcan@marcan.st>
CC: Arend van Spriel <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>, Daniel Berlin <dberlin@dberlin.org>, <linux-wireless@vger.kernel.org>, <brcm80211-dev-list.pdl@broadcom.com>, <SHA-cyfmac-dev-list@infineon.com>, <linux-kernel@vger.kernel.org>, <asahi@lists.linux.dev>, Hector Martin <marcan@marcan.st>
Date: Tue, 19 Dec 2023 09:52:23 +0100
Message-ID: <18c80d15e30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <170281231651.2255653.7498073085103487666.kvalo@kernel.org>
References: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
 <170281231651.2255653.7498073085103487666.kvalo@kernel.org>
User-Agent: AquaMail/1.49.0 (build: 104900403)
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000898f75060cd8fcfd"

--000000000000898f75060cd8fcfd
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On December 17, 2023 12:25:23 PM Kalle Valo <kvalo@kernel.org> wrote:

> Hector Martin <marcan@marcan.st> wrote:
>
>> Using the WSEC command instead of sae_password seems to be the supported
>> mechanism on newer firmware, and also how the brcmdhd driver does it.
>>
>> According to user reports [1], the sae_password codepath doesn't actually
>> work on machines with Cypress chips anyway, so no harm in removing it.
>>
>> This makes WPA3 work with iwd, or with wpa_supplicant pending a support
>> patchset [2].
>>
>> [1] https://rachelbythebay.com/w/2023/11/06/wpa3/
>> [2] http://lists.infradead.org/pipermail/hostap/2023-July/041653.html
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> Reviewed-by: Neal Gompa <neal@gompa.dev>
>
> Arend, what do you think?
>
> We recently talked about people testing brcmfmac patches, has anyone else
> tested this?

Not sure I already replied so maybe I am repeating myself. I would prefer 
to keep the Cypress sae_password path as well although it reportedly does 
not work. The vendor support in the driver can be used to accommodate for 
that. The other option would be to have people with Cypress chipset test 
this patch. If that works for both we can consider dropping the 
sae_password path.

Regards,
Arend

> --
> https://patchwork.kernel.org/project/linux-wireless/patch/20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches




--000000000000898f75060cd8fcfd
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCClU8O+NyWu4REZ6NtD
mnzMnDTgOzYCzlHcQT78LpKCtjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzEyMTkwODUyMjlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEATSRuuhaffrvAPMhReDLcqyRtY4MbpWW0O9T1
KA05WkKMjicoYiVA2w86PLoeZWHsOMuuj1nX6DmRK8/BfI7jwUevFS795K74M6kmhKRoJ6fWfNBy
RpxSP4T8qcpfpjn3Bykt5MiZdX8H3AXVeFROVcjVRJZit15wLkYnJWa/tFQmfFylGlODpMEazNxQ
n9Wj97L8maUo2pzymbfWrOlEd55kwY5/rCdQo3XWkIVWhpgUNR/uAZI8HKNnSe9OsBrwpk4aueWP
K9ABTP6IIVCPP6x97uUD7T1/I2xJx9ebQ8mx9BTrQcELJ6IulHB1BgcwNV/ZMde6uB4WQX6+lx1s
aw==
--000000000000898f75060cd8fcfd--

