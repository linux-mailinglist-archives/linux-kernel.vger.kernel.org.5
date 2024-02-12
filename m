Return-Path: <linux-kernel+bounces-62487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B2F85218B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241AB1C2266B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E414C4DA1D;
	Mon, 12 Feb 2024 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HMq16zGc"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940CC45C08
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707777563; cv=none; b=GH+fn1LIKGWAQB4zQjjpMOoOQvkbzKvS42a80wIRJrLgTM7tgbvRF528ufr9K6v93nWCHbk7KrePwymYRL+fvk5QS/PwuMU9v0E0BJ1yHafwp1bTuXsT4aHWFdBxv17XFXXB2UTZxdssj6Y46YEC/bQ4MQhc706eoR9lGnNpgNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707777563; c=relaxed/simple;
	bh=K7eZeqRd1aGN08TWKjbUUoMlnMdFAiRi7op/Ec20HF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPPbhLrKL78JFfhjdTLkLrua9p5GIs0crHUN4Qqr8NWRRzWt3lHHJWie7pSYzH5GVfnrK8HmQTziLC63m4CxShpWBI/juvydquxFmhvLfqM7s6n0GCoChiO9u50oI0pocRLaINK5H92Ki4beWYcVcmBbHZakWdiI2XtAZw3H4Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HMq16zGc; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42dac9f7183so41811cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707777560; x=1708382360; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K7eZeqRd1aGN08TWKjbUUoMlnMdFAiRi7op/Ec20HF4=;
        b=HMq16zGcR/pQTqih0RK1aPqbEtv4WOj9pepVq0UqdYbyridYtGyW9s7rTtAjlp+eXQ
         JpQyFMCg7QQ13Dv19jCTb9ntD6VSdu1x5v/MokjMO3IPNvpk2GeOge9UzzJnTWWnTpHW
         SdM7CsEf4lTawOqFpCxDKg8JDV8di7ffRkdbCsXQQ16d6aKOT6L69hmvSTzS6MbmDcgp
         Q2MWtYP3+Fp26NDnCtwwUkgNfn27DMgiPBY702PQdfgD298leeioC20Sat2eFeHJUMcX
         3FQW4FIAor6Gaf9XB26LFsLl94uZS0Uin8ZjOcpZB9GxDZeZlPhxf4WPBQQloxQOw084
         4x6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707777560; x=1708382360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7eZeqRd1aGN08TWKjbUUoMlnMdFAiRi7op/Ec20HF4=;
        b=s8yrG4YlWwhX0AT3y+5J8X2/G0P8XbMXjqA+2ienZwhG0BnhfZSWhHumFCfRxxMd4i
         X/zVJn04Rf0fmUELLl19gqxKgaYiHNaoIRtyNRevZWuvwa15wBaJTwEdIB16igyI+OJt
         hF675u5ZaTFlJub6z18XagvfFoicPlZ6ScsmjK0Q/TLJiVkzVuv3cdi861DfqKjzabp1
         MOo4tMkdi49FBsgs3Sl7kc2XBJWKSUDIcck9R7TFnOjJvYKMe/W5dISB3iuJZOBWFIru
         MQzr4E1XpB5mGt4zrpDmFDOERO0pEgHuH9k5IM8POMAY4Q1gcxgHRT+03gJQw/sM9Npw
         VS6A==
X-Forwarded-Encrypted: i=1; AJvYcCXEWnMTZ52W98yXp37OI3E0H+8tqQGcWHfNj7lcikKqBtgj28R0yEX5DroTIVeSug8VR5lex2z83u1rj48esbvW53yK+3NWNBVvXOLQ
X-Gm-Message-State: AOJu0Yy6kqTf5ms7FVx+zsYRlkOSzNknGc7L26JFYyqaD+VChV4ZTVsF
	QwHABYTLbV+is8srZhCrfgymqwPrJmDFvmx5jr8B1fje+yD1+gOtvvKQmcGmYr9FYChXQKzRsVN
	aFUy6XRbt90K/yfloA6rh8ZL+zxMzUyXjOAud
X-Google-Smtp-Source: AGHT+IEvdQndILyU0yLsK1JmFeStdZtm8LhMnIkzmxUPgo1OUPba+BgwGeQHluiOzJy1PIxXYsSoS+FPJnlkbqs0ZEg=
X-Received: by 2002:ac8:4f13:0:b0:42c:6905:c449 with SMTP id
 b19-20020ac84f13000000b0042c6905c449mr39135qte.12.1707777560338; Mon, 12 Feb
 2024 14:39:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACGdZYJ=djg1yDbZxd1AjH1Qa7rWa=vj8Swz33oFCsG63DsVWQ@mail.gmail.com>
In-Reply-To: <CACGdZYJ=djg1yDbZxd1AjH1Qa7rWa=vj8Swz33oFCsG63DsVWQ@mail.gmail.com>
From: Khazhy Kumykov <khazhy@google.com>
Date: Mon, 12 Feb 2024 14:39:06 -0800
Message-ID: <CACGdZYKdr9UVBvDuc-f5K9JzChT-hcseiSrsnVCp3Y56wznS+w@mail.gmail.com>
Subject: Re: dm-ps-historical-service-time should probably set QUEUE_FLAG_STATS
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Alasdair Kergon <agk@redhat.com>
Cc: dm-devel@lists.linux.dev, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ddb60f061136f256"

--000000000000ddb60f061136f256
Content-Type: text/plain; charset="UTF-8"

(urgh, apologies for the html)

We use io_start_time_ns in dm-mpath.c, but the only actual user is
historical-service-time currently. We need
blk_stat_enable_accounting()/blk_stat_disable_accounting() calls
somewhere.

I was considering adding a new multipath feature flag, but we already
have "DM_PS_USE_HR_TIMER", which seems similar in spirit. Would that
re-use make sense?

Khazhy

--000000000000ddb60f061136f256
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPpgYJKoZIhvcNAQcCoIIPlzCCD5MCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0AMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
SPh60fMS/BAZAfowVwYDVR0gBFAwTjAJBgdngQwBBQEBMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUF
BwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAMBgNVHRMBAf8EAjAA
MIGaBggrBgEFBQcBAQSBjTCBijA+BggrBgEFBQcwAYYyaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5j
b20vY2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAwSAYIKwYBBQUHMAKGPGh0dHA6Ly9zZWN1cmUuZ2xv
YmFsc2lnbi5jb20vY2FjZXJ0L2dzYXRsYXNyM3NtaW1lY2EyMDIwLmNydDAfBgNVHSMEGDAWgBR8
zApo16LrHixyG9HNXZVvjfvyYzBGBgNVHR8EPzA9MDugOaA3hjVodHRwOi8vY3JsLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwLmNybDANBgkqhkiG9w0BAQsFAAOCAQEADOZ8
1d6SfBe6MGM7BIlBPciQOrQUSP3rMxR9IE7z3I8RKn1UhC2fZsBwS90WZslOrHe4noODOUIgLEBx
R7b1mDlfU/lqCYTSUVRwXLAq/pn9IOyciHvLwN5MUx6rmSmRK618tzTVuD+qmFP4kMULdZe9FNBZ
PUKVmJrtrPKvOHNkrlJiVcwXkAAyOkwIVYAmFvCmi2GQRPmB/sFLFXQ8fGgLSFL9KuRyJW5nKVCK
xOH0gU9pHCw1g/FCYilgOAckCr2dolz81fhW9l3OKxOrl+qJ3RhQpKQTDjUgxYoSCxwQ49udL4x/
3puQPCKgQeylpHKOhHAnXNa1hxaF02dNhTGCAmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAX
BgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01J
TUUgQ0EgMjAyMAIQASMN+3btH9LyJdhI6aKMFTANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0B
CQQxIgQgP3nqv2ONAmR6QEMgSvAZ1q34O3n65z3VyQcTkdnOuQAwGAYJKoZIhvcNAQkDMQsGCSqG
SIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQwMjEyMjIzOTIwWjBpBgkqhkiG9w0BCQ8xXDBaMAsG
CWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3
DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBADBJ209bvROn
qd7TCeugmHM8vR8CAEeFoSuW1O13IZytzIl1kVY35AK4OV8Pa6tY78Dw3FPrs5AnfKerB9Rl768O
TVpUADlgM+adb1C+9ibU6HRTybDtgoApY8GzdZ1jUbnvIpoLTHEwzocCp3fxKB0EhGaTaBK4IPmb
a8mHZGFm/3Ul4joXbU4I5V4ckDKhNfXrUn9ERSkbbUIGYZLlNRf+gYdKWXs8Ty4fG1v1v3/+HQ7A
bgNsvAGpdVoCxABM04xEAqCTSNSQoWIAAwVZ+y+ZyTsu3a/HHD1OQzRxAw5tEjMY6B2pm3V2zCKs
KyY0tJzUyF32fORtQxfcYKxgzjw=
--000000000000ddb60f061136f256--

