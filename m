Return-Path: <linux-kernel+bounces-128852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CED89608C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468AB1F2407C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8B61859;
	Wed,  3 Apr 2024 00:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRg4vcbe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B82B635;
	Wed,  3 Apr 2024 00:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712103337; cv=none; b=CQXDW0Wpv83riMUjoQyU+Ro8KPU+vOKdMCH4DRCpgSNh2B0v6/3EAhFLw7vlNcwjEnK1+oyJixX3WHYhITfbgZkIXSZj723V3wk9BK5n1v8DEm3ciugTXng2Q2Bve+CKCNBZBSHywGGPGsA8IYatCx54PhkIDlIKT+nrvsqzAho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712103337; c=relaxed/simple;
	bh=X/dmJ8/MXWMjgbuUgEYfgF9KQYVZX6Z9nJyIkL32R8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOGkUAvywDIwAFA6DiIdBSPqqD1Q8XWehFxq4daEMBrygX1MouGelEshaarXvGknP0oxVFKHQIxc4d7+R2pJWU1Z73Apct5k44bWu2T3o1mvjLvso21F7eBgVDdEwixWu7wNgO98hMKe/iRcYVoue1sLFfOWXyqT7fwlkW5UVSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRg4vcbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C048C433C7;
	Wed,  3 Apr 2024 00:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712103336;
	bh=X/dmJ8/MXWMjgbuUgEYfgF9KQYVZX6Z9nJyIkL32R8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dRg4vcbest+z0eyhs50imc0OJSJUEqVOXiSHD1+LhfiCZjpaDbpWmMXVnLMatNXRO
	 cOZJ0gGMj64veGUgLA7R4c0+PVIob5gYxbVnzkk2D2A4X3MnoxcwLp/sf7HzXUDYF2
	 IjVdnBySgsJq9qNzwZ9tHNuWwyqGx4GBX/nqCkj+BpOdhgO+BNKG8XmKAPzBGgkn5T
	 9fKLNSgc7HLTJ/5/mtluC3wfqvw7JblOE/plZSpeq7JUGyJuGbLClmPpIQl0l6C9ao
	 0f1GSRL0vE3/Lk7mY3xiV1490ejkzKiYY8V02zvcLFVUZQssIpXTTr6SzJyZTNE2qx
	 Ic88akouoPLYQ==
Date: Tue, 2 Apr 2024 17:15:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, David Ahern <dsahern@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christoph Hellwig
 <hch@infradead.org>, Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
 <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Aron Silverton <aron.silverton@oracle.com>,
 linux-kernel@vger.kernel.org, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Junxian Huang <huangjunxian6@hisilicon.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240402171535.552c59e5@kernel.org>
In-Reply-To: <20240402162106.11112e99@kernel.org>
References: <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
	<Zf2n02q0GevGdS-Z@C02YVCJELVCG>
	<20240322135826.1c4655e2@kernel.org>
	<e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
	<20240322154027.5555780a@kernel.org>
	<1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
	<20240401123003.GC73174@unreal>
	<20240401075003.70f5cb4b@kernel.org>
	<20240402184554.GQ946323@nvidia.com>
	<20240402143607.0357d71a@kernel.org>
	<20240402224632.GT946323@nvidia.com>
	<20240402162106.11112e99@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 16:21:06 -0700 Jakub Kicinski wrote:
> they carry little weight when netdevs or traffic which ends up in
> netdev are not involved.

Clarification before this goes into "Leon's quote book"
netdev == code base, traffic == network "packets"
as opposed to the mailing list and emails.

