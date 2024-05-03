Return-Path: <linux-kernel+bounces-168212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353C08BB52E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2018E283376
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493543F8F1;
	Fri,  3 May 2024 21:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="R2lQxVma"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31994134B1
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714770253; cv=none; b=kMS3K+CWvAsgTTsYoSNo1heKXg70a8HmImG8iIfOccRc0CfE8C8CHdvNVQ1T4fHKAL2PR2RNV3szx1Om7D4x7OGf3XvojgqH7IH1H9xQ0MtHJyiHVCvugnGvyytDkdKI2GrpkQYvbtpK7VmFUMWS52ZnYXUdlUpuW/Yjt+jR1yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714770253; c=relaxed/simple;
	bh=kr8q0vJdMraPMNcp9YTW0aQV6wa6XsOli4AJVOGN+FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0R05LGl/ihApJo+qRlZd7Ms8xO86dQq3/w8k9VSQWcsKAn1hltbud8uLQKawgVsV1tXO4iSDhUS2aEoQ5ktPPWCkdRKrq1v8VAyNPLzfx+6i+w3GhTMAz6gekUxDlUpQfCYBQ9pMijAl/+/EoeMTufO+UfXEUxE1q/Q13Olwos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=R2lQxVma; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2db13ca0363so1475571fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714770250; x=1715375050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kr8q0vJdMraPMNcp9YTW0aQV6wa6XsOli4AJVOGN+FU=;
        b=R2lQxVmayNXUHwpKuRfC9YkGCKDIAp5W8O9Yeeo+wqgch81Jy9t5kaPmvPOs5WPnah
         PeyMPrbSqcei6cnBDnI7vDqAfq+39oT0gvEpq3ItwllkJmOcZQRqNM43yYCP+djgfWc/
         Ow8ILvCF1e9+5p4g+PWj4/OY3Cr5k0cvHlRvNBD/HRwF0sl6TGqUiUaH1XqEFtqh9FNX
         676PvH8MknEyR5Bt2CITcm3W0ZEuCi32hgpOK0Gf10wyPW+UEOgbwu1cTekn2lsP7Bux
         VfMqb+puY9Y5nnadlXbap4ZWY6Ljm7BfysRwyoS5putn8uHux/fQgtDgTrkvFBq4EUk7
         i6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714770250; x=1715375050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kr8q0vJdMraPMNcp9YTW0aQV6wa6XsOli4AJVOGN+FU=;
        b=SlNe0fdXt6KVfvzufvEYsHxase4FXeykAkm5YrNk213GRoJcvQi52I0waJ89HVmJQO
         vOFxpn92/hiEAQmPtMx2N4ka4sXwTxMgeU8YpbNOF6U1NFovDcj3MXog0d8J0fL+MCM5
         uAVkmYRUvZtPv4VJ/i5X+M07n4Gda+pCbWomNwwk7NqCb+zEB0OAu/iYTQUmeE1ir9dv
         pn6L/AN8+RC/YnlYy6XMcGDgB9z6RSVH8v1z5Qh1ZDQl/Se/4N7jUdeL38e1AoPJ7tta
         2JwaGJf3yDNlgvX1dArAyoHdA09NcD+jNSV6RYi6a9u8lxn+F5d4+ZDS8yLjTxCaXfNW
         /rvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/sSAcUw0bKVQwaIS9rNxPA0IfCRD3eVeY00uF7frNYMw00yvuz2Sd/DuzeSo0Km2MCHUXvNYF5hor+YLazzjUXIm2K+S02TSX5leb
X-Gm-Message-State: AOJu0Ywne8+WioUuQkMy8gcYhBWPDBqeGZgFFr5JAKYVnTKgmtfIgdvq
	cwuQlvJXBboMVwZeRUD8msJsXobjIAiml4YtSa5HmBeOGVHRcnAZnlXOHjLLvbj2woxGFTjTakH
	9tbR9uUZMcAu20+mS/3uTzlG06E2MW0pUeIacqQ==
X-Google-Smtp-Source: AGHT+IFVGeh8LKuvAXn0wbATQFthajoGa9wA2FpRSy48ryw0IkU/MmVyuccePKcDYu88/CEm2wRejt72X+QG3nu2ZVk=
X-Received: by 2002:a2e:a71f:0:b0:2e1:f255:6673 with SMTP id
 s31-20020a2ea71f000000b002e1f2556673mr3009473lje.13.1714770245520; Fri, 03
 May 2024 14:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
 <20240503-dev-charlie-support_thead_vector_6_9-v6-6-cb7624e65d82@rivosinc.com>
In-Reply-To: <20240503-dev-charlie-support_thead_vector_6_9-v6-6-cb7624e65d82@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Fri, 3 May 2024 14:03:29 -0700
Message-ID: <CALs-HsuH5KM4OEH3Uo58cq=3Zgr-gd43hhtOuP2tQFDyDUjq2w@mail.gmail.com>
Subject: Re: [PATCH v6 06/17] riscv: Add vendor extensions to /proc/cpuinfo
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Conor Dooley <conor.dooley@microchip.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 11:18=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> All of the supported vendor extensions that have been listed in
> riscv_isa_vendor_ext_list can be exported through /proc/cpuinfo.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-by: Evan Green <evan@rivosinc.com>

