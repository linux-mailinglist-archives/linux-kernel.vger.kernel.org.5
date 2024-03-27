Return-Path: <linux-kernel+bounces-122038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DF088F110
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A11A1F2ABAD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA726153506;
	Wed, 27 Mar 2024 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLKp9yq2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC41383A3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575460; cv=none; b=i6+6QHJ1TmofwXtRv/IisgAKR6z6o4NeppuU43JEI8oeNp21Y7q47IZuRnnFDBCixm535nyAPsEER4gARuGue3QgBlRQB8WJrbHIqRZ7r/Su4VsWta5qlkdyXkypS8FJn3x9eOg+QlB9RgX77hE7cOaQwVMNDuMouk9s6Klajsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575460; c=relaxed/simple;
	bh=+a/yj3h8rVSneW/iF8kjLcf4ZyxOYGMnQKmk1KbGD+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkQSPxkNNCfslTxLwjidb+aR73AvyjRpDLhh/s1DljvnaWvpIH05f2VLuR6809i3wXvTOS2ehP9/Pu+FUA+fOaT8Uxv2B9vxCZ96837dwDG9jF3Ye6T24YCxtHH3+BFsFCm4bds2jfUbzkDGHtjS9B+iFWePOltmcQ5UkseXvBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLKp9yq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2DFC433C7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 21:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711575459;
	bh=+a/yj3h8rVSneW/iF8kjLcf4ZyxOYGMnQKmk1KbGD+M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dLKp9yq2AiU7NbLXCiOD9TPEsZ2IxUXF93QH5SyS5t1M+XqFHHChbkYYJdgs+wDii
	 dfx/1b8bFxNH6i8eSeRpwPa95UYVxlKzzGMOC5Xgdod6hrFfXBjvlQtXD3PkFJIgKZ
	 TwTXav6joWJmTXWXeJUau1DkAnG+mEy54ZHjAuJqmnUE32c7YeiHS0scnt6o8CYO4r
	 e/HJJtX29AeMT2MZUl5NGnOoJgYRQenaQwg+MFOq472b45JZrlH+hfkRW5W8uMchiK
	 gsEL2ejkX//oddtOM7kC6cqtjDXKGokLYM9vXuGLb/uvyScsGDCmm6DJ+YRipR3hb2
	 SpmUoeOdR1jkQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-515c50dc2afso85695e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:37:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVd0pjq9rSkPN8VkQFHwI+o3vZ6PxFuDrCHZj8W7ciR3fwLTlgQctLo1oHQiEFsjgnZ+281FiRS4pNl8Z8k9yiYwY7FkLOwKdtm+Oo
X-Gm-Message-State: AOJu0YwRzSuOxdLmLn8gTI7AJi82mGM74K9+gj1Gp4Ij5jxZJ5IjQLsK
	HhW8VB4TnVKeo7ZeyDkQtm032tAWq3gti8wSLQPRZHivUQgH+ByK/WZyM9eDjO5hScNyeO8RurG
	kvSOTBdYNmICKZoCdwLDsTMrr7w==
X-Google-Smtp-Source: AGHT+IHPYADR3jEg0ovb+UQf5enb1wsbs2TylHVNqhyBT7RHbI/UPPyevxzVCJ9+c5vHHCX12pi8TxcJwOthcwA7Qic=
X-Received: by 2002:a19:6905:0:b0:515:a8e0:dfd8 with SMTP id
 e5-20020a196905000000b00515a8e0dfd8mr458066lfc.3.1711575457931; Wed, 27 Mar
 2024 14:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322065419.162416-1-linux@roeck-us.net>
In-Reply-To: <20240322065419.162416-1-linux@roeck-us.net>
From: Rob Herring <robh@kernel.org>
Date: Wed, 27 Mar 2024 16:37:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJqD8_DZsU6kBxvd+4X136K-Z_q_1Mow6x+d-xWbQjvmA@mail.gmail.com>
Message-ID: <CAL_JsqJqD8_DZsU6kBxvd+4X136K-Z_q_1Mow6x+d-xWbQjvmA@mail.gmail.com>
Subject: Re: [PATCH v2] nios2: Only use built-in devicetree blob if configured
 to do so
To: Guenter Roeck <linux@roeck-us.net>
Cc: Dinh Nguyen <dinguyen@kernel.org>, linux-kernel@vger.kernel.org, 
	Frank Rowand <frowand.list@gmail.com>, Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 1:54=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> Starting with commit 7b937cc243e5 ("of: Create of_root if no dtb provided
> by firmware"), attempts to boot nios2 images with an external devicetree
> blob result in a crash.
>
> Kernel panic - not syncing: early_init_dt_alloc_memory_arch:
>         Failed to allocate 72 bytes align=3D0x40
>
> For nios2, a built-in devicetree blob always overrides devicetree blobs
> provided by ROMMON/BIOS. This includes the new dummy devicetree blob.
> Result is that the dummy devicetree blob is used even if an external
> devicetree blob is provided. Since the dummy devicetree blob does not
> include any memory information, memory allocations fail, resulting in
> the crash.
>
> To fix the problem, only use the built-in devicetree blob if
> CONFIG_NIOS2_DTB_SOURCE_BOOL is enabled.
>
> Fixes: 7b937cc243e5 ("of: Create of_root if no dtb provided by firmware")
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Mark 'dtb' as __maybe_unused
>
>  arch/nios2/kernel/prom.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

I don't love the ifdef, but seems to be the least invasive for 6.9.

Reviewed-by: Rob Herring <robh@kernel.org>

I have a somewhat more invasive change which checks for top-level
compatible existing to decide whether to use the built-in. That's more
risky as it would affect everyone. We're already doing that elsewhere
and found 1 board that didn't have one.

Rob

