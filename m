Return-Path: <linux-kernel+bounces-71303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB3B85A32C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BEF41C20856
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2A92E3F3;
	Mon, 19 Feb 2024 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOCIj9ls"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2CF2D638
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345659; cv=none; b=C/fwIxZMZziCoUpVx1QEufJ2nmCxvdgnjNnr+YpXiBhePMAldtySyY44P9q4BBCMs/AQomrK+mInTI0/G/LCQifI6ByEVUa7n46Jz2zhYVIaEJLPblqFemTBNnZsgZ6at3DpslprIndXX7sBJ8eWKo1U2YCpGGPYY4SrdxIOZRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345659; c=relaxed/simple;
	bh=WC//6ifWhE+tXtiIWjc1rpI458yYbl6SPhLu3hEmmTg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UVR724jVShQj17yEq+g1jwfXY/25FFPVqSCpWhpbcyxZTW4vNVkLfMfu2DtJgnyhyXaJfpGlUZErIUFe1XtqKvRid9n6pR9O1aXP+UQnWvozoTwv866pXQOWjbi0t4niTyKYMdvvrfHpbgwQkknPqIQxJzKDmsknovu5sSwibX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOCIj9ls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60584C433F1;
	Mon, 19 Feb 2024 12:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708345658;
	bh=WC//6ifWhE+tXtiIWjc1rpI458yYbl6SPhLu3hEmmTg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GOCIj9lsOzJXS4U4rvasmFuvhcfDgGIkaaSQSn8dXkuKR4u6B2U3tgYRZFITHfR1w
	 MG/eWs60A1phxsG3ZKXnKn13gzEiq5SjPgf4KqqYj8bNwobAIGbRwiZ5uEONzU6dT0
	 +DHp9q76z4m+0fJ+bpVhAGfxx8AwCAzJSJL3Pzjbmb16bJDhEArMBHLUEmqCtZ9gkZ
	 R+SFv5+InU17XQ0Atn6q51YuM5StlRArQVQGLOST5Ve81SNNyyOjLkTv+07059cgjg
	 J6/cgXSiNVGu4+IMTE+eV7QOsarHqg6oiD1UwNxzE7A7/yTORAvRYh3X4E2BhrQEre
	 iy4kM2Ch18OMg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Samuel
 Holland <samuel.holland@sifive.com>, Ard Biesheuvel <ardb@kernel.org>,
 Jason Baron <jbaron@akamai.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
 <rostedt@goodmis.org>
Subject: Re: [PATCH 1/7] riscv: jump_label: Batch icache maintenance
In-Reply-To: <20240212025529.1971876-2-samuel.holland@sifive.com>
References: <20240212025529.1971876-1-samuel.holland@sifive.com>
 <20240212025529.1971876-2-samuel.holland@sifive.com>
Date: Mon, 19 Feb 2024 13:27:35 +0100
Message-ID: <87il2kfxl4.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Samuel Holland <samuel.holland@sifive.com> writes:

> Switch to the batched version of the jump label update functions so
> instruction cache maintenance is deferred until the end of the update.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

