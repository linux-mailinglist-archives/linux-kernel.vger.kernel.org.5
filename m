Return-Path: <linux-kernel+bounces-71376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889B085A458
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4563C2822F9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DEB36114;
	Mon, 19 Feb 2024 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVDkV4M2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6BD31759
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708348033; cv=none; b=BNEBicB/BmwG+sILlwR3ADo7w853RV4qbM3CLsrqe3UYTdr3BcPFcF5zbsQIq9TmRZqm92s5OcllziAg2MTFawun+YpctVlSpRUo5DAjqmbCu3+T+P0MJQzpCs28motLOJOQ+RmelA+dTKVHTr9r+f5mC7lzILrYRz5ITAsOfQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708348033; c=relaxed/simple;
	bh=tP365zsU1kYrOfI9ft84/uMyXJKlWnv2A2UGYeSOJkE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qlPdOFb/pJiWQrHX+nqbvW1P/IzjqZpFfdYltKUe3dSd0AWon1U9eyri8QGRud7mvrQiCWe8GrANicZa3UTONKQ73hXNwcj8Ky/UvPV6kb9/iVJZOm55gRE+1jWU0FMUqjJOF125Z/fB7boVZttkLRanlW3xrqzyWJDsWUdvriQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVDkV4M2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865D4C433F1;
	Mon, 19 Feb 2024 13:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708348032;
	bh=tP365zsU1kYrOfI9ft84/uMyXJKlWnv2A2UGYeSOJkE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WVDkV4M2vZwKC4EBVBgVUaHBe902q5NfdDVcoxBZdO96/lwSg2e17CQFklrVBHfj4
	 5JKW/IMlDqNuXSrwnI2rwjRGovTwlvUPo2Xs3wTZAP2vyCVFragNlOATZQ/Ec8mAr9
	 3QWhBZkGmIw5NXX8ZEm74z13V8rY1XO3v5mY6efQKlMjTBYG/qvr7eaFzKNEg+UPr5
	 s4hxKcxosy8GRbfaxyBqvlJeJlkLTune00A/+nFuTm3bkzhcVnZ5acvOMtEJlGoqAh
	 4n32Khwvd+xufvAHUQCwdHr4etPFf3ovT160bxnXUmxlbwiRkIX6vRNNRHa15fUcg3
	 8M5VvAsXYl0VQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Samuel
 Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH 6/7] riscv: Use offset_in_page() in text patching functions
In-Reply-To: <20240212025529.1971876-7-samuel.holland@sifive.com>
References: <20240212025529.1971876-1-samuel.holland@sifive.com>
 <20240212025529.1971876-7-samuel.holland@sifive.com>
Date: Mon, 19 Feb 2024 14:07:09 +0100
Message-ID: <87ttm4eh6q.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Samuel Holland <samuel.holland@sifive.com> writes:

> This is a bit easier to parse than the equivalent bit manipulation.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

