Return-Path: <linux-kernel+bounces-160960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 298828B4525
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 10:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2BB1C21DAC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 08:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B897844C61;
	Sat, 27 Apr 2024 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm0ZhP3u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FB68BFC
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714207193; cv=none; b=FgDqgL++ZdagqUY39dtEh1nkgxbO2JP6ZGwEfuO9dBXQ3qp7HPCBgntg1cNQC+eC0Bz3gozfE1vfA0qgoczZ+Y+x9vtC/YbaD+oP5JTtVkFPDdKbp0VNp9zl+CoeTH810GZZF21wDQtmAzszFviq0RmdoH4P3gvBnFn54Aephsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714207193; c=relaxed/simple;
	bh=9UkwLsoFz9zLzP7eFObDUQEcnezh8fLG+6WW0kgWm8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFxW3W1VBtarC3dz0Ah9kjsISyBWzWOErDdGu5RAEIcBvhYerZ9xt2sL1iGsrCz2bKCRDXFZgT0SK8QFjQyo2Kf2/IaBtTt/aYahp0OYsyYKCgCfaLuEECPg8BWHrE205JRakJlw6y2Z6/f62fGguYScndbZkaHgpiPKLVb1+D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qm0ZhP3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68EDC32781
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 08:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714207192;
	bh=9UkwLsoFz9zLzP7eFObDUQEcnezh8fLG+6WW0kgWm8c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qm0ZhP3uKnBsPQQQ+i46d5ciyc5qlttfnYZkqMc2ZECIqpeODBDpxOWm8lGRJmCkc
	 AL/3q9Tdbk9zxW+0VGcuBiFGpWwE3NEn5X6dot2etBlD1sLlKSbcX919OeWWkEmAT9
	 FV03coIiAEm9kCLBcm2CWeOUp33iwzlF7WA+KX0q61SkqbyY091ZAIAUz+HWkqXHZG
	 OyZSk8tqGjNnVuZcpvPmGXcZAUvK9B2nrge6CprDAGxYkZy9muivETbjc4KK/3r58a
	 vIzJkU9bzEo8PENQiGqsyzWY9JjAngJmQIuqCPSF4LuHOpL8F8+zYCAklTG37nhEYv
	 1wyGX9XXSlMpg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2db17e8767cso33486981fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 01:39:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVktAhA5goEsPqfMJEu8wqxtdYR7rSPCKITNpXgzIQ6KZQP4RYNK7OKQnKLgRChvntegmaqIBtGP20BFeiFUMADYicf5bJDTtWsOqn
X-Gm-Message-State: AOJu0YztO+dXBlaEvo3l0UnwIK+xHfnU3FLlGYIYd/hCexirh4+gKq8B
	72ugG1qYIRnxOT07YElaIfMKJ2HWw4W0RjpLRNKDvvaFcZjMBnLVpyoZ4ARbGvrq984koBq2UvN
	pbsJ9aB/s8axQVU13Bgk8KJuLWvY=
X-Google-Smtp-Source: AGHT+IFUDQr/uNIgyqM49IZAZopqDoStPK3MK55h2TsQs43NhAyCsa3E5kJ0YWg/v+GstTN8OaZ50u45oy+h3L7dcqE=
X-Received: by 2002:a05:6512:3f17:b0:51a:a400:785e with SMTP id
 y23-20020a0565123f1700b0051aa400785emr3477964lfa.43.1714207190992; Sat, 27
 Apr 2024 01:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426121442.882029-1-xry111@xry111.site> <CAAhV-H74cQ4XdDez5PipCxUZTpfS=CA6azL5qob=jGGebobD6g@mail.gmail.com>
 <dfdc9823a0b89c8582587fa75448bba5c3a7e15e.camel@xry111.site>
 <56414029e179d219442bde9b8eae81fa3e3ceec4.camel@xry111.site>
 <CAAhV-H5vrCrBFhDKjTXchCGABWHT6Wxz1JK6hNsarOwp+vfHpg@mail.gmail.com> <a3df8ae7ad7c4af447c6143858ae44c3da453704.camel@xry111.site>
In-Reply-To: <a3df8ae7ad7c4af447c6143858ae44c3da453704.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 27 Apr 2024 16:39:38 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5bq-PONAfUYR8+5Q_z=7+1mqtXOGTsDi9g_r71qrf9Cw@mail.gmail.com>
Message-ID: <CAAhV-H5bq-PONAfUYR8+5Q_z=7+1mqtXOGTsDi9g_r71qrf9Cw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Provide __lshrti3, __ashrti3, and __ashrti3
To: Xi Ruoyao <xry111@xry111.site>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 3:49=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Sat, 2024-04-27 at 15:20 +0800, Huacai Chen wrote:
> > > /* The prototypes are incorrect but this file is only used by
> > >     modpost which does not care.  */
> > > long long __ashlti3(long long a, int b);
> > > long long __ashrti3(long long a, int b);
> > > long long __lshrti3(long long a, int b);
> > >
> > > How do you think?
> > OK, then just keep the original status.
>
> Then I'll just send a patch squashing the origin version of this patch
> and the patch selecting ARCH_SUPPORTS_INT128 in a day if there are no
> other review comments.
Needn't, I will squash it when I apply.

Huacai
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University

