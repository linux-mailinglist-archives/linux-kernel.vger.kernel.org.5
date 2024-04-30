Return-Path: <linux-kernel+bounces-163288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 734F88B6872
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137611F22129
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911D410A0D;
	Tue, 30 Apr 2024 03:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myAu4gBs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D278214012;
	Tue, 30 Apr 2024 03:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447413; cv=none; b=lxBpCSnoYo8v7RC96ym13LO7NN/0l4VqkeV9a73EY1epucARsrC8opCxSQQVAVsIcRe37nv83PPzgILQCyRr2UK/sXR8XMmIPFEmq07ne0owRmW0cnpkH2NCuNvDGN90Ksr9F2UsIGCIYljakRweVvBYjPWaQNOwG+kT+/7XQKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447413; c=relaxed/simple;
	bh=+ziwUOuJ/5z2kID1ktuoOnRRYM512wFNMBw8R4f1CH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZqbAIPPZShs/18uXs+p47unwZUNf4ENnqdBZIGX1gqPeUPhwGAlrEpc7WzxmViTmp8oeonitNZ7wi70jmR6u3Nrp+IfWatdcbbVlkSoyjLce+MGb9hC42sA0ubFG2HeIP57kspvHTycCW39g/zhFMpee2CyjRjxLGLdXuPAJTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myAu4gBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6375C116B1;
	Tue, 30 Apr 2024 03:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447413;
	bh=+ziwUOuJ/5z2kID1ktuoOnRRYM512wFNMBw8R4f1CH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=myAu4gBsisirnn2O0lJ4Ig1Cm0FyC7rYAJzytGiDK4azOQ1ii9xHas1MwjaxUZLAQ
	 Tgx19e1KESqZVBq5dhBBIiGIOCEBwVF+yDz+ZzUMdiVaEqL2bbx5zrvHElcVL864JW
	 IU8x0ueDVSm2uE9wN447iR53NyOkkGnHKmBvxuEG/TwZ/IKkBuEE6bIZlOzJvCsVrh
	 XCCw5fTkPrvQCsMOP0Rq5Fql8TUHSnRlzDipFPFHNBFehYq/+dhO2jChsq0YCuz6Y8
	 0fQPGLST31rlspF0L5lH/5+WzoGh+++Z0Pv3cojd3ivdYyNCaYM0JgU7UZefZVWmJ0
	 w3asVzGGnlBYw==
Date: Mon, 29 Apr 2024 20:23:31 -0700
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
Subject: Re: [PATCH net-next v5 10/10] ethtool: Veto some operations during
 firmware flashing process
Message-ID: <20240429202331.29f3dafa@kernel.org>
In-Reply-To: <20240424133023.4150624-11-danieller@nvidia.com>
References: <20240424133023.4150624-1-danieller@nvidia.com>
	<20240424133023.4150624-11-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2024 16:30:23 +0300 Danielle Ratson wrote:
> Some operations cannot be performed during the firmware flashing process.
> 
> For example:
> 
> - Port must be down during the whole flashing process to avoid packet loss
>   while committing reset for example.
> 
> - Writing to EEPROM interrupts the flashing process, so operations like
>   ethtool dump, module reset, get and set power mode should be vetoed.
> 
> - Split port firmware flashing should be vetoed.
> 
> - Flashing firmware on a device which is already in a flashing process
>   should be forbidden.
> 
> Use the 'module_fw_flashing_in_progress' flag introduced in a previous
> patch to veto those operations and prevent interruptions while preforming
> module firmware flash.

Feels a little out of order to add this check after the functionality.
I'd merge this with patch 5.

