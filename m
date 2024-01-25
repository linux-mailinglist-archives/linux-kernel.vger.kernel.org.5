Return-Path: <linux-kernel+bounces-38818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A27CD83C66B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82221C23226
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDE26EB79;
	Thu, 25 Jan 2024 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QIW/w/zc"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3660269
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196099; cv=none; b=mIwNS+T13+JjbUXakzM7UkhNe9wk3Ds1FeJ6jIVwtMz5EQzJzi/CDxdn77hqdnUtWU0smjyDh2D4JvxSd5XC1yEQNt/oYQPbCAC2xAZWSBZyZ6NA5+VY7aICOokcj8UPKt38ihLqKw2172XIjQun/hgGukFQY34qYHwvpeZCbas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196099; c=relaxed/simple;
	bh=kY9GKKnuCrw27cizO1MnwU9eRhLcfafdVWJgp39ohN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6DJibNlv69wZwcILkWwbxpLxRc90ZiD8ZpazkJxqQiDzxKF3bXY/69kBq7Jd6cN2IEna57Br3cyYVOB4QnwBWpm/Akw+qcvrk4k2Sueg4E2NFMJhk8+X+zjDj0PJfnKlBAf9WLGEUeOmPc6sY7z+E/GuhkDtPO6qE2dMQiZfhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QIW/w/zc; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2901f9ea918so3804160a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706196097; x=1706800897; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0f0Rc0HyXcnVVRc0tUrEj6UJv/mWl0ixKFsRfK/E5xM=;
        b=QIW/w/zcY0zfJn5GJi+EmvGkC3rgmtU70UDtZHcvJvHspXfr+Plj9sBiul44+4cMKq
         46dUcSpNWxW6+X1x+TpYyk12KOjsZkzr+xPRqYHbR3MchgMaVI1KmKjz6gB549xcLFwV
         Jb1eK6O3imiExAtG6WBbX9UE8W9QpbDkthyGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706196097; x=1706800897;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0f0Rc0HyXcnVVRc0tUrEj6UJv/mWl0ixKFsRfK/E5xM=;
        b=lEvz9EAmoAnKFirKXujvekhYjZJ+pD+9mBNHjAoRbcPDL4KaoOo1sxo2ym0rEYD3Mz
         U9RwBzPHVlhrE5G0X3wnZ2Nc9CIRHrfEonhe+9sR3Lky9kkt2+QrTHfFJnjq/dw3EnbF
         5y/f6XUfzBJ54GAYUYg+4M05MBdWSk14Hy67wnbh3+0LfS3e0unDUgEYOYT3z5YttMq3
         d24UzUbxUxiz5g6HxXHx570QbTYUTKoC0RGHv7lMJXY4zq6IvaY2GDmbm5a0Msm40ycI
         ubaBkxgil9oMlTYcC+Gcvpxy/Fw8XlWGmccTuxbA607W4CtP2/XEBLXWpq4Yf+LiWJUX
         W07A==
X-Gm-Message-State: AOJu0Yyvtp/KB31bNUEK+5OkjBzPRrqefwEP3FyeklLaAHLrDzLPZCdB
	Cggi6yz00r7UadnQ2JtHKtSMnMLy5U3x06KYYlvDOmei8hE2rt4kqDAOCsYOgmsQNi1ryP0OydG
	Q/fwXdEpjsAWs/8ftZLVvdTQjIV+tYea1ceJv
X-Google-Smtp-Source: AGHT+IGvfL3vvvLXYsGWUeUWHTy4eHJtkOq5ATcY+CugFMq1jdJyIIQ1Vj5ywnqttRswQh1RySvGP3O2Q/9KcqlDsCI=
X-Received: by 2002:a17:90a:e614:b0:290:33f8:5c5d with SMTP id
 j20-20020a17090ae61400b0029033f85c5dmr784337pjy.34.1706196097381; Thu, 25 Jan
 2024 07:21:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125134104.2045573-1-leitao@debian.org> <CALs4sv2U+3uu1Nz0Sf9_Ya6YKxK09WU=QH4VmO94FjC3iWX3rA@mail.gmail.com>
 <ZbJ11qxfmOfRseJO@gmail.com>
In-Reply-To: <ZbJ11qxfmOfRseJO@gmail.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 25 Jan 2024 20:51:25 +0530
Message-ID: <CALs4sv3cpcy5G6d+3UL8dVSyN1vFbgiin8gLiVxKOfWUAAB0+Q@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: Make PTP timestamp HWRM more silent
To: Breno Leitao <leitao@debian.org>
Cc: Michael Chan <michael.chan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, gospo@broadcom.com, 
	"open list:BROADCOM BNXT_EN 50 GIGABIT ETHERNET DRIVER" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000530c29060fc6bc4b"

--000000000000530c29060fc6bc4b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 8:23=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Thu, Jan 25, 2024 at 08:03:18PM +0530, Pavan Chebbi wrote:
> > On Thu, Jan 25, 2024 at 7:11=E2=80=AFPM Breno Leitao <leitao@debian.org=
> wrote:
> > >
> > > commit 056bce63c469 ("bnxt_en: Make PTP TX timestamp HWRM query silen=
t")
> > > changed a netdev_err() to netdev_WARN_ONCE().
> > >
> > > netdev_WARN_ONCE() is it generates a kernel WARNING, which is bad, fo=
r
> > > the following reasons:
> > >
> > >  * You do not a kernel warning if the firmware queries are late
> > >  * In busy networks, timestamp query failures fairly regularly
> > >  * A WARNING message doesn't bring much value, since the code path
> > > is clear.
> > > (This was discussed in-depth in [1])
> > >
> > > Transform the netdev_WARN_ONCE() into a netdev_warn_once(), and print=
 a
> > > more well-behaved message, instead of a full WARN().
> > >
> > >         bnxt_en 0000:67:00.0 eth0: TS query for TX timer failed rc =
=3D fffffff5
> > >
> > > [1] Link: https://lore.kernel.org/all/ZbDj%2FFI4EJezcfd1@gmail.com/
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> >
> > LGTM, however, you may still need to add a proper fixes tag.
>
> Thanks. I didn't include a fix tag because it is not a fix per se, but,
> I can easily send a v2 if this is needed.

You have a point. But then in that case it should go to net-next, I think.
If you respin or otherwise,
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

--000000000000530c29060fc6bc4b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OltyqaGBuzv+bJTUL+bmV7E4QBLIqGt4jVr1R9hJdH6KxXwJdyfHZ9C6qXmoe2NQhiFUyBOJ0wgk
dB9Z1IU7nCwvNKYg2JMoJs93tIgbhPJg/D7pqW8gabkCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEV6y/89alKPoFbKUaJXsvWu5
fdowDQYJKoZIhvcNAQELBQADggEBAEHSIB6g652wVb+r2YCmfHW47Jo+5TuCBD99Hla8PYhaWGkd
9HIyD3NPhb6Vb6vtMWJW4MFGQF42xYRrAS4LZj072DuMotr79rI09pbOiWg0FlRRFt6R9vgUgebu
pWSH7kmwVXcPtY94XSMMak4b7RSKig2mKbHDpD4bC7eGlwl5RxzYkgrHtMNRmHmQor5Nvqe52cFJ
25Azqtwvjt5nbrEd81iBmboNTEnLaKuxbbCtLaMEP8xKeDjAKnNOqHUMps0AsQT8c0EGq39YHpjp
Wn1l67VU0rMShbEFsiUf9WYgE677oinpdm0t2mdCjxr35tryxptoTZXKHDxr/Yy6l6ExggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwV/XkICjVscn4SNZMw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBAZV6rmeJ20niekRrV5IP8+mHTogY1k
YBnltxwq7MIMMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDEy
NTE1MjEzN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBT4mEQuvAfD9ThnE9n2WXUsqPlcYwIPhDJ1oBXtEkgXwvbyiEN
GXI13UQjyDw+tlBM5iMAs9MzLhBf/ZXVa+jVCcKRZKj0gH+jpFZprrCwus1T83j9tz3wyqIsjejB
PddwlOdTQ0qMNz+LG/xUI2NBHIZOT0I1zpgM987uTYpVoLOS5b9mBySK4yFRsP8BHTCHcj1UJKoI
6Ne76PJtJGp3rVX5CqTT0qxh0OMV7IDZIxJhhot8K9QzPaYQpuu3ImWkvI4quTvTD8ZgrnkOBZEJ
BGnO+tiOh12lCgds0pcVXpz16nwlyLp+O/JZiSwqo/DVh2mOjaGGt/optBrZXWS+
--000000000000530c29060fc6bc4b--

