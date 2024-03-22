Return-Path: <linux-kernel+bounces-112076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEB78874E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9D21F242DC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1F482892;
	Fri, 22 Mar 2024 22:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROSxjC4G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB7881740;
	Fri, 22 Mar 2024 22:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711147419; cv=none; b=YqXVxquRofCS2/D5cDG0DNQLoD1Fmpx0tu9/ynetO5lJEeXGbiR21k09wx8kDXLGmQGlmaq1mfSNAtnM2nlhSLjV/SMm2A9x5ykGfgKgcrcVXyT05W5mrXr7726nYqXYbpgbEQcz0D5O16t4HMyYdcQYzaOxtLhaYJsS2TwxYiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711147419; c=relaxed/simple;
	bh=aN/sBseW/A42djcc7C5Ic5yAvi5gLg7pYn4+yQh8174=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RrS5kyS0Wxco4YShG0BLZxaX7oXhI2aMB/7zDUE2MsdLRcIiv6nRaHQ/6mHpXJaembxnuBTC3Dfi/o974i0WO4zSY+iRAoOHadT81degfCtIxe9bDyVYNrkaEFST/u7o4SAterLPH8GQLbMjWCPK8aVb+IS65ChpqgzTkKFkNkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROSxjC4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3DBC433C7;
	Fri, 22 Mar 2024 22:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711147418;
	bh=aN/sBseW/A42djcc7C5Ic5yAvi5gLg7pYn4+yQh8174=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ROSxjC4GSYNreV1Fl54PtXf0zi8Y7Km8p6pIlE8+RGOvXHTaWFDKPO75Ipmrd23nM
	 3UPKezPW93eUTC093iowNoZb9vGYcKxDlRy9MipM0Dq5BzJmY+OHICt0ayBEJ/q5Vc
	 ppP/Bf4i6CLJbLrx49r+JyEUB32NwFCP5KC1qc1npEnLHNZQ4lAFITesi0btb9oE2C
	 +QhnYIUYFf/id5ZmHBo+sCcmuevd1R36I3mPt9rQPWLazBuFdxrQCGXTsLYkAIvBjB
	 hbxO8MISgN5hv4MHz47XsQio5GeGXLbcuZ5r4M7qOQ8wxwCMQ12b1aujIN7GFpuHqS
	 BguX/FXG9DXDw==
Date: Fri, 22 Mar 2024 15:43:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Kees Cook
 <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>, Felix
 Manlunas <felix.manlunas@cavium.com>, Satanand Burla
 <satananda.burla@cavium.com>, Raghu Vatsavayi <raghu.vatsavayi@cavium.com>,
 Vijaya Mohan Guvva <vijaya.guvva@cavium.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net v2] liquidio: Fix potential null pointer dereference
Message-ID: <20240322154337.4f78858c@kernel.org>
In-Reply-To: <20240322195744.9050-1-amishin@t-argos.ru>
References: <20240322195744.9050-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 22:57:44 +0300 Aleksandr Mishin wrote:
> In lio_vf_rep_copy_packet() pg_info->page is compared to a NULL value,
> but then it is unconditionally passed to skb_add_rx_frag() which could
> lead to null pointer dereference.
> Fix this bug by moving skb_add_rx_frag() into conditional scope.

The explanation should tell us how the bug can happen, i.e. what
sequence of events leads to null-deref. Not what logic your tool
matched on, perhaps the NULL check is unnecessary.
-- 
pw-bot: cr

