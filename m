Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90FF788049
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242612AbjHYGuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242658AbjHYGtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:49:49 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A35E19AC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:49:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fef2fafee2so66185e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692946185; x=1693550985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GqnH+JWrcFdZsLFexv5u90jrx2j3gOzChnTzM6vlMgM=;
        b=cqWkmmPmFrAkZw2bS9TWMSm3Lvp/75i5jzbH4G+JqrHq6B1wDrWfXYhnVyKgMzW0mR
         UEMMq50OYPRzd5tfaiX5N6YPSlvmlNbhrqbo+gZFRbyWHYm2lTy5B2juB52bNACveYdj
         pJ2gM/HMOeiqCIWWzNSDzMn+x6ICGkwhGCIbHIrA8tru0cFzZcBqFYFKQH1vJGsgZkBw
         Ox7BgbfmjSW2HzGO6YjUM6jKsyAGsDd2qwVavzkCa/8n1Y13arAqpVHb4D0Uy9S1yIcd
         nr3wcpGasJTmV5cEy3M/hHEoMDpQUTTb0iXDu9XWW7RmosFHE19OEFfMCPK+iinIbYDu
         xr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692946185; x=1693550985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqnH+JWrcFdZsLFexv5u90jrx2j3gOzChnTzM6vlMgM=;
        b=M6FGm+0VDfkaVPJy8Ud82gTvLJLCywnwKI6egehXOxKPjj95Ucep6tVa+OUI8RDJYu
         j+6rKa6s+uQietlFURjRsrwwdV0pyAuQCQWukOBAAX7OuVMuujh5fN1rlG4n6Dy4ZhgD
         aiRJbyLBlVvm6P2dmT6DOEql4Kx83WueMNp5ETwyhcBc6eyiab687SL7F0JBExOUmc22
         7tIqSiX0FIdDZm7DSEDHxLutZPQbdeA6d3sLLd4l5dDFz0q2X/6OF+OrpHLPj1j0hwKZ
         RP2PgnN76VJLh7qvs00psuagAksajUYKN1tGvM8Ey6lP3kaiVGDbc0DH0/h6b/cZKgQC
         5kDw==
X-Gm-Message-State: AOJu0YwrTZAmWugfHGPVItA8UQvDIRoLUK5CxhfKWXKiT8QeEWOgsp6l
        JdkBm4sLwEI6pRV1BDVnlTl8/ld3raWy3zXQHFZ6Rw==
X-Google-Smtp-Source: AGHT+IH8iXVeXo+hDo794zk5kDYiph5r1se2QC1cPqYE9Ufbg23EGlYtWonNWEbAqU06+mj9wv6S+yJYKJhpSsooOMk=
X-Received: by 2002:a05:600c:1d98:b0:401:a494:2bbb with SMTP id
 p24-20020a05600c1d9800b00401a4942bbbmr100537wms.5.1692946185422; Thu, 24 Aug
 2023 23:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230824143129.1957914-1-rf@opensource.cirrus.com> <20230824143129.1957914-6-rf@opensource.cirrus.com>
In-Reply-To: <20230824143129.1957914-6-rf@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 25 Aug 2023 14:49:33 +0800
Message-ID: <CABVgOSmgKOssPH7482hm5TECo5CqnUmCzLGq1aHrdKUQkC+tMQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] kunit: Don't use a managed alloc in is_literal()
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000006855d0603b9c0d0"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000006855d0603b9c0d0
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Aug 2023 at 22:31, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> There is no need to use a test-managed alloc in is_literal().
> The function frees the temporary buffer before returning.
>
> This removes the only use of the test and gfp members of
> struct string_stream outside of the string_stream implementation.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

This makes sense to me, particularly given how independent
string-stream otherwise is from the KUnit resource management bits.

The only possible downside is that the memory won't be cleaned up if
strncmp() crashes due to 'text' being somehow invalid. But given this
is really only even used with static data (generated by the assert
macros), and to fail on the strncmp and not the strlen() would require
some horrible race-condition-y madness, I don't think it's ever
reasonably possible to hit that case.

So, looks good.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  lib/kunit/assert.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> index 05a09652f5a1..dd1d633d0fe2 100644
> --- a/lib/kunit/assert.c
> +++ b/lib/kunit/assert.c
> @@ -89,8 +89,7 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
>  EXPORT_SYMBOL_GPL(kunit_ptr_not_err_assert_format);
>
>  /* Checks if `text` is a literal representing `value`, e.g. "5" and 5 */
> -static bool is_literal(struct kunit *test, const char *text, long long value,
> -                      gfp_t gfp)
> +static bool is_literal(const char *text, long long value)
>  {
>         char *buffer;
>         int len;
> @@ -100,14 +99,15 @@ static bool is_literal(struct kunit *test, const char *text, long long value,
>         if (strlen(text) != len)
>                 return false;
>
> -       buffer = kunit_kmalloc(test, len+1, gfp);
> +       buffer = kmalloc(len+1, GFP_KERNEL);
>         if (!buffer)
>                 return false;
>
>         snprintf(buffer, len+1, "%lld", value);
>         ret = strncmp(buffer, text, len) == 0;
>
> -       kunit_kfree(test, buffer);
> +       kfree(buffer);
> +
>         return ret;
>  }
>
> @@ -125,14 +125,12 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
>                           binary_assert->text->left_text,
>                           binary_assert->text->operation,
>                           binary_assert->text->right_text);
> -       if (!is_literal(stream->test, binary_assert->text->left_text,
> -                       binary_assert->left_value, stream->gfp))
> +       if (!is_literal(binary_assert->text->left_text, binary_assert->left_value))
>                 string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (0x%llx)\n",
>                                   binary_assert->text->left_text,
>                                   binary_assert->left_value,
>                                   binary_assert->left_value);
> -       if (!is_literal(stream->test, binary_assert->text->right_text,
> -                       binary_assert->right_value, stream->gfp))
> +       if (!is_literal(binary_assert->text->right_text, binary_assert->right_value))
>                 string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (0x%llx)",
>                                   binary_assert->text->right_text,
>                                   binary_assert->right_value,
> --
> 2.30.2
>

--00000000000006855d0603b9c0d0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
ddIn9n5Jt6Z1o79zxraLMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBtHFwIgQZjer5K
H+4Q+wns10k7qN+4wN2Uf+JsyOYjukaMEgdLErfA1wwtQ9uHkoYQZcWBuVVkQFa5hI+sqI2m1Weq
riMCFSiU38s1tADdMX12IMfJRN60Nznhrw+nPyDRZqRhUTW24TwnHorkDnFPW8PHo7fAw4FrpI0n
impZAng7ccvvK09K3ZuhwTIxJMsPXCZYsrXWORTw5sczRAP6XvKbPBJnsJoSTe5dFBPBHOQJOGhU
qWfEfWnWMJPF3LxSGLpLFQXO3RwQqmxv08avwXfVPouh1xuB3FX7rpDabT8YDhu9JgIZkLEKko7L
yQt6zWwng7k8YF/jGbiAta6VMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC6
kctKa7uFzV8PregUpPXtx8qVEbpu6sGPgaXuWpQdMzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MjUwNjQ5NDVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAgyCIblRsQpE6PHJ1n91e
rIa83iJqX02OOiAk1PtHYy2yj8e3PgyU9ApSv/COND30RZ8vNyCK43r5EYMRhl7TeLiOv2t8vo4z
RYZUoSq8+xaH5l2TxRlZPjJI8m+lXG1y1muosbePNKEKGX2FpxVc4csPaLaNK+xrwrlLAM9xf3Zj
ll6lw01/136zT75xll3TNl4MS9GU/IH3GJqVutvIXD5SUUF6Tou6o/XDNTog7G4WAwKp5kkw86jS
hwt+CIlJgkg4eofoaXqXXN5ubZWii9kIr43m5YdixiZauNbL23VPosI6lCZCVgYm6J/OJpxafJT/
QICpKM+3djNWkLdYaQ==
--00000000000006855d0603b9c0d0--
