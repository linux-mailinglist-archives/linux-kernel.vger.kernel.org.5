Return-Path: <linux-kernel+bounces-157229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C0F8B0ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785D01C20A59
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACF916078B;
	Wed, 24 Apr 2024 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXzZwUfS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E741422AF;
	Wed, 24 Apr 2024 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973225; cv=none; b=hOdWGvAJ0K2vObTjkL4llivvkNWDP6wm8K1Yknk6FZ8SDJf1bU97xiGW1HU5caRd6LXgBdStlSdPWz2nKxI4vABWdPo8oRWhwEMGLyguQhDvmy4QcQky6pJE84rE0h2zgwPclJOqEhaBwvmslttTyLCtSdS8ukGuxY1p91ewTBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973225; c=relaxed/simple;
	bh=AC95m6JL1F7JZG8sItYB3WOCvHcTlGuxSvUXzc4cQXo=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=ja+JXnbjBIlVZ7TXGgz4hGe5vKEIcmtQrYTMe+JK4pJzXmdEFM0JxyAymF1vROZLTB+TQBTfdJMBrB4/iHeiJvD54e14hAxMZLn98LqgM6dZVhOnyHE9+tjy38etL7tW2I4ogF66z8QYI2xVXqNDz/n4NSEoEatFOSANW+WtlhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXzZwUfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96481C113CD;
	Wed, 24 Apr 2024 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713973224;
	bh=AC95m6JL1F7JZG8sItYB3WOCvHcTlGuxSvUXzc4cQXo=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=AXzZwUfSlS63aY5NOuVanxUFc/7T2ibF20bWJKX5r7af+OvugTESTc8663kvPxhQv
	 qyX2aUQXJUbWwyxmKga4BZ6Is04QHw9kUbxIThssBEtwu1ts2ZaNFJztqwnmh/zhiD
	 G+s0mBzyM1uFIwFqd6FrXMjFWZa6ELu8hIUPi9gpx2iHulSbOp/jd2HA4kPlrqxnVB
	 NXKEIn3g7LRh3oh89GFmbZ4LXf/HYT9A20nwKidgZ2JjiIs4ENj9uJGgTHdaah57le
	 mW12s6BkIw8IYPiUXUoVDGI+V9LnICatyTiFSG/+g1SnQQMVMSC8MZl+cmjYHtziej
	 5DmIXM0WF1dRg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless v2] wifi: ath10k: Fix an error code problem in
 ath10k_dbg_sta_write_peer_debug_trigger()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240422034243.938962-1-suhui@nfschina.com>
References: <20240422034243.938962-1-suhui@nfschina.com>
To: Su Hui <suhui@nfschina.com>
Cc: quic_jjohnson@quicinc.com, jjohnson@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 Su Hui <suhui@nfschina.com>, c_mkenna@qti.qualcomm.com,
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171397321994.2567832.9996590005061868676.kvalo@kernel.org>
Date: Wed, 24 Apr 2024 15:40:21 +0000 (UTC)

Su Hui <suhui@nfschina.com> wrote:

> Clang Static Checker (scan-build) warns:
> 
> drivers/net/wireless/ath/ath10k/debugfs_sta.c:line 429, column 3
> Value stored to 'ret' is never read.
> 
> Return 'ret' rather than 'count' when 'ret' stores an error code.
> 
> Fixes: ee8b08a1be82 ("ath10k: add debugfs support to get per peer tids log via tracing")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

c511a9c12674 wifi: ath10k: Fix an error code problem in ath10k_dbg_sta_write_peer_debug_trigger()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240422034243.938962-1-suhui@nfschina.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


