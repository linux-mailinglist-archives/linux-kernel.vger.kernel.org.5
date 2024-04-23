Return-Path: <linux-kernel+bounces-154651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4698ADF1F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C7F2885EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE3C51C59;
	Tue, 23 Apr 2024 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0kV8ECDE"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16F03F9E8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859245; cv=none; b=Y3Qzy1kRF/Zdid+6Lxn/IrO6xP6kjb9a2u9oB3Fm09LssVZXmH/XRYHAvssX+G24uLbwx98kKHVb9mnZ0BmBPkMu2+Tyyt/zCnfAWOQgbiVnNvcTX4dkZoI0l+Adwa6cXY8NfFZVkx0lyc05ZAidMwaO4+pRgu5PNBo1uV/9IzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859245; c=relaxed/simple;
	bh=05/XDmuK+jsj20QMLtxmdhJ0PndQ9ntJ2/cwVmRK9Zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksOQaIv2+6LjKAZ+OnuOH1zIW/UvC6nRK9wExcyQ3pGj+yml/TtcclT2jqENDrPH4nTrHMsVHPhkytKOSZfMiGzxgIfOIoCD8TlTqTuwGWz5jF+DxpZBB/7zIwPDGl3FHvfn3krxBEo0r3ZPjZHLhvF9R4dbQG6/XpPe+g7N5ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0kV8ECDE; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-436ed871225so175451cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 01:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713859240; x=1714464040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kz0SAMMpLBCA9oc8+t40Nhfdl/379/nlp7qawf6C2vA=;
        b=0kV8ECDEf9q4k6Wqtn6tyM/zJSfOxzht+PK1GYHoCppJvcEQyeyjJ3E5thewmTvUtE
         zVqrOyWMZYCHF38HV9/Wi3JLD+qzSeueJYU76YFRMIfkx0W+epeIW+MjvZkzUqTucl82
         PV+3mI2GHRyftLqz9HPRwd9il36WnV6mvTJept0m0psP+E30TZgVzzqmO3lg6oUs6oLC
         JcPOJVmO1b6KQtzpi9A5opWEvtLemGGfSNNjw7Hp9MMASxRD3IHD7RXb8nX2rN0ouuji
         Dql+tx5ZVyAo0PiaT4V3VevBpJAaARhVkIF80d2kwECbZEw9UWSUAPP/gwWRBfxekq70
         pBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713859240; x=1714464040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kz0SAMMpLBCA9oc8+t40Nhfdl/379/nlp7qawf6C2vA=;
        b=uIOrxjrB9uFHt3MLgglLj1oboHWKr4lPwgd8UPPyhncpxQYgxfLcHwicSEVGXzuYQ9
         ePfUiYxYoYKezp0p6YPdznKjn1+ptCH4hy/1/Zg8kNP5RCJVP4ZxR/Oh4P1BAEeE+FJG
         sT3uUL7/rmDL2bUO+IBearfpC5kUzWBFgZKDzjwlhp82c/b4lM0S1xj3LqWZ6mIA3yjq
         kX8cPvQcraSMUvWCG9hO3ZORkzJWbdgUz5sWY9OfyuexE58lsbZKiGctScdda1iSZHcA
         bWOuHmcILLMODiwSE1TKbjrh1vDQArJo8eUHBBfi56ybCQS7LYIkQZo6xOnaNh29hmU2
         ak1g==
X-Forwarded-Encrypted: i=1; AJvYcCWV6XgJ364PsDpC5mBNx5rje6/ndo0Nu7lr3Zk6yod4PRmciwrq3WpDmDKQShuRADJcyGUcpkRDjMlXzXRSGmc0XN3czFFJ6Z8PTUQ4
X-Gm-Message-State: AOJu0Yy+OaoYT3SY7kb+mGvMn7MCbBs8gFUPiG+SzOcKVUSRmknEpyfr
	LiSrZ3yJfBKrOGY0v9qII2vgAEa+pJ2xo8pxgVlNIfyNDfwzPbh/0xjj+X+/W2YiocaSRYnTCll
	YKvW+rdN4MhrDWaG4EdvA3r443tHFEObywocu
X-Google-Smtp-Source: AGHT+IGWgEFzvLK9uPenYjUI4EUDCWkzSlbhZxXqwo2E6P6nifQrY8VUUV8e/q9WolN8SgJOaZSEQz3WJfwHwxD2Lds=
X-Received: by 2002:ac8:6edd:0:b0:437:c6c5:f30e with SMTP id
 f29-20020ac86edd000000b00437c6c5f30emr163820qtv.17.1713859239648; Tue, 23 Apr
 2024 01:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419132504.9488-1-wander@redhat.com> <20240419132504.9488-3-wander@redhat.com>
 <2024041919-unify-improve-d4a5@gregkh> <CAAq0SUnjc03N5kHgJ8vwk19BjzQr8DCRCokh09npmCs2mxxwXA@mail.gmail.com>
In-Reply-To: <CAAq0SUnjc03N5kHgJ8vwk19BjzQr8DCRCokh09npmCs2mxxwXA@mail.gmail.com>
From: David Gow <davidgow@google.com>
Date: Tue, 23 Apr 2024 16:00:25 +0800
Message-ID: <CABVgOSkC8iK52LW4-H8=Z4FQ7CdepgYHrw_e6f9k1PQRXH_pgA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] kunit: avoid memory leak on device register error
To: Wander Lairson Costa <wander@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <linux-kselftest@vger.kernel.org>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003245170616bef3f2"

--0000000000003245170616bef3f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Apr 2024 at 22:11, Wander Lairson Costa <wander@redhat.com> wrot=
e:
>
> On Fri, Apr 19, 2024 at 11:03=E2=80=AFAM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Apr 19, 2024 at 10:25:02AM -0300, Wander Lairson Costa wrote:
> > > If the device register fails, free the allocated memory before
> > > returning.
> > >
> > > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > > Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
> > > ---
> > >  lib/kunit/device.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/lib/kunit/device.c b/lib/kunit/device.c
> > > index 25c81ed465fb..d8c09dcb3e79 100644
> > > --- a/lib/kunit/device.c
> > > +++ b/lib/kunit/device.c
> > > @@ -131,6 +131,7 @@ static struct kunit_device *kunit_device_register=
_internal(struct kunit *test,
> > >       err =3D device_register(&kunit_dev->dev);
> > >       if (err) {
> > >               put_device(&kunit_dev->dev);
> > > +             kfree(kunit_dev);
> >
> > This still looks wrong, the release function for the device should free
> > the memory here, not this kfree, as the reference count in the embedded
> > 'struct device' handles the memory logic for the whole structure (if
> > not, then something is REALLY wrong...)
> >
> > You _do_ have a release function for the device, right?  If not, you
> > should be getting loud messages in the kernel log when releasing a
> > device here.
> >
>
> Ok, I got it. Yes, there is a release function. So this patch is
> wrong, ignore it. Should I send a v5 with only the other patch?
>

Thanks. Don't worry about sending a v5: just patch 1 of v4 is now in
the kunit branch:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/c=
ommit/?h=3Dkunit&id=3D63761ec5971ea47c1f2d7698f03e1c6ffb9fb22a

Cheers,
-- David

--0000000000003245170616bef3f2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
7xDrOPfX3COqq162RFg/MFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AK0lDd6/eSh3qHmXaw1YUfIFy07B25BEcTvWgOdla99gF1O7sOsdYaTz/DFkZI5ghjgaPJCovgla
mRMfNcxZCfoBtsB7mAS6iOYjuwFOZxi9cv6jhfiON6b89QWdMaPeDddg/F2Q0bxZ9Z2ZEBxyT34G
wlDp+1p6RAqlDpHifQJW16h5jWIIwYisvm5QyfxQEVc+XH1lt+taSzCfiBT0ZLgjB9Sg+zAo8ys6
5PHxFaT2a5Td/fj5yJ5hRSrqy/nj/hjT14w3/ZdX5uWg+cus6VjiiR/5qGSZRjHt8JoApD6t6/tg
ITv8ZEy6ByumbU23nkHTMOzzQSxczHkT+0q10/MxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAHS+TgZvH/tCq5FcDC0n9IwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIGSOBimVPPGSA0JuQ4FhjmzwIqB2amX7BakLNnO45pkbMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQyMzA4MDA0MFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBrGrNz
NiUjPznlQlhqCOvBDnjmFVzle1yTByv8m8xcmMpEYjRUKaituqRCRuAwtTojU5UCsf7KCEzmZnkQ
1N96xHQUdWs4TIAzcTl/ivKYTFiE1Tbhcb7zQZiFZXtLRwPSHV03RAHSua2Z++IyGMLwQgjzoWyJ
L/NgNHwunhgYjFPrX1yZCkilnSbWj6QdN+Y6V8bkIM2T7qChS/dCCDavNeiSYDuy6IjNvQpr8S4X
vGF2gloqDGZoNfFcWg9bdalUx+WPuXZaiJYBGXJct6bTPiUs8I2c2KD/jjYMOQj22j6hFEeTWFw1
EiymVjU1Mi3iewp9e1/5ln3S76rWFZsf
--0000000000003245170616bef3f2--

