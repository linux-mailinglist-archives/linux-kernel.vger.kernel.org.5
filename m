Return-Path: <linux-kernel+bounces-60462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBC285053F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9098D1F216D3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E38F5C5E9;
	Sat, 10 Feb 2024 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRSMuhGA"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769D85C61B
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707582974; cv=none; b=nUuP9u0roRViwzVMnrdAkyG9+FNlAWyEl71e24IAhoSh22m0BNej7/mp5vgMFkUy0bzlBou0c5m88mCKWSP35InqdE/WrNHIpf6FQk53g6yyqq0H2gQ+xZBBO9yVn0Gy/SXcJ649qsg+YS3iaGmDno7RAqAHQJ3e1q7XjeD5aWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707582974; c=relaxed/simple;
	bh=xVg2rsySaUHLNxBRJA4noG/ZLifuDOmrz2i8pgGGNSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJyRQHSdYcsZVRUNqFnCqF6Tonq1VPf0W8EABNqmM6Xv5Jh0IxVUKYiTdlrq8uWGR05Z22SpBZLoa1TVdNeEHQqpPwEcfuWLO6V1dnvmkSuc9II9dVs23Fiqn6dEuOH52lSD9ZfVTM+NOuZG+AK12mSCmO8QDik5alvy0K8rJfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRSMuhGA; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc74aac68a1so1980382276.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 08:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707582972; x=1708187772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVg2rsySaUHLNxBRJA4noG/ZLifuDOmrz2i8pgGGNSE=;
        b=RRSMuhGAZmcQe0hEXu8DH1PdWCpMHJg0+wZDWFNBsc0rww+SEwi26aJJOJGTwekZgf
         Fu9wC4oA3c5WaI8G29pxObipeMmuUXGVOo1RXKDm9ioFhuAb6KaTONQOHEXOPl0XMdk2
         9Xs/zMjd3mTMLOQM5YnZ8oAgPY3EpsBfi/vUW4CBGYG5IOOBqRuVXEStU9oQjno2oNA4
         O/obDG5wUgHkzOJ8CwvGq23BCVnOA8OvoaXO7XDoV5GQHO912izxESVyMGNvqM9Wtj54
         MoRrL9AwniTjksLga6LedjBICs3mAguIJL9tS9bmItHWruPE6IEVh//f7WpYHgWDMAPA
         6+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707582972; x=1708187772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVg2rsySaUHLNxBRJA4noG/ZLifuDOmrz2i8pgGGNSE=;
        b=oJbTLt77THz5pSc/bAzH3qbFJvl3ZAAZDzR8QfhTECeaTQDuc/EZHDwo/uAOgjM7ni
         JPIYVgFq7BcjsduRV75dG+QHSd5kRaDCrQIygyjN48uxB/2jglgvP+c7MrFXERVwQBS5
         uB3yeppv7squh9vjL/woL2fg+EgC02HFwJs5E9lCPkvBKtbSI+TLKTRYX8/KGgfDahxn
         D+ii7lhuu5eZ5sMfc/8ty5CcotWaYRsl4cXW1LsziWTsdBN9ed/1myb+KwAZ1WuUIXOt
         JCdNyjOSlnw4gU8wsk4FG05rlhFdoT4CTWaCKTxR5ZAmxO0jl81YrHrgb08DgDSK8USd
         SPng==
X-Forwarded-Encrypted: i=1; AJvYcCXTSbzNohYZDYE5ku/jdczXFh/6OjuZ979YhN4gqa8oTOovsRCQoTtNzSUsfxerJkr6L62Yn2Y/yYeV5+R2mWLfvC1dOEcaX4MQHWjm
X-Gm-Message-State: AOJu0YygEe94q1Hq1IBI5a5d4c/WiGweufB0QXZZmAOZr8qLnYY8tP8c
	8LsFRBtyp1hmiwtsx22AjITnBAjkzDIctDroI8I81as5VrDr2lQLHMJoNRPqNDZsivHq6IrxydN
	5WNRifx/OEUgVHHpMC7MLwKTYaXU=
X-Google-Smtp-Source: AGHT+IE+fvBFa8QWEnDUJIBbyfVmQzGPZ+d8gzHA8Ie7SibJhobr4pIOwYgIwXacPtIPXu0U6U4DMlRpkiRsS00J/No=
X-Received: by 2002:a25:6809:0:b0:dc7:44d8:14c2 with SMTP id
 d9-20020a256809000000b00dc744d814c2mr2032273ybc.39.1707582972424; Sat, 10 Feb
 2024 08:36:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208002841.GA2601476@dev-arch.thelio-3990X>
In-Reply-To: <20240208002841.GA2601476@dev-arch.thelio-3990X>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 10 Feb 2024 17:36:01 +0100
Message-ID: <CANiq72=G--5LW-9sg2PscTL863mFVNdnX7LUQX2Xj02qZs4crA@mail.gmail.com>
Subject: Re: Prebuilt LLVM 18.1.0-rc2 uploaded
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 1:28=E2=80=AFAM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> I have built and uploaded a prebuilt version of LLVM 18.1.0-rc2 to
> https://mirrors.edge.kernel.org/pub/tools/llvm/.
>
> As with Linux -rc releases, this is not the final version that will
> ship. If you run across any issues, especially ones that were not
> present in earlier LLVM releases, please consider reporting them to us
> so that we have a chance to investigate and fix them before the final
> release.

I took a look at the LLVM 18 prerelease to see if these would work
with Rust for e.g. CI and other users (instead of using the
LLVM-provided apt ones, for instance), and noticed it does not bundle
`libclang.so`.

Would it be possible to include it so that we can use `bindgen` and
thus enable Rust with them?

I understand they are intended to be minimal toolchains, but if you
think it would not be an unreasonable overhead, then it would be great
to have it.

Either way, thanks for these toolchains, Nathan!

Cheers,
Miguel

