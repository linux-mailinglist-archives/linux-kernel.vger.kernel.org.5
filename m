Return-Path: <linux-kernel+bounces-55124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CD584B80D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA211F26D28
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073BB1E869;
	Tue,  6 Feb 2024 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Df1b2z7N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460DC22F1C;
	Tue,  6 Feb 2024 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230151; cv=none; b=sz2WBVN72MRsKn6yteRSGDIIGoQnC55ajJFDidGLs2M1VweDH8c7Zqy5TMoNHf/2WAVO34Vdg7j06UupRMpcuaz8A6g7OO0qvh2FxpY52niV9Lnv+7vUYhVlZhZNIfuhhiGC/jMvEK8G9V+7qnnMzps6RrePKHq29jzh+ucQ5Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230151; c=relaxed/simple;
	bh=0trDy6wcqwUr/47UQdt5PyNJOKfMwbQCB+kmGzzwG4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yu2ykpZU7I9TRclWnUnowge31xBvC8hrS8Lq+3noRUpmGgsMmxULC3cdu9eKOy5yxgbXXiIbjeqMfMLXte/lR7RDa2GmoAQaIwrA7opoTVTbKH5nPQ8m9o8+wz9w0DAez57eEpKr5uNaKT0UGmtXmrzdaQs0IIvLxGnVO5frGzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Df1b2z7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11A3C433F1;
	Tue,  6 Feb 2024 14:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707230150;
	bh=0trDy6wcqwUr/47UQdt5PyNJOKfMwbQCB+kmGzzwG4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Df1b2z7Nd44BXPbrnR9LM+6F9r8NXDadjpFefdBvw4tsMjC12zUTYcWDzC+co2w4c
	 FB/3T/q+I5+r5IX3xC/jGmcOHm8hlYdq15SIJgzDDvzLmu9lAyB5/dHrt1jrLheCjd
	 PsqO4w3EnyK3uic75Tv6UOw0VgOgu8V0CkKEcvnGkQGtAlgBi2jL8S6suXNi8YdUch
	 9t40eFo9kX1I1O1EcJM1DM1WsZn3ZMxg2qauL5UZFEMsWC9+L2wqF0QLciSlfn2zTp
	 7Iae3xnXXSPGkQiGlIg/DMjUfx/fAWty2lVEYyf0U+NYLcUpH8wjbwRpN1m31PD4US
	 qp+4HG/YImQcQ==
Date: Tue, 6 Feb 2024 14:34:16 +0000
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: krzysztof.kozlowski@linaro.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nfc: hci: Save a few bytes of memory when
 registering a 'nfc_llc' engine
Message-ID: <20240206143416.GC1104779@kernel.org>
References: <cover.1706946099.git.christophe.jaillet@wanadoo.fr>
 <01cafe43646575d843ce81221ef4e0cdef6df84b.1706946099.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01cafe43646575d843ce81221ef4e0cdef6df84b.1706946099.git.christophe.jaillet@wanadoo.fr>

On Sat, Feb 03, 2024 at 08:51:04AM +0100, Christophe JAILLET wrote:
> nfc_llc_register() calls pass a string literal as the 'name' parameter.
> 
> So kstrdup_const() can be used instead of kfree() to avoid a memory
> allocation in such cases.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Simon Horman <horms@kernel.org>


