Return-Path: <linux-kernel+bounces-128927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D128B8961F2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59C94B26C83
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD1413FF5;
	Wed,  3 Apr 2024 01:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIWb1X+D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E42CE56E;
	Wed,  3 Apr 2024 01:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712107433; cv=none; b=ADR8MG1a01D7q9Tr7cVF2SWOuPBeb9R/x8OT3lbTdLXfYZMIwurkgEZVhJn8jCgzsu6r5t0egtyCwqhvPk/+LKwL4rouo2R6x3dPzZ13R60c/IPrQY+Pobv5Q75B8bwZQQ1ypXHPVFCO62ZzGcHfSJi+WQmwca2Bd5Mk6mgR6go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712107433; c=relaxed/simple;
	bh=Yy3W35jtTdyObIhJ/w2Brxj+AIW5aDDLh0ei+LhZZUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drom+z7sAIejHcBeR1T009EmVa5NNBjuY9drx4sdbY+56FFTRLZVljTXP0eT+aHwAeIBVf+ASoeHFfRrQyl4rQabGAvzepQjcJWgLbuPS67kg1mPIhRVaP0IA35zPqPbxZP9IglikOCeEDZvGS0S2uxfI3d1u4RVXQCndwxtjNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIWb1X+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769A7C433F1;
	Wed,  3 Apr 2024 01:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712107433;
	bh=Yy3W35jtTdyObIhJ/w2Brxj+AIW5aDDLh0ei+LhZZUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SIWb1X+DZwHj4mHi9J3FOltBIYLuYyWy5XHMgk6IGbuxD7JDxd6Vcze3wRIHkmlKB
	 eVMUSkF1MF+ueaF6HjJq9TqXB7TcgnrlyhXUeUlbgFd/3UcxAGIcc59vEhd3gfA6jt
	 S1IyofvTDw5rTYFznLP0lY8gYUSo8n/fU10QO0F3rPnxqfFJx0MoaoEgJT3VtFgocD
	 sZ6QcH0rQNEjgoWY8RZTdedkLHdatfzIrPLETbDluALQGK4SMzLxMHW52E0LwET4yU
	 kRrhTYOLHEv9S5kuwUUp4e76ZIExuJXfW0j3VPBA9cxD7+1gLGx3r6Ga1fdwxN8vOx
	 qnzAvh/pG5eGQ==
Date: Tue, 2 Apr 2024 18:23:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] net: stmmac: mmc_core: Add GMAC mmc tx/rx
 missing statistics
Message-ID: <20240402182351.031f5b59@kernel.org>
In-Reply-To: <20240401024456.41433-2-minda.chen@starfivetech.com>
References: <20240401024456.41433-1-minda.chen@starfivetech.com>
	<20240401024456.41433-2-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Apr 2024 10:44:56 +0800 Minda Chen wrote:
> +	unsigned int mmc_rx_control_g;

What's control_g?
If it's number of received control frames it should be reported as
MACControlFramesReceived from ethtool_ops::get_eth_ctrl_stats.

