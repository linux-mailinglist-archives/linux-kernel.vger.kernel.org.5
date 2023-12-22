Return-Path: <linux-kernel+bounces-9378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D9081C4C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5BF287FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682D563B5;
	Fri, 22 Dec 2023 05:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDMMA9YU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AB5568B;
	Fri, 22 Dec 2023 05:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD6BC433C8;
	Fri, 22 Dec 2023 05:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703224113;
	bh=5Y0DkMdMumywUcDrPAqkW5IyBCX2AqiGZ5VecIS3Beo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uDMMA9YUfTswZNTzD1y3pwcXI1Jqh0Psn4800fqjbV2otzVXou1AUYv40GhGHQknD
	 nzNtoeT6pmZgolccK07hSD81nApbA4Leq6CWfKgmjrGswbdENzl+7k3ovqreozY83L
	 qoib/VAhaQXrUIUXznI6yGCNqijcu7lsKwgsME9R0MM9o4z6jfI3eVdr08ePlLOBqs
	 IAAvavc3sS9UenRohfjxyb5YB4nQXGgzSK0hSv6GDaN/zF+PTfiJQyZ3GqFMTYA16y
	 rJdKou9vLPZdOkQWLT4A50dwBxEM88/CHP3vbpShhThhYrTfwaAjkNRFj/ILeeuu6W
	 nk945ioKtE2CA==
Date: Thu, 21 Dec 2023 23:48:27 -0600
From: Eric Biggers <ebiggers@kernel.org>
To: Jerry Shih <jerry.shih@sifive.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	conor.dooley@microchip.com, ardb@kernel.org, conor@kernel.org,
	heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [PATCH v3 00/12] RISC-V: provide some accelerated cryptography
 implementations using vector extensions
Message-ID: <20231222054827.GE52600@quark.localdomain>
References: <20231205092801.1335-1-jerry.shih@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205092801.1335-1-jerry.shih@sifive.com>

Hi Jerry,

On Tue, Dec 05, 2023 at 05:27:49PM +0800, Jerry Shih wrote:
> Changelog v2:
>  - Turn to use simd skcipher interface for AES-CBC/CTR/ECB/XTS and
>    Chacha20.

If I understand correctly, the RISC-V kernel-mode vector support now seems to be
heading down the path of supporting softirq context, as I had suggested
originally.  With patches 1-2 of Andy Chiu's latest patchset
"[v7, 00/10] riscv: support kernel-mode Vector"
(https://lore.kernel.org/linux-riscv/20231221134318.28105-1-andy.chiu@sifive.com).
applied, the kernel has basic support for kernel-mode vector, including in
softirq context.

With that being the case, "skcipher" algorithms can just use the RISC-V vector
unit unconditionally, given that skcipher only supports task and softirq
context.  Therefore, can you consider undoing your change that added fallbacks
using the simd helper (crypto/simd.c)?  Thanks!

- Eric

