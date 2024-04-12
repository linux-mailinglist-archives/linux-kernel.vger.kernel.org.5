Return-Path: <linux-kernel+bounces-142791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EEC8A301F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560AA1F23F4E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA8585939;
	Fri, 12 Apr 2024 14:03:25 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCFD83CDB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930605; cv=none; b=IJ7xqYtsY710m7t17At7ju+qM2cOXoqglLkVZZgZ4lSrg+1DFIYQfTcB0TbksnbxYHaWPx8B96tJkT75aeAt49I+YCo1kvDOQqWYiQ6dAWcwCTPQQNWxWV3atI37/pCYfiudx28ASHWYlYpnPbEDmmaAmC5caoDL3YyWwVk7pfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930605; c=relaxed/simple;
	bh=0mJdkfusfJd3v5wVnmvpxzx+okocGpsKuI3Cih1+MeE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=A87nlVwHpB6MkXIh1DLT9x/VyanHNLljOFiUsqL6JtieGTZSwN+77a+QsnNJp0E8SJjavVMrC8p8EAHEXBkbg3gUJj5rZAIcxrT5tUivNFXidkCg7E/Qtypb8O3JI9+hqagPV7vpNyY1Fu1ePcfOdTz0EJf3OnB07ZsTh0xxyvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:6430:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 7F2AD3E6;
	Fri, 12 Apr 2024 16:03:21 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Apr 2024 16:03:21 +0200
Message-Id: <D0I77YRZ2H9K.3P77J7WK3UTZ7@kernel.org>
Subject: Re: [PATCH v1 3/6] mtd: spi-nor: get rid of SPI_NOR_NO_FR
Cc: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Richard Weinberger" <richard@nod.at>, "Vignesh Raghavendra"
 <vigneshr@ti.com>
X-Mailer: aerc 0.16.0
References: <20240412134405.381832-1-mwalle@kernel.org>
 <20240412134405.381832-4-mwalle@kernel.org>
 <14726a74-d54a-432d-a547-3b07ac97d413@linaro.org>
In-Reply-To: <14726a74-d54a-432d-a547-3b07ac97d413@linaro.org>

On Fri Apr 12, 2024 at 4:00 PM CEST, Tudor Ambarus wrote:
>
>
> On 4/12/24 14:44, Michael Walle wrote:
> > The evervision FRAM devices are the only user of the NO_FR flag. Drop
> > the global flag and instead use a manufacturer fixup for the evervision
> > flashes to drop the fast read support.
> >=20
>
> Don't we want to get rid of FRAMs from SPI NOR? Why the dance then?

Yes, but it isn't that easy. There are (three?) in-tree users of
these chips. But we can already move all the special handling out of
the core.

-michael

