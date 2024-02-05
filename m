Return-Path: <linux-kernel+bounces-53908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9B384A7E7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3BA3294C5F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D407132468;
	Mon,  5 Feb 2024 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQU23IF+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD220131E5A;
	Mon,  5 Feb 2024 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707164507; cv=none; b=NMg+hc3Q9zc4gNZULBeJBJ2apBS6l9Zs39/+mrZKFozAIEOqeihYiN8hS/ebD9C/lA37aQnTGdMgGIA9W6WgU+9UYPmz8rWcdGlTK8YwydPoKZ8OQtnp3R05DmY1UcUjxNfEyggypeJZ9/8fQ7SMGyT30DXIhMf0fmC6NNxdMEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707164507; c=relaxed/simple;
	bh=OnPs4J2FLqlSi9AAQWsy8ks+h3XUSpaDvBaw8zXZYQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3D5vZkXdnSRGmdA+HjiAJRXaNwuiGmVBA3vUtChjRTc4p9SgOoFocaNbp6Flc5g3ANh0XlXtk7Dpgbcw3WM22UsnIz6OcZNM2OZqcwBUxrieO7qWKryHyGAyiXWzABXVI4sQwvHR7HU40q3LcKCL87EMDS6sc8v5wpHD1qw1ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQU23IF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B56C43390;
	Mon,  5 Feb 2024 20:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707164507;
	bh=OnPs4J2FLqlSi9AAQWsy8ks+h3XUSpaDvBaw8zXZYQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQU23IF+/34JM5UsTXGwn1C4ycg82FIgulYTDDJ9CBWTOVB/n/X7uBYLMm7HSPgOt
	 i+cus8mTPvjvjWEo4Aw26/x+dVoCCXUrwTTrzecCMmq+SBzrp9nfk9IercDvb/RwxT
	 60Im7bvxKSTFCnoDeHhyDNoIejyAnkKYwaeGXQo07Iux7rQSwW4qTiC3MD1ZcO0PYb
	 EAX/V+f/52BeppcBvGr7nKWXYNc/L9JrAs3rGrw+zEfnDgQXSSADSCk1Dbi0ozS+Ic
	 dVlJSnCocWslszkJWVahgh0jize4v/cZQL49RK3IbzeFVyHTre40nQz6BvOkKyMxDi
	 0l0JHCnpGM3WA==
Date: Mon, 5 Feb 2024 12:21:45 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] overflow: Introduce add_wrap(), sub_wrap(), and
 mul_wrap()
Message-ID: <20240205202145.GB2220@sol.localdomain>
References: <20240205090854.make.507-kees@kernel.org>
 <20240205091233.1357377-2-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205091233.1357377-2-keescook@chromium.org>

On Mon, Feb 05, 2024 at 01:12:30AM -0800, Kees Cook wrote:
> Subject: Re: [PATCH v3 2/3] overflow: Introduce add_wrap(), sub_wrap(), and mul_wrap()

Maybe these should be called wrapping_add, wrapping_sub, and wrapping_mul?
Those names are more grammatically correct, and Rust chose those names too.

- Eric

