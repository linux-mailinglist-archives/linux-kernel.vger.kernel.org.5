Return-Path: <linux-kernel+bounces-60630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4208507AE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 04:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E25284308
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 03:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849E7107B3;
	Sun, 11 Feb 2024 03:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKDxWTUr"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F995FBF3;
	Sun, 11 Feb 2024 03:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707622891; cv=none; b=llbM5Gbqxbg165A51saD1ANnKBsIfIAI4jU+NyiF7vsP0pNkhEzvKo65q/jcSpM/G5zJCr3NH+GNdJ7M+XTP3lEpiyRJzCJ74A2f8WMEDAGr4hPNjcAUz74leYmQyVj6+SujwB2c5O1cyhiHRQD2CcG/qSU2rdVGsCMQBod5VMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707622891; c=relaxed/simple;
	bh=auuCPbN9842/RrHszjOgD6O5M0WHx3WynlBp7vOvpEA=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=YRPwA+d4VnIm3g5eBbsCZaoNY/z5K+O2AgssliIVDMTBn4iZP8kYESf56ZMrbP+IUMKzyIhYMPlqFhxWb4IK0Yw8q7+t5MlJWFwaoKoMgPthb7mlqJkQ6W/nli6Iq99yYDy1mH7yZ6sujUuhY6hz2AKBqaFP5Mdn6nRV6bPWM9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKDxWTUr; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e2bd53235fso1119963a34.2;
        Sat, 10 Feb 2024 19:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707622889; x=1708227689; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57WDDKI88C6M85fhcIOHg/OvMgqM+Mfmauuh7lerMR0=;
        b=ZKDxWTUrIBuOjdJ3gjoZy9+ZHKDIsaML7R1PAinKTfl/197TnbPkc/itgzKdAO+cgt
         S6CJRvkDkx7oMmFJuPkHmOkpYNipo6zWkw4A65NSEvnu7/f+QzY+yKqN1QcRjNdpGsiz
         Ivs3p7kEF2ENcb5+oZWYRYmnWULhloN0OPXZpWgKBMtlH8qaLoovT+KtnHtg8bz1DB8t
         Y354fqLIhdI2k6pIQpkpO7/ip2+s9oU/AlTFRsBIu5KivEA7MADFoD2KeJw9SX8B9g6w
         nnBC1AqxVAelm1igkSYs7s9s9HZgADClMvPLCjAdDs1nT7SCDRsb14Cr6yak3/UTx2Py
         px7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707622889; x=1708227689;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57WDDKI88C6M85fhcIOHg/OvMgqM+Mfmauuh7lerMR0=;
        b=MCWlN6SniC+pAGaQqyucVsaikxk8NtKhGasBe5vD4qoun0m9aumEwHbK/DmmljOpGx
         jOdJz2DoyI+lBtMAyaHzLweiTq/UZ5CtrXCbcFvmhwTgwwWMUvXsYLW1o93ve8qhA8LF
         WBE+71f+Va+uGgGqTYI9PBqJlykqAeSzx8cGU8aW879yOHJ9B68Xsb2W1n6oUsD1Xfdg
         pUVkBX94BIVGNrKVr2Uz0snABU2X0vbUkCtXZi1iREkjB5Yg1jMoCNIcKlXuqWoDRi/m
         3kvub/WBWFg8GYniQp5NmzEsHejQdu7WI5f7s3pdvqh7s+5cZDvB2ELhSe9fr887nth7
         IXTQ==
X-Gm-Message-State: AOJu0Yw23niRjcGm6uNSXcV1Zpft/Tard4KaHyurF5C/J8ATgNrR7P5f
	fF1FZmv/k0C7MjIvtdXtOfxCIBJqSSqO/CRtWYhg7LjrIRcoDSXJSFSrjC3QsyQ=
X-Google-Smtp-Source: AGHT+IEpH4avlqXDRFEkcw9u7eAiA0lwggEyglw3VFz2+sARS1ltKot/tRXDCboms7SGAOAie+E5Lw==
X-Received: by 2002:a05:6358:618c:b0:176:d2dc:5115 with SMTP id w12-20020a056358618c00b00176d2dc5115mr4168500rww.20.1707622889002;
        Sat, 10 Feb 2024 19:41:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXI2x1ZqeBGAloHSIT66e8M3mFAswPnjNJRV038X6bqt20nNIiwbey2D2InI/x/O1/Cxn2U4dbF410IbiTFXA8iwluIUREAzTN/kc6TcIYsaglkR+yBxtT787+M+aSvXM5/pl/PVZxBME4J4g4/PeKUsjP5gk+jZWZNzOrSC6PlMzVMcZ/g1/Igvdzri49MAQWNbgs=
Received: from smtpclient.apple (g1-27-253-251-175.bmobile.ne.jp. [27.253.251.175])
        by smtp.gmail.com with ESMTPSA id d20-20020a170903209400b001d8e4de7a44sm3678407plc.127.2024.02.10.19.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Feb 2024 19:41:28 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: "D. Jeff Dionne" <djeffdionne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Problems with csum_partial with misaligned buffers on sh4 platform
Date: Sun, 11 Feb 2024 12:41:16 +0900
Message-Id: <8C704EE6-7B5E-4569-B9C3-84B2CBADA102@gmail.com>
References: <0a0fbbd8-17dd-4f4c-9513-f3ac9749890b@roeck-us.net>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <0a0fbbd8-17dd-4f4c-9513-f3ac9749890b@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
X-Mailer: iPhone Mail (21D61)

I remember there being problems with alignment on SH targets in the network s=
tack.  IIRC, wireguard triggered it in actual use, seems to me it had to do w=
ith skb alignment.

Rich Felker may remember more, but I don=E2=80=99t think we implemented a (c=
omplete) solution.

Cheers,
J.

> On 11 Feb 2024, at 07:03, Guenter Roeck <linux@roeck-us.net> wrote:
>=20
> =EF=BB=BFHi Adrian,
>=20
>> On 2/10/24 12:12, John Paul Adrian Glaubitz wrote:
>> Hi Guenter,
>>> On Sat, 2024-02-10 at 07:12 -0800, Guenter Roeck wrote:
>>> when running checksum unit tests on sh4 qemu emulations, I get the follo=
wing
>>> errors.
>>>=20
>>>     KTAP version 1
>>>     # Subtest: checksum
>>>     # module: checksum_kunit
>>>     1..5
>>>     # test_csum_fixed_random_inputs: ASSERTION FAILED at lib/checksum_ku=
nit.c:500
>>>     Expected ( u64)result =3D=3D ( u64)expec, but
>>>         ( u64)result =3D=3D 53378 (0xd082)
>>>         ( u64)expec =3D=3D 33488 (0x82d0)
>>>     not ok 1 test_csum_fixed_random_inputs
>>>     # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit=
c:525
>>>     Expected ( u64)result =3D=3D ( u64)expec, but
>>>         ( u64)result =3D=3D 65281 (0xff01)
>>>         ( u64)expec =3D=3D 65280 (0xff00)
>>>     not ok 2 test_csum_all_carry_inputs
>>>     # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.=
c:573
>>>     Expected ( u64)result =3D=3D ( u64)expec, but
>>>         ( u64)result =3D=3D 65535 (0xffff)
>>>         ( u64)expec =3D=3D 65534 (0xfffe)
>>>     not ok 3 test_csum_no_carry_inputs
>>>     ok 4 test_ip_fast_csum
>>>     ok 5 test_csum_ipv6_magic
>>> # checksum: pass:2 fail:3 skip:0 total:5
>>>=20
>>> The above is with from a little endian system. On a big endian system,
>>> the test result is as follows.
>>>=20
>>>     KTAP version 1
>>>     # Subtest: checksum
>>>     # module: checksum_kunit
>>>     1..5
>>>     # test_csum_fixed_random_inputs: ASSERTION FAILED at lib/checksum_ku=
nit.c:500
>>>     Expected ( u64)result =3D=3D ( u64)expec, but
>>>         ( u64)result =3D=3D 33488 (0x82d0)
>>>         ( u64)expec =3D=3D 53378 (0xd082)
>>>     not ok 1 test_csum_fixed_random_inputs
>>>     # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit=
c:525
>>>     Expected ( u64)result =3D=3D ( u64)expec, but
>>>         ( u64)result =3D=3D 65281 (0xff01)
>>>         ( u64)expec =3D=3D 255 (0xff)
>>>     not ok 2 test_csum_all_carry_inputs
>>>     # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.=
c:565
>>>     Expected ( u64)result =3D=3D ( u64)expec, but
>>>         ( u64)result =3D=3D 1020 (0x3fc)
>>>         ( u64)expec =3D=3D 0 (0x0)
>>>     not ok 3 test_csum_no_carry_inputs
>>>     # test_ip_fast_csum: ASSERTION FAILED at lib/checksum_kunit.c:589
>>>     Expected ( u64)expected =3D=3D ( u64)csum_result, but
>>>         ( u64)expected =3D=3D 55939 (0xda83)
>>>         ( u64)csum_result =3D=3D 33754 (0x83da)
>>>     not ok 4 test_ip_fast_csum
>>>     # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:617=

>>>     Expected ( u64)expected_csum_ipv6_magic[i] =3D=3D ( u64)csum_ipv6_ma=
gic(saddr, daddr, len, proto, csum), but
>>>         ( u64)expected_csum_ipv6_magic[i] =3D=3D 6356 (0x18d4)
>>>         ( u64)csum_ipv6_magic(saddr, daddr, len, proto, csum) =3D=3D 435=
86 (0xaa42)
>>>     not ok 5 test_csum_ipv6_magic
>>> # checksum: pass:0 fail:5 skip:0 total:5
>>>=20
>>> Note that test_ip_fast_csum and test_csum_ipv6_magic fail on all big end=
ian
>>> systems due to a bug in the test code, unrelated to this problem.
>>>=20
>>> Analysis shows that the errors are seen only if the buffer is misaligned=
.
>>> Looking into arch/sh/lib/checksum.S, I found commit cadc4e1a2b4d2 ("sh:
>>> Handle calling csum_partial with misaligned data") which seemed to be
>>> related. Reverting that commit fixes the problem.
>>> This suggests that something may be wrong with that commit. Alternativel=
y,
>>> of course, it may be possible that something is wrong with the qemu
>>> emulation, but that seems unlikely.
>> I have not run these tests before. Can you tell me how these are run,
>> so I can verify these reproduce on real hardware?
>=20
> Enabling CONFIG_KUNIT and CONFIG_CHECKSUM_KUNIT on top of a working
> configuration should do the trick. Both can be built as module,
> so presumably one can build and load them separately. I have not tried
> that, though - I always build them into the kernel and boot the resulting
> image.
>=20
> Hope this helps,
> Guenter
>=20
>=20

