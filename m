Return-Path: <linux-kernel+bounces-75895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFAD85F068
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3201F23966
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75C31799D;
	Thu, 22 Feb 2024 04:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZn2MrGq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37A017755;
	Thu, 22 Feb 2024 04:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708576030; cv=none; b=SCIu6EqDPSpwczi0/oSBkvBUY8YSmNsXz2lJYFjkSutmo1WlXNJaLaYVd8MplXMqrM00btBKtXyGMCNicsHGnwk1kI+t7fhZZUmAhSpUMgXrwyfycoVi3gwJeF0rZTkuvtSXggwuSMGpcE1t+BdGRdNs8elo9Kj9Vm5GdILo5+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708576030; c=relaxed/simple;
	bh=d9H5OiXqQ3u3m9ZnjSiQ8O/4LeLOQWApoSJAQSEG3XY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=lcsC1J0esZ3CziF+OrvxMq/9Q4LH5d4R7H+xP9ZNULLyvRvzBlFEPSwoR0UZVr1ATwDBAxSkVVxi9x0I4PHfNCKI1ejqaeak6wOARbHuOZ9E6xXUFlVkVO70Aj40ekjLxVXUdOHwvnnibyuZqXbWAsxnIdPSJZ9a8d0arNAjLo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZn2MrGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE274C433F1;
	Thu, 22 Feb 2024 04:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708576028;
	bh=d9H5OiXqQ3u3m9ZnjSiQ8O/4LeLOQWApoSJAQSEG3XY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=VZn2MrGq+A8d6B8N8OpIw0JOwWZXr//WSCYMQ5UtcCrlhRR08MVVf3vcI//KHeyjw
	 xlFybWL1NxrQh43Bh4OkNHFRmP4Byi/1BVFBG8Kwywcc6pR/DNnvt86DX/aX5v73z3
	 +/vpKyf52HlfPMtBPD1wNa8D1aJhO4nw6/hSSndm4au6xV+eFXyzjSSZIdvMIHTXAv
	 Lkum3nai9fxH8jOwWZ0KkLzJD1B17DA4B6Z9j8RrZCqS5Axkdvy/rfYFP17zoeuF9W
	 eXx/F69Xhg6fo2RFUp7x0EQy12lx95Ngba/2QWRkWdrQ7Z+EKqMCVRO5ytMTMu2QJD
	 ty5SASJu9WtAg==
Message-ID: <f8bf91a3fbbe213f0bf0e63aa7cdf86c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <773fc8425c3b8f5b0ca7c1d89f15b65831a85ca9.1705850155.git.christophe.jaillet@wanadoo.fr>
References: <773fc8425c3b8f5b0ca7c1d89f15b65831a85ca9.1705850155.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] clk: hisilicon: hi3559a: Fix an erroneous devm_kfree()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-clk@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dongjiu Geng <gengdongjiu@huawei.com>, Michael Turquette <mturquette@baylibre.com>
Date: Wed, 21 Feb 2024 20:27:06 -0800
User-Agent: alot/0.10

Quoting Christophe JAILLET (2024-01-21 07:16:24)
> 'p_clk' is an array allocated just before the for loop for all clk that
> need to be registered.
> It is incremented at each loop iteration.
>=20
> If a clk_register() call fails, 'p_clk' may point to something different
> from what should be freed.
>=20
> The best we can do, is to avoid this wrong release of memory.
>=20
> Fixes: 6c81966107dc ("clk: hisilicon: Add clock driver for hi3559A SoC")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied to clk-next

About doing the right thing, it seems OK to remove the free for now
because the code continues on anyway.

