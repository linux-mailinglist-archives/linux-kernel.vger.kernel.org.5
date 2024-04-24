Return-Path: <linux-kernel+bounces-156214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303518AFFB2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F5C1F235AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF8113B583;
	Wed, 24 Apr 2024 03:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScufGjgy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3705F126F09;
	Wed, 24 Apr 2024 03:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713929585; cv=none; b=Xm+P9wP3dLIc0je8FtD0rT6i/F/J0j9qXKhm4wIz0l4WAb16pHLSH8f07gKXJLXeSZnOp/IfdxYijnOs/hn8ZpZ4UhSoMz/2WTmZpxd7O7ganwmj2gQD9MVk44JTpVJNAiefPotXbG/UelGmBAuLyAag06fvNwulCQu5DFLfv60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713929585; c=relaxed/simple;
	bh=KZ4Wx3vojtmu1T5yBHKPKnazen3vB69ch9sDcexlvV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pI6hAougtFXyQvpDGvN/kQ+9ECSKuzVA+7QPgtKXEvbjwPw5Kin0Lh8ccLWgZFVFj7gf3xby+UpWOJZDIOgLlntoDd+qAzcdc1M8o4Rq04VTKvhl2UYF1URtHbVBVW4MndfscRFh+ZcPSPacqK1O9HLf8PuLVrtjYOsslm5CGxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScufGjgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F273C116B1;
	Wed, 24 Apr 2024 03:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713929584;
	bh=KZ4Wx3vojtmu1T5yBHKPKnazen3vB69ch9sDcexlvV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ScufGjgyMUpjq8Nav6ywOaQ/8Qn2TtYdQQD1VtIiKz9pOUM9mUQSKl4HnVLXlwlEr
	 kXxoKsf9FUxsaFaIOWOAcUfbxJ3F9WTzeNZirGV/CpmBEFSDDFacxCUNuS8ODQcnds
	 BlC1SV/S7rajOOc9jbj+U3jFzBhrDIKLWRCliuqtoV2QofhPdAfjlM5n97mG4hHLU0
	 wSadH0cRAgfSKNXd+3Era1PHXChzo/cCrsxdth245pUMNos3MLLz6GN4J2k1NyRUpm
	 I2d/TFQjrEZ3Y4IqIYgzwfxUw0hXl2Tru4OP5cXPAmfuzcfxjN4nRhzwYQJITJ9Dqx
	 GuGwoebqxLuXw==
Date: Tue, 23 Apr 2024 20:33:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <christian@brauner.io>,
	Chandan Babu R <chandan.babu@oracle.com>, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: xfs fixups for the fop_flags conversion
Message-ID: <20240424033304.GC360940@frogsfrogsfrogs>
References: <20240423124608.537794-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423124608.537794-1-hch@lst.de>

On Tue, Apr 23, 2024 at 02:46:05PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series against Christian's vfs.misc branch fixes up pointless
> harmless but pointless over-declaration of capabilities for XFS
> directories.
> 
> Christian: the first patch would make sense to just fold into the
> original fop_flags conversion if you're still rebasing the branch.

All three patches look good to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
>  xfs_file.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

