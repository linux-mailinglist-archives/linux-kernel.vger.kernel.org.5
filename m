Return-Path: <linux-kernel+bounces-99827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 301AB878DF9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B41C1F21709
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77B7C2FD;
	Tue, 12 Mar 2024 04:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sY/T5RWB"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFB93A1C2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 04:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710219236; cv=none; b=iA2dVgRqwnnHtYczmip7Xzw2IPRdGGUyZ7YYqtZOtPkAesAsB9mM44ULp66CAIKX7sp29sOHt9zRkRc6A7M4oF6aJ96dJncMzodwMPJbXDflrCJcplLExixxmKaiIv1/XU6D/w4PFYZqUHe7EVBEw6BZr1kCIHRHzGcvymXqkUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710219236; c=relaxed/simple;
	bh=MGFuZwBwiuiuFNujmelpdeTzQUrEoQl7emQ6fErY7hQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rH8g2pt94L7CotAOIype2i8PhaFJQjh1KfJoodghgWfxw6b84ofaXfH6fotucKzZCOo3Bvy5a28i+pg8OLUdfYTrynXLnsdnFw9flDER6+Tegq3DXDfG4yQaPohvaTIt8zAxDUGSgQHR+CVD4K6AV3GoJHEHtGpWLQ13k+7uovg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sY/T5RWB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412d84ffbfaso45495e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 21:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710219232; x=1710824032; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aIpbeEL2FtxAvDMJCVRnniAL8qg1AA09D+6rAveachc=;
        b=sY/T5RWBYKtrDIi9uPYBtDgCH46g1DBjhY+504dzsjbCaiP33bWJdCuCVbufkRZxTa
         7nSAYaukqijTlcjoOU3bmvSPjZLCxSfHewbtJ8WZeRyVx+CAAlpRfYc7+Mo1mOSCXMA3
         FN3IcW6mglwH7iwGmkoE+k3HmvM5aM1MZgAox15zU5lf3HP1EEYBFp6Jb1U8vqL7kzM5
         alVwcluuGbju76Vn0gIy/PaAYy/0EAYsOJAwanReDRDji7FL/VThzobUpf2b/DGMS6uL
         ynMz4icZbSwsev4yYzan5beDa4/gR4kQg4/tC5PRe1yTKcagucdB2HXEmN5s3TUlR3Fv
         UDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710219232; x=1710824032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIpbeEL2FtxAvDMJCVRnniAL8qg1AA09D+6rAveachc=;
        b=gyS6xtcmt3IpqXs+Va7Av88+CCeIJtJrtyuS8wQYPDMg/RPFswu+FTskBVvnhPrxM6
         8uaOMS+4af05jThoYerRI/HgcSU7zSzB3x+VeTMaqr2xjsks+NEdAfe/vCzW7PQHFELI
         +Nxx2Bnjoh4t13jzI+ENCMrJMbuVlX2hKUTImA3PyEdzLLsiw9Imwvv9RHt+6S3908WQ
         Yukk4fuUhenduAQ8JzhNjQAcncM01gRqEMabGL62ZoKziPUCeG7+Xn2Mvk5VFjAUhDSf
         6tZW1Wtydfl+ISDfh3p8ADVxFqRdPVl+IeKK9noqBzkvw6s9K3IKKWvL57oACGhYJhaV
         N4Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVPDr7ZQAbC7qUaFI5dWHL6/pcq0FZx7jHNQyha3lAkcPwWAaLmvcny5w16b3HIc9RNTjBGI/PfLsx4WF5aLkATvs2e1yYG0q5venPM
X-Gm-Message-State: AOJu0Yz4QgZScy22ImjO6nqS9qqkBq/BamyEKDpc+eqeZcruJVrjqN0u
	EhwqpdM1hXMmrjxiW9MC/LOt3L8QMBmpB20+IOYVG7IkWXsKZnuO2SIphqqK5cSE8iDUK0OXUAy
	lgP25DWphWuc1D5OmNOc7ZjOSPR+JyYktsR3G
X-Google-Smtp-Source: AGHT+IH6+m5w8TGGzuwdUpiEXcJqv00NfGEP/ve9y5SjfQ9XDC9z4o16zHLoCUxftJDTzGASqpMs5DoDZfsu+kGAcvM=
X-Received: by 2002:a05:600c:a007:b0:413:4d2c:91de with SMTP id
 jg7-20020a05600ca00700b004134d2c91demr12632wmb.0.1710219231893; Mon, 11 Mar
 2024 21:53:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301194037.532117-1-mic@digikod.net> <20240301194037.532117-4-mic@digikod.net>
In-Reply-To: <20240301194037.532117-4-mic@digikod.net>
From: David Gow <davidgow@google.com>
Date: Tue, 12 Mar 2024 12:53:40 +0800
Message-ID: <CABVgOSkwfis8rUHFZQ41NGEWritwZGf4+4704FzBREb2Y-G3Zw@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] kunit: Fix timeout message
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Brendan Higgins <brendanhiggins@google.com>, Kees Cook <keescook@chromium.org>, 
	Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, James Morris <jamorris@linux.microsoft.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marco Pagani <marpagan@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Thara Gopinath <tgopinath@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-um@lists.infradead.org, x86@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d2700d06136f71ac"

--000000000000d2700d06136f71ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2 Mar 2024 at 03:40, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wro=
te:
>
> The exit code is always checked, so let's properly handle the -ETIMEDOUT
> error code.
>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240301194037.532117-4-mic@digikod.net
> ---

This looks good to me. It might make sense to use a switch statement
rather than a change of else-ifs if we end up handling more errors in
the future, but this is fine for now.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>
> Changes since v1:
> * Added Kees's Reviewed-by.
> ---
>  lib/kunit/try-catch.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index 73f5007f20ea..cab8b24b5d5a 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -79,7 +79,6 @@ void kunit_try_catch_run(struct kunit_try_catch *try_ca=
tch, void *context)
>         time_remaining =3D wait_for_completion_timeout(&try_completion,
>                                                      kunit_test_timeout()=
);
>         if (time_remaining =3D=3D 0) {
> -               kunit_err(test, "try timed out\n");
>                 try_catch->try_result =3D -ETIMEDOUT;
>                 kthread_stop(task_struct);
>         }
> @@ -94,6 +93,8 @@ void kunit_try_catch_run(struct kunit_try_catch *try_ca=
tch, void *context)
>                 try_catch->try_result =3D 0;
>         else if (exit_code =3D=3D -EINTR)
>                 kunit_err(test, "wake_up_process() was never called\n");
> +       else if (exit_code =3D=3D -ETIMEDOUT)
> +               kunit_err(test, "try timed out\n");
>         else if (exit_code)
>                 kunit_err(test, "Unknown error: %d\n", exit_code);
>
> --
> 2.44.0
>

--000000000000d2700d06136f71ac
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
hvcNAQkEMSIEIIRwYpLx+UFgLCJwnaN23WnpzIUS6mZGqq9hDDaszYkwMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMxMjA0NTM1MlowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAtLDUz
GSm8/FzLAdaZmcdDM5iXD38aJNkLoFKluOH5QTlfL+y0wIfpUNZnKn8umG9UTtQSRq8+AWbSsv77
5Ub71Y1LS0zS/sQUsAm7JFFfX5ssbQmLfsT12ZraDe63s2nK9eG2MJLmjkLXvdT6+wkxQ3xvuzNk
skEvt5hRoESacPBfeQlJZrYcDyQWuPHiXytxsj+U6AwR21DztlpKaoh0CZAK5OWLi2+3++ZNIRVF
4W7CbKpJdbNi+udW42lPRnw2EyI4zCcsb7FzZITeowt8CPHa6KQWp/mXO0UcWUbHk6vqJUjefo4g
/r6ZLy9d5v7uhJy4gc/99uY/pmHvqpFw
--000000000000d2700d06136f71ac--

