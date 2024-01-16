Return-Path: <linux-kernel+bounces-27692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A55882F432
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5751F24B08
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227311CD39;
	Tue, 16 Jan 2024 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQc8vUZN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E1B1CABD;
	Tue, 16 Jan 2024 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429622; cv=none; b=mK5LO8wlXtBnyXEceEl7gdiIVrmwaCqMArHwKQlmcHfbQz/1Ov/+Pn2Vap4HjoOGpV1mMkypaBPwIK1GHqh8Jvrm+YNhxiTytz57jNX03K5L5s9Zd7caWxt/w5TGCYjxFdskPO2NYt2aqh6cPKVsSM9KxTOm3lBLe0tv95Po6QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429622; c=relaxed/simple;
	bh=ksTT7otkFuZ3TfpBCATNfR7X5lSyn/EtMAW/HBn05lk=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=f6y1Oo76fvqyx2WRPT7dsSYrX3ORQ4ZVdtVN522ZX35AS1AxynxWOjzwU7Un/6cINjJuCnAyVxyBYHdaBg/fiNNZQTdYUQPAdTWTgS5Z9lRehVYWVo1QyUiFPMDsaPpN8iKoItRoU09Ekl/FwQls5hJoib6ZnewgPKwFLdklHq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQc8vUZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2773C433F1;
	Tue, 16 Jan 2024 18:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705429621;
	bh=ksTT7otkFuZ3TfpBCATNfR7X5lSyn/EtMAW/HBn05lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQc8vUZNUbp5PHty7JFX18C7OgBqSeNzGvvol5FcQHoAlHoN+PKItErFSI7ei+q5R
	 /e3ptAch5LbbEf3D1ICwU49+85OoxWsuZ2vWVJdtRwwwFGfjkfT/JyIvHdhfIFZzqR
	 y1+0kU4+GyLKtITqEJpvYGiTF0VXzLFwHc9idVB5+bZHI/XboIcmxp4/Z68KDvuEs/
	 eiFGFb3OXf9mJBy7C6oHqNEscRjBvtwC/QIWue2IaP3jsu2lcLNIx6B9b1JBi76+Ye
	 b/SXxLtMvcmELgeqOnKZs4CzMoTFFslwSDnwAEik5NEn7kzOmrFvBQocN3Hj1wyIxu
	 1rj5mWsxPSAOw==
Date: Tue, 16 Jan 2024 13:27:00 -0500
From: Sasha Levin <sashal@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>, catalin.marinas@arm.com,
	will@kernel.org, keescook@chromium.org, arnd@arndb.de,
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 5.15 05/11] arm64: Fix circular header dependency
Message-ID: <ZabKdPnhwPALE5Z0@sashalap>
References: <20240116010729.219219-1-sashal@kernel.org>
 <20240116010729.219219-5-sashal@kernel.org>
 <hevfrjvifsaglbjta3ut6og54wcy6bu2ymjab5wly3a7kawrn7@6ctlgbhpfhso>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <hevfrjvifsaglbjta3ut6og54wcy6bu2ymjab5wly3a7kawrn7@6ctlgbhpfhso>

On Mon, Jan 15, 2024 at 08:46:07PM -0500, Kent Overstreet wrote:
>On Mon, Jan 15, 2024 at 08:07:05PM -0500, Sasha Levin wrote:
>> From: Kent Overstreet <kent.overstreet@linux.dev>
>>
>> [ Upstream commit 04bc786d663543512d08f1b86c7bcefb5144afe3 ]
>>
>> Replace linux/percpu.h include with asm/percpu.h to avoid circular
>> dependency.
>>
>> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This patch doesn't need to be backported, it's fixing an issue that
>occurs with the memory allocation profiling patchset

I'll drop it, thanks!

-- 
Thanks,
Sasha

