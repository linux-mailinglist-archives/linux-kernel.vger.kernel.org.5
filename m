Return-Path: <linux-kernel+bounces-118085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D872B88B389
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE8A1C394CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54FF71B52;
	Mon, 25 Mar 2024 22:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSnWZsxW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF23E71732;
	Mon, 25 Mar 2024 22:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711404587; cv=none; b=BfVNFMtYav3sKRSKstOe12zgqMFoOndTQV3GO9hlD4dZq3FvlwzAl83BNYqyZWY/zmwBzq94hiGfUp/6LRTviWImCSO9uCu7yolBByFAIRIHsomWdzWyQru+pirQ7Jhe2lv7MUux2NYHS/67k2zAsB8TpxoItve7wxYvgBciHIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711404587; c=relaxed/simple;
	bh=MHgrmDbY6yGfAgeqDr3txltVR53Kng8qLPXpLxZiglw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=UZXUWe7hAm2h54yFmEOjyJfbQcV/MThirZykPyEhKfrJo+Z8fjiACHX3Idikn4AEe5IT34lvwGrtca8QNqfXUY0qbrc4sf2il2AiZlMSIsFmXuOFnJkWdHRDJddxXYvz1i9FLTWTRgfyfWMibVACzVn6bx7Lx/3051HOEJAaZFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSnWZsxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E98FC433C7;
	Mon, 25 Mar 2024 22:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711404586;
	bh=MHgrmDbY6yGfAgeqDr3txltVR53Kng8qLPXpLxZiglw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=NSnWZsxWV5zih75kzQMss0dcrkir5jVOC2GifM2BBPN77g5hkoNR3oxgkh/zNR3j6
	 S2Bq5lxz+2EPod17risV9ZyCEhMThjo9Lf1Xx/wzwwzgX3sxKDx0GrYnFB06OD76Xx
	 0IZO8QQPVYf1VgGcq9PrcoDQ9b4vcF7kMdMIkzHiikVNpbaNYZ0YBwYno3KdjNth5R
	 TD/rmv+qrAzCcx+Xxhb+zxSyXDPaLVHDD/3Vr5jteguD4BNhJ0qhvagGmCpj4EPwZ8
	 L7ptgGeLIynCCC9OhLlGawsSKuX/+wbiaNAq2lBg7WzJLyLwPYt2GQJ578dFIZ9wV0
	 9XlVUjpnhJEYw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Mar 2024 00:09:42 +0200
Message-Id: <D036AJAEAOUF.34494O217N0RI@kernel.org>
Subject: Re: [PATCH v5 1/2] kprobes: textmem API
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <linux-riscv@lists.infradead.org>
Cc: "Masami Hiramatsu" <mhiramat@kernel.org>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, <linux-kernel@vger.kernel.org>, "Luis
 Chamberlain" <mcgrof@kernel.org>, <linux-modules@vger.kernel.org>, "Naveen
 N . Rao" <naveen.n.rao@linux.ibm.com>, "Anil S Keshavamurthy"
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>
X-Mailer: aerc 0.17.0
References: <20240325215502.660-1-jarkko@kernel.org>
In-Reply-To: <20240325215502.660-1-jarkko@kernel.org>

On Mon Mar 25, 2024 at 11:55 PM EET, Jarkko Sakkinen wrote:
> +#ifdef CONFIG_MODULES
>  	if (register_module_notifier(&trace_kprobe_module_nb))
>  		return -EINVAL;
> +#endif /* CONFIG_MODULES */

register_module_notifier() does have "dummy" version but what
would I pass to it. It makes more mess than it cleans to declare
also a "dummy" version of trace_kprobe_module_nb.

The callback itself has too tight module subsystem bindings so
that they could be simply flagged with IS_DEFINED() (or correct
if I'm mistaken, this the conclusion I've ended up with).

BR, Jarkko

