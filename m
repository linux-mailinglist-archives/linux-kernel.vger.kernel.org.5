Return-Path: <linux-kernel+bounces-99299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E37287863A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4FF1C213A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171574D9E8;
	Mon, 11 Mar 2024 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AID5+l/A"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E359638DEC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710177768; cv=none; b=h2Y6LmnWFPoBX/X+oqf1Kuu96nODopfrLNdg534GbRQM3AJEqTe9BC3tw/LEJUW5cPG7upmSiDfiZCaJMjYoeqgllxm83ZZQQZbuLgnX4HqEactAnMm2jkRUZQXYQ9fmGjYOuo7RkSSHxJLgPpE+I3T59bL91KEXgR9HJ7eagNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710177768; c=relaxed/simple;
	bh=UFTaEdKx1t24VkeS5ziW4j8SwWYeFIWxKokcq3RKsXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRjlEod9d5msgFL/aeEGsxeZ9nL3//U7V4V8RfddnBP4unF8Ruet0KnBvQ17K5WdemP+R0vn+BZPkaj7LYAiBkBu0nHprVsUZxxExVYLJ9K6h31z/+V2dihwGKpSR4a52CzWAUqBxmImqLX6kw3OWEw3AB3Z/oqAHnnZ8tFTgEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AID5+l/A; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5684db9147dso1925115a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1710177763; x=1710782563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8EciYOaijriKQm9uxzzxRnFwd5bVtroaXIOj04r33M4=;
        b=AID5+l/AgtFfYjqGP+4P1DqVwr2zwqG0pJ5P2hEUyFW6YeuRZsl9lFdXda8iuM63nk
         061aNiRPwAmnYveiXojzewCnO2di/J1rZT9WKzkXPGB7TNwoowy4fh5YmhgXoR9fRh5I
         m1WfDSc27snZHolGABD56J4Dp0c9cGjU66s00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710177763; x=1710782563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EciYOaijriKQm9uxzzxRnFwd5bVtroaXIOj04r33M4=;
        b=hxKFJTiXpyHcvPjfrwp4YjLblwGpGy2x+WQm/2yfYqSpHz6onDCWaNX5JSyDuOHoZw
         EmxUasxVecDie4YPjlByoOnQ/N6DKg19MSUuVgsm8pIDRaJshfrfltxa8qUVvBmElOei
         Rngy5cHPiD7jqcRp7yY9QQvZFTMEODFYre9Rf9EuvlhD8Y2rX4S2fzaCCvxQp3AuOBWJ
         oQQDJFEP7IQWfZpQH9DieXcTv4CPPTpo4tRkIhsBe4f4uf4wwznrasZJCEOAvXBCkV5w
         HKcfRwTiXQCd0ABSYsOszU4d6bru53mDkiOrIWDewjNE5+perKdhR5OXLRXWU+iHf5g+
         9VIw==
X-Forwarded-Encrypted: i=1; AJvYcCWQmh1ai9lJxGTzTFPHIBy6EMf5whO3k/frQGMQgK6gqZXD7xcsHAjxyg8lLKhRgzqesyFqXxbUYtUcfEmCM6B0MGCOSp0q2nC0ICbX
X-Gm-Message-State: AOJu0YxemdgfQ8w6Ew3mYx9t+k5t6e5m+LHKN7DeSZ6BfjWQ0fmykMGY
	dmT+Q9Ls9OadY2kWFGK3gd18yKB7usY+ZRQ96IKJ8Ap8NAVcZ2G4ZPzpXlRjzuZLOW3mAIrD8jj
	X5+da49/QdB8KNRJt0efPde/NJxb28BlIHniy
X-Google-Smtp-Source: AGHT+IH3cFZgJ2k0bJiy5q5S/R/8S/i7OhlrAtT8zfCljgL4aeNKsaefoa5bN6sGVgRhThGOfuUsgLjdaouHAmJ8/gs=
X-Received: by 2002:a50:d794:0:b0:566:47dc:47e3 with SMTP id
 w20-20020a50d794000000b0056647dc47e3mr4573541edi.15.1710177762294; Mon, 11
 Mar 2024 10:22:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACKFLinzJjqe0j4OFkcCV+FyH0JiUpnj3j2azZkGaC9jfvFXrQ@mail.gmail.com>
 <a6f3f931-17eb-4e53-9220-f81e7b311a8c@ancud.ru>
In-Reply-To: <a6f3f931-17eb-4e53-9220-f81e7b311a8c@ancud.ru>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 11 Mar 2024 10:22:30 -0700
Message-ID: <CACKFLikPmtbkvVFerB0WNvLN3w=ia_vd6fUAo8iWpAqNsegMaQ@mail.gmail.com>
Subject: Re: [PATCH v2] tg3: Remove residual error handling in tg3_suspend
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001b2fef061365ca61"

--0000000000001b2fef061365ca61
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 8:45=E2=80=AFAM Nikita Kiryushin <kiryushin@ancud.r=
u> wrote:
>
>
> As of now, tg3_power_down_prepare always ends with success, but
> the error handling code from former tg3_set_power_state call is still her=
e.
>
> Remove (now unreachable) code for simplification and change
> tg3_power_down_prepare to a void function as its result is no more checke=
d.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: c866b7eac073 ("tg3: Do not use legacy PCI power management")
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> ---
> v2: Change tg3_power_down_prepare() to a void function
> as Michael Chan <michael.chan@broadcom.com> suggested.
>   drivers/net/ethernet/broadcom/tg3.c | 30 ++++-------------------------
>   1 file changed, 4 insertions(+), 26 deletions(-)

The patch looks good to me.  But this cleanup patch should be for
net-next and net-next is closed right now.
Please re-post in about 2 weeks.  You can add my tag when you repost:

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

Thanks.

--0000000000001b2fef061365ca61
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIETlLFeznxypHPO6HKSgRANSXYZyfdWr
XO0ipQIVMWN1MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMx
MTE3MjI0M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBp7MjyHrJYDU0YSMovPYecwB38Ja6f9nRdrAQqCB6b8mKriCTJ
kZ2gpgiTC2GnxMY2iLpTbfwZRrgtSjmyeI5Y04ss8cVvjw0QkWnZC6GaCQWsuFNoIhGuF/p6Dhyu
LKTSmhOqhVo4T4DMGYSXr+Fu8hqEmISd4ty91Ffr52+2frnRMaIoeHGQjFTg2CMlfhYR0gEtcoWL
ZN6Fb60nt6uTX+Kx2B2esezotOnKYjE3yX1jioE+l2sU5y1t/sN3g8bTrwu2hO8cH8sUkPuk485f
kQGBvpDOQ4WH0/FtA44VUTMFgzkq7JcGnk6VM73CXgGZM7B4o17Qy3CZsZF89fuK
--0000000000001b2fef061365ca61--

