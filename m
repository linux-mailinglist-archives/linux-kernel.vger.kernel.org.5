Return-Path: <linux-kernel+bounces-166687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F9F8B9E2C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D116B22A16
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19FE15B988;
	Thu,  2 May 2024 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="SBDFZHf4"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E5E15AAC5;
	Thu,  2 May 2024 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665988; cv=none; b=XhfpBX9aD7GS5S1HCGFYg1E1ULDdBuSnF64ECHlv/yh1tD3YuZZg60dIqpBi8zBOzP5igDUSTNzbpqcBAvQwE5k7Too8CHdLJ688Tu2bAYjc15EGfFczEq0rLz8J/SqgvqAcAhMg6mOGPyzTdUL2fVo/yHBf1OgdEH0rqMy89Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665988; c=relaxed/simple;
	bh=NH/hCRLZca42J/1IS4rDzmtz5xvYVpojGUnoCUyHPQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t8PzQv8pda+PVKhLkIw/KW711kRqAeRIcYIuw26LAeJulAt+onPd8TzhU95rpcA9QOlU/uKrWCkcb3YUqNyH05v4bEhu+S9G4HaWav13yUKhrJx9Ng8v4E6IE6Guk9M3WxvoopVxVyfdlshbvL/4rHDTBc/yludl08dY22VqUm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=SBDFZHf4; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BC3F747C39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1714665982; bh=JVnu6Rn5yL32/Yuky0AEoY5FGBjtyMlHIa6Q8d8sdDM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SBDFZHf4vwcSiJj25DqZ0zvpk8/YGL91TXhsf4AwR4UpkNBXK5KMhlVD91FxjWXHn
	 Gv77Y18Qb2dtw//7dJZEWLfdEiHs8mgOlbLz9azv2MnljHLpkuL/zLIDwTmIsVu6jW
	 A3aYuLcqXRrbwQzBNypzFcTlpr5PCqbyd3EUCJEYM7309r1lnPVV2bbBkvX+UjP0YY
	 MudGfYV7XS6byi34sRW6PJA4LDxhUWUIAefMiSfdYJlopKGxK9PzS5em7v9cAk1j5D
	 I9JNEqZV7TWbVrhNcV0q3YCG0nCcYxIUMcu4nG4ST4wvq1lo5vs5TS8cAjd2m2Jkie
	 qqmNkSVc3ktxA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BC3F747C39;
	Thu,  2 May 2024 16:06:22 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Ivan Orlov <ivan.orlov@codethink.co.uk>, naveen.n.rao@linux.ibm.com,
 anil.s.keshavamurthy@intel.com, davem@davemloft.net, mhiramat@kernel.org,
 rostedt@goodmis.org
Cc: Ivan Orlov <ivan.orlov@codethink.co.uk>, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs, kprobes: Add riscv as supported architecture
In-Reply-To: <20240429155735.68781-1-ivan.orlov@codethink.co.uk>
References: <20240429155735.68781-1-ivan.orlov@codethink.co.uk>
Date: Thu, 02 May 2024 10:06:22 -0600
Message-ID: <87o79o6vwh.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ivan Orlov <ivan.orlov@codethink.co.uk> writes:

> Support of kprobes and kretprobes for riscv was introduced 3 years ago
> by the following change:
>
> commit c22b0bcb1dd0 ("riscv: Add kprobes supported")
>
> Add riscv to the list of supported architectures.
>
> Signed-off-by: Ivan Orlov <ivan.orlov@codethink.co.uk>
> ---
>  Documentation/trace/kprobes.rst | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/trace/kprobes.rst b/Documentation/trace/kprobes.rst
> index e1636e579c9c..5e606730cec6 100644
> --- a/Documentation/trace/kprobes.rst
> +++ b/Documentation/trace/kprobes.rst
> @@ -322,6 +322,7 @@ architectures:
>  - s390
>  - parisc
>  - loongarch
> +- riscv
>  
Applied, thanks.

jon

