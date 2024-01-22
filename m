Return-Path: <linux-kernel+bounces-32393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3143D835B23
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7561F225B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F00F505;
	Mon, 22 Jan 2024 06:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGX5H/AI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C8E555
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 06:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705905653; cv=none; b=fXi6t4gVVysjnrPjfQk2fqOpX7Zd55pTx935OG5OoUQzEtMzNFu4sjQQpkZlgzcTU07et8K6/sJfS7cf/cf72Ug9JEyah46ZKeyRjnpiN/F1m5dLswfQnfDp/sCisJPFUkDp98YAC6bpNCIb4rwx7FZJmi8uQ/8Fvz3aS8yuAD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705905653; c=relaxed/simple;
	bh=ESwAwHNR0KizEuBeTY7Ay/BPZ8adjrsgS5iwEFoTl94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxPD9zGwhs7XUOpyD/nYoGpVoJaGny0l9rOvB74C3cfiOJBFPGbRSHB1wBHVtFqErIJGbbDqWC76bAnq2Vg7gGm1IZZW/bPvj7laZe/lLLlnZJVBqJ7Akmtb/CCWKpqcjeoyIcJ/zjKnqpCZoQOn9ZJ0VaZxAlbXyRQIiUBcJp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGX5H/AI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA6DC433C7;
	Mon, 22 Jan 2024 06:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705905653;
	bh=ESwAwHNR0KizEuBeTY7Ay/BPZ8adjrsgS5iwEFoTl94=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XGX5H/AIx66uCc8tuZhnqBID3S17b5a6COs4y9JN1drT8To4onRN4jgYEvk38e25Q
	 GneFC3tr1IESHwzLLEDhWGN/N2PMI7cvewxXtqSkwlD22noRAOFL4DTTHa8iBlAOHz
	 XaC9B58CXWcPRiiQ6I2ZZbuOl0RShk4X+A7ipBJSe077b9XMJzRTJfVCiDYRoEI0u7
	 rHGVMYFEgRbIuE0rcjvtXdDfZoXLxefaKx0vl/9IcCX59s4WAnDNPbOOXblqVdIOt+
	 f+Sp3QB8AiO3rd5uiFOgZ03Kj9KJRUUz7bPZhrbWTGaxoSFippWC9v9Gtm43+n2Pfo
	 Yuh+rU2LkViVg==
Message-ID: <b0bd6cb0-bc0b-4cbd-a470-923bb2d11b47@kernel.org>
Date: Mon, 22 Jan 2024 14:40:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: allocate logs after conventional
 area for HM zoned devices
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
References: <20240117230032.2312067-1-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240117230032.2312067-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/18 7:00, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Make to allocate logs after conventional area for HM zoned devices to
> spare them for file pinning support.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

