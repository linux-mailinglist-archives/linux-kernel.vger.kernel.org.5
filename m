Return-Path: <linux-kernel+bounces-110149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EE0885ABC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63519282FF8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BD786277;
	Thu, 21 Mar 2024 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpxN06Lp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3339885279;
	Thu, 21 Mar 2024 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711031303; cv=none; b=Rz9YUc+q5bErlzlbFEYaR35HfUWG/J0cXkMVGLTegPBDDcCH0tvG+oIGk5M0YsNWAytCyCIUpFOlZZ8rK29+p3hVIsiGew9kQkmOG5uEOAOMNMhyGOWXAlU0L9NA79gtTKOPavyF0ttvOcfjUoWqB88M2V3nhPMokpxO+mpRrj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711031303; c=relaxed/simple;
	bh=pH2prGeFdJHwwa2fwQUUxFRLlz1GTq7varQulC5JgdY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8DHshr59EyVNQMuqoDXLvp2VcicAWl63RFCqmz+0YsAi2k6N/SDQz2y+qpfYlNvfYuiEn0q/4IcQVReUA1XNAfa4LG6Z+5z+v3HOJFqiksYgXynelgeepNvsJkR07lh4kkCwczFJ+dOPg82/ZvU8nRpL4zD+Q5nPvWRAJ5PpkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpxN06Lp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDABC433F1;
	Thu, 21 Mar 2024 14:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711031303;
	bh=pH2prGeFdJHwwa2fwQUUxFRLlz1GTq7varQulC5JgdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SpxN06LppfVgIhmcsu1LrlaPRuDknGG/5OjUT5Wu+HapT8qxkC8DGJ+6guCxsERy1
	 PXZpdK+Dm1USZIRFXud+clP1GT8QF72UPK7UfyHLkoAsFM24+lUacMN98ru+KSstF9
	 OYj9uf+ri6/KXrTMW/4glRlbmBr29nm06GuRCGKcXVApw5eNf4g8DJJoGK6qz+rAGv
	 J3xCmoV3A/XHruiLd9xAyosdmPjSmq+ePeZs8x4N25ak1RxBXhnTE+xp94RQ8LYc9f
	 0LI5lyBQsTHoSzT0UOAl2NrNRpo9fzTVhGpL/H0FR3Wl/2Gv4YV9tpbUHAT9sjIENR
	 tGTK4DbXeziKA==
Date: Thu, 21 Mar 2024 07:28:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Breno Leitao <leitao@debian.org>, Kalle Valo <kvalo@kernel.org>, Jeff
 Johnson <jjohnson@kernel.org>, <keescook@chromium.org>, "open
 list:NETWORKING DRIVERS (WIRELESS)" <linux-wireless@vger.kernel.org>, "open
 list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER" <ath10k@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ath10k: allocate dummy net_device dynamically
Message-ID: <20240321072821.59f56757@kernel.org>
In-Reply-To: <9fcdb857-da62-4832-ae11-043fe993e4ad@quicinc.com>
References: <20240319104754.2535294-1-leitao@debian.org>
	<9fcdb857-da62-4832-ae11-043fe993e4ad@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 08:12:46 -0700 Jeff Johnson wrote:
> NAK this based upon the ath11k patch results.

The ath11 patch is much more complex, I'd wager this one is fine.

> As suggested there we should just use kmalloc/kfree to match the existing logic.

Please no. There is no magic here. alloc + free must match whether
you're using magic object alloc wrapper (alloc_netdev()) or straight
up kzalloc().

