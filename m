Return-Path: <linux-kernel+bounces-72156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A53B885B01F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6E01C21A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DA9BA42;
	Tue, 20 Feb 2024 00:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lBHpxGiQ"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6481290B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708389984; cv=none; b=UDH+iuKgLsoJf0LvLNGTmbn6MqcyE7hu1dczgynIYYqZa7bf4gFNGASuEDnDwxb/h7YDPzxgMjYjyxRvL0OSAu0vPVirXpu2LmvdomnTil5919STc6E1Q/eNT5ynMGUwaCzSaPxY6Zh4p0ACfnv5aEClp+Wgt4KUVG+Gd1X62d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708389984; c=relaxed/simple;
	bh=EMFChxJAK7WBWspFqRBdtseGiJQcq0nnKgNfh8cc6OU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEgiMpWxPl82+j2FkCFt6JKDEYYwsc0pqOFBsK2rNjG94+moY/vrFEWlndEhaf5WwtVIhuqshIhT1+mJ5+s/wDekxeWY/9lrku84rCUTzSnmXJXnn7sZxF/HnzGBbFyRgfNx+r+MlTYjZaSHt6QeiQKCIn/32UWuA/4dpc7yoiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lBHpxGiQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-411d9e901dcso123535e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708389980; x=1708994780; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rbx7co0ICNc6LB7fEeqJ4VhoBGQ9HF56tSoFJ/0lYJU=;
        b=lBHpxGiQ130ALVF4KI8OS/p7Zdq/BP+0SPikQB5in83wdk4jAJO8EF0oaztbS2iBiO
         P80QfBI8VgRuBW76a/N3LFkUL3AQin9CV7eobRsRGoVIz68Ic6ANMw2jkio3N/0Hoiw9
         U1pztFfWZzGG/6fgFKvIiXTTZcmQ/gil8JlkRzOJaO9IeLEpneESyUz4a9JJcA6O70el
         2Kge1Ntcsm115mOzyVqfz/YZnJ8jCRczfab6CpOy4xVTzOO4ynKMCwiV3OR6GT4EhlVH
         Y4R4wPXnHHdJJimS/G7O3J1lu40HnhGO/EYx4NhNKRQPWDcUSX3Dc/uySPn5cK4FCQT8
         FcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708389980; x=1708994780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbx7co0ICNc6LB7fEeqJ4VhoBGQ9HF56tSoFJ/0lYJU=;
        b=Y88+4F/POyxcqpfW/IimumJw26WN8Bt/Ms4djPMLnT87RKPCIDT+DgWOXgEfQlcrte
         PH1/+BxmlhMYqJCTeUVUp/NHuemU+91HLuOcuUpqQzkPRwzVNsD85EgV4zIN8hHZrT4d
         DxwlnqX6upYMuqqEkMcuO1VwKPk6NsHkWu3UjuA7YC4lgfNPnZyMQDnJFqvVj4MUATvm
         T/MtiK9WjGJGFY1/BUFhJ015G2gLg3VGPrMRdXpXfgCbwJql4+KiCszgIgwPGhIVujBG
         Kv+ZNDmDrt04bSDGnnzDIurLBkyYESHFgOBEKAqUCguMU51qPnKi76zYdwbGGh2OnTTE
         +2gg==
X-Forwarded-Encrypted: i=1; AJvYcCXjChyKlBHUiu331Qaw2FeMPY5Z9BwBEIRTTv1Fh7X3izPTbSu2bkqShGUlQ7Q8S07xQLOQJVib+0GPfooyOhZ763Q2bOsRknegRq6T
X-Gm-Message-State: AOJu0YzZrKRcgn6zsqnjDNPgpI3BvzkaY0qdPMLuUx5zbznCsu6abHrs
	MIs/P5kdRx4wk3csLLo6PNbfdc8iCLlP8CM97/6dRgMiQ+zRFNY7VxIaGHG0l45Yvx1CZVmPzPR
	e20bQCQI0PwaTHE6xJ++u1hQsRZbxBUBn6a6slJl2tlMK5GIyvg==
X-Google-Smtp-Source: AGHT+IGbzgg5emOmsNJabzEMv5o/6mu1/+eSDYXgzIO0NzlPlKMid4nGtCQHEX1ZfiIiyNvmuNjsKKzwrbBml9MCZEo=
X-Received: by 2002:a05:600c:6016:b0:412:6d18:7276 with SMTP id
 az22-20020a05600c601600b004126d187276mr45956wmb.1.1708389979994; Mon, 19 Feb
 2024 16:46:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214124131.990872-1-paul.heidekrueger@tum.de>
In-Reply-To: <20240214124131.990872-1-paul.heidekrueger@tum.de>
From: David Gow <davidgow@google.com>
Date: Tue, 20 Feb 2024 08:46:06 +0800
Message-ID: <CABVgOS=n0rCS6ecAAh7BKkZbQQJu7ZHNrMJhkFGDqDG_n-U9bQ@mail.gmail.com>
Subject: Re: [PATCH RFC] kunit: tool: add 'mte=on' qemu arg on arm64
To: =?UTF-8?Q?Paul_Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Mark Brown <broonie@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <linux-kselftest@vger.kernel.org>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ebb5e70611c5896f"

--000000000000ebb5e70611c5896f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Feb 2024 at 20:41, Paul Heidekr=C3=BCger <paul.heidekrueger@tum.=
de> wrote:
>
> Hi!
>
> I was running some KASan tests with kunit.py recently and noticed that
> when KASan is run in hw tags mode, we manually have to add the required
> `mte=3Don` option to kunit_tool's qemu invocation, as the tests will
> otherwise crash.
>
> To make life easier, I was looking into ways for kunit.py to recognise
> when MTE support was required and set the option automatically.
>
> All solutions I could come up with for having kunit_tool conditionally
> pass `mte=3Don` to qemu, either entailed duplicate code or required
> parsing of kernel's config file again. I was working under the
> assumption that only after configuring the kernel we would know whether
> the 'mte=3Don' option was necessary, as CONFIG_ARM64_MTE is not visible
> before.
>
> Only afterwads did I realise that the qemu arm64 config that kunit_tool
> falls back on, uses the `virt` machine, which supports MTE in any case.
> So, could it be as easy as just adding the `mte=3Don` option to
> kunit_tool's arm64 config? Would this be a welcome addition?
>
> What do you think?
>
> Many thanks,
> Paul
>
> Signed-off-by: Paul Heidekr=C3=BCger <paul.heidekrueger@tum.de>
> ---

I think this is fine. I'd be a little bit concerned if this were only
supported in newer qemu versions, but it seems to go back to 6.2, so
should be okay. I think it's better to just enable it unconditionally
by default rather than trying to parse the config.

The KASAN tests seemed to work fine with HW tags in my testing here. I
do wonder if there's a way to make the tests skip themselves if MTE
isn't available: is there a way of doing a runtime check for this?

Regardless, this is:
Reviewed-by: David Gow <davidgow@google.com>

-- David

>  tools/testing/kunit/qemu_configs/arm64.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/kunit/qemu_configs/arm64.py b/tools/testing/ku=
nit/qemu_configs/arm64.py
> index d3ff27024755..a525f7e1093b 100644
> --- a/tools/testing/kunit/qemu_configs/arm64.py
> +++ b/tools/testing/kunit/qemu_configs/arm64.py
> @@ -9,4 +9,4 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=3Dy''',
>                            qemu_arch=3D'aarch64',
>                            kernel_path=3D'arch/arm64/boot/Image.gz',
>                            kernel_command_line=3D'console=3DttyAMA0',
> -                          extra_qemu_params=3D['-machine', 'virt', '-cpu=
', 'max,pauth-impdef=3Don'])
> +                          extra_qemu_params=3D['-machine', 'virt,mte=3Do=
n', '-cpu', 'max,pauth-impdef=3Don'])
> --
> 2.40.1
>

--000000000000ebb5e70611c5896f
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
hvcNAQkEMSIEIGTXQnRWZHumS7wjpYgJzOM4uizDONY1wq25LB9T9bFXMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIyMDAwNDYyMFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBDXZyz
Rg+xlWe9RropPo8S/0RFTnlkOLmwMh1/uMEebOVrPWRYyG4cr8M4RpJp80tLS7N0qXYYalJUhM2a
xuWpJr2CmgYLe00KzhX8c5jfZWfzCwnu3S4xFK+WVx0pqJvhHVexeHS4EbHPhBrWkWNam29YKVoP
zpgU0nvH/4BtLQ5OEYKEr+rD/GZ+Y5OXnwqoWS8bzn7aQLllt/Heg2sq9tjnTyeZsFNbm7WmN/rh
y7g9ZK3z3wgcLn+3qNXaQJjMd2luH/jyWDqwXinU5jJWknc1+9GRs8W+AxA939LasrvyOlUgPLHJ
j0mTA3ChSX5uiEUs8oODMxciFJPzH5I6
--000000000000ebb5e70611c5896f--

