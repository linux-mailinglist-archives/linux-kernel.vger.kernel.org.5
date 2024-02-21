Return-Path: <linux-kernel+bounces-75356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A2D85E72D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61F61F22854
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029AA85C6A;
	Wed, 21 Feb 2024 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsgkSVWp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FE17FBBC;
	Wed, 21 Feb 2024 19:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708543391; cv=none; b=MVmyLR8oLjeQtc1Zj3+OYe/jSUZCeBuAW7KD7RDtb1TCVTPXe70H9SdK2Wo0unQL8smeI9VVEp1Zms3LhBea/8xQE4EGbBvOPN+kuQCUgT2RrzXfOEcEI9y1BupjujTTOvRMLqXS6AhW5RqByhG7kSvmtuD63seXjggzhSS2RfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708543391; c=relaxed/simple;
	bh=44BbNyfO2hsLqhiZVvFq5AvRg+M1fVAZffeBMNfhyiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WaYsSUeF9FLBaJvuNX71gnJs2zv7WI9fM0NamHiJ16pUOjtyUU/qy+v8AMswz9Yo/G/D5fG0IJS5kwgnBhrK82ghrVHt2hU/Z3a9no15S31gN+nGekCHPPB8tf0XxrW/azfz6s0Sz/N3IF87qqgS3dQLKiUHCL0JKKHEWrdFrH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsgkSVWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96ABCC433C7;
	Wed, 21 Feb 2024 19:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708543390;
	bh=44BbNyfO2hsLqhiZVvFq5AvRg+M1fVAZffeBMNfhyiQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fsgkSVWpCiY3k/2b0VPWcRC6q4k2Ou0tkwN+cvGyweSSB+RxysHl2P8o0VAdF3fWx
	 hYbsY34/PqN3RQCQ+s2RWbRsq24gpBLEoFLbBQJtb0rqbb6wLIhoAQ14UIjReK5FzV
	 QcUF+scXNMtBCph6bZON+bmylZMguBPIsfquKzqKaVmPVCa3DS6vV0aVZzRohTwxjt
	 Nl5RJ2MOv0LH+gG+xMymWRzglrzP4ezoRvuzJn998QdqUwrprQ4PCJPS1gaQP7H36/
	 DKFw/ewWDq0zbKcJ6MTy2wSKI7EWxfA7OnRPgfa4ratc9V8ftokLZwpZY246u4uBrz
	 Hk1BPsN+Jr/Jw==
Date: Wed, 21 Feb 2024 11:23:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, John Garry
 <john.g.garry@oracle.com>
Subject: Re: [PATCH] net: ethtool: avoid rebuilds on UTS_RELEASE change
Message-ID: <20240221112309.7d526047@kernel.org>
In-Reply-To: <20240220194244.2056384-1-jannh@google.com>
References: <20240220194244.2056384-1-jannh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 20:42:44 +0100 Jann Horn wrote:
> Currently, when you switch between branches or something like that and
> rebuild, net/ethtool/ioctl.c has to be built again because it depends
> on UTS_RELEASE.
> 
> By instead referencing a string variable stored in another object file,
> this can be avoided.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> (alternatively we could also use the utsname info from the current UTS
> namespace, but that'd be a bit of a behavior change, and I wanted to
> keep this change a no-op)

Is this related to John's work from:
https://lore.kernel.org/all/20240131104851.2311358-1-john.g.garry@oracle.com/
?

