Return-Path: <linux-kernel+bounces-55727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A1984C0E6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9C41C247B0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C041CD19;
	Tue,  6 Feb 2024 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxo7JDOg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8376C1CD1F;
	Tue,  6 Feb 2024 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707262211; cv=none; b=nYnyNkxR1nqQMiDiIvbUMAYKsiFCmGqFPwwnRbe0kMBGQhVIiS9MdO6ZH2imsymALY6FWjOeZLdEDDp4OtDjjMJUYLRj86veEXe8Vf57iRFQqBbgrE2tvPtQ9QZa25QPkObM2x9NnOYQbEzhjKge/kBxTTGLGDt7CHUvLXH+6Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707262211; c=relaxed/simple;
	bh=bEZzxrjmXdGWmzLzZmKyiuwKqJtVkLkw2+vEepcg+OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNAbs/YkJf2tCC/+OVSrEh758TyujdcAG1vKecT1Zb0VqcIxFv/jsGyLnCVkDV89yIkRw/TjKpLPWVpxBZjKtUs+yEXaji6QILvf6T4S7PGs1N/g6ThIFUylN0wHFL02gWtOFdMEQ8/RJ3oDqsrs0uRfgbiCwzupQoSXDR/L9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxo7JDOg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EABBC433F1;
	Tue,  6 Feb 2024 23:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707262211;
	bh=bEZzxrjmXdGWmzLzZmKyiuwKqJtVkLkw2+vEepcg+OQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sxo7JDOgqIlzDqsVIqXV0u99NxJVD8GMIhWHRtsFKmHeX7ElHhGxJC/ZJofQMNLrv
	 QeGXG9xtsdymCB7DMzcpg2LSAG+NRVdQlKOVtmtljSnYBDZPgJpJGy/SUtaQAWVOhW
	 ZmrGDtxy8mA/zV/QZtRs5BOKzTQoYnO6fjtz/deIcu4jERqhchsa3XzXEHnQtTgx5q
	 VsO0y8kt2EBUJuDRmeQX9pRXNNJD5skz43tEqwz3EuHoDgNQFK/8IYZw2HHwTKgnoU
	 cp3EzGtj21wKShOtU5MSLUUcKTKXjuciWoeu8jigdFevr/bz0sePYTfQQLGW5YekEo
	 pz/r59f7lUtlA==
Date: Wed, 7 Feb 2024 00:30:08 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/5] sched/vtime: do not include <asm/vtime.h> header
Message-ID: <ZcLBAKMJ5Vbbm2Ln@localhost.localdomain>
References: <cover.1706470223.git.agordeev@linux.ibm.com>
 <2402f44309e1c9705501bdc9b798e8fe6d73f905.1706470223.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2402f44309e1c9705501bdc9b798e8fe6d73f905.1706470223.git.agordeev@linux.ibm.com>

Le Sun, Jan 28, 2024 at 08:58:54PM +0100, Alexander Gordeev a écrit :
> There is no architecture-specific code or data left
> that generic <linux/vtime.h> needs to know about.
> Thus, avoid the inclusion of <asm/vtime.h> header.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

