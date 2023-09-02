Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC414790620
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 10:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351836AbjIBIYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 04:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350324AbjIBIYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 04:24:45 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7A4CD7
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 01:24:41 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4005f0a6c2bso23085e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 01:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693643080; x=1694247880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/h2Iq5YHortQrBkpbHH2co6MVYfwCZbs0BnY48kuUTc=;
        b=sjZr1GVDl5/h6Ct28QNCvbGuRsxBheFyx9Od0k5YEMVVMzjdyL41iFSmF/fTA578SV
         VFHc1Ct0+qTADwcWUcmcv+ZO/NpW/7T2HRiWYxEAzN1j50tjSpst0I97jrDNnSy7Q5Ln
         lH7W+7w09lMeBYaHjPercBm2RXDQ4XthZwDA1bdI6IqYGfMeP0IoRfrjGs3iGIlcBDkN
         sw3kf1yroC5hnIbNtk5Pqyb1yZHAqpJExx7lbLMfwo+8QoKfvbPtx47EDF7+rPXk+26B
         CvJUKF1AfLJqYSfcKZ49xszYgjTmMtUyPOzWgPNhVapTQGdxRhyV4siBfxuK+x5es91p
         BH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693643080; x=1694247880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/h2Iq5YHortQrBkpbHH2co6MVYfwCZbs0BnY48kuUTc=;
        b=N6CbNkVrZFWRfFvkgvPYkssUfKRxorMq0+DpCF5r+FncXOn78y+jcJFc9E2YF/8mPC
         ikod6mSIX596enSKBdZafnSX1Q628T+Wbp+eAuZKryr9D1s/jEfilElII+0psPV3C05s
         MCCR3iH3Ca+uQMTdVfgOiPU4v5caSBAwtlmHdLKwq04eEWJQY5OAeL5kAUNt4qW+xNIr
         h99R0AyWOhGpiyr+D3PvcW3vuNUtvw02eymjPRAjtnwQmRD46Sv/i3n7xAqUlFT4VhAQ
         O3bLVW6n219dALUImEo0x+F/zFheLnt2mZj0nMffYh4cgh8zINS1GV0c4j0w4m/PSj3t
         CUqg==
X-Gm-Message-State: AOJu0YwzVs0QHDfuctBYL6FUUTKmLUWHetKbuE9cjQwo8bNy47BIqEJX
        krAHTNrriyR6VfT4Fdu1FqN2K8PIWZzzoTaigcFnbg==
X-Google-Smtp-Source: AGHT+IEH1+0Ob6EeStwkbgTLEw0gOijSdGucMvnE4uUHPRliodObOvt8wzdd2Lc71tMQOS6aYUMdkMY09YBiGC9H+1k=
X-Received: by 2002:a1c:7416:0:b0:3f4:fb7:48d4 with SMTP id
 p22-20020a1c7416000000b003f40fb748d4mr49637wmc.3.1693643080203; Sat, 02 Sep
 2023 01:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230828104111.2394344-1-rf@opensource.cirrus.com> <20230828104111.2394344-9-rf@opensource.cirrus.com>
In-Reply-To: <20230828104111.2394344-9-rf@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 2 Sep 2023 16:24:27 +0800
Message-ID: <CABVgOSnNwWUsRcTaAJgVy76ikJ740OYuDjdFLwhnTN1rQg_x3w@mail.gmail.com>
Subject: Re: [PATCH v6 08/10] kunit: string-stream: Add tests for freeing
 resource-managed string_stream
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000033b8de06045c0255"
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

--00000000000033b8de06045c0255
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Aug 2023 at 18:41, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> string_stream_managed_free_test() allocates a resource-managed
> string_stream and tests that kunit_free_string_stream() calls
> string_stream_destroy().
>
> string_stream_resource_free_test() allocates a resource-managed
> string_stream and tests that string_stream_destroy() is called
> when the test resources are cleaned up.
>
> The old string_stream_init_test() has been split into two tests,
> one for kunit_alloc_string_stream() and the other for
> alloc_string_stream().
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
> Changes since v5:
> - Fix memory leak when calling the redirected string_stream_destroy_stub().
> ---

Much better, thanks.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/string-stream-test.c | 147 +++++++++++++++++++++++++++++++--
>  lib/kunit/string-stream.c      |   3 +
>  2 files changed, 145 insertions(+), 5 deletions(-)
>
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
> index 58ba1ef5207f..b759974d9cec 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -6,17 +6,33 @@
>   * Author: Brendan Higgins <brendanhiggins@google.com>
>   */
>
> +#include <kunit/static_stub.h>
>  #include <kunit/test.h>
>  #include <linux/slab.h>
>
>  #include "string-stream.h"
>
> -/* This avoids a cast warning if kfree() is passed direct to kunit_add_action(). */
> +struct string_stream_test_priv {
> +       /* For testing resource-managed free. */
> +       struct string_stream *expected_free_stream;
> +       bool stream_was_freed;
> +       bool stream_free_again;
> +};
> +
> +/* Avoids a cast warning if kfree() is passed direct to kunit_add_action(). */
>  static void kfree_wrapper(void *p)
>  {
>         kfree(p);
>  }
>
> +/* Avoids a cast warning if string_stream_destroy() is passed direct to kunit_add_action(). */
> +static void cleanup_raw_stream(void *p)
> +{
> +       struct string_stream *stream = p;
> +
> +       string_stream_destroy(stream);
> +}
> +
>  static char *get_concatenated_string(struct kunit *test, struct string_stream *stream)
>  {
>         char *str = string_stream_get_string(stream);
> @@ -27,11 +43,12 @@ static char *get_concatenated_string(struct kunit *test, struct string_stream *s
>         return str;
>  }
>
> -/* string_stream object is initialized correctly. */
> -static void string_stream_init_test(struct kunit *test)
> +/* Managed string_stream object is initialized correctly. */
> +static void string_stream_managed_init_test(struct kunit *test)
>  {
>         struct string_stream *stream;
>
> +       /* Resource-managed initialization. */
>         stream = kunit_alloc_string_stream(test, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
>
> @@ -42,6 +59,109 @@ static void string_stream_init_test(struct kunit *test)
>         KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
>  }
>
> +/* Unmanaged string_stream object is initialized correctly. */
> +static void string_stream_unmanaged_init_test(struct kunit *test)
> +{
> +       struct string_stream *stream;
> +
> +       stream = alloc_string_stream(GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
> +       kunit_add_action(test, cleanup_raw_stream, stream);
> +
> +       KUNIT_EXPECT_EQ(test, stream->length, 0);
> +       KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
> +       KUNIT_EXPECT_EQ(test, stream->gfp, GFP_KERNEL);
> +       KUNIT_EXPECT_FALSE(test, stream->append_newlines);
> +
> +       KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
> +}
> +
> +static void string_stream_destroy_stub(struct string_stream *stream)
> +{
> +       struct kunit *fake_test = kunit_get_current_test();
> +       struct string_stream_test_priv *priv = fake_test->priv;
> +
> +       /* The kunit could own string_streams other than the one we are testing. */
> +       if (stream == priv->expected_free_stream) {
> +               if (priv->stream_was_freed)
> +                       priv->stream_free_again = true;
> +               else
> +                       priv->stream_was_freed = true;
> +       }
> +
> +       /*
> +        * Calling string_stream_destroy() will only call this function again
> +        * because the redirection stub is still active.
> +        * Avoid calling deactivate_static_stub() or changing current->kunit_test
> +        * during cleanup.
> +        */
> +       string_stream_clear(stream);
> +       kfree(stream);
> +}
> +
> +/* kunit_free_string_stream() calls string_stream_desrtoy() */
> +static void string_stream_managed_free_test(struct kunit *test)
> +{
> +       struct string_stream_test_priv *priv = test->priv;
> +
> +       priv->expected_free_stream = NULL;
> +       priv->stream_was_freed = false;
> +       priv->stream_free_again = false;
> +
> +       kunit_activate_static_stub(test,
> +                                  string_stream_destroy,
> +                                  string_stream_destroy_stub);
> +
> +       priv->expected_free_stream = kunit_alloc_string_stream(test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->expected_free_stream);
> +
> +       /* This should call the stub function. */
> +       kunit_free_string_stream(test, priv->expected_free_stream);
> +
> +       KUNIT_EXPECT_TRUE(test, priv->stream_was_freed);
> +       KUNIT_EXPECT_FALSE(test, priv->stream_free_again);
> +}
> +
> +/* string_stream object is freed when test is cleaned up. */
> +static void string_stream_resource_free_test(struct kunit *test)
> +{
> +       struct string_stream_test_priv *priv = test->priv;
> +       struct kunit *fake_test;
> +
> +       fake_test = kunit_kzalloc(test, sizeof(*fake_test), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fake_test);
> +
> +       kunit_init_test(fake_test, "string_stream_fake_test", NULL);
> +       fake_test->priv = priv;
> +
> +       /*
> +        * Activate stub before creating string_stream so the
> +        * string_stream will be cleaned up first.
> +        */
> +       priv->expected_free_stream = NULL;
> +       priv->stream_was_freed = false;
> +       priv->stream_free_again = false;
> +
> +       kunit_activate_static_stub(fake_test,
> +                                  string_stream_destroy,
> +                                  string_stream_destroy_stub);
> +
> +       priv->expected_free_stream = kunit_alloc_string_stream(fake_test, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->expected_free_stream);
> +
> +       /* Set current->kunit_test to fake_test so the static stub will be called. */
> +       current->kunit_test = fake_test;
> +
> +       /* Cleanup test - the stub function should be called */
> +       kunit_cleanup(fake_test);
> +
> +       /* Set current->kunit_test back to current test. */
> +       current->kunit_test = test;
> +
> +       KUNIT_EXPECT_TRUE(test, priv->stream_was_freed);
> +       KUNIT_EXPECT_FALSE(test, priv->stream_free_again);
> +}
> +
>  /*
>   * Add a series of lines to a string_stream. Check that all lines
>   * appear in the correct order and no characters are dropped.
> @@ -334,8 +454,24 @@ static void string_stream_auto_newline_test(struct kunit *test)
>                            "One\nTwo\nThree\nFour\nFive\nSix\nSeven\n\nEight\n");
>  }
>
> +static int string_stream_test_init(struct kunit *test)
> +{
> +       struct string_stream_test_priv *priv;
> +
> +       priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       test->priv = priv;
> +
> +       return 0;
> +}
> +
>  static struct kunit_case string_stream_test_cases[] = {
> -       KUNIT_CASE(string_stream_init_test),
> +       KUNIT_CASE(string_stream_managed_init_test),
> +       KUNIT_CASE(string_stream_unmanaged_init_test),
> +       KUNIT_CASE(string_stream_managed_free_test),
> +       KUNIT_CASE(string_stream_resource_free_test),
>         KUNIT_CASE(string_stream_line_add_test),
>         KUNIT_CASE(string_stream_variable_length_line_test),
>         KUNIT_CASE(string_stream_append_test),
> @@ -348,6 +484,7 @@ static struct kunit_case string_stream_test_cases[] = {
>
>  static struct kunit_suite string_stream_test_suite = {
>         .name = "string-stream-test",
> -       .test_cases = string_stream_test_cases
> +       .test_cases = string_stream_test_cases,
> +       .init = string_stream_test_init,
>  };
>  kunit_test_suites(&string_stream_test_suite);
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index 64abceb7b716..a6f3616c2048 100644
> --- a/lib/kunit/string-stream.c
> +++ b/lib/kunit/string-stream.c
> @@ -6,6 +6,7 @@
>   * Author: Brendan Higgins <brendanhiggins@google.com>
>   */
>
> +#include <kunit/static_stub.h>
>  #include <kunit/test.h>
>  #include <linux/list.h>
>  #include <linux/slab.h>
> @@ -170,6 +171,8 @@ struct string_stream *alloc_string_stream(gfp_t gfp)
>
>  void string_stream_destroy(struct string_stream *stream)
>  {
> +       KUNIT_STATIC_STUB_REDIRECT(string_stream_destroy, stream);
> +
>         if (!stream)
>                 return;
>
> --
> 2.30.2
>

--00000000000033b8de06045c0255
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDo
acT3HR1liuqNvkaCc9B1KVJy+n8o/Bgq+mbN5ZjjQzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA5MDIwODI0NDBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAVHs8Mbo6jleU2oRvcvDP
sONF+nmwOSKpvLfB0hHvZUS8+tH+Uo9Q4h3/yDWDUbqy9nzZKldEyDBJixRhPUJOT07wznUnAIC2
Y+wFQ2bpqos5iYkL+pBB8nsecUCKHVy3/hRg7pg5rXvkGQ0RJxYaE/XLisLzB78XrKdHomRpPaUx
16fN2erTfuex2QS0FS1xaS6FJmg1Vhna8fZxv9H3SussGXvK/5kMFONP/WbF6R/V2/BK61iOi44W
3+8k9/aaPFZiSpcftnxw8VZJSq4GRIQrIUWZEYw5CjRLGBTzZbLPdLpukLNqW8lG25GqSsW9ueYD
8jW4FI9gGDqXqwY2uQ==
--00000000000033b8de06045c0255--
