Return-Path: <linux-kernel+bounces-77679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF3B8608DB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF3E1C22394
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12F8DDA6;
	Fri, 23 Feb 2024 02:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7xMF9bZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B99FD26B;
	Fri, 23 Feb 2024 02:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708655389; cv=none; b=Q4SG7eFafqGLeBvBRP1Swk8c8rDKlPpFpQV9CNz37DmjZVAu831/LZCIkGJtFnVJtseix7DhgPTu3zQfkx4EpdmnapxeS0zuRZaXaC7vecgfnIgkzSjiYe9Bv7LJdATc7HcK+AEyDUSSvM70TH/xRtLQQSNDOU2P/HvZMQbkbq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708655389; c=relaxed/simple;
	bh=8HMeF1hMpyAh7aZAuXf/OPNCGHNNAMlUhcBpRVamXEc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rw+fXp2vDlA0AuT3y+tjePbQ1OujHmWnmgwMG0lctTu8+BdPOITDf+Hl38IYdaZQNKtRlleW3YfVyYduY6Q+CnolGQDZKHN8FwhaUXXqoBseZFRqZ5yZCCHwvS881lFow9VMUojcYjr1fAy/3QoaHrQbZ7tcGQyOjXln5n6UtDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7xMF9bZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652D4C433C7;
	Fri, 23 Feb 2024 02:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708655388;
	bh=8HMeF1hMpyAh7aZAuXf/OPNCGHNNAMlUhcBpRVamXEc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n7xMF9bZF8ImnNy6zHCUZnb/z+k1v6lUaki+V9YIxL7m2UoI33w4EdZWJPyEC3YPp
	 k8gxbP1+iOV/cYxaCn/ZDdJnR/LA2Bi2iUQGnpDR6Tal6DHc2e0y3+EQ4qF4AEKOCv
	 8IzUgWv9w1J0EmUcdXJFj9O8YLPSVGSQFKAEVq11FUTKBYWNNOdk7aHKQT/pULvVPz
	 Q4jksCan/lo6MhWtgvWp8y3ZnhR+BuAN220tEkgl3E+NpYdKIBnLhqMlg92s8ME4QX
	 H7p+aEGRaG+1t/sh2cQPylv79c4AAgJQ0VePtCe3m/zPDOm1Baqa7+3v4DWpQoXAE9
	 8Ais1QiYsq+FQ==
Date: Thu, 22 Feb 2024 18:29:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Thorsten Winkler
 <twinkler@linux.ibm.com>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/af_iucv: fix virtual vs physical address confusion
Message-ID: <20240222182947.0379e7a3@kernel.org>
In-Reply-To: <b96f27a5-53fa-495b-b1a4-cff574898083@linux.ibm.com>
References: <20240215080500.2616848-1-agordeev@linux.ibm.com>
	<47789946-0ffe-462e-9e2e-43b03ea41fe0@linux.ibm.com>
	<20240221143115.6b04b62a@kernel.org>
	<b96f27a5-53fa-495b-b1a4-cff574898083@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 15:41:23 +0100 Alexandra Winter wrote:
> > FWIW we're assuming this is going via the s390 tree.
> > Please let us know if you prefer networking to pick it up.
> 
> Hello Jakub and maintainers,
> 
> please take this patch via net-next, as it belongs to the net/iucv module.
> Please excuse that it was not flagged with [PATCH net-next]

Done! Hopefully nobody screams at us for the use of virt_to_phys() :)

