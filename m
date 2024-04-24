Return-Path: <linux-kernel+bounces-157578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 233F28B1322
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE240B2A20A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096A722EFB;
	Wed, 24 Apr 2024 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="suRkzCOq"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3FE22612;
	Wed, 24 Apr 2024 19:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985363; cv=none; b=McYEieON50SUjk5ucWL7FRjiua/PhPROrUmxDDMhmS2vUN9VEXbZd8UjPGDIwlY+3Kni/xNoY1scTiVImSj6I4MC2j2rrMNf0S6xlNtEUhdZhoEzoGEVc5ghCBJ0ul4HTkiv4ECqiSFUtJVldFpWVNJ6kQoYzdR/UUWVydbBD9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985363; c=relaxed/simple;
	bh=D8hVz++GpFugfjOvsQUiim3GwV4aUgvi8Mgm/n/7cxk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gEjWBmmIZ8JCd1DIBZftNfrlx1BpEVwXsiis5RzU/DJp2oA2uDuv+t5n8x6A9xlK9kshfq32Ji9/i2XK+SNmaGjUZRYSdoDSDDvPBj74EMeJ8K2K3UBGsXzoj/c8EguQ+D8jwtHKR47Z7ErDNIR7rP0N3wP2/0hPvnvphvxy7Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=suRkzCOq; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6872747C41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1713985355; bh=WuEWuIcnEOYd1g2UFaW7pujvnyvueZalHPpMfpbYQtc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=suRkzCOq3jKKULBoBSPI1YxskVl46LvvS2yhgwfIsn2+m3ilswllUMR1Ms4oQkMo2
	 eCL0AK72AKDbHYHcv23ptOdORhWXgOZuu8q3SnmMj0Qg+VNlJ+Q7GLv3KJj56OrNkG
	 84ziE1GMb+tM9mnm5sxUl1Dvqfar8GSo3naNDmAl6UtuFJTAKHIeOe7B7Ho7/jRYtA
	 Ylu4YVF/dClA4ilc8lCeqKeG2/JMoRmFoTz6EB4dNe+o1DZS+CpCGCYiidz9dXelJx
	 RKSlTOyUwI9CeX1IEk2ETDI5a8PoAlgWk80J7qIy+mpwBvmTCm+Jl8LwE7zVKGoKnC
	 Zy7ltUCMpgn5A==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6872747C41;
	Wed, 24 Apr 2024 19:02:35 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: "Bilbao, Carlos" <carlos.bilbao@amd.com>, elena.reshetova@intel.com,
 Akira Yokosawa <akiyks@gmail.com>
Cc: bilbao@vt.edu, "Naik, Avadhut" <Avadhut.Naik@amd.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap
 <rdunlap@infradead.org>
Subject: Re: [PATCH v3] docs/MAINTAINERS: Update my email address
In-Reply-To: <97731c94-99b0-46be-8b78-5dac8510f690@amd.com>
References: <97731c94-99b0-46be-8b78-5dac8510f690@amd.com>
Date: Wed, 24 Apr 2024 13:02:34 -0600
Message-ID: <87cyqetwhh.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Bilbao, Carlos" <carlos.bilbao@amd.com> writes:

> In the near future, I will not have access to the email address I used as
> maintainer of a number of things, mostly in the documentation. Update that
> address to my personal email address (see Link) so I can continue
> contributing and update .mailmap.
>
> Link: https://lore.kernel.org/all/BL1PR12MB58749FF2BFEDB817DE1FE6CBF82A2@BL1PR12MB5874.namprd12.prod.outlook.com/
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>
> Change since v2:
> - Fix .mailmap entry from <old-email> <new-email> to <new-email> <old-email>
>
> Changes since v1:
> - Update .mailmap

I went to apply this, but it doesn't apply to docs-next.  Which tree was
this patch done against?

Thanks,

jon

