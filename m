Return-Path: <linux-kernel+bounces-164299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC1C8B7C06
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FBB0B21205
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D343217557B;
	Tue, 30 Apr 2024 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6k1uonD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CF1175570
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491941; cv=none; b=lGDd8uCpBb6ekAOt5lEA+uravBGcKAv5VPo/j8lnscGP3Mc1qNQH94uaOFF9ldOLDNWnGwTaemmLfha5YuLJz7d0uDZvpPxYuw+LhqhLK7OYYj80bJYa0hRsDcxHLye8XsRjtPOzAyh4STjMoe8qZwPOQ1oKmUi9VX4huZZIFM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491941; c=relaxed/simple;
	bh=oZb/aw2XkBtHn/oFyQgCSsXV0ubKMtqH5UegEn065zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sd/JtTS+FWyaYT8DtzR0IOLdJYr3eAJ+xoZFvoUCmsJW8kD1Pflrqw28K5pHBCLKKxzsvF3O/PN9VQJWZgOAFdRy4aSfDrBE3qjAPYuRJvaUGQS/I/tPgDbiT6AjP6jYu4EY41JKphMBsisJPHHEzJWDki6XBsj9IdVCuMpX0QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6k1uonD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF31C2BBFC;
	Tue, 30 Apr 2024 15:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714491940;
	bh=oZb/aw2XkBtHn/oFyQgCSsXV0ubKMtqH5UegEn065zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=u6k1uonDHc4Fw+PsIS/HeIekAfg5iF936HnVWcEyh+4aD9MQG6WpGxmqx0TtvaiLc
	 Bwpq8vOpax2dK2hJw3WqjEAMgxU0Z+I2aHaqGca1/m/5VtJ5dKZDqJcmUaCo1MIlnB
	 Yev5QeRUgdvkj7EHm+z1fhLC3yxyCJg63HlletFNqbDmk4K0VvYmKalyLdcrT6sylH
	 qqW0oujeptdUACruJ/8B0jkC5XvADkePG7b0Y+z0UFaSADlOxZdbnFjtBuz8worgFF
	 Avmxkdc4o6eiFoTtp8736OULZde2uAYlk3ssIMHB2+j4xxDyLUbtXuZLwtsvve8hGp
	 vos6e+FbUGIEQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Dan Carpenter <dan.carpenter@linaro.org>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: replace unnecessary div64_u64() with
 div_u64()
In-Reply-To: <20240429121113.803703-1-mwalle@kernel.org> (Michael Walle's
	message of "Mon, 29 Apr 2024 14:11:13 +0200")
References: <20240429121113.803703-1-mwalle@kernel.org>
Date: Tue, 30 Apr 2024 17:45:37 +0200
Message-ID: <mafs0ttjiam72.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Apr 29 2024, Michael Walle wrote:

> Both occurences of div64_u64() just have a u8 or u32 divisor. Use
> div_u64() instead.

Applied, thanks! I fixed up the commit message a little by adding the bit
about performance on 32 bit arch, and fixed some typos.

[1/1] mtd: spi-nor: replace unnecessary div64_u64() with div_u64()
      commit: https://git.kernel.org/mtd/c/c84b3925c7d6c

-- 
Regards,
Pratyush Yadav

