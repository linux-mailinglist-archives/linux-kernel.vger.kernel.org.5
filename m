Return-Path: <linux-kernel+bounces-162367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BCC8B59E0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E779628C735
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D569651B6;
	Mon, 29 Apr 2024 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyBy3Dqw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737A142055
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397267; cv=none; b=p3mIwOWdb7KrhpNGFo6g6xQigY9SptLdfduoyAryzuNAiQNtwpVF/joZoGmH4mJ4Plxg7+Zik2I8FttXpvVFlMRhyNFradUFhn36OzQWUz41VLU7wBclMyPSRd9k2K+mgtdj+RuPNN1w3xijWD2onsVRLdtQIaQHrcNbkhi7dxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397267; c=relaxed/simple;
	bh=WiGmI+j0Enf5O5AlJU8LIZQyCZ6bZpihfhCn3RhotIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lSjINcwanY0LPVbEKvoSruJiOQR9G2LIheey7S0XqV6Gg9mT0/bc4HmOgCdw657/+gMGV7anuvRcyVjpEHlyDnTVsSO77D9/5iOoP0QsOqNZSw3nZ446rNo9gU/Pn/f8kvbKcMNvhjB1exlj8fovs4jIWv8Ovj2BOo2nBN9ekTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyBy3Dqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B657FC113CD;
	Mon, 29 Apr 2024 13:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714397267;
	bh=WiGmI+j0Enf5O5AlJU8LIZQyCZ6bZpihfhCn3RhotIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QyBy3DqwzwIbe4F03tqVf+oGEqmzEU4W+e6WfaZqVy/mt+O90331rfXABnFsQvCRv
	 iVZd1ZC0cyMoLGOdAQRLP4aF3hEIxA1PSMrhQwUYxKQ5LRlCsSu2xKfL+xAYtuP/Op
	 nf/IwspCNSmN8anjeS9+BaNGnDsKSBYGjipFQEXm53nTmoKNsBwZpaQqwue3QR93r4
	 dn5PY4RvxipgY81ge2k2I+4int4C5vZp2DGsCOECM3KRMZHhJeNgQzRwAHJgPjP/w9
	 5pkOr69XhejhroptfUODhKhQ7vgvb2qGdgURmCEZ20h1E0cGFovZK54+Q8JwV0fono
	 2fbxBALUz/GMw==
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
Date: Mon, 29 Apr 2024 15:27:44 +0200
Message-ID: <mafs05xw0cn8v.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

On Mon, Apr 29 2024, Michael Walle wrote:

> Both occurences of div64_u64() just have a u8 or u32 divisor. Use
> div_u64() instead.

Does this improve performance or is this only for correctness?

Patch LGTM otherwise.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

BTW, I also noticed that there is a do_div() call in spi_nor_write()
that also uses a u64 dividend and u32 divisor. I was wondering why it
uses do_div() and not div_u64() (I am not sure what the difference
between the two is) but I suppose it doesn't matter much since your
spring cleaning series will delete that code anyway.

-- 
Regards,
Pratyush Yadav

