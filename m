Return-Path: <linux-kernel+bounces-94776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7781387451C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1779F1F23171
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DB2800;
	Thu,  7 Mar 2024 00:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nM15LYMg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F2837E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 00:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709770847; cv=none; b=VLbvDwsIB5Rr5wF2/7DIrNrRfhK7clISuqLpVAgtZvWyV3MOW+vW0OgbpuBMwVKbqWoXzs8ehnAYNZJa1wwVnYk/jgeWm34jq4Pc3YuA2v6najAdFj/n1gxAjvzCvWJ1ViABlA5RTv8vOGvOwCQljD2nPSpccN4j/QAJu75tBMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709770847; c=relaxed/simple;
	bh=lQLA4KDP1+a8sOvFY+53datgUNAEzd1jFiJ+rERFdpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yq1Es+MJjq/o+M4TCVKtnYMZOt2o63hmN//Sl1jvqBs8V6VTv4n04lOOvFaKwGXeI6x96Psw8XZ7xiJ5hKef+IHUb+s2XHqvkJJhlezRL2mR2PF+AvgXy7zluz4z2kBLvRqk/ZXjX5BGQAVa5SqTXOPwOpMea5pV3DNLzjYZek8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nM15LYMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BF7C433F1
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 00:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709770847;
	bh=lQLA4KDP1+a8sOvFY+53datgUNAEzd1jFiJ+rERFdpA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nM15LYMgt4MnF6cPhWhE5JrtjD9AeRuO007ZSvNSseaZfv0IHiEU6/9VGhy5SAZlu
	 ZgQGJ7JwVntwuWV+KxLsU/ulX/J53oAtdsSq+XmLKC/N/2unEM81GpkHpfbJ+tZdNw
	 ZpIUZkDfoEWUTHQueeJ8ju2YRmovwowQvNfLr1hQ21G1fUs4W8uzzPLpWTHQDxKqra
	 T/NSnCnsa5FpnKckc5ncg9Wu6bZZJ11no6fqBCdNjLAwg+v4IEaE9euqsyKAq6o89D
	 YP5R9lE1bnUFtNEslRWtchl1Qv6yhWMpyt8w1CSKfS5NFhoKzXc0+CnZNpODSS2BcS
	 9Bs5DOI1KIKNA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512ed314881so303479e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 16:20:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW11uzVZv3B+PjEiD2Xce0NOe6X+yeGIEzomTfdMrSkK9hZwSSuRU0l0OYmVOun692t+k8Cs30zPxDo9tKumN3jXX3Pgz2J3sPhDYeh
X-Gm-Message-State: AOJu0YwjaXvpwfzG/7iQPPtW1J4b8y31U4wKFybm9/M0uSSR3kBE9Qwr
	ET8hi7j33VKameyW0wwY8QL7SP/Dg40hy599bSA6RLjTSwsFoaJeAiYj5X+ZoxUnUYwuyJTGKpg
	nV+oL81iYITgdUi9BHWwYuT/8Uz8=
X-Google-Smtp-Source: AGHT+IGsU0BfI/ayNo4scI/BG8+EbKZWimxPLx67MTfCPvEZ4VO2I0fi3hlw3N74W7hSmC/uIJF/zTDaSf9BCIsscAE=
X-Received: by 2002:a05:6512:234b:b0:512:fdb3:7a9e with SMTP id
 p11-20020a056512234b00b00512fdb37a9emr395570lfu.31.1709770845134; Wed, 06 Mar
 2024 16:20:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1703596577.git.u.kleine-koenig@pengutronix.de>
 <4a97c8e6996c9c95244715310b57ce5af6ccb1ad.1703596577.git.u.kleine-koenig@pengutronix.de>
 <dfw3rfgifkv5qliwzxlziwq5kvud4vdro36v22celda6wasy2d@fpcpgcuo22bo>
In-Reply-To: <dfw3rfgifkv5qliwzxlziwq5kvud4vdro36v22celda6wasy2d@fpcpgcuo22bo>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 7 Mar 2024 01:20:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE+T_puAegyDaBrXo-zUPJ4dJ8DWXq=1Ji4ZLMaM51Yrg@mail.gmail.com>
Message-ID: <CAMj1kXE+T_puAegyDaBrXo-zUPJ4dJ8DWXq=1Ji4ZLMaM51Yrg@mail.gmail.com>
Subject: Re: [PATCH 1/2] virt: efi_secret: Convert to platform remove callback
 returning void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Dov Murik <dovmurik@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, kernel@pengutronix.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Mar 2024 at 22:35, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Tue, Dec 26, 2023 at 02:28:02PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling b=
y
> > returning an error code. However the value returned is ignored (apart
> > from emitting a warning) and this typically results in resource leaks.
> >
> > To improve here there is a quest to make the remove callback return
> > void. In the first step of this quest all drivers are converted to
> > .remove_new(), which already returns void. Eventually after all drivers
> > are converted, .remove_new() will be renamed to .remove().
> >
> > Trivially convert this driver from always returning zero in the remove
> > callback to the void returning variant.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
> Is this patch still on someone's radar? If a resend would help, please
> tell me.
>

I've queued this up in the EFI tree.

Thanks,

