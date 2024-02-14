Return-Path: <linux-kernel+bounces-65446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC238854D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 773A2B23B52
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D996F5D8FB;
	Wed, 14 Feb 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="M3p3yJ55"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952375D8E7
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925478; cv=none; b=fDpOeP31JcGtkBgE6RNMF8UsVduksYgUiD+vRxxQXV4naAJXDK4ZsaHJ42/uAPvl9IVD/ldSkjZcpiN9osJOCR8dlyMFh5oOfaBZk08XS6pjhStcJ9aZrGU1XMnNxPgknUhwzpbRmtBxqcYY/VuLXc1/JqL7RTJkAZBmRbXyL8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925478; c=relaxed/simple;
	bh=fKoiCadkZo1au3t1rE9BOBoK9f42Dey8D80vTpAGoKA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RSJM+IcmOgdVgKSKtbULAbvhmgbqwsLPCZB3zPOAJus6FFclRkvPHXfqcz7At48YjlHQTDkq3OHuS3JKGpYPbF8SPK4tmdSpahNWsVZ4D2V3JJKWu56sncmvCEQTipVR0QISTd6kv5XnepAnZAXQKkkRdARsPGIBlQjaUk3KVmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=M3p3yJ55; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bfe5aa702fso214051139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 07:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707925475; x=1708530275; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8H+tRUVl6VTTJ+I26hI6HADTZ0Un+fCkMERAMbKsgaY=;
        b=M3p3yJ55stQA8f9zc1eTSHcJ4QjhoZNUbYdIseibVUIYaSBmTS91+4e5+iwQdH+1vb
         XlQCeJJkbMG23+ipWdqY8yAP06aNZarDw83HvvYT7kH9eVH0yWmTdKaK+w1lJuZg40RL
         zXWwduGsE9rU7QwvqV24qc2N1OiZaobd32DPbwpocKv5zPc/imnUeNqIgio98sHXazs0
         6WnSflEQBW1rcorWadlj1ipHpxYx8K0rokvXeZdCZR7pzQ3CUyj7sYXCYm9yYRPge9rS
         z0IOMooHA3aRPP3K3A2wkKfrfltBE0ZmjF+HIxAs9Wxg9XarL3QMwyidDyIit2VF3Fdv
         SPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707925475; x=1708530275;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8H+tRUVl6VTTJ+I26hI6HADTZ0Un+fCkMERAMbKsgaY=;
        b=k23XJi41nb9SQLvldymzUhRvELWW3ZN6e4XnTgpIctxiWkrWTYKXLah4lkT8B/2RcU
         6VuYE6fjIZLGcX2fUeMTbASBF3CjzSOcOWXtXesfJP15ZoSV122Js46WhBZRs7Xc26Qy
         2UQanr6VLdkNEPxtg1lzZuuVz7V9VzbX2V5Y9upZjfJFdNQOtpExyhm1d9Ff7Zs7oz/Z
         D26d77CGpPFIPccRn4YXxaWB8W6PKG8d6YkQexBa+sL10ui/hrj994Vm1N1iSSuUCJht
         8vlzKS3v4Au4Gt8xKjgv6KzyHi/SY9TeKBqEocGuIhpkRF8c0oH+Jk5YCfwl/9vgqFhz
         1N9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6ZlTHTv6iR9cGnNTrm29SVwOhJ6G6AD7Y1mOXsDwufslT9hTrhpq2YrLFSzoUxG6pFSPuRUQH/RMsw2Lo+vlrnmkd3Hf2guSq+66E
X-Gm-Message-State: AOJu0YxytGePGScAGuaHzwxzj/s5W7FxYsOao2vkDwzkDafr86p8D2IN
	+wQ1xRmNbWdhGY8ZyvYKwxX+V/nnIL9pmVncPtAOlKJFLZZO2zebbr4boGSVXKc=
X-Google-Smtp-Source: AGHT+IFSYvJVra1vjtWRcKFPj8EVyDWmX9NPiOhHx5QSIIUGMlUmsQm/kaGm5mHv2EhcHDI6PNBp7Q==
X-Received: by 2002:a05:6602:5c2:b0:7c4:6b0f:ee7 with SMTP id w2-20020a05660205c200b007c46b0f0ee7mr3689037iox.7.1707925475720;
        Wed, 14 Feb 2024 07:44:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVppKyfQx+1K0Z9etHaCtXFjcZ0ltuX51rMZRw8r7Hn3rqRCqUQHSe34BMQK/vibc3EGnEXzCUDXX4aJ4y12fqw+eikFKbJZP5ND+IEH7dP2qbcptphPDaBqWt6hz5g9bUIJV9GCWSVWJQfbnnJCnu+LWiS+SRarXPQRnWJTg09a0MPqcpWI1tHAeJJhPB9tsBX2LLa5o0Ei26c6kfq9Z/xqc6LTR/9BVl/cNEVsrCWD6pzUEwyt1h8UvE1LbIBZ3ZLy4AoX8qKzUhS5qD94rXCEkllJmhGAkmWyzjq/AkRUe6mlU60S889xjiUSdlaavBP8ScOM07xOKaOA9kzG7a5an3KUfuaOFIjoK/zPTvrWtL54g==
Received: from localhost (c-98-32-39-159.hsd1.nm.comcast.net. [98.32.39.159])
        by smtp.gmail.com with ESMTPSA id a26-20020a02ac1a000000b0047133a05f33sm2484253jao.49.2024.02.14.07.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 07:44:35 -0800 (PST)
Date: Wed, 14 Feb 2024 07:44:33 -0800 (PST)
From: Paul Walmsley <paul.walmsley@sifive.com>
To: Palmer Dabbelt <palmer@rivosinc.com>
cc: linux-riscv@lists.infradead.org, Greg KH <gregkh@linuxfoundation.org>, 
    jirislaby@kernel.org, Atish Patra <atishp@rivosinc.com>, 
    ajones@ventanamicro.com, apatel@ventanamicro.com, 
    linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org, Emil Renner Berthing <kernel@esmil.dk>
Subject: Re: [PATCH] tty: hvc: Don't enable the RISC-V SBI console by
 default
In-Reply-To: <20240214153429.16484-2-palmer@rivosinc.com>
Message-ID: <0e41108b-2a64-2144-34f1-e7c0f1ec952f@sifive.com>
References: <20240214153429.16484-2-palmer@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 14 Feb 2024, Palmer Dabbelt wrote:

> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> The new SBI console has the same problem as the old one: there's only
> one shared backing hardware and no synchronization, so the two drivers
> end up stepping on each other.  This was the same issue the old SBI-0.1
> console drivers had, but that was disabled by default when SBI-0.1 was.
> 
> So just mark the new driver as nonportable.
> 
> Reported-by: Emil Renner Berthing <kernel@esmil.dk>
> Fixes: 88ead68e764c ("tty: Add SBI debug console support to HVC SBI driver")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>


- Paul

