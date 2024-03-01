Return-Path: <linux-kernel+bounces-89147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A185A86EB22
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC06D1C23275
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D06C58138;
	Fri,  1 Mar 2024 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nt0M7OVF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F945810F;
	Fri,  1 Mar 2024 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709328502; cv=none; b=hVu4I+jHPXF161oFk0Ycu/gKcu6TpTauNXpHrgFwln7sJ9bQfOpasDMtAj8TQZLBb/mHHFvIlDjhrsCg/NagymICdaC2lXsUZvyyVbcc8Sa4BH7swD/UqkRmEs2btGLelzSweMO56bepA3WcCirIfNeolsTdY8XzgrmyUfHTrUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709328502; c=relaxed/simple;
	bh=nXjPiWNmBdKJjciRfvUp7jz/RJ04d81N51LnB9Qo/Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr0suzxsqf/l01Fj6l0s4dPMPRPqMz0iNqngxZ95TwioHoe14DnRCPjdMU6Es/ofnp+5GDZ5NqGqGaI2YPVyffM6elBT+y4noa1J/pi0UtMi2Hl90TLxDD4fSXemL2g/sIfO9gO/RoM6CP6hc310BG1zHRcIpTd6BhbryL1wDrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nt0M7OVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB55AC433C7;
	Fri,  1 Mar 2024 21:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709328502;
	bh=nXjPiWNmBdKJjciRfvUp7jz/RJ04d81N51LnB9Qo/Ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nt0M7OVFItSPUmJWsWBEdbqOH2y5PwmnkrWgk789KoUwJ1pMWJxp3dIEUe0JLvnLF
	 edmbLw8pow3I3oPdnqkibkzOmsidP5GuWMrtb9EQTLqHEygdoPcR7vEtlqnY8dmql1
	 tVDNTmaOFbum57rzfhe9lCyXoEfu50SYLmF34fhDABWT3pJUOz01nvkDEhDtErD5dU
	 D4vSV3xAMJO9GAF6Ftzo5ImiHkUS0fxRWwm5N4n2IaczMa3zixJCD3o9c05WJMPbH/
	 B+QI5OX3MalK2d4DF0fUi4fx5UfEmOHs9Pf2oaydUzOZk0UdwdhqFSkJObOiCBpjwf
	 v7YSXpqKAVCHA==
Date: Fri, 1 Mar 2024 15:28:19 -0600
From: Rob Herring <robh@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	=?iso-8859-1?Q?Herv=E9?= Codina <herve.codina@bootlin.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] of: property: fw_devlink: Fix stupid bug in
 remote-endpoint parsing
Message-ID: <170932849758.3069211.9107185737518213439.robh@kernel.org>
References: <20240224052436.3552333-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224052436.3552333-1-saravanak@google.com>


On Fri, 23 Feb 2024 21:24:35 -0800, Saravana Kannan wrote:
> Introduced a stupid bug in commit 782bfd03c3ae ("of: property: Improve
> finding the supplier of a remote-endpoint property") due to a last minute
> incorrect edit of "index !=0" into "!index". This patch fixes it to be
> "index > 0" to match the comment right next to it.
> 
> Reported-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Link: https://lore.kernel.org/lkml/20240223171849.10f9901d@booty/
> Fixes: 782bfd03c3ae ("of: property: Improve finding the supplier of a remote-endpoint property")
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> Using Link: instead of Closes: because Luca reported two separate issues.
> 
> Sorry about introducing a stupid bug in an -rcX Rob.
> 
> -Saravana
> 
>  drivers/of/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


