Return-Path: <linux-kernel+bounces-86765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7187986CA6F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2740E1F220B7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0AB4B5DA;
	Thu, 29 Feb 2024 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxNXyYjs"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA1A15D2
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709213973; cv=none; b=ppyj+g2Jzy23eRLwUmhHTLvskjy9w/6RR7e2HNqcxGgz7voJnvo7ysxMem6pUBjM5nTd5bHpZ7moG5+VK4ik2D95MNRpMs24AqZDRyYTpnLcXNNDeJP+lmXFK171xRT0QT1CeUdv6MizxjTpN4pY6clsw+mLTGiOZzHBi7n84To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709213973; c=relaxed/simple;
	bh=VZ5Y9Ei+MIJf3FL0eONlszgY8Ic/ozZTLuYGdsjIyaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJSLPSMeyKxi7yjD1Wzcz7IhYBxQKc3kWix1sfTF/VzWcSUioKuvkRIqxDSfKz7KFtWuP7FkX2hS5d7V9nrpi3bbAD8/jv/3+mKMRaqbE8YaXyAtzZrEBZCiWX58+PcxjTpq87KzNCdMjqpzekH9sNz2w/BDL+0nm4odyzXgLKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxNXyYjs; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so602337a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 05:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709213971; x=1709818771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZ5Y9Ei+MIJf3FL0eONlszgY8Ic/ozZTLuYGdsjIyaQ=;
        b=IxNXyYjsZ9Mvczk/tAOCsSjLqDceccj/CfzkxtPEFM+gMywsTuOX+uuDOTtiSsYWYX
         zZ7zWsC3fB7/ALsODcnEO0r5H9/zIKx9E3rpdQ+ehlHAkjkSAakdtF6eAZyOp/zZr0CQ
         P/pUt8HwSyZFXmz4fAkC0OKO6svBZXfIhsS7I+cGKWMqs6SiuvR1DCB0cd5+pVC9GkWe
         TEPmu/tVKTK8ZeIE8QSisKmNOww6/fqXW5ssbXv0LKUEI4VtXP8tCVTEJcf43HQUSq21
         MpQ5HfAkrhlV2RpViDvFSklWRUUUaCzYy85MMyKVBZOadzf0+O5l+o+pQNtbBPeTgQUF
         Dl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709213971; x=1709818771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZ5Y9Ei+MIJf3FL0eONlszgY8Ic/ozZTLuYGdsjIyaQ=;
        b=Q+wT8FI1jAIrbD/5VGrI6P8mo81uxsOtrrzYDssvP7hDxn+JAYshMFp9h4D5FNzOOR
         d/E0Eo0q0ipfJDeS7ZtPDptybcWVfovrDz9t5ffNWMG/AM2SN2/ASg1nyhyBVXBJuBlF
         WJw/VppCR373meckHdTDEKIbgsiQOrce+oJgWNEt/3MDxIi6E+0lzMJgthFVF02Md5DL
         bdD9uLrJaRgmqZ4aYsvBibWjgt1tLi/RmnC4rEfRMFgfP6PQ5U5sLvSk9YDRtXARNGIw
         PaRCzuXTtL4rmJoF/rm5zY6aWSHqamY4TS+EfWzqP5TOZ6xzfqRSnUN7fr2onotkocDn
         gr8A==
X-Forwarded-Encrypted: i=1; AJvYcCUrJb02S7h1DVETUhyrlkr1Ofp5NnpgIPV0xaIdCUZYNW2jLMBHJioak0XhrKzSDQ28hDJw7mKhJb5yGXon5WcQIxsfLTss1y0AH+Eh
X-Gm-Message-State: AOJu0Yw460IcTAzV5xDKJBNbEHyuA66G8RZgYGWUeYfbLMc84yYIW4CP
	kzuUfQaFS/5wBt/ms1vUBk93Jx9shNOuJetX3i/0LF7ZBK2BGwN0U/m51xJKlWuzNhAJ3mams3c
	/qz/foGNqsnjF+6cVDrsQiX0wew8=
X-Google-Smtp-Source: AGHT+IGelv6RxKf9aqGK7A90j222h96pKeHWfIAlFdNLY2T7ujbgu4wSQ5mit0xxWvEu2nYQoMTFCnN12WUrXbkeIks=
X-Received: by 2002:a17:90b:3a8e:b0:29a:6436:ed59 with SMTP id
 om14-20020a17090b3a8e00b0029a6436ed59mr2134966pjb.2.1709213971151; Thu, 29
 Feb 2024 05:39:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208002841.GA2601476@dev-arch.thelio-3990X>
 <CANiq72=G--5LW-9sg2PscTL863mFVNdnX7LUQX2Xj02qZs4crA@mail.gmail.com>
 <20240212234850.GB3221859@dev-arch.thelio-3990X> <20240213025303.GA4006766@dev-arch.thelio-3990X>
 <CANiq72npYCD-zKqcXPNOAxnKiUCCXGbFQaGo-8=0-171ni+ncQ@mail.gmail.com>
 <CANiq72kcQUuxcno00+QWrstrcfwC+2_Bvh+8dr5kgVkEtrWOEA@mail.gmail.com>
 <20240227153728.GA819789@dev-arch.thelio-3990X> <CANiq72mmDquTeoEVErwXH7bVhP0+UifCrK0n=-HD97noWLqryA@mail.gmail.com>
 <20240227215605.GA1422986@dev-arch.thelio-3990X> <20240228184358.GA139944@dev-arch.thelio-3990X>
In-Reply-To: <20240228184358.GA139944@dev-arch.thelio-3990X>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 29 Feb 2024 14:39:18 +0100
Message-ID: <CANiq72myA+BGb44XfCqyjLDUmG8gbqQF9z-_sk1=q2KPiJtNRg@mail.gmail.com>
Subject: Re: Prebuilt LLVM 18.1.0-rc2 uploaded
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>, Conor Dooley <Conor.Dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 7:44=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> O Tue, Feb 27, 2024 at 02:56:05PM -0700, Nathan Chancellor wrote:
> >
> > 15 through 17 is a reasonable rebuild request, I've added it to the
> > queue along with 18.1.0-rc4, which was just released. I'll message you
> > when I have them uploaded.
>
> This is now done, please let me know if there are any issues!

Thanks a ton Nathan! That was very fast.

I gave them all (15, 16, 17, 18.1.0-rc4) a test (but only x86_64), and
they worked fine -- I could boot-test in QEMU (x86_64) a Rust-enabled
kernel and load the sample modules:

CONFIG_CC_VERSION_TEXT=3D"ClangBuiltLinux clang version 15.0.7
(https://github.com/llvm/llvm-project.git
8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)"
CONFIG_CC_VERSION_TEXT=3D"ClangBuiltLinux clang version 16.0.6
(https://github.com/llvm/llvm-project.git
7cbf1a2591520c2491aa35339f227775f4d3adf6)"
CONFIG_CC_VERSION_TEXT=3D"ClangBuiltLinux clang version 17.0.6
(https://github.com/llvm/llvm-project.git
6009708b4367171ccdbf4b5905cb6a803753fe18)"
CONFIG_CC_VERSION_TEXT=3D"ClangBuiltLinux clang version 18.1.0rc
(https://github.com/llvm/llvm-project.git
461274b81d8641eab64d494accddc81d7db8a09e)"

Cheers,
Miguel

