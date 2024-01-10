Return-Path: <linux-kernel+bounces-21736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDBE829384
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645FB1C2161A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721DF24A14;
	Wed, 10 Jan 2024 06:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eloBkqhq"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFA62F37
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 06:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so3461759f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 22:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704866405; x=1705471205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kPeXYoAmCLYf1j8ahUbrM6AOYKYmAzDrbvQF6GEOMok=;
        b=eloBkqhqW+5Upu0ryviMYl5V2rwTI1PwBJwdcpTjXdoHjGzzmenuUdE/VnJ6++gpDA
         tIJBQvIeGdX/n/K5Zy+JjkQTIxR7OCHKmvyw87WsdBWs3W/Scm+OQXS67bdWS7mc3Mou
         s9a4NU60aDbObZi+JJb+277Lz98KM4Up5kKyFtQ3NezhEY3EPTVKa12sO/AdK5mcUis2
         eIolvCIY2tujxszRmGuVBrKwIjU1ANa5xoCMqhFFXpxWKamht9MKgkJZAFtgQOrPXTp6
         dYI1aHQkJ1feFSasecRQwFHN+C7daXvDQsQDAbE65GHbTtjgocbQTPsuzYyd+ITKJFbT
         MNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704866405; x=1705471205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPeXYoAmCLYf1j8ahUbrM6AOYKYmAzDrbvQF6GEOMok=;
        b=AL2D0hGDl8xMGsiczNulvPhWg+QkD8hbqfuqWOwp+jcjKrvjDEPGqOoFvy0HGepY/4
         UvIyvdsQ27fTCfNcS+4ng2IW+P2rTvSy3BYdhD36JplKyJ4/ki8cD5nMrBDBm5syZrxi
         c8X8SHyBVhBtf7oNFQWK/NmvZ+ZDSJkHOswro4vvFDjtD9zcqKnIAqpHt7ekH9gqb4l8
         AcQaoN2gFwltL+9yP6Xlt4GMpyyY8j5aypUloyd5hdIAQXMzcXYabShXzC61znUk0zFH
         dPVitxj7f7xzpNgrKWPsRdlRyyVojHvNh8e9+35w8WxgnTWsAMLJaekt4hIOlMcbf2oJ
         jZlw==
X-Gm-Message-State: AOJu0YwaTfR3jhboimn/2zSyKVz1kU0/m759MAFI2uAU8bs8orwEu2oS
	TbgMTCoO1OMymrw0KdSIlrC/TazFRnWVYJyQocu6EN2eAxk=
X-Google-Smtp-Source: AGHT+IHtUtnhqCk4yVP5kMCpqHp7bM26pNDSBAjHHvyDk9phnXi2Zde5FpTxSnJ7iUAEVMxVayOx72WBjoWCAcGlsQ0=
X-Received: by 2002:a5d:4602:0:b0:337:61b1:68d4 with SMTP id
 t2-20020a5d4602000000b0033761b168d4mr219120wrq.35.1704866405170; Tue, 09 Jan
 2024 22:00:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJNi4rO+Dw5qYDtyJVbuo0OqAoXpGq_Qq6xjH9cvMCAUnW+77g@mail.gmail.com>
 <CAJNi4rMHtM=39jzkzwqt++kVpSp0=XfDrVdY94WoW6B34oKwDA@mail.gmail.com>
 <ZZb2f0U4qTWDjCGj@FVFF77S0Q05N.cambridge.arm.com> <CAJNi4rOpzmQAW1Fjst-Em=SQ7q8QsQh0PWhVxUizrOW9JukOgQ@mail.gmail.com>
 <ZZvS8rigFJR8L56c@FVFF77S0Q05N> <fb6c8253fd90e66c036a85954c3299bc2c047473.camel@xry111.site>
 <CAJNi4rPj0Wc7ByqrS-GVLUUEnOFPZi8A5nLLCEEJErqAe16EZw@mail.gmail.com>
 <9aef98eed96ed32962ce90499291cb30ad5e3e14.camel@xry111.site>
 <20240109074843.GI19790@gate.crashing.org> <4ee8067e72028b070d92e10fa33ddde3a498cb48.camel@xry111.site>
 <20240109082647.GJ19790@gate.crashing.org>
In-Reply-To: <20240109082647.GJ19790@gate.crashing.org>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Wed, 10 Jan 2024 13:59:53 +0800
Message-ID: <CAJNi4rM_w5JKjug1PtV+tHyk11DUhRJ-K1pSDE6P1x8KSU2wrg@mail.gmail.com>
Subject: Re: undefined reference to `__aarch64_cas4_sync' error on arm64
 native build
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Xi Ruoyao <xry111@xry111.site>, Mark Rutland <mark.rutland@arm.com>, gcc-help@gcc.gnu.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Segher,

A ported driver in linux kernel calls '__sync_val_compare_and_swap',
the cross-compiler 'aarch64-linux-gnu-gcc' doesn't complain
'__aarch64_cas1_sync' undefined reference, but the native compiler
will complain. As Mark mentioned, I double check that both cross and
native compiler should have  ''-moutline-atomics' option enabled, do
you know the reason for that?

