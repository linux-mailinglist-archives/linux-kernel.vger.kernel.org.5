Return-Path: <linux-kernel+bounces-148859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CE68A8834
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490671F226A8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC734147C89;
	Wed, 17 Apr 2024 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZTwn/r+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315F613C668
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369263; cv=none; b=JKFgrsU//ZDx2iy2ghikXPn0CXRMBq0Z7KEYVfxqb/7BfVtnzHIeapXzP/WwTktEDXoy7GlqE9Y1GVG/gEX88ZqiPD2q8QVlqtNMhG1MHiha6TN9njzMuNUBfYHQn1CMvg0O0YvCfq7HctTjb3PFBxp3owzPIP+SB64fOJnZb9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369263; c=relaxed/simple;
	bh=W0YWw5vLPqHHsCnnmSR86Q1J8YxmqvWrAh+Q7H1bIBI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hH5wdyIqsjp3D2e3phN0kgnXaC3JKSVagm7gfdDbQxq7dJoThDrmmMesqxqLuT7r26eOxxGvXf+NoJzrQgy5IwDO2VHm+lZLUnR5/qvdA1dn+vbPgyzBKGYu/3AHYqjKsNxltmGrfB+9E0CsjsAW3DJA66OZOQr8AOyd1dLo2bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZTwn/r+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89155C072AA;
	Wed, 17 Apr 2024 15:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713369262;
	bh=W0YWw5vLPqHHsCnnmSR86Q1J8YxmqvWrAh+Q7H1bIBI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UZTwn/r+Fvv6swnbxOfWV4DDq8j/kIxriBCJTZzt84QD2a75YIl42j647fTKSV7KX
	 Bxt645CujvhBakPtpfeCicQOuhgQWa9fSrQKseJGGR/o4HW37wXo3YnR07UJWXFYCv
	 upWBUessqnYZN0IWlMqs5ipfyIrtfY/QGn64IXfldeHU59xmIU7cyhjV/6OEBiM7gl
	 wZ+hXjP/Srhg7MmFqv+6PsADlUVlmdqoCi1GevYU7vuOYQ2AWrC9XQgyYzXOGaXRAd
	 F66ftSF7ZnK6BxnoFV9WInhLQg2T6QcPooz5UCqgS6Oy8vTrXgYeaCm+UdAE0hWyhN
	 xBr3EV0dYeFhQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Pratyush Yadav" <pratyush@kernel.org>,  "Tudor Ambarus"
 <tudor.ambarus@linaro.org>,  "Miquel Raynal" <miquel.raynal@bootlin.com>,
  "Richard Weinberger" <richard@nod.at>,  "Vignesh Raghavendra"
 <vigneshr@ti.com>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v1 3/6] mtd: spi-nor: get rid of SPI_NOR_NO_FR
In-Reply-To: <D0MIJ6FT9Q2J.3B75NFD9SOJ7P@kernel.org> (Michael Walle's message
	of "Wed, 17 Apr 2024 17:45:51 +0200")
References: <20240412134405.381832-1-mwalle@kernel.org>
	<20240412134405.381832-4-mwalle@kernel.org>
	<mafs0sezk6rcr.fsf@kernel.org> <D0MH78KYG87L.ETRH24X6MK6X@kernel.org>
	<mafs0frvk6luy.fsf@kernel.org> <D0MIJ6FT9Q2J.3B75NFD9SOJ7P@kernel.org>
Date: Wed, 17 Apr 2024 17:54:20 +0200
Message-ID: <mafs07cgw6l3n.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 17 2024, Michael Walle wrote:

> Hi,
>
> On Wed Apr 17, 2024 at 5:37 PM CEST, Pratyush Yadav wrote:
>> BTW, -M and -C options for git-blame can help you a bit. They can detect
>> moved and copied lines, and look for the original one to blame. From man
>> git-blame:
>
> I know, did you saw "So You Think You Know Git - FOSDEM 2024", too? ;)

Hahaha, yes :-)

> Anyway, at least in netdev unnecessary code churn is frowned upon ;)
>
> -michael
>

-- 
Regards,
Pratyush Yadav

