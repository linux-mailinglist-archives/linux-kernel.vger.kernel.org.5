Return-Path: <linux-kernel+bounces-148666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CE88A85D0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7111F21BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06141411E8;
	Wed, 17 Apr 2024 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUGdD89K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1318B13F42E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363538; cv=none; b=VG4drJWUzDahb+PaGUwkJFymdwcz7XnQR4w7mD3FoukkFYp3ZU7Gykq1bQAqANweEOSNmVlINsqVrYWhsG0I1WjYzFbVuTmYLUk7415WL7sx4fEcLL2YwTDbGeMi54eut5JTY3yVBmkDwTRvWj2NYDJXuVAj82+1Ea1ix60KEDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363538; c=relaxed/simple;
	bh=MZQGj06BJDdrslsKZJAiXK55Co8ES6uGoSaBdr5+6bI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NU/7Jve5gjDoopVIWoNv5/0H7pMsAVkTa7k78mMLVbXKUVfDVnB/BUGrfIY6HJK7mbZFCyUN8nu4Y6xmqnFpf2/4zXw5a8reNSKUppXM8S/vt8mICst73TPGkBlo9vXQAa/6h46nTaMfwI6+8KcT1xzOU+18uPNTkud3aN4TySk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUGdD89K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671E1C072AA;
	Wed, 17 Apr 2024 14:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713363537;
	bh=MZQGj06BJDdrslsKZJAiXK55Co8ES6uGoSaBdr5+6bI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fUGdD89Km7HiRVPvV9ilyfxfT8MehO5cgauI6yIvifsb9UztQiV8UtJ02vrG/pf1U
	 HLmT27aX6TVjTtmQ7AoppChmzdNpXqM32hsyuVe2bGt/LdeZkx8D36VOIMPQNpcasg
	 LjN7njybBqoCwTeuatDo/aDuh1HteTmV4u/64a2LjWiRjU3L85AsERHFWsLVgFujUB
	 ibSmUTAZ7b88htsH6jY7ogxq4wFK8RmBFIM4G0rU833BLHTjmPK46AaZgBETKGfFJY
	 /bCDVk5Mp2uZ2BNBfZGsOBQ8j9SuxoB2byM9LYsISds8dhqVG9qxlqrgCM2CvPEv6c
	 aFVPfjj202BAA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org
Subject: Re: [PATCH v1 5/6] mtd: spi-nor: simplify spi_nor_get_flash_info()
In-Reply-To: <20240412134405.381832-6-mwalle@kernel.org> (Michael Walle's
	message of "Fri, 12 Apr 2024 15:44:04 +0200")
References: <20240412134405.381832-1-mwalle@kernel.org>
	<20240412134405.381832-6-mwalle@kernel.org>
Date: Wed, 17 Apr 2024 16:18:55 +0200
Message-ID: <mafs0o7a86pio.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

On Fri, Apr 12 2024, Michael Walle wrote:

> Rework spi_nor_get_flash_info() to make it look more straight forward
> and esp. don't return early. The latter is a preparation to check for
> deprecated flashes.

Looks much nicer now! Though I did spend around 15 minutes wondering if
it can be made even simpler, but I can't come up with anything better.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

