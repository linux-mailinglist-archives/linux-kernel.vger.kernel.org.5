Return-Path: <linux-kernel+bounces-75637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E824385EC8F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD211F22F73
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A898F127B57;
	Wed, 21 Feb 2024 23:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cZUswbMF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E9C81752
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556988; cv=none; b=baD+l+D/jCDYguackgq23qwIxjEQdS2OH0HYxLlCPs2qhZ4dvHvg4g/d+MrM7UTdOyfODVhiksofsp0PSC168OYd2ZCSCfKbK7UnzSk14J80Q4FKtaldz3VAy5tSH9ergR/wISgdEa6yd7r461Gi6m2TOcVj/pDh/kv7sB7NkCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556988; c=relaxed/simple;
	bh=+8hQKDSkHaa77sJeJopkoKcCu7Z0DboOb3oS5bU8/NM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvCfTNDA4uQx5A7LH6Tlpclz8VHbELc/7hHi96bplyF0mXIlil+y80UwXYhcfYv0B1vWMfW9pg5X4WzUGulIp6wirmgcMGP3tke29D/8g8JnwKjLbK52eeon0Fb+EYpGeIljiKBIphI9UWWuUu+xZ6d53Cm1vFXRtyw6b5kaweM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=cZUswbMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EC1C433F1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:09:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cZUswbMF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1708556985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+QLNawNQWiBsuKTXbumMmGwOiMc7OejQSxxYtknrm60=;
	b=cZUswbMFd4GMeZO7PJ769j7t7GIwG20gjFRRBQ8O2P0Bz52au/JMcirj/euq9hdB47Sje7
	Cdd5Fy0FtaD7E93qcWZhI5Oev17uFEuPE9ZOcwRbXA0AEjN6uLkxBhNuB5k2CQXxzhsmWa
	TSnItfNzPtcv1bt7JIZ55z6mUYeJ3Kg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 766f31f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Wed, 21 Feb 2024 23:09:45 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6083befe2a7so39387397b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:09:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVmtIsIHWOBw7kZ6mEu8fKVHM/nGhS/HLMNOeuJQ5Qxc2KS+kdh/js1wB+jSmAXzzXgWmM8gViKorzh/ZhwrD9Fd+exSnEXcPYWzBqj
X-Gm-Message-State: AOJu0YzSdxefKlMl5g6YJj36uN20Vim2ZP1/0CVVfhjcfkhdTuLBatMT
	PbzX9AkbzotDiBPEKFgTQpLHqe9sZD3iu3YLpH2cYxvgKPc4G0D9pUOUFcQI4rOJNd0YZCcLDtE
	AVHNoK5iSLZYCg+ZOyRjKmvY0Hec=
X-Google-Smtp-Source: AGHT+IHP5cV4M4Gq8D9U6OfE4bQYwP/OeSmqy/RUl+EOkwpcupTlK4dXZciVramz/Ff3gTj3EXEnhS8DzXNQ25FOo3c=
X-Received: by 2002:a81:7c55:0:b0:607:910c:9cb3 with SMTP id
 x82-20020a817c55000000b00607910c9cb3mr19268302ywc.36.1708556984269; Wed, 21
 Feb 2024 15:09:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221123248.25570-1-Jason@zx2c4.com> <eada8acd-9341-401b-b6c9-a05848eb91d6@intel.com>
 <CAHmME9o75KzsfMRDtr2K0+N-UM-MX7MWL4AZhy27CedZRNd2Tg@mail.gmail.com> <7a8c04bb-214b-4031-bdd6-59dad62f88a7@intel.com>
In-Reply-To: <7a8c04bb-214b-4031-bdd6-59dad62f88a7@intel.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 22 Feb 2024 00:09:32 +0100
X-Gmail-Original-Message-ID: <CAHmME9rCQgY_DMmpOEJWO8qytNw3ErJNy9L-E7WzEKYHVyqCHA@mail.gmail.com>
Message-ID: <CAHmME9rCQgY_DMmpOEJWO8qytNw3ErJNy9L-E7WzEKYHVyqCHA@mail.gmail.com>
Subject: Re: [PATCH v3] x86/coco: Require seeding RNG with RDRAND on CoCo systems
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 11:47=E2=80=AFPM Dave Hansen <dave.hansen@intel.com=
> wrote:
> OK, so we're trying to get 256 bits of seed data from RDRAND?

Yes. This fills a 32-byte buffer of longs up with output from
arch_get_random_longs().

> But no pattern I could discern.  Did you mean something different by
> "platform drivers"?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/um/kernel/um_arch.c#n413
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/char/random.c#n655
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scr=
ipts/gcc-plugins/latent_entropy_plugin.c#n90


> If we're going to have arch/x86-specific crud, it would be great to make
> it obvious and straightforward to those of us simple folk that are
> familiar with arch/x86 code.

If you insist, I'll stick a local `enum { RANDOM_BYTES_COUNT =3D 32 }`
in that function or something. Seems unnecessary to me but if that's
what you need no problem. Would that suffice? Or a different variable
name? Or a comment on "what is 32 about?"

Jason

