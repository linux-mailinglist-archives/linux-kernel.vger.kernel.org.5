Return-Path: <linux-kernel+bounces-41255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5923A83EE11
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EECDCB2203D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228D22941C;
	Sat, 27 Jan 2024 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mp4N5V47"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6785728E0D;
	Sat, 27 Jan 2024 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706370529; cv=none; b=QoD7vX2hiHGXd/xyJseNQbGaH/Fmn+L84NeMrRXwH/yiyG74TDMikCeAdqE+0Yrtv5EoYUvRxsysl2RFIW1XF1iWxFdA4s+X18EsRMRxxGfkni6OxW8yiLilgcQi58XDzq+wbBrcqoLwYGf1ivLUElOF2S+2JSr2ymwUgLLJCd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706370529; c=relaxed/simple;
	bh=6CXq4Rt4QMBMD4/zjKHeRa1y6dixk2tNS4/vGYDiNrA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqo4JyHMiX3Z/Q1d+KKk7I3lE1Liq6eei2WfPEnGGac6ALZbfycyX1pFb3goQCHgPF2jRB3R/4Kkc0vaS1Pxlb7t45/hNnGHZGCjmx/Pie5L2Da78PBV76X6T4KFMLt2Y6opJrhRl75eEz3aIV8n0LJ7F6yVHOCB2UbYNJTjPzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mp4N5V47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43DFC433F1;
	Sat, 27 Jan 2024 15:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706370528;
	bh=6CXq4Rt4QMBMD4/zjKHeRa1y6dixk2tNS4/vGYDiNrA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mp4N5V47GiY9uNd4/P6igePZ+QY56uxETxFT04gUBd7WxrYZd6h5VGS+2mNqD4sZ/
	 ga63x58+mkIt+Cd2OLcoeki8yUxyBX3RkKfMQ1zdOwLtyOHK7wtJHTNonZm2JMjle6
	 eJpy5PVi1MBLpRJo6L/V6kqNxVN8Qbb+aY1pNzmw6oIx5bWEYu5gpE2H9TCUz3poC/
	 cJWOvsIGM1+fDUfgds3+bDLxelIs4onFnhOrQa6FflXCogmL6b+58OemUllcViQNuW
	 ipj45CWIUt7pXK7jH5yLVPrOfVCLWE453+e4xUd5c+8QTlhtRPX/KSQbBMAEs+gnT6
	 n9RJXyPzRwXKQ==
Date: Sat, 27 Jan 2024 15:48:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?=
 =?UTF-8?B?Zw==?= <u.kleine-koenig@pengutronix.de>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] iio: health: afe4403: Use devm action helper for
 regulator disable
Message-ID: <20240127154836.153127a3@jic23-huawei>
In-Reply-To: <20240123140918.215818-1-afd@ti.com>
References: <20240123140918.215818-1-afd@ti.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 08:09:15 -0600
Andrew Davis <afd@ti.com> wrote:

> Use a device lifecycle managed action for regulator disable function.
> This helps prevent mistakes like unregistering out of order in cleanup
> functions and forgetting to unregister on error paths.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
Hi Andrew,

All applied.

You could make use of dev_err_probe() as well to save a few lines if
you want to (as a follow up patch).

Thanks,

Jonathan

