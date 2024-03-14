Return-Path: <linux-kernel+bounces-103829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAC887C506
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5788D1F22181
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF19768FB;
	Thu, 14 Mar 2024 22:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="IECZdPuB"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A545776416;
	Thu, 14 Mar 2024 22:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710454405; cv=none; b=g22MWP/9m+VQJsuTUQKDnhpMIYAael+TOGVw5XylSVVVUgDOdiV3EyDOsdU9SV1IOd/wpglaIzS8I3zLEfRI4JzjL9XJCg+Of6eq832J2sm1/+TuG+XqxQgNQgERoTCQ7K6JidLy2fo/38WXJh4AUkHDk7I5T7lNElRiJeW5dX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710454405; c=relaxed/simple;
	bh=4uEGNnBZilbuF8qy88AEM2K2bNF+K77tHLHrcoHCr/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bBG0S9iBIZYV55sNpcI9ZYNUfMTFz9y6YMTSEdQ8IV4QEe2cYOJF5tFP+pHNljB0PcPDXuQ8lHOe5YRRM406sT5gT6t45Gz+iCxl7ULqDiSSnv7LwoVNiFy2H/Ztlx6ZH8NcH/NYtNcMzvSpDKdVTIxBUzAjFDfcQbfrerZqRdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=IECZdPuB; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1710454394;
	bh=gEhbEPH5aj2Z/7UOp7mkhRqYJQi1PvcDq1cmOaQVYNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IECZdPuB8mxs6KEW1DJaf4Mttp7mFL0NZ4N9gwYMd8u8af4NOt/CKMzgfbF1EJlJt
	 g2fBzevj2IyWMk/Wvine73Ph8/V8tnlaPGIHrgwuRsSWGNcXy/JoNZaYuVMi7GX2dm
	 XQuHo4uWY1NMN/BUYgRRxkA65k/hMND4FElAW7HttCDds2lDFL5ZfDv7EhnvSltRxq
	 vtUYgm28mPyTxy/DixOS/DaWwkAXYvBqDQ1Jk8HLLx5k8TrH8abfyOF9k1Ay1Dz+Ct
	 5+eR2AIx24QXmDWnEmOPGHmha5eNPNPpz6wyOhcsmXRm6Ara/4t5k5SZpvyVevZt4q
	 ByD5XMiLCnovw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TwhTh47qDz4wcR;
	Fri, 15 Mar 2024 09:13:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vignesh Balasubramanian <vigbalas@amd.com>,
 linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com, ebiederm@xmission.com, keescook@chromium.org,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 bpetkov@amd.com, jinisusan.george@amd.com, matz@suse.de,
 binutils@sourceware.org, jhb@FreeBSD.org, felix.willgerodt@intel.com,
 Vignesh Balasubramanian <vigbalas@amd.com>
Subject: Re: [PATCH 1/1] x86/elf: Add a new .note section containing
 Xfeatures information to x86 core files
In-Reply-To: <20240314112359.50713-2-vigbalas@amd.com>
References: <20240314112359.50713-1-vigbalas@amd.com>
 <20240314112359.50713-2-vigbalas@amd.com>
Date: Fri, 15 Mar 2024 09:13:10 +1100
Message-ID: <87o7bg31jd.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Vignesh,

Vignesh Balasubramanian <vigbalas@amd.com> writes:
> Add a new .note section containing type, size, offset and flags of
> every xfeature that is present.
>
> This information will be used by the debuggers to understand the XSAVE
> layout of the machine where the core file is dumped, and to read XSAVE
> registers, especially during cross-platform debugging.
>
> Co-developed-by: Jini Susan George <jinisusan.george@amd.com>
> Signed-off-by: Jini Susan George <jinisusan.george@amd.com>
> Signed-off-by: Vignesh Balasubramanian <vigbalas@amd.com>
> ---
>  arch/Kconfig                   |   9 +++
>  arch/powerpc/Kconfig           |   1 +
>  arch/powerpc/include/asm/elf.h |   2 -
>  arch/x86/Kconfig               |   1 +
>  arch/x86/include/asm/elf.h     |   7 +++
>  arch/x86/kernel/fpu/xstate.c   | 101 +++++++++++++++++++++++++++++++++
>  include/linux/elf.h            |   2 +-
>  include/uapi/linux/elf.h       |   1 +
>  8 files changed, 121 insertions(+), 3 deletions(-)

IMHO you should split the changes to replace ARCH_HAVE_EXTRA_ELF_NOTES
with CONFIG_ARCH_HAVE_EXTRA_ELF_NOTES into a lead-up patch.

cheers

