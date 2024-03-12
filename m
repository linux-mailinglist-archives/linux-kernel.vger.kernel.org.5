Return-Path: <linux-kernel+bounces-99828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E692B878DFC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13DF91C21526
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05797D310;
	Tue, 12 Mar 2024 04:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xi9lWGYn"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA41B67F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 04:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710219288; cv=none; b=a10w7H1NdFKmNcu9YWkMrQdlFCffiqkQfTaTCKp/yCNwz8DGB7Ox5HvMIUgF9LQnU5LtJrzJXIpou7+TfeZaUXX8CLuGe61/p2FDigGSX0MG8nRqOk0Sa+tj3+BZNoZeNjY38qX7iMnb2tIRG3HkgDbAN8Z7uBd9Imnyzj5TC/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710219288; c=relaxed/simple;
	bh=va3+4SuN4m0QaE4gXvII4HrSkok0BzxMc6FYTwhi8No=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLnf6xll0ZbvaN/8Q3UEXvBcACPpMpmDjAWZVck6Zv/rdHwqNBtZdAWjPnWvWjE9eFkMs9I294X/rMz2uwlcGbKeaDKDEsyq9NL0bKrBcPitA1oBQ6Q3i58AiXLNjZZ4wRIay3l9qaPhd19PPf1D4AicJMfbLFzBAG2nROPAArI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xi9lWGYn; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso3749a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 21:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710219284; x=1710824084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2ktp0cw7qhM4uTbqS0uF+YCL5AGCW3l4rlYP7tw1r+U=;
        b=xi9lWGYnw7dislAB+q4GL7TntPquxDUgdkfo8qGzn31FFZuTFg5wmUCP5K9RZAyk5C
         zJgwX5TPoH29idVDGfZcSURXExKecG8THFde8+7oZnJvu7HMPHLo6xzvdbcEsoxjpfW8
         4pBcFjE/pZYqzy7ZqKrKzlQ6zu/EgVRJaEDE/p5C70+fZ5+w8junSy4wc8yZ4KRL7e9B
         miyuJUfDwCsRHdeTg42DfdNvj1TYrbj43/EBZhwkvBbGmK6bC5/wlzRNAvrkgpLRNziJ
         NRnqVnrSqvQPcUL5+RNVQqwe31wW+C1QGG3WL5aVOP/xvLsvjisSuKYMCh414t2WzdJG
         3zsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710219284; x=1710824084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ktp0cw7qhM4uTbqS0uF+YCL5AGCW3l4rlYP7tw1r+U=;
        b=SsntfUA8xmWRXc5ydh4OVISwPvwYU5SAioPYA0Ddk87IZAdODHczlKXWpetFG6fE5R
         oCskVTy99S+MzPVT5wr2M3EMfpSZT5ep2Fof7ADCxVSNWra0Om5aSa1X/mgDYelLvVy8
         PAru9jXCnOoM0J1WDX72Pj+N0mGJSPW8IbLUsXk8vpE/pwheMrAi1V5nyO0IsgqL89M/
         XQxohMWJV3jJt4qhkd/iklKIJj2LNSVeq1R1BfOPjoLYb6z8i52DfJv8nKN9JrLpgjYq
         4VvOMnVETxeXAJDh3oz4dyoOc0cbgVNwQ+OHudhKOJCOG7cUd/oJsl+GNGbGq4l/QJso
         Nt+w==
X-Forwarded-Encrypted: i=1; AJvYcCXb3t/JaA8UTz/stHKnlKuyTr8hkbSn+BpAAj/1AmO/ETMxClNqGCIwvKmjpIeGGjD+6mloFPBO0aXvxRe7GZaTeWfYNjFXw2gA42YX
X-Gm-Message-State: AOJu0YxKovPWNgNUnuz9sT49PWzkjIvElHxH8DzcvOVxaeNmMMmobOC7
	FY8b9xmArr2qCRcpDLgZSQGZla2Q/vuZ2HN5zKFSeVHbH5xL2L3Nn0xefnLMrLENf6XnA7h0+ER
	ct9yZg432qJaDuy0jTxxMJ2GsZaJ17GlunZUs
X-Google-Smtp-Source: AGHT+IHMvpeCp94H9+CQpRLnJE1D5gDLC9RFj181IDRLKbMYyc3PKjlVy1+AZvJ+pPL6yiwer/hG6jBTxxW66UEzA90=
X-Received: by 2002:a05:6402:8c5:b0:568:7767:14fd with SMTP id
 d5-20020a05640208c500b00568776714fdmr12186edz.7.1710219283993; Mon, 11 Mar
 2024 21:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301194037.532117-1-mic@digikod.net> <20240301194037.532117-6-mic@digikod.net>
In-Reply-To: <20240301194037.532117-6-mic@digikod.net>
From: David Gow <davidgow@google.com>
Date: Tue, 12 Mar 2024 12:54:32 +0800
Message-ID: <CABVgOS=AkKYjEuzrTGEh_AwMYZ0kmYz-uXsNKW--ExSCae6pVw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] kunit: Fix KUNIT_SUCCESS() calls in iov_iter tests
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
	boundary="000000000000f0536006136f74c2"

--000000000000f0536006136f74c2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2 Mar 2024 at 03:40, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wro=
te:
>
> Fix KUNIT_SUCCESS() calls to pass a test argument.
>
> This is a no-op for now because this macro does nothing, but it will be
> required for the next commit.
>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240301194037.532117-6-mic@digikod.net
> ---

This is a pretty straightforward fix.

I'm actually a bit surprised how many tests were actually using
KUNIT_SUCCEEDED().

Reviewed-by: David Gow <davidgow@google.com>

Thanks,
-- David


-- David


>
> Changes since v1:
> * Added Kees's Reviewed-by.
> ---
>  lib/kunit_iov_iter.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
> index 859b67c4d697..27e0c8ee71d8 100644
> --- a/lib/kunit_iov_iter.c
> +++ b/lib/kunit_iov_iter.c
> @@ -139,7 +139,7 @@ static void __init iov_kunit_copy_to_kvec(struct kuni=
t *test)
>                         return;
>         }
>
> -       KUNIT_SUCCEED();
> +       KUNIT_SUCCEED(test);
>  }
>
>  /*
> @@ -194,7 +194,7 @@ static void __init iov_kunit_copy_from_kvec(struct ku=
nit *test)
>                         return;
>         }
>
> -       KUNIT_SUCCEED();
> +       KUNIT_SUCCEED(test);
>  }
>
>  struct bvec_test_range {
> @@ -302,7 +302,7 @@ static void __init iov_kunit_copy_to_bvec(struct kuni=
t *test)
>                         return;
>         }
>
> -       KUNIT_SUCCEED();
> +       KUNIT_SUCCEED(test);
>  }
>
>  /*
> @@ -359,7 +359,7 @@ static void __init iov_kunit_copy_from_bvec(struct ku=
nit *test)
>                         return;
>         }
>
> -       KUNIT_SUCCEED();
> +       KUNIT_SUCCEED(test);
>  }
>
>  static void iov_kunit_destroy_xarray(void *data)
> @@ -453,7 +453,7 @@ static void __init iov_kunit_copy_to_xarray(struct ku=
nit *test)
>                         return;
>         }
>
> -       KUNIT_SUCCEED();
> +       KUNIT_SUCCEED(test);
>  }
>
>  /*
> @@ -516,7 +516,7 @@ static void __init iov_kunit_copy_from_xarray(struct =
kunit *test)
>                         return;
>         }
>
> -       KUNIT_SUCCEED();
> +       KUNIT_SUCCEED(test);
>  }
>
>  /*
> @@ -596,7 +596,7 @@ static void __init iov_kunit_extract_pages_kvec(struc=
t kunit *test)
>  stop:
>         KUNIT_EXPECT_EQ(test, size, 0);
>         KUNIT_EXPECT_EQ(test, iter.count, 0);
> -       KUNIT_SUCCEED();
> +       KUNIT_SUCCEED(test);
>  }
>
>  /*
> @@ -674,7 +674,7 @@ static void __init iov_kunit_extract_pages_bvec(struc=
t kunit *test)
>  stop:
>         KUNIT_EXPECT_EQ(test, size, 0);
>         KUNIT_EXPECT_EQ(test, iter.count, 0);
> -       KUNIT_SUCCEED();
> +       KUNIT_SUCCEED(test);
>  }
>
>  /*
> @@ -753,7 +753,7 @@ static void __init iov_kunit_extract_pages_xarray(str=
uct kunit *test)
>         }
>
>  stop:
> -       KUNIT_SUCCEED();
> +       KUNIT_SUCCEED(test);
>  }
>
>  static struct kunit_case __refdata iov_kunit_cases[] =3D {
> --
> 2.44.0
>

--000000000000f0536006136f74c2
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
hvcNAQkEMSIEIAwntcAOUrRJsRZBbycG7e3AU2cSN+1k0xuF7otav2ZJMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMxMjA0NTQ0NFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC0xxcO
XomfL4QL28VwieN1Zwu6fNNGL2lKjrw5Ic+ujk7USwQ8l44k8mf3ALzeWRTC+6XIUgALpIBBgcY7
zxL8qJ4S88QxYxLaR1OXTbvCHLzLTK+/otuiVhDObaPmLJfwjXLJdOuWkMpdUXSeHq3nBTtfCPCK
SzuXKTwChdfVEtfYHnoO8hAkeOrvQkYMbKF4P9XfcDbwjwOWc4+im09Dt0TsrgEer7zhKgZTfOJk
JUzlCIlFbO2oMwSBWLhKYSljBy0orUOM4yj497a18ncWzsNLHWUW57bQA88lvPrcN3brR1ZWd+Xn
1q+/SpjDK4YFoH/sNKy+M/DAo1VeBFFR
--000000000000f0536006136f74c2--

