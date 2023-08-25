Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AE3788071
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbjHYG7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjHYG62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:58:28 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F0C199E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:58:25 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4005f0a6c2bso42255e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692946704; x=1693551504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D4jRn2k5P02iPL3WCWMvGO7bjgW/zDWoZvxcX1DGF/E=;
        b=pT3cB9F5Zyrp2kEYrdGstyI7LvyaIsqfr0o0aYIIyI57nNrPnRn9nrpf5LdtDsKhP6
         HdMxm5F0rzLJwSBZ9E1s8xx3ot0zvFyfYY+v/Y0Dt+EyXOiSizfs3xFXSZ/wJ/c/z/fX
         +rN2nTY+Z9/0FP6MncCTmOqIRwVab4NNR6vj7JGKebwkvxvFs3RDBdxWJRJo0k+GWxaq
         Kh8mennSfl72j0ljJ8IVUA/ro079kViRYlLu0ozqvBa30hAMenmZIaK0wjjpy4DVwRts
         RM05FumKH4lEIjcVEfgKlKqVjjl8fvV681VLTT/80DWjX3ogltlkIav8TmUyrl5QsNaf
         ZRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692946704; x=1693551504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4jRn2k5P02iPL3WCWMvGO7bjgW/zDWoZvxcX1DGF/E=;
        b=g//BT+VCgb+8eebFYX2clV6T82QOp5grb+w4ZXD7DA8+LMydCjZX4XN+VLBnB72HY8
         41Mm6ZnA8BRMR5RMsr/Ah03g19pJDImCJxixGX6xG3KOqCXFJx+2l6JG+qjLYIrK03iD
         yRMb8WnePFWBf65HkL5A9afrBn+plqlpO/HlkE8Ban/pK/vaC2YDWE1GXZIrBvp8MixI
         uIPZns6GenTqO68jxDX5fDGkFcCYY9b4rljA5CyzgEFZsXP7N7pcQIIHeYfN1GmD+W+k
         poVqVQpIVIpL6/lu3BKdJ1v0XnuZ7bEyfW5mU/EOdQJ65gVGRqYqLDUqnqbe4rChn4QU
         vjfg==
X-Gm-Message-State: AOJu0YxrNVNNdHr+EXWyW8389k0WTHYcmq/tFdvKgb9S6a2kIwtjf14X
        npJ9eYVpIgfMirwcnCKIHzut1BvFMoTn4IVnG80uag==
X-Google-Smtp-Source: AGHT+IFT0DfTwzsxpQvtbJyEMIaqWKpiegNaNEaiwRKLAi4qJg8KyM53GkUGUdVEXaODVXA7y68bpU4hk9lB80TLESU=
X-Received: by 2002:a05:600c:3b02:b0:401:7c14:948d with SMTP id
 m2-20020a05600c3b0200b004017c14948dmr131939wms.2.1692946703922; Thu, 24 Aug
 2023 23:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230824143129.1957914-1-rf@opensource.cirrus.com>
In-Reply-To: <20230824143129.1957914-1-rf@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 25 Aug 2023 14:58:12 +0800
Message-ID: <CABVgOSkpB3uJoLJppVZObXsm+BQEdA+b0+AfCmN54_1bpFeCzw@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] kunit: Add dynamically-extending log
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ef2b410603b9de02"
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

--000000000000ef2b410603b9de02
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Aug 2023 at 22:32, 'Richard Fitzgerald' via KUnit
Development <kunit-dev@googlegroups.com> wrote:
>
> This patch chain changes the logging implementation to use string_stream
> so that the log will grow dynamically.
>
> The first 8 patches add test code for string_stream, and make some
> changes to string_stream needed to be able to use it for the log.
>
> The final patch adds a performance report of string_stream.
>
> CHANGES SINCE V4:
> - Re-ordered the first 3 patches from V4 to squash the first two sets
>   of string_stream tests into a single patch.
> - Changed is_literal() so it doesn't need a struct kunit.
> - Split out the new resource-managed alloc and free functions into
>   a pre-patch to reduce the amount of code churn when the string_stream
>   is decoupled from kunit.
> - Wrapped the call to string_stream_geT_string() in string-stream-test
>   in a local function to reduce the amount of code churn when the
>   string_stream is decoupled from kunit.
> - Some minor changes to test implementations.
> - string_stream is now completely separated from kunit and the 'test'
>   member of struct string_stream has been eliminated.
>
> Richard Fitzgerald (10):
>   kunit: string-stream: Don't create a fragment for empty strings
>   kunit: string-stream: Improve testing of string_stream
>   kunit: string-stream: Add option to make all lines end with newline
>   kunit: string-stream: Add cases for string_stream newline appending
>   kunit: Don't use a managed alloc in is_literal()
>   kunit: string-stream: Add kunit_alloc_string_stream()
>   kunit: string-stream: Decouple string_stream from kunit
>   kunit: string-stream: Add tests for freeing resource-managed
>     string_stream
>   kunit: Use string_stream for test log
>   kunit: string-stream: Test performance of string_stream
>

Thanks a lot for sticking with this. I think we're in pretty good
shape now. There are a few minor comments, only one of which really
concerns me. That's the freeing of string streams in the
resource-managed string stream tests. I can't quite see how the actual
stream is freed after being "fake freed" by the stub. Is there
something I'm missing?

Otherwise, this seems good enough to go. I fear we're probably past
the point where it can make it into 6.6 (pull requests are already
being sent out, and I'd really rather have the final version of this
soak in linux-next for a while before sending it to Linus. But we'll
make it the first thing to go into 6.7, I think.

Cheers,
-- David


>  include/kunit/test.h           |  14 +-
>  lib/kunit/assert.c             |  14 +-
>  lib/kunit/debugfs.c            |  36 ++-
>  lib/kunit/kunit-test.c         |  46 ++-
>  lib/kunit/string-stream-test.c | 508 +++++++++++++++++++++++++++++++--
>  lib/kunit/string-stream.c      | 100 +++++--
>  lib/kunit/string-stream.h      |  16 +-
>  lib/kunit/test.c               |  50 +---
>  8 files changed, 662 insertions(+), 122 deletions(-)
>
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230824143129.1957914-1-rf%40opensource.cirrus.com.

--000000000000ef2b410603b9de02
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA7
UG2vVcC3D/vdBySQf05ufAAdiVgRHGbuToUf0FSPPDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MjUwNjU4MjRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAoQQFIOdFbgc9bE8M8JI1
XYPVg7BAB8w8yMYfgsn5jiSv+tRbNbFScBsbpIBM/3gasBIeqFRib/FuSxcaV/nW1yefGOJYD1Js
9vF6m7annd+d/7JonY2gFh10vr+lOHlFF4wcsAFRVCDfCqby/scKdT/X+vmuuAERMs+fY/RS0lZL
DxARqYRirsoZMUde4Orp5y4CGYSLOWQEdDS+ktFrdI+nBksMpoEuHBNssUUqLw8M3gKWMYFm9CK4
QLMU6bTvE2qCRh6DGYdrEtsrO+K5X9oLGE+5fyNn0JKPK7NwfhYBJjgJWj3zLW+o+QuqOFB0GfzA
E9Utph/wt4ux9dgzsA==
--000000000000ef2b410603b9de02--
