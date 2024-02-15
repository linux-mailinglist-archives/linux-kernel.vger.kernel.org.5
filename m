Return-Path: <linux-kernel+bounces-66210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 705BD85588B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 02:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9BC1F2934C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D173A1362;
	Thu, 15 Feb 2024 01:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVQoZunP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F2E184E;
	Thu, 15 Feb 2024 01:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707958925; cv=none; b=JLOL08xUOyIlEqQGraj+QMJDwvZ5q9zMlzzBiKHci7APQ59K/lQ3cRHQH41GPDoNegLzjr/6D1wsnjV+SIMB+r7Bxoo+pj25FjGQmaT3G+m5kY8Y0Ey8v40xID8I/7owxZgcQ0Wfws3ia9oXt+wv6WKg9G0pvufYR62AmBQ7hHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707958925; c=relaxed/simple;
	bh=Z7IBwlxEVPqGxWdYiyD7ZJELI6QCwfFBuGkNDpX6rrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=feoUdIAoGgGs7bWRHQBIzuu5jZ52ZiHTWTnS1ilPYn/43VUcAuK6CCzPdmx9GKrWb1qpu394bssadpK6XaXWIwh2AAuwgFHoKKa1Yn9R9Kzgh19aXlX4YJ78uIl/WhNeAN1vH8Xr9464Z+TY8iaGOR2PsT2dOpsB3r9H/eLC5MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVQoZunP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5F4C433C7;
	Thu, 15 Feb 2024 01:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707958924;
	bh=Z7IBwlxEVPqGxWdYiyD7ZJELI6QCwfFBuGkNDpX6rrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CVQoZunPb8jvNkG6H2BcauSGZlEDjo4hi1jrW8wc9BkZx7jvJgL0H0piu0fejtxSq
	 H+nksj2s+5vH9/AhV0nGy3BAZYnvh2fB+4zmb+2nqYPMeXrPWl1rD/FoUC4kKAfeop
	 uc1IubG66AtffHzHRNx89IWicLY06hu73DDhLO4SqArrcVuCo2utRFZc2BdR72ZCpu
	 y0aTMDVKk4+zBeNgHmnjkvK695Jawn000dSgPz45HpzD798WcWPvlf4LPCSADvHikE
	 XlOLdfMpECewgAIyWmoAllgeLxNxA2htBM57hNbxih4SmluDuS4FnwjQuVyn2WDS5h
	 8FsXb/9CSH/VQ==
Date: Wed, 14 Feb 2024 17:02:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rand Deeb <rand.sec96@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, deeb.rand@confident.ru,
 lvc-project@linuxtesting.org, voskresenski.stanislav@confident.ru
Subject: Re: [PATCH] dl2k: Fix potential NULL pointer dereference in
 receive_packet()
Message-ID: <20240214170203.5bf20e2d@kernel.org>
In-Reply-To: <20240213200900.41722-1-rand.sec96@gmail.com>
References: <20240213200900.41722-1-rand.sec96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Feb 2024 23:09:00 +0300 Rand Deeb wrote:
> +			if (skb == NULL) {

if (!skb) is more common

> +				np->rx_ring[entry].fraginfo = 0;
> +				printk (KERN_INFO
> +				       "%s: receive_packet: "
> +				       "Unable to re-allocate Rx skbuff.#%d\n",
> +				       dev->name, entry);

no prints on allocation failure, please, there logs will include OOM
splats already. A counter as suggested by Jake would be better.
-- 
pw-bot: cr

