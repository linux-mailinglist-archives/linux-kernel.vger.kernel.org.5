Return-Path: <linux-kernel+bounces-99829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF34878E00
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A3B8B21CD9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE28510A12;
	Tue, 12 Mar 2024 04:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0G4GNL0W"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4955C13C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 04:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710219302; cv=none; b=pgjrW/Apyu7+0sqax8RMbgg2V2Ns9g4BlSam4JddxwwX9aaOme8NIMRvIi8b9qDpH10JKBBRRFiLjxNzUya4yvC3oNHLJTN30SKWzVoav5JxSfFNslmLi1OSaVJDW/NmAQjgBfQkHX0VeWdTqqEwil9y1113W3KGqldoqhNyUqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710219302; c=relaxed/simple;
	bh=snenZZ5jBwQQderdgd31WNkwFpJddg8PqXggiBzZER4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hh1OoQfbeMF8yU9+8+S4pbsrhapHQgVUXGHnfeg9vojtQCASYx3b3/mp7p8C85YkMy8oakb009NokMkfOW54rfjwwZPRXDQM58SDnO/IXxo9uIwgVF1/90sfeMQi+EoLl5BgB7KpFVB3GlekFxHsIDxccFjclPwrdLMSK11QajM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0G4GNL0W; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5682df7917eso10403a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 21:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710219299; x=1710824099; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cVIEwnVVaZEZDfNobRnuDbV5MLdgn7gFmL1tcNqDano=;
        b=0G4GNL0WJjEEPjWN5UokJPIxPNSjYtOlDvMUiMgeXq2Xsoz6Ndfn1cVpHxDWhKETaQ
         rJ2ysrv4Kqq+7DSl3N+ho9/DqMvdXBbGlPWwrd11ihx0NqpGDC67MlwoA1OO5gryf+0x
         2ZjB1IeeYEbSJY8E8ZPDrpOL6Rn3jETMzXRHl237v6ybSLZkahTq8V+PksVxNSnb4pTF
         HfAsD6a9P95If1WGZ2Y4Coo2YxkIPsuQe6yntlsdHeMNpPEOSMuneqdBziw2UVJ1+nd6
         VKNuzb2rxlrj53QNAzYSwe5r6waD+v3huZRv2ChmtZIsRHdvpw7mO0TSWVo5j5Cw6ClM
         PKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710219299; x=1710824099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cVIEwnVVaZEZDfNobRnuDbV5MLdgn7gFmL1tcNqDano=;
        b=H4D4tutMoEGe5pvNy8Ex8LpGbEfI5el1yCxLAunb9C9SrlqSQPd3I4EOwumV7KMP7q
         9urtz/GAgAnF1Nkzx+KuxQpWZmDyxECb41drRg5wmNXCWTsg7J0RWH89lbC4Q4c5DXNL
         H/QPYqs51PMmP8vhLABh69tcDRXoQnngM7qde0klT+7qn7eYH3rrDjSFuMlAt7qZtdB2
         Ba3jOnypplBvruA68Un1E7+xVg4UQy3paKTrpFp/X8ghj3VP4PzdjmrJpNDfCJ6T+iHL
         myFUILlivBLTTINcKADVj1gTi/h5/MKk/FI48Fxy2/13vmOoztkBUOQOktn5dtHpc4OG
         JvcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyNt8XPGZ4NvWTUNXzW00+mJjykubLULt2HKgAmeQGMHJVjHP1aUaXB85ucgwLUknbN1qXGmkL1ujryetAXWGoQX5kfcLvix9nuflM
X-Gm-Message-State: AOJu0YwNCkVUzQmFvWsij/tbhVBwvUsbz2LlRugvEMmvRL8GilYW9lJc
	EYEylVsn8AgMVWGcgZ501m9d0tHbI1fQ5NwNUN3LBPZTEIFU2VES9YOy0k1WnyITM5H9NNRGdi6
	racIsAdEvQEY1g3BgbipfZ8GorERfLMOFH4mC
X-Google-Smtp-Source: AGHT+IGCgjnmLuXfBbtP8+gsEcNsHnpGaerHMD0TL6bCnr5fI7d2PETZfJg9TYQYWbglAG2V8+VUVjhiqfuuwWFqwrg=
X-Received: by 2002:a05:6402:513:b0:568:53c2:2feb with SMTP id
 m19-20020a056402051300b0056853c22febmr52621edv.3.1710219299266; Mon, 11 Mar
 2024 21:54:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301194037.532117-1-mic@digikod.net> <20240301194037.532117-7-mic@digikod.net>
In-Reply-To: <20240301194037.532117-7-mic@digikod.net>
From: David Gow <davidgow@google.com>
Date: Tue, 12 Mar 2024 12:54:48 +0800
Message-ID: <CABVgOSk_vea-LrPwJet6hQ4D3PBQOLVg32nZ_gE4c9kgGDEEnQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] kunit: Print last test location on fault
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
	boundary="000000000000d7f17906136f7559"

--000000000000d7f17906136f7559
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2 Mar 2024 at 03:40, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wro=
te:
>
> This helps identify the location of test faults.
>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240301194037.532117-7-mic@digikod.net
> ---

I like the idea of this, but am a little bit worried about how
confusing it might be, given that the location only updates on those
particular macros.

Maybe the answer is to make the __KUNIT_SAVE_LOC() macro, or something
equivalent, a supported API.

One possibility would be to have a KUNIT_MARKER() macro. If we really
wanted to, we could expand it to take a string so we can have a more
user-friendly KUNIT_MARKER(test, "parsing packet") description of
where things went wrong. Another could be to extend this to use the
code tagging framework[1], if that lands.

That being said, I think this is still an improvement without any of
those features. I've left a few comments below. Let me know what you
think.

Cheers,
-- David

[1]: https://lwn.net/Articles/906660/
>
> Changes since v1:
> * Added Kees's Reviewed-by.
> ---
>  include/kunit/test.h  | 24 +++++++++++++++++++++---
>  lib/kunit/try-catch.c | 10 +++++++---
>  2 files changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index fcb4a4940ace..f3aa66eb0087 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -301,6 +301,8 @@ struct kunit {
>         struct list_head resources; /* Protected by lock. */
>
>         char status_comment[KUNIT_STATUS_COMMENT_SIZE];
> +       /* Saves the last seen test. Useful to help with faults. */
> +       struct kunit_loc last_seen;
>  };
>
>  static inline void kunit_set_failure(struct kunit *test)
> @@ -567,6 +569,15 @@ void __printf(2, 3) kunit_log_append(struct string_s=
tream *log, const char *fmt,
>  #define kunit_err(test, fmt, ...) \
>         kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
>
> +/*
> + * Must be called at the beginning of each KUNIT_*_ASSERTION().
> + * Cf. KUNIT_CURRENT_LOC.
> + */
> +#define _KUNIT_SAVE_LOC(test) do {                                      =
      \
> +       WRITE_ONCE(test->last_seen.file, __FILE__);                      =
      \
> +       WRITE_ONCE(test->last_seen.line, __LINE__);                      =
      \
> +} while (0)

Can we get rid of the leading '_', make this public, and document it?
If we want to rename it to KUNIT_MARKER() or similar, that might work
better, too.

> +
>  /**
>   * KUNIT_SUCCEED() - A no-op expectation. Only exists for code clarity.
>   * @test: The test context object.
> @@ -575,7 +586,7 @@ void __printf(2, 3) kunit_log_append(struct string_st=
ream *log, const char *fmt,
>   * words, it does nothing and only exists for code clarity. See
>   * KUNIT_EXPECT_TRUE() for more information.
>   */
> -#define KUNIT_SUCCEED(test) do {} while (0)
> +#define KUNIT_SUCCEED(test) _KUNIT_SAVE_LOC(test)
>
>  void __noreturn __kunit_abort(struct kunit *test);
>
> @@ -601,14 +612,16 @@ void __kunit_do_failed_assertion(struct kunit *test=
,
>  } while (0)
>
>
> -#define KUNIT_FAIL_ASSERTION(test, assert_type, fmt, ...)               =
      \
> +#define KUNIT_FAIL_ASSERTION(test, assert_type, fmt, ...) do {          =
      \
> +       _KUNIT_SAVE_LOC(test);                                           =
      \
>         _KUNIT_FAILED(test,                                              =
      \
>                       assert_type,                                       =
      \
>                       kunit_fail_assert,                                 =
      \
>                       kunit_fail_assert_format,                          =
      \
>                       {},                                                =
      \
>                       fmt,                                               =
      \
> -                     ##__VA_ARGS__)
> +                     ##__VA_ARGS__);                                    =
      \
> +} while (0)
>
>  /**
>   * KUNIT_FAIL() - Always causes a test to fail when evaluated.
> @@ -637,6 +650,7 @@ void __kunit_do_failed_assertion(struct kunit *test,
>                               fmt,                                       =
      \
>                               ...)                                       =
      \
>  do {                                                                    =
      \
> +       _KUNIT_SAVE_LOC(test);                                           =
      \
>         if (likely(!!(condition_) =3D=3D !!expected_true_))              =
          \
>                 break;                                                   =
      \
>                                                                          =
      \
> @@ -698,6 +712,7 @@ do {                                                 =
                              \
>                 .right_text =3D #right,                                  =
        \
>         };                                                               =
      \
>                                                                          =
      \
> +       _KUNIT_SAVE_LOC(test);                                           =
      \
>         if (likely(__left op __right))                                   =
      \
>                 break;                                                   =
      \
>                                                                          =
      \
> @@ -758,6 +773,7 @@ do {                                                 =
                              \
>                 .right_text =3D #right,                                  =
        \
>         };                                                               =
      \
>                                                                          =
      \
> +       _KUNIT_SAVE_LOC(test);                                           =
      \
>         if (likely((__left) && (__right) && (strcmp(__left, __right) op 0=
)))   \
>                 break;                                                   =
      \
>                                                                          =
      \
> @@ -791,6 +807,7 @@ do {                                                 =
                              \
>                 .right_text =3D #right,                                  =
        \
>         };                                                               =
      \
>                                                                          =
      \
> +       _KUNIT_SAVE_LOC(test);                                           =
      \
>         if (likely(__left && __right))                                   =
      \
>                 if (likely(memcmp(__left, __right, __size) op 0))        =
      \
>                         break;                                           =
      \
> @@ -815,6 +832,7 @@ do {                                                 =
                              \
>  do {                                                                    =
      \
>         const typeof(ptr) __ptr =3D (ptr);                               =
        \
>                                                                          =
      \
> +       _KUNIT_SAVE_LOC(test);                                           =
      \
>         if (!IS_ERR_OR_NULL(__ptr))                                      =
      \
>                 break;                                                   =
      \
>                                                                          =
      \
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index c6ee4db0b3bd..2ec21c6918f3 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -91,9 +91,13 @@ void kunit_try_catch_run(struct kunit_try_catch *try_c=
atch, void *context)
>
>         if (exit_code =3D=3D -EFAULT)
>                 try_catch->try_result =3D 0;
> -       else if (exit_code =3D=3D -EINTR)
> -               kunit_err(test, "try faulted\n");
> -       else if (exit_code =3D=3D -ETIMEDOUT)
> +       else if (exit_code =3D=3D -EINTR) {
> +               if (test->last_seen.file)
> +                       kunit_err(test, "try faulted after %s:%d\n",
> +                                 test->last_seen.file, test->last_seen.l=
ine);

It's possibly a bit confusing to just say "after file:line",
particularly if we then loop or call a function "higher up" in the
file. Maybe something like "try faulted: last line seen %s:%d" is
clearer.

> +               else
> +                       kunit_err(test, "try faulted before the first tes=
t\n");

I don't like using "test" here, as it introduces ambiguity between
"kunit tests" and "assertions/expectations" if we call them both
tests. Maybe just "try faulted" here, or "try faulted (no markers
seen)" or similar?


> +       } else if (exit_code =3D=3D -ETIMEDOUT)
>                 kunit_err(test, "try timed out\n");
>         else if (exit_code)
>                 kunit_err(test, "Unknown error: %d\n", exit_code);
> --
> 2.44.0
>

--000000000000d7f17906136f7559
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
hvcNAQkEMSIEIKIxQaGMP0MGQQv30sCV7JG+8TJEF2LhFCr0SVrF3w1xMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMxMjA0NTQ1OVowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBqcOvZ
+Liux9W1tb12ggeaId6JXsPeTZAhIBmwBzIV4i38udiCw02dVZ7NNeovqOuafh99hzt1mA/B2HyX
stKjNJXSSWaihtILRfRs8S98SCNArgJRKvisDAQPAIs8AWIJjP7n5CuNXhA4zV9IKjyuopuiYxJl
BQukIJMuMizhLgvlSJ/g+IkUveuWdNedMvq7ZImlIqI1IIYlZGHBRxbz5JD+DtWpoQpSJkZxfHzB
ojyaOsN7b94fpKp22JdZfZuHYIgny8IVDSmMIcY2FG/aTCSBuMZcjgQYGqj/71fcov5yWQ1jJpMX
IO2OZHZgc1vg68QRk+P+bNsXwf1middj
--000000000000d7f17906136f7559--

