Return-Path: <linux-kernel+bounces-102635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F9387B526
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB401F222BE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4835D72F;
	Wed, 13 Mar 2024 23:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qot+M2LI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8593E41C6A;
	Wed, 13 Mar 2024 23:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710372155; cv=none; b=q6tCPlVFrl56Po134M0NJ3Or9XiM/QdmPCxqwVtP1JiJjSEQFyv2jR9wGX5DJphwNPNBEhCL7puGKgvjWRL5yMdZ+IA9RXmIxgF7Mm0l0fjHFF4Y5Uv62azoARWoPNdiaUiYCl46htXIwhL4ANnJnrFEFZ5C7v6Zc4jULYJnf1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710372155; c=relaxed/simple;
	bh=fxk1108PeCQX28AxaCyOGdwiZBxZBjip1A0EV7ScBFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClMrYt+JtYmwuXzXVCC74ouizuA73l9NcF4R+azji3l9/IL8LGo1fXs4xVK5jWtP6rlwKyPEh2hKLiQVv2Mm2h6dqG+xSHoDLz+HMwVTfd3fB3InpA2Gd70VqyRHhmtRsj8AADxaiXnpnqzWMn4BkSUsuMCsYi4GfQ2ObHoKA3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qot+M2LI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7B7C433C7;
	Wed, 13 Mar 2024 23:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710372155;
	bh=fxk1108PeCQX28AxaCyOGdwiZBxZBjip1A0EV7ScBFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qot+M2LI/PDeEfLHvdURsiJyIcCRztnqFapvO3l43uEgLjBYR02ymI5jCSlmgQU8Z
	 gAhmZZCzm98uiwg3TXbVfGaWl7jMKCfDZ9EM3rJg1nEgv3fEnlQ0eXzsrVI2uNUsHr
	 su8hgTKc9Pg369wTeo3kFKCbTXoocjHEM6OzYyCRzFKCyZGXvPVBHddJIRraA75DAK
	 DrfoyNnmsozRtOpgE3IumEpUxYOOqiLxijbnKSE/t0L2vz+m3X4/DvFJ/LIEQYmxZj
	 3G+9XkdoRoMcVD8r84burh1tOHRU7EAq+QVy53qSqY/1//Smq4VCHliW94c7hrNFv9
	 rDqqhuc1wV5mA==
Date: Thu, 14 Mar 2024 00:22:32 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: paulmck@kernel.org, joel@joelfernandes.org, josh@joshtriplett.org,
	boqun.feng@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org
Subject: Re: [PATCH] rcu: Reduce synchronize_rcu() delays when all wait heads
 are in use
Message-ID: <ZfI1OOm4+GbyYUYs@lothringen>
References: <20240313083228.233247-1-Neeraj.Upadhyay@amd.com>
 <ZfHDwPkPHulJHrD0@localhost.localdomain>
 <35e009c4-d52c-4b96-ba10-afa0be9dfd5e@amd.com>
 <ZfHXrTUHRhAVjBOE@localhost.localdomain>
 <33ff03f7-0301-42fb-842f-17f21426cdc7@amd.com>
 <ZfHfNo_J-XZX0BS3@localhost.localdomain>
 <3f544c35-365c-4782-8dd6-f523b257f867@amd.com>
 <af5168ae-973a-46dc-8766-d1949cc82ec8@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af5168ae-973a-46dc-8766-d1949cc82ec8@amd.com>

On Wed, Mar 13, 2024 at 11:19:08PM +0530, Neeraj Upadhyay wrote:
> Missed one point. We will continue initiating new GP until first node cb
> is processed, which can happen when a wait head becomes available.

Ah yes, I missed that indeed. Ok that seem to make sense.

