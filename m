Return-Path: <linux-kernel+bounces-67015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4968564FB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA7ABB26007
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6727131752;
	Thu, 15 Feb 2024 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NX27xYci"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ECD12FF72
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004921; cv=none; b=QVMbmUU0+AjpVAT6oMQ8+WzW0Ih+MP9+IZv9i4XzLmrRBIOVZelF4TI2tRB7jHr/02uP0QOSjqt7fYNyeWNoHt539wID4X7HdjSgAwUXgeU5IbRP5JEMqbqNFwhtDqw2XNPvhSIKJLXcjEBiTH2mYO2CD/5XJQDRoIHwZiY3pZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004921; c=relaxed/simple;
	bh=nTx7t3qPVuoGc38RZL0qBC3dEZ87WlRahTldgy/eUFE=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XEdbhwLxkzth3mLdokmBEcs3DGxEqJaxPljqseO9r3ZDfkMccpud7ZPEp6gQefWx04k4zNSeNY3ljn7r9R3g8BgA28s/ddzL+3hxlu9sMrDjQaMLaQrWXjMFZ6xSi0gkWH/M06RG6yjZ5F39ckCgg75dns1oxbpELRvyFNmIGfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NX27xYci; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d94323d547so7474415ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 05:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1708004919; x=1708609719; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+QyZR4QTKFwIqAdCxUmpac/CnG5XX34FdEEcePXfIw=;
        b=NX27xYciWfqzyL2cyQdoPKBjHsHmtBSocLLU2sRn1gSRokVMqyULWZq3rL/g/h51nv
         7/UwxRizuFOCOgBZOWXiqzCzYHOaVGWs9eAR0awg0p/hpzm9ItqjFXy9S3JmKCTW40bU
         o9+YmaNPjKbulEwJo8qxj9OZRdZYhFWZOMbBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708004919; x=1708609719;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+QyZR4QTKFwIqAdCxUmpac/CnG5XX34FdEEcePXfIw=;
        b=crND5NvvFDi93ZJOGyuQLZnlXaU8KC3ZdnWgw9QoswS7Zd8J9pqXmxmD1vXN+wblGZ
         94hRjMv8giep50usebjZevRGjriNQFUvKucqlhPzOuXu8S/wJiokXDXFqINo/mnhb01l
         cZma8d5ySxRt8+h+U6haR0ajM26AgUcR6//QGhhIu4wePbSGCMyO1lnH7/uLgh0fUhde
         XiFaSD4TKhBVVJ9lj97kubi8m566YF66T+/fae7BDAjLL1BBIwuRneuWZZ1PLFSohSIB
         aI5PGl76wTyB9p8S+XrZStsMi0wV2/bJJ2j0ctAbAe7h9V+snQNNEhzPR9jOp/vWvcWg
         sNOg==
X-Forwarded-Encrypted: i=1; AJvYcCWFjOtbx/EdHuxRmjMDZfxumeVNQ0+64cZ86eOf4w0+R6iXXzq+L/0wkPWRGxdWB3SbS1e4fcQZwRZ6WJy5CjLX31JNtG6qip4/nSnm
X-Gm-Message-State: AOJu0Yx0byr6YMJ2AP/Yg9tzJStsoogdH648SFe/jG23ckALMZwvG9vV
	TAAM6J1ls99x0baAm/ET8I8PioSE0vAqfo2zO2AXlOPsa2PvKsuZMr1VnGxKuQ==
X-Google-Smtp-Source: AGHT+IFI8moL74eV0uJEjyW9RVRYm2GQI5IzaDGshNjNp/nd0XLI1HUF5OKTheGE3uMIMFK8IksUig==
X-Received: by 2002:a17:902:e5d1:b0:1d7:17e6:44df with SMTP id u17-20020a170902e5d100b001d717e644dfmr2250177plf.14.1708004918749;
        Thu, 15 Feb 2024 05:48:38 -0800 (PST)
Received: from [10.176.7.55] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id mp16-20020a170902fd1000b001db53ccb856sm1285715plb.108.2024.02.15.05.48.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Feb 2024 05:48:37 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@kernel.org>, Arnd Bergmann <arnd@kernel.org>
CC: Nathan Chancellor <nathan@kernel.org>, "Greg Kroah-Hartman" <gregkh@suse.de>, "Pieter-Paul Giesberts" <pieterpg@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Artem Chernyshev <artem.chernyshev@red-soft.ru>, Jonas Gorski <jonas.gorski@gmail.com>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
Date: Thu, 15 Feb 2024 14:48:32 +0100
Message-ID: <18dad06ab80.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <170799320307.3764215.10635499094580279814.kvalo@kernel.org>
References: <20240213100548.457854-1-arnd@kernel.org>
 <170799320307.3764215.10635499094580279814.kvalo@kernel.org>
User-Agent: AquaMail/1.49.2 (build: 104902408)
Subject: Re: [PATCH] brcmsmac: avoid function pointer casts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007acd8906116be236"

--0000000000007acd8906116be236
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On February 15, 2024 11:33:30 AM Kalle Valo <kvalo@kernel.org> wrote:

> Arnd Bergmann <arnd@kernel.org> wrote:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> An old cleanup went a little too far and causes a warning with clang-16
>> and higher as it breaks control flow integrity (KCFI) rules:
>>
>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c:64:34: error: 
>> cast from 'void (*)(struct brcms_phy *)' to 'void (*)(void *)' converts to 
>> incompatible function type [-Werror,-Wcast-function-type-strict]
>> 64 |                         brcms_init_timer(physhim->wl, (void (*)(void 
>> *))fn,
>> |                                                       ^~~~~~~~~~~~~~~~~~~~
>>
>> Change this one instance back to passing a void pointer so it can be
>> used with the timer callback interface.
>>
>> Fixes: d89a4c80601d ("staging: brcm80211: removed void * from softmac phy")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I can add 'wifi:' during commit. Arend, ack?

Here it is:

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

>
> --
> https://patchwork.kernel.org/project/linux-wireless/patch/20240213100548.457854-1-arnd@kernel.org/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches




--0000000000007acd8906116be236
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBNw9VlvwxoPsqGrZYf
2b1nLzVvDn7VyhPFMHluMx05nDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDAyMTUxMzQ4MzlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEADmpS9aboki9Umv1jhKnb4EJaed/wHcBdw4jB
XCXLfw6uGVkRQqvVcTlxmYtRDoZo20rcOqd3Y6r1JvD4lPW78sMV+W7tsQOv5o+XZOE+hRpzzCFh
6+zg4M+O8eG6yjq08/Q2SC+cwrFa6rlnhbPuGUZYHkAeS4UAyd18YTM4Op/S1/9h8ZYHntPAIc3E
6lP1sv4mfFVzec4toBpxdvbypZPkE4bqaP8ZbVKVzX2cJ1j7yx2912irI9J99LyWI4In+YxYYr5I
UYgxzVgdtNS5kP1JihD3Ffg1PmTm98AamGBb0ZnCH2qIdAltlJvX6BURQhFMQUn35MV7q9sNpVo6
Ag==
--0000000000007acd8906116be236--

