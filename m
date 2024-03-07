Return-Path: <linux-kernel+bounces-96334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0836875A5A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA082846F7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FEC335D8;
	Thu,  7 Mar 2024 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hi86h58+"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AF73399F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709851098; cv=none; b=bBKTrXc1BRxH1DaH+oFJS0pxoiapmTZJ3VAZqodVgstK7oz2hd4c22FRr1LCO9ZDUC8/1QVoBR4PGgm83LV4JuHI1UMAXa006jpynXl77dBjlQiFZn2NwhZ3Faq0NGWfGSbVoSgCRGDOFcd2M35rGK5SPZf9RgCnWXYCp6509Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709851098; c=relaxed/simple;
	bh=sDOg2FzJmLD1mWSQz7zIQOQOGSIywG6nZFGmIq5IQzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YW06jl/M8RHtGGjmkbcotcd0K1WT9DBzXBIug424+GmzDo+tlNXpUj3g+YhFTkRgJ55I/6/+dMPi49TTqNMZEb2QFkig+R6vcGc25WwB33IBND6nTPROg/2xVdobAP+kaZNtjWQtAXvGIXcMq5xNWXdZhaCOGKEORSrwriZ2GdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hi86h58+; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so222737a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 14:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709851094; x=1710455894; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f+Q2Z0zsOLfwKK3IRnTIWVV+YAS4qCoVeIxUJnKwdT4=;
        b=hi86h58+uU3NFAu55dyp/3iZKRwUADA2KrTFNLOrt5CYBM/Yl7qlPlukI863ZHYIdf
         NhSmqBmRvKFg9sycoZ52BkJrrvl4PukLA84BwkgTXO6N5FyDdtIujQZ3H/bwPcftrQa9
         DBTkTJzDLplfOJcMM0cbYr2f5/0IAuV795ptc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709851094; x=1710455894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+Q2Z0zsOLfwKK3IRnTIWVV+YAS4qCoVeIxUJnKwdT4=;
        b=Pp2DvwVjWje4Tr3lUgYwpogCUwEI5Ko5xUaRAU6jFuYJpn7jBdvwNBO4rupUuCv1r6
         Qwx9/u22G2NAU0Unz2ZtBas/DJQr7YpWjch/0XDv5C9AanDP2ipYEahaBoCt+l7E30TN
         9U4cCfUYvdcWuvkfFYDCAPhBw1dilhFoCQt+/0fn7Ig7a+N1s3PjWFqHVyk3E4B0Jobr
         TGPLwM+qoY7fHyE2kJutcPn/TxzIxdG5LUD/VUS39yRWR8SKa7Kn2RRT0cjkOTZtvPEh
         50hlshIBQR+BwV+5dYSUW8xYVRagvVifqMvurVu8CVbpOi27J9ajYQY+dWeXBCN9jrAx
         9m5g==
X-Forwarded-Encrypted: i=1; AJvYcCXa6Gi8R86fen5eQVfIPXKqadJ8ddAGTGf1a0J+3TAsJnN0G1hr1n+acw3pv/SIaWXPDQ9GzRnJshvWg+th+qupVNIdIthSIz0Zu2Pd
X-Gm-Message-State: AOJu0YxtLAiU0vriRfwN5fw3lbyuftazE/H/aB7QQYdzpQfc6loIg+uj
	L5N2uKNNjPYNEa8f26T2OoguwepIYh6wz6LuOjEH+sqePMDKivChjrAcGD/f9AdbNEBUDSkxDYt
	jSsVW9avkria9CWjtQCd4K+YlbREPbpyO2t4E
X-Google-Smtp-Source: AGHT+IEBXMKJtEG59eltzl5INnig7sALNFBIS1v5utW+diqIkwJX8DP29dOR1EwtkJQzxfE5D/+zeAVUF1fWKgcD0AM=
X-Received: by 2002:a50:ccde:0:b0:567:e812:e44b with SMTP id
 b30-20020a50ccde000000b00567e812e44bmr665214edj.32.1709851093637; Thu, 07 Mar
 2024 14:38:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4e7e11f8-03b5-4289-9475-d3b4e105d40a@ancud.ru>
In-Reply-To: <4e7e11f8-03b5-4289-9475-d3b4e105d40a@ancud.ru>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 7 Mar 2024 14:38:01 -0800
Message-ID: <CACKFLinzJjqe0j4OFkcCV+FyH0JiUpnj3j2azZkGaC9jfvFXrQ@mail.gmail.com>
Subject: Re: [PATCH] tg3: Remove residual error handling in tg3_suspend
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000201319061319bbba"

--000000000000201319061319bbba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 11:23=E2=80=AFAM Nikita Kiryushin <kiryushin@ancud.r=
u> wrote:
>
>
> As of now, tg3_power_down_prepare always ends with success, but
> the error handling code from former tg3_set_power_state call is still her=
e.
>
> Remove (now unreachable) code for simplification.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: c866b7eac073 ("tg3: Do not use legacy PCI power management")
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>

The patch looks good to me.  But I think we can go one step further
and change tg3_power_down_prepare() to a void function.  Thanks.

--000000000000201319061319bbba
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIJH4gxcilHSAaOKSA6BJI/QrFStWFAR
wLXu9whh53h6MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMw
NzIyMzgxNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBW9Vom75TP51ObAXjbOh6akPYVoQNDwABhw7e2gI7GC6+eIw7C
aKCR42lroxwGsn1+j3lVxuMxPcM73Q/HG5A0YbKRcwDhDFqnPhpC3ZJnp9VwRe55XoLxtD53so12
V/rb34kkdWZCaxdPltTqen7SUsuCFmezIhpbbfuM+y5BUCyBe0O5dI0umox0dNPTSywPZHfa8Rg9
CpnGfyPEo8ODQ0v2wr58MNbhFm5h74zWmGcbvBgBNPLjaZpQNMdpL8P1sINwMRTM1sT02vqDxmpy
MLEcnJ64vPYDNG9Duuhsstbu44+2j9sH7YrfRjTaRWmkQ+NOgTvHtDy2aEbNqxT4
--000000000000201319061319bbba--

