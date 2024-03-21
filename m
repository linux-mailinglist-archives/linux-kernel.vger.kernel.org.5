Return-Path: <linux-kernel+bounces-109619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B30E881B70
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36346281C22
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B5F9463;
	Thu, 21 Mar 2024 03:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEsWWEo0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2183B1C05;
	Thu, 21 Mar 2024 03:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710991146; cv=none; b=eNrQ+qWL4XXG70gaAvYeeoaQPvehVTCg5NVraQEXx5VkSoaukXmKkAeXm2+4NU2vDgO9X+gFPhBXcobL4EjlE804/LfiZbRsDIl3Ery2zFxm/9880pAjQbYwPFq7XLDF2/ZN6/ovh0fPDaOquYIdhgqUMVihjBxUTp0rkTp8fug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710991146; c=relaxed/simple;
	bh=XIrK6+XRynGxct1VOsfF7Y6IWSVr3BBqO6upxc4Ad60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJn67+NqSsMNVmdHoLmFEBcc9NmUnoLxQX8k/CsbgtM/B4IO19TjbkrsDKpB+BO2UD9cC6/CRfY6HyQIf6Xffm87dmwdTOg9jZ3kZtwdzqY8Bhm/GhuI8ue946TLmOgE48UOs0s+h8eN2+JX7tALqgKOUTl3Dh/SuJyUFNL96uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEsWWEo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9F9C43399;
	Thu, 21 Mar 2024 03:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710991145;
	bh=XIrK6+XRynGxct1VOsfF7Y6IWSVr3BBqO6upxc4Ad60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sEsWWEo03vCQ+jN1NVSuMr9+zxUVpDZFBKix28LduCbvd3YIKMDHPiyZz+twhejYs
	 LAzw4msSbkJM6YQaD3ERHRau5GRwV2YHk4gctfY8PWrRNEgm3USaj21oOemBul10GI
	 U01I2/vITIYGKcp7UfpwjG6xexEG13SCrqygSTlHfshyOwCJSvYXIaQ9vjqosTQpEu
	 Jm3GEyBjGCI5nW8MwdgpnN1ELFqdN/3wefcIbbXrmi5troDDTjOdBQ/oiEEVsyhToJ
	 4bAbcuHRgHkBYGWUeO97VW/JQGAY1Brc+QuF4eixekIYLHpTDODZf9COqSQ8blk/oH
	 P7xhUpjds0e3w==
Date: Wed, 20 Mar 2024 20:19:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Herve Codina <herve.codina@bootlin.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2] lib/bitmap: Fix bitmap_scatter() and bitmap_gather()
 kernel doc
Message-ID: <20240320201904.519613e4@kernel.org>
In-Reply-To: <ZfssQF5MIQSFCaT8@yury-ThinkPad>
References: <20240314120006.458580-1-herve.codina@bootlin.com>
	<20240319193338.068c2559@kernel.org>
	<ZfssQF5MIQSFCaT8@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 11:34:40 -0700 Yury Norov wrote:
> > We took the offending commit via netdev, so I feel responsible. Please
> > LMK if anyone else is planning to apply this fix, otherwise we'll take
> > it and ship it to Linus on Thursday (19th).  
> 
> Please go ahead and add my
> 
> Acked-by: Yury Norov <yury.norov@gmail.com>

Done, thank you!

