Return-Path: <linux-kernel+bounces-141827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9AF8A23FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AD28B2317A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAF112E63;
	Fri, 12 Apr 2024 02:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QocOlV19"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29778205E14;
	Fri, 12 Apr 2024 02:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890534; cv=none; b=i69cuyvIr5GSmpn+KBvhXeLEYAq8zXextVVDIybEP15xGHxeiSbgAf4zhnxIZDkDq1MnBu7eeRraMGCLwZ/4BT6qCsNa/Q0DLqt5VbtDov+AufOThz6YcdPA6FxgQiE1+rBJWslxzaz2lyz4X/2yaUr6knUL9Q10SWkrA5sPn0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890534; c=relaxed/simple;
	bh=5zlXhp6vfxGZNNTcQ+FUjWCHBIH6LjVhONhbyat2Jww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iA3WVtrl94RnVY1z7wqcyH7f8j67d4E45Ym8AMif3d9t26KEiHwqgyRkl3weSsmawvGG8fIQfD3U7FFGUXw1hk74LGnRdYr0I258lm8npiDR4l+lJfWdb8MTYe8ZlEiiWvVK8j6nOt2+SJVY/s3Tdi1uqLJu9DU4FOUhoH1KftE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QocOlV19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24688C113CE;
	Fri, 12 Apr 2024 02:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712890533;
	bh=5zlXhp6vfxGZNNTcQ+FUjWCHBIH6LjVhONhbyat2Jww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QocOlV19cicvKdlP1yCT9dyv+enm6JR0JqUY9Bk3cjLtIL3yJVRbXh9jKWvjDcyRy
	 hd3n+7iEPSvrbP4M4s1ShaUOQPiBpRD0wicHdOCHvvMjI1sxSNVeLBlITLaXkktqVC
	 boEsOAn1wAFb/VNrk+wCpByRR6l+4fcfBxmZJsbdyjf0q+Yf2PRHB/cnZlY0/QMePw
	 pftYnr3J6L8wL96hpAqEMBzmr1AKtyC7QxY5hjqklrMgzfKHtH3QcgSx7tzbBQz1uq
	 9O8rDJ0ytBVOsxnnLbdPQcsRnmidnAsAqsgyCnc0XYdyHeu4tnBinkq9f6aOSR6lEQ
	 ZFToTCvkfjgXw==
Date: Thu, 11 Apr 2024 19:55:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <sgoutham@marvell.com>, <gakula@marvell.com>,
 <jerinj@marvell.com>, <lcherian@marvell.com>, <sbhatta@marvell.com>,
 <naveenm@marvell.com>, <edumazet@google.com>, <pabeni@redhat.com>
Subject: Re: [net-next PatchV2] octeontx2-af: map management port always to
 first PF
Message-ID: <20240411195532.033e21fb@kernel.org>
In-Reply-To: <20240410132538.20158-1-hkelam@marvell.com>
References: <20240410132538.20158-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 18:55:38 +0530 Hariprasad Kelam wrote:
> The user can enable or disable any MAC block or a few ports of the
> block. The management port's interface name varies depending on the
> setup of the user if its not mapped to the first pf.

There is no concept of management port in Linux networking.
I may be missing the point, but I'm unable to review this in 
the context of the upstream Linux kernel.

