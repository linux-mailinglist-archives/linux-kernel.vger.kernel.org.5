Return-Path: <linux-kernel+bounces-151004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2F18AA7D6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBB71C2248D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 04:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C201EC8FF;
	Fri, 19 Apr 2024 04:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2pnXu4VI"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FF59473
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 04:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713502738; cv=none; b=KvZh4J8PYERI+Gnx1UciZCRBfyqc1PbzEJiV1f2sPFyCAY9/vNK+ZY+ksP24ZRTUYWbMNM/LdcPt3O3bQ3HObdIevBdZhuW1ZsttVcov1v1aGdWsHzrDcG2G5jCN6bR6U+4+3ryToruLRWPV496joJ7xvVmJ0dEGEvmJHFHTiFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713502738; c=relaxed/simple;
	bh=vNqXX2D7Vr+IvwztTmcwH0mnmeewVpCFwFCZab3LTYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxD0aAoOd4gGu1Fx+ne5OVVqfIcVrPEQyz44noV6eFm1VL9fivEgLhi/B8aoBX4gBpVcwrhU57ZP8eIJ9IxLB9IHzv+3x64VQ08ubeu+qvTQXRgyuOEIO2D37bdbaz7P05yTp/ASch2gLvS+C+7qCG8fu7ZGuya9+DXFwV3vxDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2pnXu4VI; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-434b5abbb0dso141151cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 21:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713502735; x=1714107535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V14gg60avmglAS8NWa47xC5yP98LYNMcHM557r28G6g=;
        b=2pnXu4VI/Eu0CNpyY8EbBjpkzlWFXgVVchNJZGu/N69WfyUfCoEwK1iTfdPPNtwxDI
         igykzrNYPwtz4OagcOXCHnevmj/VqTpe72tyjQ7K6j7WkofHUXzzvVZsoHsYAcrODINq
         Zu18/xZIfTMX15ZfQ7vRVoq/YD/WE+RHyAVaQrZKVPmncTikyzCLpzs74riNVtpukATE
         pWf5X2ycx3+FWhayST3+Zs6hC5QR1nIPb18AYyyKlL6h8mbBljpUszdCpHbnizvUOSHA
         0cHr6TqDhs5EvK42ElbkBydPPTzhdG0W1fP5YTtLqGi7KUhigciRv0i1kaVykfrzlfM5
         VhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713502735; x=1714107535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V14gg60avmglAS8NWa47xC5yP98LYNMcHM557r28G6g=;
        b=fDkOwz+8td5Nx+HiGO/QKy9f3gsNOfdZoTuqq8WLHnmbPtJTeMKwOF7hfFzyBK+mnq
         LsoRyxLXgyuhAib0HsE37Q1nT0lp+B+bcaVRAylkaaYOa4kdM5SbXvi+C6fILDlpkOr4
         pnVbqCzLmFXPoW9XDkWTvFjRN9qTkjnHfxOE4dMdZ0vW5X+CLVwhFR76923mX1XmkNrn
         KVRRz3vCPtMitGeKaEPdePOPp8B6b0ezMN8ZXRVNkDLob3Kyj/+PklMUEnsc/7SgCYvK
         Z07SQ0yMwbC+oeqgXVBIiu/f/1hMKwKyFw4aLTq86rFskon+j/DcfQUgCvzsm4lViK7A
         4UPA==
X-Forwarded-Encrypted: i=1; AJvYcCXTV6XrNlxrsh7xiofyRXsBKeBHCGBZdp4Z97jO0aSlHwRzGa2iceb0BCZOoSz8atQyVVsZshvPJZ8l7CIH4vFKclkvLOOPMRN1H2rR
X-Gm-Message-State: AOJu0YwBjm4tjkFMEq+zefSe8seaEZvbnyqmUExG4vvohdj05vXfGii9
	nb6GqhEFIfykdAJHfUCjroJyJ790PmiNRBfpU5LKzvhvWJDhp4h7jcGb0pOpdrsCBkPZhwqKxlJ
	Kql8zhVKoXwYT3RgE9rBCWd6tzACqVZ09D8Iv
X-Google-Smtp-Source: AGHT+IEtA4+CpARfB5vsmh3tcDAFtCecqb318nZ1xGMNN45xDP9fukg8WpYQrN3dnZW/45r+OVJ5eg1lH1FLEzj/8fM=
X-Received: by 2002:a05:622a:181e:b0:434:3688:f093 with SMTP id
 t30-20020a05622a181e00b004343688f093mr100837qtc.27.1713502734921; Thu, 18 Apr
 2024 21:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418210236.194190-1-wander@redhat.com> <20240418210236.194190-3-wander@redhat.com>
In-Reply-To: <20240418210236.194190-3-wander@redhat.com>
From: David Gow <davidgow@google.com>
Date: Fri, 19 Apr 2024 12:58:44 +0800
Message-ID: <CABVgOSncx1eS_8EWsNkoDOj+TaNsaW8MpjG8XaFY2Q8JXo+oqQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kunit: avoid memory leak on device register error
To: Wander Lairson Costa <wander@redhat.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Maxime Ripard <mripard@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <linux-kselftest@vger.kernel.org>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000dd0c8f06166bf146"

--000000000000dd0c8f06166bf146
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Apr 2024 at 05:02, Wander Lairson Costa <wander@redhat.com> wrote:
>
> If the device register fails, free the allocated memory before
> returning.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
> ---

Thanks.

I'm not sure this is correct, though... Shouldn't put_device() free this for us?

The documentation for device_register() says to never free a device
after device_register() has been called, even if it fails:
https://docs.kernel.org/driver-api/infrastructure.html#c.device_register

Or am I missing something?

Cheers,
-- David


>  lib/kunit/device.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/lib/kunit/device.c b/lib/kunit/device.c
> index 25c81ed465fb..bc2e2032e505 100644
> --- a/lib/kunit/device.c
> +++ b/lib/kunit/device.c
> @@ -119,10 +119,8 @@ static struct kunit_device *kunit_device_register_internal(struct kunit *test,
>         kunit_dev->owner = test;
>
>         err = dev_set_name(&kunit_dev->dev, "%s.%s", test->name, name);
> -       if (err) {
> -               kfree(kunit_dev);
> -               return ERR_PTR(err);
> -       }
> +       if (err)
> +               goto error;
>
>         kunit_dev->dev.release = kunit_device_release;
>         kunit_dev->dev.bus = &kunit_bus_type;
> @@ -131,7 +129,7 @@ static struct kunit_device *kunit_device_register_internal(struct kunit *test,
>         err = device_register(&kunit_dev->dev);
>         if (err) {
>                 put_device(&kunit_dev->dev);
> -               return ERR_PTR(err);
> +               goto error;
>         }
>
>         kunit_dev->dev.dma_mask = &kunit_dev->dev.coherent_dma_mask;
> @@ -140,6 +138,9 @@ static struct kunit_device *kunit_device_register_internal(struct kunit *test,
>         kunit_add_action(test, device_unregister_wrapper, &kunit_dev->dev);
>
>         return kunit_dev;
> +error:
> +       kfree(kunit_dev);
> +       return ERR_PTR(err);
>  }
>
>  /*
> --
> 2.44.0
>

--000000000000dd0c8f06166bf146
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
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBOMwggPLoAMCAQICEAHS+TgZvH/tCq5FcDC0
n9IwDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yNDAxMDcx
MDQ5MDJaFw0yNDA3MDUxMDQ5MDJaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDY2jJMFqnyVx9tBZhkuJguTnM4nHJI
ZGdQAt5hic4KMUR2KbYKHuTQpTNJz6gZ54lsH26D/RS1fawr64fewddmUIPOuRxaecSFexpzGf3J
Igkjzu54wULNQzFLp1SdF+mPjBSrcULSHBgrsFJqilQcudqXr6wMQsdRHyaEr3orDL9QFYBegYec
fn7dqwoXKByjhyvs/juYwxoeAiLNR2hGWt4+URursrD4DJXaf13j/c4N+dTMLO3eCwykTBDufzyC
t6G+O3dSXDzZ2OarW/miZvN/y+QD2ZRe+wl39x2HMo3Fc6Dhz2IWawh7E8p2FvbFSosBxRZyJH38
84Qr8NSHAgMBAAGjggHfMIIB2zAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFC+LS03D
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
hvcNAQkEMSIEIL56kAejH7/ZrhvsQs2CvaNGqDJhYdmbj9mUIp6iiBBdMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQxOTA0NTg1NVowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCMlSIl
qvIYPGSTeWbOGP9HioRXuIlV1MeLtwr9/wizSBDP5NK6mFFQP21ln8mti18jst1QbLlyRi/DQFMx
dcWhMDjMOUyeWiiYtLC6IpBIGj6ZgjspyyowioY9ETaJvH70iAZcbLCPE8G9pnckSzPrKZAtkMEr
EnoxKyPSCLpC+4hPXEvvZiURVOG6u+8BIWw1YCCg46xPXBpqfov1xDOEFTNd5p4kaSG5su6HT6px
oS3s8niNFKaOmGiOrqncl6xjCOGySLNLXOQbJ6xv/sH6O9oJePQhA0RyqwhvzxqrEErGF5T0ZNLW
xOarLOSdri8JNsHw0zm/VTYiJ34OehQ6
--000000000000dd0c8f06166bf146--

