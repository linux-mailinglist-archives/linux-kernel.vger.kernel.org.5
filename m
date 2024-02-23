Return-Path: <linux-kernel+bounces-77857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CB9860B15
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ACC0285090
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE347134A3;
	Fri, 23 Feb 2024 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OuoNxWBk"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459C112E4E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708671720; cv=none; b=UZj0xqytzGcFwFe3DOEmM2Xjns+6nj1PBcgjoKKHOJB+cxd04oVWoKJkfGIBmWVxY+LURhNFhlMqKboQ4jjCw7khYQc4FtAL57Bce0KCBEO9BjSTtdDOEtMoLc40LJ63ZyAn9hZtYn+hjXN1J9IgUm0i57sb+masjsMKfrDLR6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708671720; c=relaxed/simple;
	bh=OicggR++no/rBmK47CuTnad564I7swRTv7LQDAJTCmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGNOqqbUWN8JIYicxl3VbO5/zT1xPia4Zy1BDG/ST7/vtPhYVhxe2TKX9E2Mp9Y14V+r0dGmtfhEeBfJxd2Hh7SeQbsB9LoxWoenaSj4WDz93HbtQfxAfT2ov29mk21cobOpr1GA1zLRexv9Xzy4Bo2RqnUZLGc7ki0CboJdC3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OuoNxWBk; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5650c27e352so5312a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 23:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708671717; x=1709276517; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TWaA5+KGjSMHjkuFRHM1qKgKplmkeIkG437TxnYzJSw=;
        b=OuoNxWBkvcGXqLWDzldbrJGHFArEk9tV08XTkom+YgOqgEV5KeRMynp4e3DqST7qzo
         6rl9//xrAJrq4efxkp20hcYFAGaUbcTOfZy6oZPB4SJnmVAouahPJ2R6PccRJbih3wCV
         WJZWTs+DbgHnMCBVXvhXPExL99owqxXauhIzdbovMeMf+8ZaQr4MXrrEPuUXZnjVSdIq
         qXxD8+e1b9ei0LbeFu1IuzfjUkV15kZBusgw4wdA04IHjfgUfeHFevsGKJVmkNPAl0+U
         W+E9f0zYAyu4ZsgnGv1G5o+JNnt/WBfCexwcU90eo+qFUik01CLfC3C28fC2HGozqKZ5
         LxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708671717; x=1709276517;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWaA5+KGjSMHjkuFRHM1qKgKplmkeIkG437TxnYzJSw=;
        b=Jlq3qG1ZR/eoHxp3B7poUhEW39iD7+5eqFLp0R3cqbyHrZBpL5sU9StTK2+I5NlV4X
         q7VkuR7LVYuKXF+D/CWscfTpbJ1K/DAx08PwEaKEp+5KdiEPLiLxWjJpu2Y3REWjUKqI
         6WhlEd7yi7+MDu65m7YGkqUyZ40hzQKzLGljnBY8IQqy5qIIuLLQy8zlT/SxS2UCt9Ia
         +8cYA5xK+odnEcm0ZWb9TmF3z4vMhsnejo4YUbaxkkhZLQw95eaL1iGKHlL28D5o6Q+v
         YREmXOAFuNjO9GnQqIqtRRyXM/0ivf9sYMDxd5Mrbj/h41APfZXHc9ycBA6rJxUMtNcf
         cRDA==
X-Gm-Message-State: AOJu0Ywtb9TmjdorLvo2WYhu5Fa0VkGQh5XiwDzBfq/9tXOnLJEa/90I
	tU17MiDOmqA/IghSw9oSL3q9c7v0nNcke2mDkciPCLhK8YUODPsrtcQNjEdXsFIM8MgDDcqTncP
	+Jr84eJ3kyUJHovw6OF5OeqD/h+PyPpb/Xn2uUkmENyQic1EjuVLa
X-Google-Smtp-Source: AGHT+IHgmbOQHwv1lw9Kp1RkyW7p5JFvBQO2BQnIB8YJ4mbBKKGXzxSKwS0FVQc1MQ4rfv2qH/7RRWSxlLbJFJNrsXM=
X-Received: by 2002:a50:8a8c:0:b0:565:4c2a:c9b6 with SMTP id
 j12-20020a508a8c000000b005654c2ac9b6mr246100edj.0.1708671717183; Thu, 22 Feb
 2024 23:01:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221092728.1281499-5-davidgow@google.com> <170853967893.398.2243431921138187436.tip-bot2@tip-bot2>
In-Reply-To: <170853967893.398.2243431921138187436.tip-bot2@tip-bot2>
From: David Gow <davidgow@google.com>
Date: Fri, 23 Feb 2024 15:01:43 +0800
Message-ID: <CABVgOSn8m9SgCzu0KzYt27qMsze+LfYET=d97Pb_=TCVciyzFg@mail.gmail.com>
Subject: Re: [tip: timers/core] time/kunit: Use correct format specifier
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c557c30612072237"

--000000000000c557c30612072237
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, 22 Feb 2024 at 02:21, tip-bot2 for David Gow
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the timers/core branch of tip:
>
> Commit-ID:     e0a1284b293bdf91a68a6d1a0479ad476d0d8ec2
> Gitweb:        https://git.kernel.org/tip/e0a1284b293bdf91a68a6d1a0479ad476d0d8ec2
> Author:        David Gow <davidgow@google.com>
> AuthorDate:    Wed, 21 Feb 2024 17:27:17 +08:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Wed, 21 Feb 2024 12:00:42 +01:00
>
> time/kunit: Use correct format specifier
>
> 'days' is a s64 (from div_s64), and so should use a %lld specifier.
>
> This was found by extending KUnit's assertion macros to use gcc's
> __printf attribute.
>
> Fixes: 276010551664 ("time: Improve performance of time64_to_tm()")
> Signed-off-by: David Gow <davidgow@google.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/20240221092728.1281499-5-davidgow@google.com
>

We're hoping to take this series in via the KUnit tree, so that we can
enable the warning in one place without annoying Linus with lots of
dependencies between PRs.
(See, e.g,. https://lore.kernel.org/linux-kselftest/CAHk-=wgafXXX17eKx9wH_uHg=UgvXkngxGhPcZwhpj7Uz=_0Pw@mail.gmail.com/
)

Would that cause a problem?

Thanks,
-- David

--000000000000c557c30612072237
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
hvcNAQkEMSIEIDSwtywTaIuCbUp4fAlX/Y90UkjWL//9bvATdN5uaI35MBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIyMzA3MDE1N1owaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC8LLNp
eL6lWas3eIxmtOo23P9Imf+9AePTkrWxCJbjg5RD+BriiR6CayxTjThsM9Bq4VlIRQU3SgZAP3As
tyzQnHgh/m8B8XiCGvP6/myMecHYdR3yROLbJfII62dk8ug6Wn9qZN9/34CY1qm/3QYdX81p00MB
35EGYHBPZz3uUaRlBtfVfMDoL7pUgfOywbSN3LZMIiafrm6DLenuhptrIs35kqRjMdZ9rNEDoSXe
a+6rn3OpBKdORB+MGjYM2LFkiVCtD99yiYnZeGu6ntaw8w/3nLakQf65Ey2CVIoRNILW12gq2ovQ
yt6aGhcjHg7Xl5/J0PTeC6Hv0ApEfhsV
--000000000000c557c30612072237--

