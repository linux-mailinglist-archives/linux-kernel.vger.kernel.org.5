Return-Path: <linux-kernel+bounces-94126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB08873A51
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4793FB21AA5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EF2137909;
	Wed,  6 Mar 2024 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yqh9LnU6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9B713667B;
	Wed,  6 Mar 2024 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737619; cv=none; b=ADA7Yt2rgrPRJCQpduSItszwXE56hDhMN4yXPVPLqmRrvBxIdT5CMe5FUE1xCk1oa1K6/7wH36/4p1Gl21QxpBays/TCXb1c8V1qcWjDDbInBs1O5t/RN2cYU/Y/Pd+Ebq/tXssZkOFGBdXhGUZkB7n0jQVteYaWDrsJvXx2XZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737619; c=relaxed/simple;
	bh=SZlyoBAGWRDBRp2u5L70J/RZwbAwTu9tQQtjQCgNUuY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qz2RzNaUPINzm+I7DK3bHkC66bRkE+5p4XQjM4RbCF3JN4HXRFVLKyzwbHMpmQCNfisVk2dQU93cBroq6AStWRESiZLEN9uTz+bAJwjDfBTFGHQHYNvFPGTnwe7z7kJGWUsVqmN5NpqJEHxL7k+3ODEXULDTv0xKFBuHiKEAxGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yqh9LnU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A930C433C7;
	Wed,  6 Mar 2024 15:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709737619;
	bh=SZlyoBAGWRDBRp2u5L70J/RZwbAwTu9tQQtjQCgNUuY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yqh9LnU6jP3h2U+QlbSvrrMk3G4wZm0TEbB1l0+4aCQcd/AqgCiuh9j1Dbxy5tkTt
	 c4FwdhpBO88i6QMd2xLE43VMZYcoRwI3T78Zc41MUEzp4uS4V1SGU3LmPUiNyy5F13
	 9YOcIlancMLb9GIeDkIIj7BP7Zgu2QO8dO8xNF/0h/xqd/duVujFvFQJwcfgVLPzxu
	 +Uz7se7rG+6GgErhgLji9WRhP58GlzuICcVU0wRhGRmcZVo+7ewBNbd2YdKvvqRKHT
	 ZgybOt2kB4DegGRXLTte8ed3lhksynHbD7dDbwjtYeNN5GpgeTfJIPfzwiDVSt8aqw
	 IDwZWhZblok1w==
Date: Wed, 6 Mar 2024 07:06:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>, keescook@chromium.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org, Simon Horman <horms@kernel.org>, Jiri
 Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, Coco Li
 <lixiaoyan@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netdev: Use flexible array for trailing private bytes
Message-ID: <20240306070658.4216fdf2@kernel.org>
In-Reply-To: <ZehsoPb/WZzUcFHa@gmail.com>
References: <20240229213018.work.556-kees@kernel.org>
	<20240229225910.79e224cf@kernel.org>
	<ZehsoPb/WZzUcFHa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Mar 2024 05:16:16 -0800 Breno Leitao wrote:
> I've been looking at some of these embedders as reported by Kees[1], and
> most of them are for dummy interfaces. I.e, they are basically used for
> schedule NAPI poll.
> 
> From that list[1], most of the driver matches with:
> 
> 	# git grep init_dummy_netdev
> 
> That said, do you think it is still worth cleaning up embedders for
> dummy net_devices?
> 
> [1] https://lore.kernel.org/all/202402281554.C1CEEF744@keescook/

Yes, I think so.
Kees, did you plan to send a v2? Otherwise I can put the cleanup on our
"public ToDo" list :)

