Return-Path: <linux-kernel+bounces-55722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D9284C0CA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28E628399C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAD91CABD;
	Tue,  6 Feb 2024 23:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5iOZ77h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776761CD19;
	Tue,  6 Feb 2024 23:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707261640; cv=none; b=nUmLXHcDRIc8N9E2QQqzkq+adDLe+DgoGv0tnslz+4ui5UL9hDARJvsih0bhZ9s0T6Tk1ixngjhu3rS3awRExwP1Xa6XMD5rxMbsBZQ8ussyz4YI0QcHhrgEP8YTbgsJMGV0KqVw9/CyDPcEu1qHgrgOMznz+AiLqrA4VmaRPGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707261640; c=relaxed/simple;
	bh=1O9RvWgEImib2iF51r5QYr1VDYDSSOzJ9bKUEoxfyA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZazPOJskmTnYSowzJ7OxoD2RFESdCxYiVq1vwrokyQ6IcYp3eFIUNoBa+SDcaOyEO7lZqpEnefgmbju07AQm0FXEaXcUzhVA0Pao+zibLy9AWmFwFIvKRquO9PZXm3GyAyqQQVQuSornztswP6nIvdk2N03eb3kj7iCcKDarC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5iOZ77h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CCFC433F1;
	Tue,  6 Feb 2024 23:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707261640;
	bh=1O9RvWgEImib2iF51r5QYr1VDYDSSOzJ9bKUEoxfyA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H5iOZ77hy5azlnJnGSyQdl4mhV2QCSpLc03NRtFn/YccY2rA3WUNmT0O2OGzZ4+sb
	 APKAEO2dBqXiyKR6pv6SRbtOOxA5OmZ/ZB3THAEwTODuO2IHIi/HsY8d6qVi7FaVvC
	 Cl0PPplbM88qe73PhLyGAML1/E23IiVS+mqwCsSM1/Ik1at9AN2t0mJgFnINMd0epr
	 m0hjrx1Ss6L+E/Qy3jQXrJ9QXvI35J6PdcDUJSjFqAlgp7suRJXeUzh35NHim+7F2l
	 8e5gZuZMP5trLx514I7b961ZTrSSN3CKIFCoBc87XzSxl05XS1+XLz5HL5K3VQr2Y+
	 KYX3PG36klLYw==
Date: Wed, 7 Feb 2024 00:20:36 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/5] sched/vtime: get rid of generic vtime_task_switch()
 implementation
Message-ID: <ZcK-xETH4ny8zMbW@localhost.localdomain>
References: <cover.1706470223.git.agordeev@linux.ibm.com>
 <1f519a8c86cf13bc4acd18ed5d8d1705d1554083.1706470223.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f519a8c86cf13bc4acd18ed5d8d1705d1554083.1706470223.git.agordeev@linux.ibm.com>

Le Sun, Jan 28, 2024 at 08:58:51PM +0100, Alexander Gordeev a écrit :
> The generic vtime_task_switch() implementation gets built only
> if __ARCH_HAS_VTIME_TASK_SWITCH is not defined, but requires an
> architecture to implement arch_vtime_task_switch() callback at
> the same time, which is confusing.
> 
> Further, arch_vtime_task_switch() is implemented for 32-bit PowerPC
> architecture only and vtime_task_switch() generic variant is rather
> superfluous.
> 
> Simplify the whole vtime_task_switch() wiring by moving the existing
> generic implementation to PowerPC.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

