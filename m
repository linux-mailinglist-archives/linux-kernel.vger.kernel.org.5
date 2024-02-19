Return-Path: <linux-kernel+bounces-72134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2E785AFCF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533571C226A9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08A156774;
	Mon, 19 Feb 2024 23:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FegLkIkF"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BDA3C36
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708385995; cv=none; b=QkljmaQJzZ6ubbsgAQL0tE44oaqI4sIPJfnB2BlwNC6Mi293cg/BaJO3AhXFsBBOBz4qXHSWFwT0COQKqmm4UxI9GyRKPKKDvyaQZmh0gXttTn78vjln1eXghpd2ExqKdDz7bdPkE6h5YjdRTntnUBKpa32GEDz3mVf94w1YlBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708385995; c=relaxed/simple;
	bh=ThsKJiCIaJ23r3/rD1WznWE4qDzQWwbwXKRt2d4kCFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzJejGVD9QdQ9J6ibQ+zi5KvAVzcElowQByLxbHOokPZZBjnPsaStKQh9i8dsyYbSoN/9iqiRk+bw9K/g4mtA75bom8s2UCtdZ+GJaMqf5Hf+CYfBSFU+yNueWn4CoxUwHdKOnKTjULOpm08d3gX0dvSZzBdIO0OiluiIvJ9qcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FegLkIkF; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-563dd5bd382so20772a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708385992; x=1708990792; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ThsKJiCIaJ23r3/rD1WznWE4qDzQWwbwXKRt2d4kCFw=;
        b=FegLkIkFw4pZ2Uh3pCTnf0nULt2SomCo4DQMosh6sGh+Cwil9KhHCcHLISdv5sUJmB
         8aYfyzuDbrLWAHIL5UZOdwGDqVyCJKWUYURex49QJj2nfM7JwPZc5PWWXSYuxzOaF2E1
         NxYJQOaEYsbnCsoPIcE0tkqKm6XjTQWtd8rnsyfazmsRVSl7ifp+uLJdX/DNUIrqYVoo
         6aatzSd2SiR1gmmFgQAS79NTPX6eIX/d3PzlM+mm8pjJ3RtkJUthzOYfW24pBJiv7PIR
         AgYG1rTlgCWmFP/fIBrF/uNf6/TMdYlajVQCh4UD/Q3EyNzwo7liRLz6JX2hkxL40P4E
         437g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708385992; x=1708990792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ThsKJiCIaJ23r3/rD1WznWE4qDzQWwbwXKRt2d4kCFw=;
        b=qEF042QP/fi4TFG64E8KacZCda7w4SxSgk6qDzw+g5e5855JN89b1G5LNjIL4U6Dne
         ytxCcEnBoq6pBt2B4M05XVj6xZHWUNfcEZkXUGSExK2aCkbeVAoh0Siu5UwxKTmm+kt3
         y6KmfOzECxq5SgO+X+qIhMrEDOLahqkc5ehF3kOUCTxuMgsRVzRm/2nveajUlVfme+t6
         KLv0VLp5CQUD3BGWfWZHtP0YhewFYAF0nd8RBg9RIlIEnYGBn8PDBK2gPXGfrluz/2o/
         mNVyk09f9HOqfSVZ6VSZkYt5xutL9wRvXrsHTbqI5lZ2FLTinGVhF9yE2KuhrEdTw+s2
         v1MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZvdkAL+rHJ7ZwZeXYt29YcWSANcAhQ4Yx3NNo4GDhfA2V1EEdSO34MU7FHW3tDBTLLyU1Cmq9Ai8OxzrbWjCb2CdCnlRAwl2ogowd
X-Gm-Message-State: AOJu0Yy9Iem5Kr1YjDb1RUTtWA5s0cxJN4L8fBLOWzZFBo6QGw1BVgrX
	s5ItbmbmDkwwNNglPDm0CcseY4c+5l/qRIFh1PaIRt+GkDZNC+9waHSvz3qFOCmMIM5X957oGcv
	zHsZDP7CNR6FP0yUp1SkEA9XKhVmLT+TWAO/2
X-Google-Smtp-Source: AGHT+IFI9ErYFSTuX/iUh2FUDqVFuu4qOOZGA8jVsVKQ6ZfJMAt0wQuav3WLQqFEG2eVM+DCyyqKrGmbs2GWs8UDmBY=
X-Received: by 2002:a50:a697:0:b0:563:ff57:b7e8 with SMTP id
 e23-20020a50a697000000b00563ff57b7e8mr352162edc.1.1708385991590; Mon, 19 Feb
 2024 15:39:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214-bus_cleanup-kunit-v1-1-1a38323eed73@marliere.net>
In-Reply-To: <20240214-bus_cleanup-kunit-v1-1-1a38323eed73@marliere.net>
From: David Gow <davidgow@google.com>
Date: Tue, 20 Feb 2024 07:39:38 +0800
Message-ID: <CABVgOSm+nrvWsAaT-ttRiAw4rHp+HUfw77t0q29cxdweUjVZ4g@mail.gmail.com>
Subject: Re: [PATCH] kunit: make kunit_bus_type const
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003177fe0611c49c0f"

--0000000000003177fe0611c49c0f
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 03:14, Ricardo B. Marliere <ricardo@marliere.net> wrote:
>
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the kunit_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---

Looks good here: thanks very much.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

--0000000000003177fe0611c49c0f
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
hvcNAQkEMSIEIK2l2CPN4toNUWvpU6EFEH6O9zWgIPre48CTL2ulu1eOMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIxOTIzMzk1MlowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCl1C4P
W/HS4et3rru7W6UJA9LIkZW/B/cxFWxIxrXcEWWDn2/vrsA3rRqXkp8UDEP19VkY2MdecAcmr02G
WL/fnZwXV5xbN30O699UVuLRV9i2/zkewucskTwtGTg0+CCwzvNzGdKPpKSUKUHT5KBJZExPPQX/
KhXQiBwzs5Vkn33O6KX40mqQislCaaCqPF1rLh7ZOZJQbSCn171mxUTakfVGl89ud2dSTaF0GN+w
crn+53bLq56l1yyrBHzSISOP/HxZjaxTSheZnvwz0P+/WXAPZKDgMamm5ypcRUNaI5wYpkEFL5/S
3fL0jpU7lJGxxigc5HSo2oTglObNR4DA
--0000000000003177fe0611c49c0f--

