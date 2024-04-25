Return-Path: <linux-kernel+bounces-159315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322BD8B2CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D051F24DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E662C14A0A7;
	Thu, 25 Apr 2024 22:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t489KzEa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313282135A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 22:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083494; cv=none; b=noWcGSq7KgjHSrJ+3EI8N7GUnOYHprDBz1/LQVFTb2Nfpoxln2ZJG/SYhNLRXjjSkHxJ7Z3pCPPhukTdRbBFLjzFBOUseISXzEos8LpW29yZQpUk7o8NNTHOHeYfMowIOtJp0VS3QqIjSc1JbQg4/Ze7OU8KSDT9MZXTtXbJDgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083494; c=relaxed/simple;
	bh=Dz6RWLpFcn7RlWHOMLCCQ42JSiNuOiRkMPLd1UdxpfY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRv2dWOzCf/wZJrgyk6/0+m8u1qnyWFBUkSbrPFSAcSPgYQWOChOB0A9/D8kN5YkB3yFCSaDaNJ/Zh26DxPbT/IVrMz5hR1gZrkvyjpPYDDpqOAPCD4O8NzeaKS5bxXaM1ZJkn0/IAV5vcbS19I4HTTdFtKELhQAeG2ast8kizU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t489KzEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34942C113CC;
	Thu, 25 Apr 2024 22:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714083493;
	bh=Dz6RWLpFcn7RlWHOMLCCQ42JSiNuOiRkMPLd1UdxpfY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t489KzEapf+A+qlRhxFNwbmGPHANlKrHHcdHx0/axrVh9VdDVTYmzjrfD/6WdhqEv
	 aDs9jPtPj+POa+oKQUB+3ja5DLt11+NFng6m6Q2LkvPzY93fmlMKOn/nYPDn6rRNcx
	 fV0f4HTEi63j7m4m56OFIe+iJY0WIsSKfqAOyiwm0RpUKeRUwmfvDsSHxC6VqDDLqf
	 6++6gUsX1eVBpBX5kQVFxNPVaTtjlRsMk7yqwCVHB8tYoXTqjUBwOvyJVGuopwYjjW
	 iXidfea6eytZwIKrEG2d9PbJTaHljcv87tenhV+gs4TozydQYfb4yrc+QrgZ2qJ377
	 ADeYX0yfBLoAw==
Date: Thu, 25 Apr 2024 15:18:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Doug Berger <opendmb@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.or, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] net: bcmgenet: protect contended accesses
Message-ID: <20240425151812.3a8a31d2@kernel.org>
In-Reply-To: <20240425220650.2138801-1-opendmb@gmail.com>
References: <20240425220650.2138801-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 15:06:47 -0700 Doug Berger wrote:
> Some registers may be modified by parallel execution contexts and
> require protections to prevent corruption.
> 
> A review of the driver revealed the need for these additional
> protections.

netdev@vger.kernel.or missing a 'g' at the end, FWIW

