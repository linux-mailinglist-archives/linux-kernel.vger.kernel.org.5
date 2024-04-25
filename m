Return-Path: <linux-kernel+bounces-158970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 430F98B2789
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BA1DB26AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30ED14EC42;
	Thu, 25 Apr 2024 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKooamEZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EBA12C7FB;
	Thu, 25 Apr 2024 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065812; cv=none; b=VewBw2IkLZ9hQKl4Wrg2k7NpW6kmnyxNKVNiC5eniFqH3w0LoQF+pTMTCTiXGufAqawd9HiM7/fxTVaej6u5heTYXvKy9ohoA8NTfZ0e5ZFBBko5w7tgW+XjHPsiQE0xlyeVCAc08DJMd6/x1DG+IEiEIDhmkhXKih38MSAc/CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065812; c=relaxed/simple;
	bh=71tOg9c3cDHNigwSj/Ul5YCf2hLyj7oeig1kAtxHycI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4r4qei1dirlFhqGZCq/J8E4y/+qI7CzOIP5KXsxDS2w5JKK8vs4dMrFr/cXDbLMiiF81nCyjj1VHfeE4+xCY5SHrnlVS4jV5ZY2HwtFphLDEfXtmUYBIn+lKr81saTs3WkKhHj8mgMS8JwHt5La46I2DY03wYHEzKCsUOcGqio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKooamEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E911C113CC;
	Thu, 25 Apr 2024 17:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714065811;
	bh=71tOg9c3cDHNigwSj/Ul5YCf2hLyj7oeig1kAtxHycI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BKooamEZOlQ6f60+YsqA5u3lUvONVwWKx4PaGBKB56EgwBCKB1BmZophqOBS4//A+
	 RqB/Yqe9ufFN5RMDQE1woldKjGRSwz+VmMAhfcemLfuVBMmmSb6+K3+r0t91NiCZgk
	 /zVrG61JoxpJrhx5ikyjiX/+S7pWrz6DnRt+IcPHt/XSdR3cZODvWXETcWD/ge0iX0
	 iyDq+VdQmID5LEN7MYzNYFFPBCtOTg3SLWOaLsyqlUtjj8OR4ZUEJ/CYr6UuFkDeAS
	 NMFLnyeIMcE8EGavJ4vGi+VfrbUWPqw6S+egbqB1Al7xH8apRiGSXTQm7eLJuOB3FE
	 9Sdq6PD7E1tLQ==
Date: Thu, 25 Apr 2024 10:23:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ismael Luceno <iluceno@suse.de>
Cc: linux-kernel@vger.kernel.org, Firo Yang <firo.yang@suse.com>, Andreas
 Taschner <andreas.taschner@suse.com>, Michal =?UTF-8?B?S3ViZcSNZWs=?=
 <mkubecek@suse.com>, Simon Horman <horms@verge.net.au>, Julian Anastasov
 <ja@ssi.bg>, lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 netdev@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH v3] ipvs: Fix checksumming on GSO of SCTP packets
Message-ID: <20240425102330.700d7124@kernel.org>
In-Reply-To: <20240425162842.23900-1-iluceno@suse.de>
References: <20240425162842.23900-1-iluceno@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 18:28:40 +0200 Ismael Luceno wrote:
>     Changes since v2:
>     * Use only skb_is_gso, no need to check for GSO type

v2 is already in the tree, if the change is important you need to send
an incremental fix.

