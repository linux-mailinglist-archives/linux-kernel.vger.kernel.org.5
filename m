Return-Path: <linux-kernel+bounces-71379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0663885A45B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E032B26CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147A73714E;
	Mon, 19 Feb 2024 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5WqmQUv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6182E85A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708348090; cv=none; b=MMb+Twi9B4MlNRFEzQ+pcO4ylwwkmBBgCb6tZlN2OTmlBrZkPdEfwaktEQ9dEV5b18bNtKJrKf5yb4dNjO1sTkOXqpKq7YS9oCTGYi3qg8I8zslnBsR9mR/hv9rXbZW/KedmLLzJxpJ0B6d8d3b+UTLf8HrVO51B14FoKY4P4H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708348090; c=relaxed/simple;
	bh=RRgvDsXt1cJqdXB/Y2xfMBbMeZt3lZcBBNJH1BLI4L4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IaxY2dTD7tG1vgmp3L7sXXJLIPkjJ+l7mbwUWImzSh2QeL4vd9pirNo4oEJVLIKCgZhtQ8bZejLyTZDU49gMHyY5dpafunixJbkePOdH/QkX9eGSSgv7RgltX/897d6XT1Xj3PRY4X28eWWftS5GcSsoBrECdQX3vUzndIKEJTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5WqmQUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3A1C433F1;
	Mon, 19 Feb 2024 13:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708348090;
	bh=RRgvDsXt1cJqdXB/Y2xfMBbMeZt3lZcBBNJH1BLI4L4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=u5WqmQUvtkhiHOmStFgwdjLqk5Q98mfjxnBSzC+xG1NAMzaPsmu9P8BDhd1clo25C
	 atEarJG0BA0H9gfq2KBn5CERDpgEKgeapgSxMBB7kPDEVYWx4g2kClToxqNEeft5we
	 aStIAerRdTGy4izEAQoUiVNoh9XHtKHfncmnHJEM3rOl1ycTSXa/2QZiti4rBqRUx/
	 Z2slxJE0Av5i2Az+Y+3e/+gACUyCXtdGIcoXeff7usyk/Kl26pBQ2C9FVmIXiRnQGk
	 MD7GDpAKvQ6Uiq2wbskKzDwlj+QSkjbDeDyrE1O/3HdClGRC3xV4eoXVU1vnI6HGy8
	 WDoLZocaq1Ywg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Samuel
 Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH 7/7] riscv: Remove extra variable in patch_text_nosync()
In-Reply-To: <20240212025529.1971876-8-samuel.holland@sifive.com>
References: <20240212025529.1971876-1-samuel.holland@sifive.com>
 <20240212025529.1971876-8-samuel.holland@sifive.com>
Date: Mon, 19 Feb 2024 14:08:07 +0100
Message-ID: <87o7cceh54.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Samuel Holland <samuel.holland@sifive.com> writes:

> This cast is superfluous, and is incorrect anyway if compressed
> instructions may be present.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

