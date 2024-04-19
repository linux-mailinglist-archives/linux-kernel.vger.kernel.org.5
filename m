Return-Path: <linux-kernel+bounces-150923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4DD8AA6C1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C551F22419
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339B64A3E;
	Fri, 19 Apr 2024 01:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDziLBJi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0DB138C;
	Fri, 19 Apr 2024 01:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713491978; cv=none; b=sNJ0Ap5OZHoKOfTq8odT4K/Z7a4RrZMqCu3WHZWpsfs5EWbGAqtIjsZIi+5N/SSigssteKmoJ/1M2g6p1b8Z7tATmN3WhRmokFJCVdeuaGc1pmUrMolVNQu2G6o51NZ5kdUcLYjXNniNv6XUhawy+/Fsaca2mha5WEabkMgo3G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713491978; c=relaxed/simple;
	bh=JZVoM+QdB6JxkGZNBvN6H90f7S3tp6VIhdOo4EXC2Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjaC4lL7J0Ii7UAjU5SvPaBGQcTKCru+z1l2lWWSbBhJw5IASyD+z1TD70prgrA6A3auhhnjyc1qonPzrFJ+2/5IuaAhN8KJXkHFgLVfxAAsimhK71Q1mgsdhoT224IeMk9+ObijgLHzFGIfg8CPycNFl1V0sb/3BQhgrAJI8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDziLBJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96A1C113CC;
	Fri, 19 Apr 2024 01:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713491977;
	bh=JZVoM+QdB6JxkGZNBvN6H90f7S3tp6VIhdOo4EXC2Pc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QDziLBJi1CKzx+8mZrIz1TyoVFnB0J3QJNkCHXrXpzWzx1YBC0zPy4Vs0Y20P2aAS
	 uwUAkvLbSf9TVuaf7YtRgUXOvmu0T5mE1WHgtCC+TpCnxxTiA8w6TxMysuOwgpPEUv
	 r2PXulyOxW+4XYp2pOyTJSolpoA4c7NKuGO71+/PgE87bqYcp0mS0uoptiBuwXBV/J
	 jqOXYgxBZXppgoPu8HYW6XnwI07rEhsrty53y95qOWIg5WsVQp2akvjw0slFcFfv2/
	 J8Tu4FK/gGUPP3l7EiNugVqZ1vL9evaxdFyjQCEP/ge8WuFLVL5fx4jxxQ2aTnfp3o
	 r/D+PRyxRwupQ==
Date: Thu, 18 Apr 2024 18:59:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <corbet@lwn.net>, <linux@armlinux.org.uk>,
 <sdf@google.com>, <kory.maincent@bootlin.com>,
 <maxime.chevallier@bootlin.com>, <vladimir.oltean@nxp.com>,
 <przemyslaw.kitszel@intel.com>, <ahmed.zaki@intel.com>,
 <richardcochran@gmail.com>, <shayagr@amazon.com>,
 <paul.greenwalt@intel.com>, <jiri@resnulli.us>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <mlxsw@nvidia.com>, <petrm@nvidia.com>, <idosch@nvidia.com>
Subject: Re: [PATCH net-next v4 07/10] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Message-ID: <20240418185935.2b0ec734@kernel.org>
In-Reply-To: <20240418103455.3297870-8-danieller@nvidia.com>
References: <20240418103455.3297870-1-danieller@nvidia.com>
	<20240418103455.3297870-8-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 13:34:52 +0300 Danielle Ratson wrote:
> +static inline u16
> +cmis_cdb_module_features_completion_time(struct cmis_cdb_module_features_rpl *rpl)
> +{
> +	return be16_to_cpu(rpl->max_completion_time);
> +}

nit: please drop all the inline in this file, the compiler will 100%
inline this anyway

