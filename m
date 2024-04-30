Return-Path: <linux-kernel+bounces-163201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9E78B671C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57C831C21DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7E51FA4;
	Tue, 30 Apr 2024 01:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWnOuI9I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0862A10E4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714439027; cv=none; b=LR6GgTHLErdgaz1l5zquzv+DTwDNXEGUx181Vl5FEvp2uS/8ZJyG8MiTC8nle2zyi8TciuD26zEw517deUCfKU9wVgmzTjL3H59ZygzbXulOUA4KmYbZbChpV1rR6lsfpm/bWZfd6RCgFglCU28/hFFAh7XHpQQ9Rq2oyNQ6l3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714439027; c=relaxed/simple;
	bh=PAF4WJyIaNmkSTXqrUHajPaMbgSU+MVEoA5oBCMbMss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eWwql2J9VgJctgm8dxBK0y1gMV+hnneZE6pckhIw7psdo0Qjc29C9MUB2KWwAPhaX8MHncCrTgTtWTFHem3+LvisKtNLk5PaN7YMbbbZgVJu7OAksbF7fuSHxkwxtOWiwCn9MhwwJalWXpAB4OYsYPdQQ4/SsAVHkJaIvPy16I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWnOuI9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFE5C113CD;
	Tue, 30 Apr 2024 01:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714439026;
	bh=PAF4WJyIaNmkSTXqrUHajPaMbgSU+MVEoA5oBCMbMss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cWnOuI9I7bJdf1KJ4tARP4Y9TptaMirUt76PQX1sJOdxmBmU1Pvu+Okv90iKIvDek
	 LPwapDjjQkvWR8N5NtEIIMepCioFORlsiPPebil+3+fnDqA+8nMmJKhIvHqbwCHJ6g
	 oHlXa+l0UueGyeGQEsefWLywDSYgj/30PhhU0wY5IvYbAftVnAIulnDTxfGOn3aJEu
	 OdY7MD2bWQFIB+zO0H9fAlZQNWronPrpfG8CZEVK6PByKg4f2sd/2ETvScON7qA+8f
	 wBhO2UIxAh/1E2XRscyct282libujl9/Mz0O7Rs1Yn9nOLjltHoMfv9GNp4EN3hfZ4
	 U5qiqnmF6jgOw==
Message-ID: <8ecd9ebe-8ca3-4829-96a8-0a4da3f58b94@kernel.org>
Date: Tue, 30 Apr 2024 09:03:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] f2fs: fix block migration when section is not aligned
 to pow2
To: Wu Bo <bo.wu@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Wu Bo <wubo.oduw@gmail.com>, Liao Yuanhong <liaoyuanhong@vivo.com>
References: <20240429035142.706356-1-bo.wu@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240429035142.706356-1-bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/29 11:51, Wu Bo wrote:
> As for zoned-UFS, f2fs section size is forced to zone size. And zone
> size may not aligned to pow2.
> 
> Fixes: 859fca6b706e ("f2fs: swap: support migrating swapfile in aligned write mode")
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> Signed-off-by: Wu Bo <bo.wu@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

