Return-Path: <linux-kernel+bounces-74984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D0D85E0CB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7411F26D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD4480606;
	Wed, 21 Feb 2024 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DxjO3qNZ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76C58002D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528740; cv=none; b=f6ZFp+1ChOUWFzry+z+ROyKr96KmzzO83QBCk70VEcJzLwUs+pwLX9rer2CX3uzyqm5IfYPtGRggOwg+UyfuDGYMe8CH8cmu2vdurhL2kqVQZBzcUhcygIEbz9OdeIypQUdrHwfhDrAwuqiV1/mAO7fSZ2nDYvVcC4YHdJEwdjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528740; c=relaxed/simple;
	bh=SVN2brY5secpiGQcR6r7qO2NSkX9Sg3+pNiSRYMfNl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oScmDqdsG8tcyIJ7uHoFWZkZUkL963/MvzBcrLmXyhtKMVhvzGvrWj8Q+0AL4YxOQLj+RYBorAIheGrjFzqN5ysCKeW3+UxqjDQJCiUIxkdbz/aN3CaTNIgRLH/JdotVH842jarOQ8yDzAOT4C62lSltxQJchRc1RBuOI4dJV+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DxjO3qNZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sPMSiwVCiPeIGwx/AAt1khtpUMTfnKFjzlJJot8Dxks=; b=DxjO3qNZEsRbv9bgH6zJr6Xx+4
	bRW+lGgb37aeyfZERuZo1Xp9XVx+BCF5kiMRHCZ7vDWRnTLA/DAcJFIi1P/PJs6Ov6plCIKPDWtw6
	OQDmLj8AF9of5cbrY6w+LomPvDeg9TaAhJmaUJ/OB5+Px7I46r4HBvZNyQmMZueK/m7umIrLU2Xen
	mis/x4Xwbyplo9dcBLAI9zvx7u0CBKB66Ly7OCnI45CH8iK00YhzFubeVSgzTIVlI46l9aef/aiDJ
	ujG6ClwOLOL35GoFduW9v97NNAF8aWQ1khOVcPYbV7X44w4DkdHyG+V916au3M2ouTgBfDjdKUqLd
	vcBzLP5w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcoN6-00000001Rci-3s9K;
	Wed, 21 Feb 2024 15:18:56 +0000
Date: Wed, 21 Feb 2024 07:18:56 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: russ.weight@linux.dev, gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware_loader: Suppress warning on FW_OPT_NO_WARN flag
Message-ID: <ZdYUYOuFzE8yZ0Yz@bombadil.infradead.org>
References: <20240219163954.7719-1-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219163954.7719-1-quic_mojha@quicinc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Feb 19, 2024 at 10:09:54PM +0530, Mukesh Ojha wrote:
> Some of the warnings are still being printed even if FW_OPT_NO_WARN
> is passed for some of the function e.g., firmware_request_nowarn().
> Fix it by adding a check for FW_OPT_NO_WARN before printing the warning.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

