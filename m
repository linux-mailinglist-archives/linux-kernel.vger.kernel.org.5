Return-Path: <linux-kernel+bounces-141868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1628A2469
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7DB284AC3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0AA175AE;
	Fri, 12 Apr 2024 03:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QIoxasWZ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D574C96
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712892403; cv=none; b=ZHpmQtqmdg0kM/S3DgwAI3A31h2DAxzY8fcJVWlsyHbamlxH9nD353X2qzP4qWMvwuqyFTYtVuMl7PZn62mDtqznTWjnL0kHQ5mya+C8o6zlX2VuIlgK3Fm6d0jAjr/CdB8M9+CzWCUbxbaa9Zu9tv8GnUO3d5WEi84gXOETpSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712892403; c=relaxed/simple;
	bh=4M3FNnyZyVDf4uokgn139KIGzFvYPfL9yLVntAJebXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLBHpXGGyna5lTP2TFUeClhXgKptuifI1Uj6j1AWibY7UULxkjwhqRUCgg2ANIf6JuXVbWW9uJMAmQJL7QSu003DNUdHjMPmaJDYiBGIuXNaNN8+Db0UU9z4FKDkVW5lJhfokPv2UF6khBeX9z/z//8/vS/VN0GPT6nR5MCmR30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QIoxasWZ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so4059a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 20:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712892400; x=1713497200; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PNbfL6DEGT9XbfXMB1UspIsW0sHjjcVZ9sUkOisAfQo=;
        b=QIoxasWZ4Q2Pjsox22tKDbcjVU/pnvi4p/yZFpTPqLtC+nVmApi8coH203JOMPbmki
         Chf2uxyLODOhHWbwyNuq+EAHD5CZmIdlFzJPF07i8RWwRUs2tsBMuIVKnFcc8BiPP6YY
         V+F2sa1Rox62NAD6X2uc+FuQeb6YvdPG6Y3PJk8ywGY0RxucDkHvIt3Eg0VTfn9z2pCV
         HuvG7rlt/G3n1O6jLfrbSV8/fVYDf9VWl7fS8kqAA40Gu3C9oDNzAV63AuxgwCWPXtQ+
         rWn7DPRCLDTNaWxRIYaT1bdyXWUU82AHEbW95BFfz66us43wqEQbnG/FU1TMcXNBArot
         XlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712892400; x=1713497200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PNbfL6DEGT9XbfXMB1UspIsW0sHjjcVZ9sUkOisAfQo=;
        b=RIYYwHbYGyUN6eB/VifLvFDX1htZqBztEI/Fe6AvtdGDIXI2qUV1grNB5Nz9U92a+l
         lFOfRSMz0blmz/9nqeGv/coNmHY9wrvl75e0fjESFcOq8Kfz803e45QGF9KPlAU2roa1
         cvWY+Hm7tvjrL7Hs5PUzEEkj42ohTdgzWpQ/wl+VHWrH/XT7wJLlouhumBbMgV1uqWWL
         T2LvtD3vWhVFP0N8/mPil4IJPStzBXizPxjeHmNa606k+9hKSjqhrLd8RA/WXTyyvLJD
         gQM4rcqLLjRAaKnNIqz8tXaanm3Y9p2sY5iLtPyMyj0Rm1qfZmOU18Uis4VNNvbTrGAX
         pyjA==
X-Forwarded-Encrypted: i=1; AJvYcCXpgg1pBi3R96ae57y2o+NPRINOVyvb0XM2whs/PCrAfJjg8NJBNjtvkNfU7w70Q/Yal22YMLxGT4I9So2XZvJp1FdxerkEUNXdvpxm
X-Gm-Message-State: AOJu0YxtbB8rO+Rp5YBH0ddeCT/qcrhAUIbLFnQZW8ycj9x8eV9wjwRQ
	u3OrLXuRQSKHgjr65CAQQCEUZeo3xI7By9FIBITAZ8fnkITHQAbdE6v4j05r8H75QEjSniPDjoJ
	niVOJNNTzTIqkMS0MYCqkOr4dE95jRol9P2f+
X-Google-Smtp-Source: AGHT+IEieLJ2WFk4mg6HPorqABkSptYJZ6XwgW7gqqpUeTeWs/vkAHh7tXSe5wEd29+rzEFa3jXgyN54Dmm9ZUgavUY=
X-Received: by 2002:aa7:d6d0:0:b0:56e:85ba:cab0 with SMTP id
 x16-20020aa7d6d0000000b0056e85bacab0mr46242edr.7.1712892400059; Thu, 11 Apr
 2024 20:26:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410102710.35911-1-naresh.kamboju@linaro.org>
 <20240410152307.GA25111@willie-the-truck> <CABVgOSmJX=scCGZ7FWafpKB8CdQD17Uh5MuTeoFx2BhGC0DMSw@mail.gmail.com>
 <CA+G9fYuuLXnVuc2fqy_-EY3QBiUxroU9uw74vZ2i08qW=-q1tQ@mail.gmail.com>
 <CA+G9fYt6U4YzYGvYWxDVvUVKNc0pgVYiGafZ5_OSEf=5r1=YYA@mail.gmail.com>
 <f2d02e35-185e-44d1-9b58-1034336e2e0d@moroto.mountain> <fd604ae0-5630-4745-acf2-1e51c69cf0c0@roeck-us.net>
In-Reply-To: <fd604ae0-5630-4745-acf2-1e51c69cf0c0@roeck-us.net>
From: David Gow <davidgow@google.com>
Date: Fri, 12 Apr 2024 11:26:28 +0800
Message-ID: <CABVgOSmfyvw6Bb1SKkBr7EmQ=+rJ7pJYenG4vmwqKrCQdf87GQ@mail.gmail.com>
Subject: Re: BUG: KASAN: null-ptr-deref in _raw_spin_lock_irq next-20240410
To: Guenter Roeck <linux@roeck-us.net>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Will Deacon <will@kernel.org>, mic@digikod.net, keescook@chromium.org, rmoar@google.com, 
	lkft-triage@lists.linaro.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	longman@redhat.com, boqun.feng@gmail.com, anders.roxell@linaro.org, 
	arnd@arndb.de, Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000011e2df0615ddd775"

--00000000000011e2df0615ddd775
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Apr 2024 at 23:05, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Apr 11, 2024 at 06:00:25PM +0300, Dan Carpenter wrote:
> > On Thu, Apr 11, 2024 at 08:20:55PM +0530, Naresh Kamboju wrote:
> > >
> > > I use to notice kernel panic while running kunit tests
> > > now I have noticed this
> > >
> > > Unable to handle kernel paging request at virtual address
> > > KASAN: null-ptr-deref in range
> > > pc : kunit_test_null_dereference (lib/kunit/kunit-test.c:119)
> > > lr : kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c:31)
> > >
> > > The kunit tests run to completion and the system is stable.
> > > Kernel did not panic.
> > >
> >
> > [ Snip ]
> >
> > > <0>[   76.808597] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> > > <4>[   76.809876] Modules linked in:
> > > <4>[   76.812055] CPU: 1 PID: 567 Comm: kunit_try_catch Tainted: G
> > > B            N 6.9.0-rc3-next-20240410 #1
> > > <4>[   76.812987] Hardware name: linux,dummy-virt (DT)
> > > <4>[   76.814123] pstate: 12400009 (nzcV daif +PAN -UAO +TCO -DIT
> > > -SSBS BTYPE=--)
> > > <4>[ 76.814947] pc : kunit_test_null_dereference (lib/kunit/kunit-test.c:119)
> >                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > This is a new intentional NULL dereferencer that was added yesterday.
> >
> > Maybe these should have a big printk, "Intentional NULL dereference
> > coming up!\n".
> >
>
> Can the backtrace be suppressed, similar to the warnings suppression I am
> working on ?
>

I'd like to do that going forward. Of course, this isn't a warning, so
it doesn't work as-is (and it'd be harder to pass things like the
function name through), but it seems like a worthwhile feature to have
going forward.
We did have some similar stuff for trapping KASAN errors as a part of
the KASAN tests a while ago: that's also something to look at.

I have been playing with the warning suppression with the fortify
test, and that seems to be working well.

Cheers,
-- David

--00000000000011e2df0615ddd775
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
hvcNAQkEMSIEIGpJ1SoOeXy1AKKeFMyiYiq4bHVPexaKJ+fyRXU+ysDuMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQxMjAzMjY0MFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQByeWG7
5MKLDxnak2qj5kFcFnWS+04Pq3FmnTpN5SV/bIBoFLRlMRk6FxDvhKbPrZZ7dHrvj18DJr+jCa3b
OXuIBPZvzR2B9mt3bALrhmP0OqWM9Yp019mhcObmq20MjuIJ0ZDWGoAblKlHz3+XAo+A2pct7FZX
+fSKwR8EgRcW+xkpRmv1TRsSG6NQ1X2u2CIlM6stI/i4Brqa3hpxklGkkmXthZ2ULcM05ZEmC0J7
NXHVcGll/iUYMOgPsK4lmzTAEdsgrmlXQpk8h8Gfm4s25uUrBKUOTxYgnN3L9iWOXU8nrr8wR+9z
PQmwAAiVJVj07hl/I0gRTmge98PqB2ym
--00000000000011e2df0615ddd775--

