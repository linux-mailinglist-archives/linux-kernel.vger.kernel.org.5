Return-Path: <linux-kernel+bounces-110921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3008865BA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D597F28626B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 04:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F066FD5;
	Fri, 22 Mar 2024 04:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KC73NRoT"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39226FA7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 04:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711080747; cv=none; b=O0XOcpp9K5g2ci5OX/ppfYLJBuHMt1Ai7ZTG1Fr204G09himyMgLsyDqotPJ9Bjd1N1A/UI1yVH0JzQL8I/6C3rMZ4ky5LPoRWcCglnmxYPYf7iAqnNzw7Tc8/DWGSSTFjnAgtKqe6YdbFTQmhH56aiw9fJrQf1EbQTgfI9MfEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711080747; c=relaxed/simple;
	bh=aCgpQ/5AZOJYJm87g1KkgimsRJNnXwx4IAHdihsBfow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shF7Y99Uf/Dd/PMl5chi7Bif1wdB/gIJVdrjP5PI/l8lmqKQ5+uVZ3zIwIwVHomGheSUeU2XVyqWFoCSJDNAyAguYSeS5pbVCLLHG/HFwkThkW6tThg4BzhJEsRvCimA0tuvPXBGfoiOT5JD9wxUOlf11zGEMWIFsc3otvTp/0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KC73NRoT; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-568c3888ad7so7936a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 21:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711080743; x=1711685543; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wjlq5GlSHJ881vQ1InVKUCnOCBQMy+ID/MFMwwR7tsY=;
        b=KC73NRoT/ysRwkz/Cv/qYvn0W4bV6zcTzB7Xfs31mK+rSR9FSAdjxiqF9dYmiRpREG
         2UHy6xwH0l4naoYArJS3a1qxcF4WbTWlwRrWRh82ioiD9p9maGwPpsp1vk7zfIu0qSv5
         FQmPEFHdIA+LAqKVqjSCiF1xAqYZjShCntuf8ENdNiLcdD9zu2/Y+tud1bjgtDSLkmwL
         QOWiN4RYK/Nc+SpKkvZmWBybYv89JXJW2t/xClVgveI3oacBnl8YGWqAeBmXZWDkuB27
         SGa0rkwZ/vgTMOumDf7rlR0oQLQSml7lZWAyhVRdA18rDD8vUSkiaOkcyOtWPTLlgTmS
         7nIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711080743; x=1711685543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wjlq5GlSHJ881vQ1InVKUCnOCBQMy+ID/MFMwwR7tsY=;
        b=nERe2KUt6kbhUnskpU2noQFNurfMq/zobAldovnXLPELGQCSOwsQzBQ/+A0jf7stgg
         hYJjK2AGVNvZIbVWJLQGrqgG+/T9COHqPBRCq8GujMJNUrdmt8AvVPx+ST773hQZETRQ
         mmlTf0dICpeCEZfW6igwCEWsTScA34UQNqHh8bb4hCLUr7JNLugrKIuRwnuK7n2Huug+
         s/i5vNUYjesHdwpoEQ3hZx/UVEm2fkEghTia4v4ygBX+eXe/r+kx5N/wdRL/KlGwMFfB
         D2sI2lrBBY4bap1p65UkO34LLdE4K0OiYWPVxFCgcwLr10prw/JAf412yJc0cO2ALocJ
         v6Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXe1SSpgGpmv66NSweiYovlU53GEXvr3VrQKDGf8l402QZ5qfsO/0/gjdRYfWbY5Fv5W6BVSL01Esu7dIE4PFnMwlSYhtLWLSJ8PdRG
X-Gm-Message-State: AOJu0YwYUi6oRnS52Ylz2Kv/09LOqdM+fwwZVPRJMB1874eplHWzC0vh
	YOvYQua1Cz+vH6LIfqwFYHwRaywQHfEwTq/8JFi+T9Cr4uVja6zUe6quri3dqNwomRKXcoKEZgN
	PV8w0MwNGGipvnbmD4CcWWzcIE9ZV8bXWHgfp
X-Google-Smtp-Source: AGHT+IGxanXjgGcOapF59tHbF2WoOg7zW4/uF2onBPnCibCnAINNFzUr1hhboYKE0sEYEJzwOnupeijArSEBuUy3IHQ=
X-Received: by 2002:aa7:cd12:0:b0:56b:b464:d529 with SMTP id
 b18-20020aa7cd12000000b0056bb464d529mr329111edw.2.1711080743058; Thu, 21 Mar
 2024 21:12:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320171424.6536-1-shikemeng@huaweicloud.com>
In-Reply-To: <20240320171424.6536-1-shikemeng@huaweicloud.com>
From: David Gow <davidgow@google.com>
Date: Fri, 22 Mar 2024 12:12:10 +0800
Message-ID: <CABVgOSkJz5ZRePqQR3naK__MxoRLsE3VV0TJOhfjOYxmRayA8A@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: correct KUNIT_VERY_SLOW to KUNIT_SPEED_VERY_SLOW
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com, corbet@lwn.net, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e8c2a90614380775"

--000000000000e8c2a90614380775
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Mar 2024 at 16:18, Kemeng Shi <shikemeng@huaweicloud.com> wrote:
>
> There is no KUNIT_VERY_SLOW, I guess we mean KUNIT_SPEED_VERY_SLOW.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---

Nice catch, thanks!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  Documentation/dev-tools/kunit/running_tips.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
> index bd689db6fdd2..482f598d141c 100644
> --- a/Documentation/dev-tools/kunit/running_tips.rst
> +++ b/Documentation/dev-tools/kunit/running_tips.rst
> @@ -294,7 +294,7 @@ macro to define the test case instead of ``KUNIT_CASE(test_name)``.
>  .. code-block:: c
>
>         static const struct kunit_attributes example_attr = {
> -               .speed = KUNIT_VERY_SLOW,
> +               .speed = KUNIT_SPEED_VERY_SLOW,
>         };
>
>         static struct kunit_case example_test_cases[] = {
> @@ -311,7 +311,7 @@ suite definition.
>  .. code-block:: c
>
>         static const struct kunit_attributes example_attr = {
> -               .speed = KUNIT_VERY_SLOW,
> +               .speed = KUNIT_SPEED_VERY_SLOW,
>         };
>
>         static struct kunit_suite example_test_suite = {
> --
> 2.30.0
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20240320171424.6536-1-shikemeng%40huaweicloud.com.

--000000000000e8c2a90614380775
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
hvcNAQkEMSIEIL1LdKj94T/2R0cL4Yidkga41orJF2jK/ZbbD9dlZSrhMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMyMjA0MTIyM1owaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDLI9nR
4dXnqqk9dYWfoXVlGGPRRH9uNhuwXsMKXEtdTamGK0p05eOZS8TrxB4jE4kSPYUHv15QYew3OuxJ
z+1zVT32RMeIvIFYM6zEc4zqU+fLeSU29IzOwPwIjQsoNF1h1GuSlJaRwfrikQ5NncMSjGOHY9Rj
5j6TRplumPMIqG1ed+0ZMYNtThvRyQERzPlMeTLuIm/lihwu8k/upEDBfa8zlc3Xr9ldcPkg+j9j
JkCTTJl7mG7IIrqCPL+2VKCIbzwh0lIEu0EnAB90eG7YUAA5X2p9Lgs6MKbo9BkyvBQ1XBr9DXhF
va9pYk9sgfI0kkLEqQyK7NkYvnkVzV15
--000000000000e8c2a90614380775--

