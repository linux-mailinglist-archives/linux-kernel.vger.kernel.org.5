Return-Path: <linux-kernel+bounces-86261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B0B86C30A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07BE31C219BB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB14F482C2;
	Thu, 29 Feb 2024 08:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1B5+yJ3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E4A47F73;
	Thu, 29 Feb 2024 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709193939; cv=none; b=NSunH6yEmbJiFTR7aZBcSqe/hHQnMl3C75HBDOGs+6NzHo2ukkXR7R+JHVhdlk6yK7iQI78uBCyWfs+ud6miHil+v5unsk3c6nY1H6ZBFZ3611bOnXYBgEWaTB9oM+1GagxV39iwZ7wYYwDRUk61+ulPmxkIFJa56m0OKPsthQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709193939; c=relaxed/simple;
	bh=O4ub08fowVUJaSCtr9/z+v7hMyHt9QpQVsdHz/1JMqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltqmJzviQP2iwTVtN+s5Ta4TkJeQqBefXasPg0m70fSmU/CNaLnWUwxyd8doQn+Sjfn8lXLhR4yCUa6Z+c8r5vH9i0HdlgSqI9uo4Tx3ATYpJ+FWdlsBdCyVMqwXbYAgF02AT1ygVHcwM6lcGkhsvvfeBfrKf4Wz/2mYvqMooDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1B5+yJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F5BC43394;
	Thu, 29 Feb 2024 08:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709193938;
	bh=O4ub08fowVUJaSCtr9/z+v7hMyHt9QpQVsdHz/1JMqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1B5+yJ3SgmYuJ6GHA3l/OPcShytoL5/tVWLvfE8DziynpyMrPYETuIKsxtSFm6Ki
	 16dPttpf6r4NW9U/ty8u1YJC0IcfmyAwqNv8uXN6OSYSvEKgP0oexVbKNNfMhCrJ54
	 tb7KDEKBjghWDthbU7TDmdT1u/hC5z5j3pSl8GLwEYVjEMbfJq0bJTWpHs6oJ2w3u3
	 ZYqJVIAzDyqPyzRVv6VKIHIt69yw/2H4LqeZvaU5QEtN2Flfo3yRN8iFeGRBTpczuZ
	 vuM/A9C8JXzb+dHyCoMn2eFnpJqxdFD+Qmk1yMfBzxuVZarfdzpUlEe10wxAWPfF4u
	 /woioTw/skcsQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rfbQI-000000000NL-37JJ;
	Thu, 29 Feb 2024 09:05:46 +0100
Date: Thu, 29 Feb 2024 09:05:46 +0100
From: Johan Hovold <johan@kernel.org>
To: Vamshi Gajjela <vamshigajjela@google.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] spmi: hisi-spmi-controller: Fix kernel panic on rmmod
Message-ID: <ZeA62vK1QB0xfjmX@hovoldconsulting.com>
References: <20240228190523.8377-1-vamshigajjela@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228190523.8377-1-vamshigajjela@google.com>

On Thu, Feb 29, 2024 at 12:35:23AM +0530, Vamshi Gajjela wrote:
> Ensure consistency in spmi_controller pointers between
> spmi_controller_remove/put and driver spmi_del_controller functions.
> The former requires a pointer to struct spmi_controller, while the
> latter passes a pointer of struct spmi_controller_dev, leading to a
> "Null pointer exception".
> 
> Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
> Fixes: 70f59c90c819 ("staging: spmi: add Hikey 970 SPMI controller driver")
> Cc: stable@vger.kernel.org
> ---
> v2:
> - Split into two separate patches
> - add Fixes and Cc stable

You need to mark this patch more clearly as a stable backport (e.g.
using a "[PATCH-stable]" prefix), and explain that the corresponding
issue has already been fixed upstream by commits:

	490d88ef548d ("spmi: hisi-spmi-controller: Use devm_spmi_controller_add()")
	ffdfbafdc4f4 ("spmi: Use devm_spmi_controller_alloc()")

but that those commits (and their dependencies) are too intrusive to
backport.

Johan

