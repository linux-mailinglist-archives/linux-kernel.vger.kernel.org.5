Return-Path: <linux-kernel+bounces-112672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC4D887CC9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 532DAB20F88
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061EF17BC1;
	Sun, 24 Mar 2024 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvP3Vc9z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EF9CA64;
	Sun, 24 Mar 2024 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711284364; cv=none; b=SMK5wOuPu/W2xQjqp23uLh1RG02YJ3jCU2FYrMPMwAjzTPpXOWzJ/6M+qUvTgQiMagUn2JtHkxmlA+CTD/8bf6ne1tVYvTXDqodsihj3coN1s7ayBwQbbUdl537Cwbitj4WrsPoHjOeut/scK1Sov+mTsKA2+TPT02iKJBOjqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711284364; c=relaxed/simple;
	bh=kqaM0Gs9eyQh/TpZTAIYEFx7H0H+b1/38Dn5OUuSjjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvuVJsp6jA0pIpEZAYYzMxI5m7Yolud1Xhk0PRMn66Hsz4Ts6L8J0NGyM12iutXdkevsE0x5aYxtQcSUWMcw3N6C4ZUcm6daqCDzh9zvByazVdQRWvEEoIVKVrAuyyFX+DtCb3aSgiutrzau8QdgUCDI4OW9jgUtoP9DGlSqfzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvP3Vc9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA17C433F1;
	Sun, 24 Mar 2024 12:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711284362;
	bh=kqaM0Gs9eyQh/TpZTAIYEFx7H0H+b1/38Dn5OUuSjjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mvP3Vc9ze4ggSkSjKySfvEEW/pjnirD2XDo7Blkra2PPaq8mJoa7IxyLDCf4a961f
	 1Qa+w7jOIGBIZWwFXqSddlxNkC1Nx/P+TWr4Nxe+PbtJkxT9pNoASolI45s4POIv+v
	 yPcyMlzs44cqpg+yGo2/zJ5fdpRuPm4HfpWRrhJ9aZOSGbgb8zb9Pf1J753jGaJAKe
	 fHvbcTBBkYmrttKCKIF6bvs4zW059Y76m2x9sFvhMo0MsaLlzxdHodMNVilo1J9ycl
	 ASDfsSyHFJvL74MVfPRrbuhTJmYH2M6VHyzDOaGMSMM8UTTeKDnBH+y/0PgsAKyCfv
	 p2zN6ntAH4fWw==
Date: Sun, 24 Mar 2024 12:45:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: Add support for AD4000
Message-ID: <20240324124546.2e07f802@jic23-huawei>
In-Reply-To: <CAMknhBH7umcBD0hyt=6fOKu9E8k=CSrnNE4Z+9ynn0F4B=Wk2w@mail.gmail.com>
References: <cover.1711131830.git.marcelo.schmitt@analog.com>
	<15a70e55d7b6f0a97c4042bdaa41c2b672eb4f2f.1711131830.git.marcelo.schmitt@analog.com>
	<CAMknhBH7umcBD0hyt=6fOKu9E8k=CSrnNE4Z+9ynn0F4B=Wk2w@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Mar 2024 16:53:17 -0500

> > +
> > +       /*
> > +        * DMA (thus cache coherency maintenance) requires the
> > +        * transfer buffers to live in their own cache lines.
> > +        */
> > +       union {
> > +               struct {
> > +                       u8 sample_buf[4];
> > +                       s64 timestamp;  
> 
> Usually we see __aligned(8) applied to the timestamp (I'm guessing
> some archs need it?)
> 
Good spot. Yes, x86_32 is the one that we most commonly refer to for this.
It aligns s64 to only 32 bits whereas IIO ABI is always naturally aligned.

> > +               } scan;
> > +               u8 d8[2];
> > +       } data __aligned(IIO_DMA_MINALIGN);
> > +};

