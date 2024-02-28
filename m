Return-Path: <linux-kernel+bounces-84472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF5C86A72D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3AB1F2BA16
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF4B200B7;
	Wed, 28 Feb 2024 03:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4A31KBm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846772107;
	Wed, 28 Feb 2024 03:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709090642; cv=none; b=mcqqPByb5/ugXNfqoaxcKacx3SbF//YCbUphUGTChrk/pE5yKn8NLyORmILE6gqifqH8IWl2O1xyM9MIVd4uO1KF4SmQQEEA1XpERC+T2t7Sp7VibTutgLv0SZX6ZJ5Y09FmqdabLhUK64snxOwf3VeDarF8IAVFV/UvsflBvec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709090642; c=relaxed/simple;
	bh=qjRhA/7m70o8XxVxvrScP2vkVDFa71oSPSWfBELbXys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=siJiEYt9bEnMOaRoTuPwr58sgZOO1tsbKhMgtBIYy5joRKGcZ8YlcqA+qKKHcVTSWBvj6Nlwp+dKQ7l6rDPS9UHabU0VYtVVrMv557wHXqmZPpGDdL4MBXiKkQwn2FBPR3KU7a5kY3khmKeQ4DftOM2yJyL3QPNz9KJSTedyRJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4A31KBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803E7C433C7;
	Wed, 28 Feb 2024 03:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709090642;
	bh=qjRhA/7m70o8XxVxvrScP2vkVDFa71oSPSWfBELbXys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E4A31KBmTGU2rRX9LATdmS8xnX2Wl4RXHZPQR09a/oGzT7tkPAevLuxPnKp8keGJI
	 vTJ2f5hsHjQLaEz5uqRCs7X5kZ24yGNuhOhP08UCbkECRrucrMZ5k2vuXTzOljpyCs
	 0s8tOSmMi55lxSCR0oOEB+erU7MSCmcGaX9LrKBERtzq/eexk87he7aETHSdCL6eaK
	 8LyC54cF13Fl8U4qsLGtOEu7boziqji32fHh1XsP5jP/a2UgCNAkJ13qLxHfD2/F3C
	 DLFtu59Atjt34//wJGigH3/FkkDUbNy5yon4pUwQ/Tfn+0khjsO/nrRQOm2iXu2L3D
	 TRbkAUniEwZMg==
Date: Tue, 27 Feb 2024 19:24:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Piotr Wejman <piotrwejman90@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: stmmac: fix rx queue priority assignment
Message-ID: <20240227192400.19f4c9cc@kernel.org>
In-Reply-To: <20240226093144.31965-1-piotrwejman90@gmail.com>
References: <20240226093144.31965-1-piotrwejman90@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 10:31:44 +0100 Piotr Wejman wrote:
> +	ctrl2 = readl(ioaddr + XGMAC_RXQ_CTRL2);
> +	ctrl3 = readl(ioaddr + XGMAC_RXQ_CTRL3);
> +	

checkpatch points out there is an unnecessary tab on this empty line

> +	/* The software must ensure that the same priority
> +	 * is not mapped to multiple Rx queues.
> +	 */
-- 
pw-bot: cr

