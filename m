Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA231788055
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242679AbjHYGuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242638AbjHYGuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:50:16 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E39019AE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:50:14 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4005f0a6c2bso41785e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692946212; x=1693551012; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i4vdhJEIdaUou0cCnX7+S+jLuJMyHgXEG1yX0PrHZgw=;
        b=rj8bCxYy2EmuvQcTo/AVm1gUNCUVdJzCsoacRYtE+pUwpip4XHHkXKxVavzp0bVGgJ
         /RNlz8crFA9zu7ktzcUbyHWN9nK/oZWdsStHkpTh1/U/2DYCnL+9NE2nOHjsUbUxe46F
         bAd/ZiDqpNBfaisJdrgO9IWGsmrvAFlDEpOfdj6V1ZxYGFExN19QFZUIfUiXw+nfpm5q
         6wsl3ImLVUenTOeZ1J1pWwIE4jOxj3CEBxohBTDGbFqf1Ba0vJXD7KKr0qPudF1axRbe
         agM8ITMeiyOy1w2/V2gB3kgCmfEPi7g/YFFqs4ow4yPCCeeXaWmd48dNDHopuMcwwkco
         /GSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692946212; x=1693551012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4vdhJEIdaUou0cCnX7+S+jLuJMyHgXEG1yX0PrHZgw=;
        b=Z6IxTG4F+IfwMA+jNr/OQg4RAOfSKMW1Yi28HxoDKb05QIODcamV8a/nEKpu/xkHta
         G1SyHiorH8KJkhxO4wrD97MG8en2lMrtSRr9/e+UfYxa9CT9pBJKg5h6Wj3W51GRltBn
         gQsaLjdjP5reAQBq67AujA2Wk9QI54DbLdgoTNlhqVHZSu/yqWPax25hyvZUF18xdbfI
         vMt4mpE9j55uxuRVpb5Y2s0ONR/YlHeaGOsxMw8p0nJ3AzTZSy3WcPLzDPj5YeRJzTti
         anfspnE4Q11qkULMqFjNWuSOjsHzr730GzDcgpkAsQQKMAaiwCnb6HIgki4r9S4+8lIF
         93Pg==
X-Gm-Message-State: AOJu0YxwflTvb3lsz0Pt3oWceVbp6AuTgTfxdiAy6izVtUgSU+bWAfJF
        LpmpSN/zPJN9YmpEYuRX/8Q+xQT6M3lNwY0yJjsM2w==
X-Google-Smtp-Source: AGHT+IEcXa9pqxTHYq38o4Zreb4PndfleV2GPv3W1rPmWJXHnKgAuyA3HbDgKPVnV8cXVtQoU4gjurQQaQG3DzrTKdw=
X-Received: by 2002:a05:600c:3d8e:b0:3fe:e9ea:9653 with SMTP id
 bi14-20020a05600c3d8e00b003fee9ea9653mr130296wmb.4.1692946212639; Thu, 24 Aug
 2023 23:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230824143129.1957914-1-rf@opensource.cirrus.com> <20230824143129.1957914-11-rf@opensource.cirrus.com>
In-Reply-To: <20230824143129.1957914-11-rf@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 25 Aug 2023 14:50:00 +0800
Message-ID: <CABVgOSk+wEegL2QzR1hJAxyeuy9cgQ8GuyChJvd22W0Qpj_B=A@mail.gmail.com>
Subject: Re: [PATCH v5 10/10] kunit: string-stream: Test performance of string_stream
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a4d3690603b9c167"
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

--000000000000a4d3690603b9c167
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Aug 2023 at 22:33, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Add a test of the speed and memory use of string_stream.
>
> string_stream_performance_test() doesn't actually "test" anything (it
> cannot fail unless the system has run out of allocatable memory) but it
> measures the speed and memory consumption of the string_stream and reports
> the result.
>
> This allows changes in the string_stream implementation to be compared.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

Still looks good to me, so still:

Reviewed-by: David Gow <davidgow@google.com>

My results are:
   # string_stream_performance_test: Time elapsed:           4457 us
   # string_stream_performance_test: Total string length:    573890
   # string_stream_performance_test: Bytes requested:        823922
   # string_stream_performance_test: Actual bytes allocated: 1048280

Cheers,
-- David



>  lib/kunit/string-stream-test.c | 54 ++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
> index 6897c57e0db7..7d81d139b8f8 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -8,7 +8,9 @@
>
>  #include <kunit/static_stub.h>
>  #include <kunit/test.h>
> +#include <linux/ktime.h>
>  #include <linux/slab.h>
> +#include <linux/timekeeping.h>
>
>  #include "string-stream.h"
>
> @@ -437,6 +439,57 @@ static void string_stream_auto_newline_test(struct kunit *test)
>                            "One\nTwo\nThree\nFour\nFive\nSix\nSeven\n\nEight\n");
>  }
>
> +/*
> + * This doesn't actually "test" anything. It reports time taken
> + * and memory used for logging a large number of lines.
> + */
> +static void string_stream_performance_test(struct kunit *test)
> +{
> +       struct string_stream_fragment *frag_container;
> +       struct string_stream *stream;
> +       char test_line[101];
> +       ktime_t start_time, end_time;
> +       size_t len, bytes_requested, actual_bytes_used, total_string_length;
> +       int offset, i;
> +
> +       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +
> +       memset(test_line, 'x', sizeof(test_line) - 1);
> +       test_line[sizeof(test_line) - 1] = '\0';
> +
> +       start_time = ktime_get();
> +       for (i = 0; i < 10000; i++) {
> +               offset = i % (sizeof(test_line) - 1);
> +               string_stream_add(stream, "%s: %d\n", &test_line[offset], i);
> +       }
> +       end_time = ktime_get();
> +
> +       /*
> +        * Calculate memory used. This doesn't include invisible
> +        * overhead due to kernel allocator fragment size rounding.
> +        */
> +       bytes_requested = sizeof(*stream);
> +       actual_bytes_used = ksize(stream);
> +       total_string_length = 0;
> +
> +       list_for_each_entry(frag_container, &stream->fragments, node) {
> +               bytes_requested += sizeof(*frag_container);
> +               actual_bytes_used += ksize(frag_container);
> +
> +               len = strlen(frag_container->fragment);
> +               total_string_length += len;
> +               bytes_requested += len + 1; /* +1 for '\0' */
> +               actual_bytes_used += ksize(frag_container->fragment);
> +       }
> +
> +       kunit_info(test, "Time elapsed:           %lld us\n",
> +                  ktime_us_delta(end_time, start_time));
> +       kunit_info(test, "Total string length:    %zu\n", total_string_length);
> +       kunit_info(test, "Bytes requested:        %zu\n", bytes_requested);
> +       kunit_info(test, "Actual bytes allocated: %zu\n", actual_bytes_used);
> +}
> +
>  static int string_stream_test_init(struct kunit *test)
>  {
>         struct string_stream_test_priv *priv;
> @@ -462,6 +515,7 @@ static struct kunit_case string_stream_test_cases[] = {
>         KUNIT_CASE(string_stream_append_empty_string_test),
>         KUNIT_CASE(string_stream_no_auto_newline_test),
>         KUNIT_CASE(string_stream_auto_newline_test),
> +       KUNIT_CASE(string_stream_performance_test),
>         {}
>  };
>
> --
> 2.30.2
>

--000000000000a4d3690603b9c167
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
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAHOBX7j6YmdTMbtcPLp
3a4wDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMzA4MTUw
MjQyNDNaFw0yNDAyMTEwMjQyNDNaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCnYKS3ueVXUlVatkXVQgk8pbgZH4/s
KBKSGW9Z8e4hylAI35vqFf5f5D4U5KhUYUyG0+AYhurwEiUyZUhGcLqRNmSroohx9nbZjXDXjkVV
LXBAr7xaCU3DDQcA1SaxmALxBC7u4zlcVHfUKope2JNJ2xn5kU0Z/kr01tZuJD5/jn+2hp68jdym
tbFd3zzOJmtG6hb4ULJNXSi1qkjtZp6SyDLEsliQGRuI5AIha7GQPeSNsFmIpi+V5UxhrznuAv0y
Uxd27MtO+/mgSMpLmUb4vuSjy2zuftatzVYvFG00pfHldrnJ1od+kW8lAl6gyahVgMp+j3GAlO2M
oGCkihK9AgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFJO3Y8Jq
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDs
bBm7SNrdjWEn69clZnamsrqbpSIjXSf9YGWuSV3qADAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MjUwNjUwMTJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAK6auv3Zd5NH/IFdGaEcQ
ScJCqEemHKzDqV3MRPbEzSTUHUryz2BWHxFd52SJfu5gokfTNA8OAEXzMRfKGekpf/p+whUGWECR
Ms4uFLoQTW5SjwTpP+Aifs/IUQa8UgehExTzZ2PZaoxeTK4CxzRc1g30IMNX5+eODYvWqAY9rbtT
3Lxwg3vDWugxsBuCnvu5hB6Zf/Qxd33ZLSdwwzGFx7YSrKf4DVv581039C6vhS1A+2rTqqdXCPNQ
j13A4S8bQgtEnFP+kNHTwEigQJaOXUkV0jugyJwPCJ7J+Ci1Jb9lUPJIrWBHxzTTy8p0MDO38tCy
XqDjS1gzC7oIOEH/1A==
--000000000000a4d3690603b9c167--
