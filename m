Return-Path: <linux-kernel+bounces-11817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D15E81EC04
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 05:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33EFFB21A0D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 04:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1887C3C2C;
	Wed, 27 Dec 2023 04:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pu7JWQd4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4A83C0D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 04:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B23DC433C9;
	Wed, 27 Dec 2023 04:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703650966;
	bh=ves+k/ehF5nuuuhN50R9kvbHrix4q/GEBWsuYo+6QBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pu7JWQd4VQVUFDQTyU5rIq+MCb8fqqlKDBlpMOhyq5hKNo2cG1dn6F2xB7X7LEZKo
	 Njni9Lh9davLmG6kwNdl2rR59xpQSAgMhy1Pk9JGsgK1rx1nSSYlVCjjDrh9hjXsug
	 NFVhLDk0LZAVGFnEEU7WdZe+kbl6zFW5WMCV7XGoA2YdB2UMVga0ZunN37G7/+NDh4
	 hGVJndS6mpTRzyZkiHQRiwTU1d86DSsUmNhn29GCPdAMUW9eiVJLSWgXmpR7NzUw/g
	 gcA23+iYcfcTBMNzR68pDLid3r71deJADwncSxcRux4MaKxIOrFC8DO1GJptKA2dZs
	 HFEG56rIMN4Mg==
Date: Tue, 26 Dec 2023 22:22:42 -0600
From: Eric Biggers <ebiggers@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Qingfang DENG <dqfext@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [PATCH v4 1/2] riscv: introduce RISCV_EFFICIENT_UNALIGNED_ACCESS
Message-ID: <20231227042242.GA4240@quark.localdomain>
References: <20231225044207.3821-1-jszhang@kernel.org>
 <20231225044207.3821-2-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231225044207.3821-2-jszhang@kernel.org>

On Mon, Dec 25, 2023 at 12:42:06PM +0800, Jisheng Zhang wrote:
> Some riscv implementations such as T-HEAD's C906, C908, C910 and C920
> support efficient unaligned access, for performance reason we want
> to enable HAVE_EFFICIENT_UNALIGNED_ACCESS on these platforms. To
> avoid performance regressions on other non efficient unaligned access
> platforms, HAVE_EFFICIENT_UNALIGNED_ACCESS can't be globally selected.
> 
> To solve this problem, runtime code patching based on the detected
> speed is a good solution. But that's not easy, it involves lots of
> work to modify vairous subsystems such as net, mm, lib and so on.
> This can be done step by step.
> 
> So let's take an easier solution: add support to efficient unaligned
> access and hide the support under NONPORTABLE.
> 
> Now let's introduce RISCV_EFFICIENT_UNALIGNED_ACCESS which depends on
> NONPORTABLE, if users know during config time that the kernel will be
> only run on those efficient unaligned access hw platforms, they can
> enable it. Obviously, generic unified kernel Image shouldn't enable it.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/Kconfig  | 13 +++++++++++++
>  arch/riscv/Makefile |  2 ++
>  2 files changed, 15 insertions(+)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric

