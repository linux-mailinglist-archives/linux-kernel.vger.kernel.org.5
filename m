Return-Path: <linux-kernel+bounces-127103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D67C48946B3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05DED1C2156C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607D354FBB;
	Mon,  1 Apr 2024 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="jOH+sOfH"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D085554F87
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 21:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008145; cv=none; b=jfh6hM2gO3lEqSez72X8WPcaArzjd/ahLy3T8NAIAu/39ZYDHieoGn1tyOE0yM1nWrDdgAjDpAnj4ooIJtTsw+XUPhX4H8Kvrh3bfd3X+q4yrLQpdXL3Y9CeMU9zkkR7zlGT2xAC2l4p3pxHSB7w/YnIZQaTmzHaZUoU7EogEqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008145; c=relaxed/simple;
	bh=KkGf2RM28bsvANkBUVJW1/ivuEkJ0rohZQ9Hd6eDyug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FfMYI4BG1H/mJw93P1Jqa3pO99i2nHCDwKpsvOpCSDwzNC7ijgeodiV+9+1gHIPzqxBKcNY04WWkMb+9r8N0UsEebZjmBfq44J+k3AuRzCy6iJ/NbH5I+0XRHiB70PgRhxfNrpGWxExsdb/pU34SN67adUh03DRxQIk8iXoBQnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=jOH+sOfH; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6ca65edc9so1601057b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 14:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1712008143; x=1712612943; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VX4QVpH9/Tr9RRXvNsFKWNK+S3DWdeI/iUFhyNCWtEU=;
        b=jOH+sOfHf+K5GuuLBLCgpUWcJjSsSKkRpFMpZZtZbAIZFlq8fkFhg7qj7LLcwRC8Ki
         /ksIyVVaeSMdcgNGkH8CsuqVW+Frx1qvCCji5MxAkCuz7af2b1CQelYKNOeWGtpEqs1g
         fyWNX/753q2IdHdIe6fAtgj52yNSA9sxahgiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712008143; x=1712612943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VX4QVpH9/Tr9RRXvNsFKWNK+S3DWdeI/iUFhyNCWtEU=;
        b=iGOSJqv9YatTAGapc/48M7r+7ru+rF72isHjbuZXSwpdWAcRsrxsnC6Vq9uXm2L6Jy
         etXSmqzZ0Po4LtDMTOsHrG/w/gvE6FkDgV4nFLMG+iDfwOZwRE0oayfbX5I20Ocu0XlY
         UqQ99s9RURMsnrEbHrKGKCleunpJrsiHtYzgRg9D/hvOIqTzDHmRYFgjLucw/G2g24Nk
         q6J8ls1TSMGalpWwBKnXc4t+6Ws+0fq+d0rakZkJ5gIKPnF6x8oIMEezC/0eMHbG6Yfh
         tBtNX7/JJBw2kH6zatwNHkmukwy0LTjcP2WZOytMQ73Wb0aZvD50zW8PiMAcpYUqsRBn
         /tGQ==
X-Gm-Message-State: AOJu0Ywb48/BvHlqx+J+K99k3yd3h/QDw6EX4cph5gRIwCZIr3aLW3dr
	4JhwThlbWFzylCnA7v0NSEqgyLuPkrod7DCT33MUSe7Y8I2bkqxk5hgDb0t1PkZ4KRdPo2t4uDL
	bm3zyedNSCtsu3r2J0cVDyQA6f3bZtRYkvxA95hyr0dAK4fYE
X-Google-Smtp-Source: AGHT+IGm0VOEZmNTLZDUX54EJrqtPhyfISIDWsnFBmuDVCzhGoIQSZ2eoGAymfahuLIemJE7UEex1uPF7F0h7lBCJUk=
X-Received: by 2002:a05:6a21:6d85:b0:1a3:c3a1:b780 with SMTP id
 wl5-20020a056a216d8500b001a3c3a1b780mr13797544pzb.1.1712008142997; Mon, 01
 Apr 2024 14:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402080949.20b4a9b5@canb.auug.org.au>
In-Reply-To: <20240402080949.20b4a9b5@canb.auug.org.au>
From: Corey Minyard <cminyard@mvista.com>
Date: Mon, 1 Apr 2024 16:48:49 -0500
Message-ID: <CALQyB5H2obzN6OW1wHVkNDKif0WKDkynU0Dr0Q9YCRL_rMcYJA@mail.gmail.com>
Subject: Re: linux-next: duplicate patches in the ipmi tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003e0adf06150ff532"

--0000000000003e0adf06150ff532
Content-Type: multipart/alternative; boundary="0000000000003767e506150ff5b6"

--0000000000003767e506150ff5b6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 4:09=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org.=
au>
wrote:

> Hi all,
>
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
>
>   090251a7852d ("MAINTAINERS: erofs: add myself as reviewer")
>   912635053a01 ("erofs: drop experimental warning for FSDAX")
>
> These are commits
>
>   7557d296ad43 ("MAINTAINERS: erofs: add myself as reviewer")
>   a97b59ed7968 ("erofs: drop experimental warning for FSDAX")
>
> in Linus' tree.
>
> These commits in the ipmi tree are also missing Signed-off-bys from their
> committer.
>

Somehow some strange branch got into there.  I'm not sure what happened.
It's cleaned up for now, I need to get the actual patches in there that are
supposed to be there.

Sorry about that.

-corey


>
> --
> Cheers,
> Stephen Rothwell
>

--0000000000003767e506150ff5b6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Mon, Apr 1, 2024 at 4:09=E2=80=AFPM St=
ephen Rothwell &lt;<a href=3D"mailto:sfr@canb.auug.org.au">sfr@canb.auug.or=
g.au</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hi all,<br>
<br>
The following commits are also in Linus Torvalds&#39; tree as different<br>
commits (but the same patches):<br>
<br>
=C2=A0 090251a7852d (&quot;MAINTAINERS: erofs: add myself as reviewer&quot;=
)<br>
=C2=A0 912635053a01 (&quot;erofs: drop experimental warning for FSDAX&quot;=
)<br>
<br>
These are commits<br>
<br>
=C2=A0 7557d296ad43 (&quot;MAINTAINERS: erofs: add myself as reviewer&quot;=
)<br>
=C2=A0 a97b59ed7968 (&quot;erofs: drop experimental warning for FSDAX&quot;=
)<br>
<br>
in Linus&#39; tree.<br>
<br>
These commits in the ipmi tree are also missing Signed-off-bys from their<b=
r>
committer.<br></blockquote><div><br></div><div>Somehow=C2=A0some strange br=
anch got into there.=C2=A0 I&#39;m not sure what happened.=C2=A0 It&#39;s c=
leaned up for now, I need to get the actual patches in there that are suppo=
sed to be there.</div><div><br></div><div>Sorry about that.</div><div><br><=
/div><div>-corey</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<br>
-- <br>
Cheers,<br>
Stephen Rothwell<br>
</blockquote></div></div>

--0000000000003767e506150ff5b6--

--0000000000003e0adf06150ff532
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQ6AYJKoZIhvcNAQcCoIIQ2TCCENUCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg4sMIIFXzCCBEegAwIBAgIQD/rh8xorQzw9muFtZDtYizANBgkqhkiG9w0BAQsFADBlMQswCQYD
VQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29t
MSQwIgYDVQQDExtEaWdpQ2VydCBBc3N1cmVkIElEIFJvb3QgRzIwHhcNMTkwOTIzMTIyNTMyWhcN
MzQwOTIzMTIyNTMyWjBqMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYD
VQQLExB3d3cuZGlnaWNlcnQuY29tMSkwJwYDVQQDEyBEaWdpQ2VydCBBc3N1cmVkIElEIENsaWVu
dCBDQSBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOqxRa06rLwKBvrDb/qQ8RtX
feKA9o0A42oZbLF4GYr4Xdt9JE8r3PJRIOUZD1U3mEln4S/aZoS54Q+5Ecs3q2GGT/Z82VeAPLeG
vJoT0LS5t/zXeUcbMuDFWgyj33kiesnuusnOWvpISoxN+oBH4oo0+oUiHI65mMjMAlb93x6sabh9
kKvHQvHC4x2u7wYv5+NXjnbOhJS/1NjGq+ugLMXeldFMz0O5qFIDpn3aQGU0htyJQ2SZyxEqlUrg
unsrYj9wgfW7XuhAi2j0y5d9oMT0SuVeKFFnQhTEk5B3fq+OBOW0AU2JdW1r929UtRbAr8RpLt05
WI2G2RNVVlHYaU0CAwEAAaOCAgQwggIAMB0GA1UdDgQWBBSlYiBQ3LtbV5etI4814lRsqX75TjAf
BgNVHSMEGDAWgBTOw0q5mVXyuNtgv6l+vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwTAYDVR0lBEUw
QwYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3CgMEBgorBgEEAYI3FAICBgorBgEEAYI3CgMM
BgkqhkiG9y8BAQUwEgYDVR0TAQH/BAgwBgEB/wIBADA0BggrBgEFBQcBAQQoMCYwJAYIKwYBBQUH
MAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBFBgNVHR8EPjA8MDqgOKA2hjRodHRwOi8vY3Js
My5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURSb290RzIuY3JsMIHOBgNVHSAEgcYwgcMw
gcAGBFUdIAAwgbcwKAYIKwYBBQUHAgEWHGh0dHBzOi8vd3d3LmRpZ2ljZXJ0LmNvbS9DUFMwgYoG
CCsGAQUFBwICMH4MfEFueSB1c2Ugb2YgdGhpcyBDZXJ0aWZpY2F0ZSBjb25zdGl0dXRlcyBhY2Nl
cHRhbmNlIG9mIHRoZSBSZWx5aW5nIFBhcnR5IEFncmVlbWVudCBsb2NhdGVkIGF0IGh0dHBzOi8v
d3d3LmRpZ2ljZXJ0LmNvbS9ycGEtdWEwDQYJKoZIhvcNAQELBQADggEBAHZrbCQCo3MAIqR0kekG
YrC70EAGRDRq11COufNEXhcpv3YH6BMhUoVinPPNgfo5HPrZAFrLK/KPXYdJdgkASGsINabAfY2l
jUaJwKlpIewwjS6KuGEn59MgidaAUPh6lbetIoRsLhCqCzAnX1aL99fjCMf4NMWLUC8TqotnnrKN
uw4JSjx4fcQs+U5T1bbgnyDx+8ybONuIEDvinHdKDu2VjoECzez2y/1IVTPlh57zBfjHJQFqLWzH
dou8M+ucdJtr2swXII6s3nkq4pfEn7KnbzMS9quFSuyOGILcg/3qVwaHNLM5R+8nB5gPI5+u5Uh5
6w1i+9Ds1pjYAiTHdeUwggOWMIICfqADAgECAhALkxw61jln6mcjv8OvmvRLMA0GCSqGSIb3DQEB
CwUAMGUxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5k
aWdpY2VydC5jb20xJDAiBgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0xMzA4
MDExMjAwMDBaFw0zODAxMTUxMjAwMDBaMGUxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2Vy
dCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAiBgNVBAMTG0RpZ2lDZXJ0IEFzc3Vy
ZWQgSUQgUm9vdCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANnnKC9SPzZySYiT
NPP4ah4xVICfrVRBtUfflqjUr4AtuQrPdf2JpX0k+uMiDCu8lRcLM78ZTUEGkAC9DE0Q/ge15xxu
IlUxZZe90xfSHmLz2+psUIw/hAyWz7fLA+DKbaEUTBuJ3e0AsFJ8r5FssTgT0ekSCMAAsBwrEdp3
cDabrs55h9yCcOYJdHBVaa+jaJ+/3bZ5s/KdcClV9Kv/lWHzyUBvHdG+k7vTiCq7nb9yWlZxOz/U
89EK/ijvo+7Zma8D049gt/KSobG9iYkfMM3Dpi5iM64WAndEWueBCjynRC55uD8EvFygh+Ebr1GO
zews+vj+bfA6fKqL5GeVMY0CAwEAAaNCMEAwDwYDVR0TAQH/BAUwAwEB/zAOBgNVHQ8BAf8EBAMC
AYYwHQYDVR0OBBYEFM7DSrmZVfK422C/qX69VrWXNqfWMA0GCSqGSIb3DQEBCwUAA4IBAQDKpVWM
48hBbmknp3UR7zyGNm/SncZ4OB1plqKSaS44bJt9BNSJpbExN4rJIcyrbM2LHJrWv0jSMmbBisDz
LzrvwOPUkYbRUOMD23N3b0o5U+3eJse1fa8rQtF1YuNKKwLHUEvgaeKWbA5EZhBEj60F6/h5rKYb
6Dc0nVPJYaqiUq9KcBaGwjrIsRNwNtjP7vQKNNVbTP0HnKK62QFyXPNNwd0OsRwNxGO+rfQU+4ns
okEOTMzIV0DQbgOqzQyOiZmZbPA8MK8432+8o74pICerdP8TInjel1JVHoO1VCAD7q7AT1beN8zD
f6oEJ7vTd7hi2xd8nCgiE3Nszyb1iinnMIIFKzCCBBOgAwIBAgIQCPdWMA138ZCH0Zxtj7kynDAN
BgkqhkiG9w0BAQsFADBqMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYD
VQQLExB3d3cuZGlnaWNlcnQuY29tMSkwJwYDVQQDEyBEaWdpQ2VydCBBc3N1cmVkIElEIENsaWVu
dCBDQSBHMjAeFw0yMjA1MDUwMDAwMDBaFw0yNDA1MDUyMzU5NTlaMEIxHDAaBgNVBAMME2NtaW55
YXJkQG12aXN0YS5jb20xIjAgBgkqhkiG9w0BCQEWE2NtaW55YXJkQG12aXN0YS5jb20wggEiMA0G
CSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDY2HEGeR0DklI0Rsc7cH8OHr9h6y5Fg/qtl6HVGuHC
b4jSzyo2ys2peHLhx979LWXp53YYOGrZZ394baGNPmoYpbXJ/W5k/aWXK7vfImw+gwbgeuHhc2Dp
HJhoe9DURVt9gDO82SMjR/IKqSVwg45JHBxF70EqrhSBeMkgGTKxvfcU2tpDxtBVL0vxg81/Flai
e6yI9hArJLMOCmCnYRiI+tgT6BFslDBXsCWEKvjEfMJMnNVStTUiXmSBQy0HiDkSE3ldzhgn7GfY
BWXXJySlPK4HhTovbV1T1VDACwUutqZCGUNBNilu41So+zk2eVRBhkHvdFk8qhDv3kQNZgz9AgMB
AAGjggHzMIIB7zAfBgNVHSMEGDAWgBSlYiBQ3LtbV5etI4814lRsqX75TjAdBgNVHQ4EFgQU1rCH
cfCGeI7qWJROdKkH8y8zjRowDAYDVR0TAQH/BAIwADAeBgNVHREEFzAVgRNjbWlueWFyZEBtdmlz
dGEuY29tMA4GA1UdDwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQwYD
VR0gBDwwOjA4BgpghkgBhv1sBAEBMCowKAYIKwYBBQUHAgEWHGh0dHBzOi8vd3d3LmRpZ2ljZXJ0
LmNvbS9DUFMwgYsGA1UdHwSBgzCBgDA+oDygOoY4aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0Rp
Z2lDZXJ0QXNzdXJlZElEQ2xpZW50Q0FHMi5jcmwwPqA8oDqGOGh0dHA6Ly9jcmw0LmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRJRENsaWVudENBRzIuY3JsMH0GCCsGAQUFBwEBBHEwbzAkBggr
BgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEcGCCsGAQUFBzAChjtodHRwOi8vY2Fj
ZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURDbGllbnRDQUcyLmNydDANBgkqhkiG
9w0BAQsFAAOCAQEAUpuWwUYMpUU+gPKxMzEPOkQBp9BR9ZBF9/Kr5WU5Vakt4hPs1nmQ3/Wr+HmB
4llcJj8DM/dI3vY2Wlsr0ydBWi2ZDN2Q+NbapQteT9SzEn/Ops72bzOzkD/cMypxtWvJ+iUgVYeM
G6Ogl9m3UMnKgDGj+lN++EZt6mmHBNwqVm50lPQxYYl8MAqlVZRz95XYpe4dKPintnruV9Snmpnf
KyDibF5/GZ3yMId625GUdOCA5W6USe9ytcrYpSotNxeKx5a2vSB5PDkH3bJSILrOQ45uBglwWvDM
Xjuenh8YM44JfoWRVC02niCs7rCl0drMK5X/dIU7b3KY1VQtg+sMqDGCAoAwggJ8AgEBMH4wajEL
MAkGA1UEBhMCVVMxFTATBgNVBAoTDERpZ2lDZXJ0IEluYzEZMBcGA1UECxMQd3d3LmRpZ2ljZXJ0
LmNvbTEpMCcGA1UEAxMgRGlnaUNlcnQgQXNzdXJlZCBJRCBDbGllbnQgQ0EgRzICEAj3VjANd/GQ
h9GcbY+5MpwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBqxPaA03zVlD9TfC6Zh
mQC8H+I4ekUiYtH0kukmTEJ+MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTI0MDQwMTIxNDkwM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCcNAjPOJ0hW+dD0s4MnY8WERJU/tp6yH+mWCco
EXu3G3TOb44add1a/J2MV+3hwrYNJ+v3B1+vOpryLG1dF7dwipSZMtl+83ThsR8PBkPXJbbl8TSO
oqPEKiXBwzrO7VRDsPpNYQGJEJiEeOxT//HqC8vmfdJ7jHvKHh35+qHJ7lRxDNUVBScu1sVNf+ki
Gx9jfn66G4x23bAafcqss7yHJaY1m0lXtDRsh3IUKj/ygi11FQxa8L9qZk33IS6n7UBWQDVg6XLj
k6bhoLeEfepxly4CGj0eEPzI4b1X7LDmG6COws4PzouDjN5D2Z8AEcc5XfkLZjKYGLYgkIW011ht
--0000000000003e0adf06150ff532--

