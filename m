Return-Path: <linux-kernel+bounces-161339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A51E48B4AE1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1A1281D63
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22D954BDA;
	Sun, 28 Apr 2024 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7Y5RiXN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C457433CD
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714295341; cv=none; b=J7JigrE/mvPflDKCEtLglXNQP3RvFuZ41EUQI9DGnkkj4Yybw27HBA/tE/ScQDEtBo0dGE8vz1lcYJB33Y9sW/f1R4bANJqQmXFvAgKmWjZ7xYIZykqETnWE0ciA2OfwHim+QmutupIN+mYlAYgF92Gl8AoVinmzYubmFcosN7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714295341; c=relaxed/simple;
	bh=2tP4WEZOMkIS1sLkWlghhXO5TyWe82hph+C/8aOfuWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LFYunOdZ+TFp4JHeUvbqVh8HfKaUM6dRyC3xcMdzI/zW69Ic5sMYFJVmXGC/4pwzlg0W6jhXQA/giPI4v0BouKFi5S8GwKiSzljre/xdNuX1MEpm48xT6HmyZkPbWBwNOaOtXYIb3gSyzpoocVoZGFtxFjns2uSUtI1YV/f0mbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7Y5RiXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9D8C113CC;
	Sun, 28 Apr 2024 09:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714295340;
	bh=2tP4WEZOMkIS1sLkWlghhXO5TyWe82hph+C/8aOfuWw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T7Y5RiXNdk2af9yVhMFgN0/9t8Ya5JILUoNzmuTeGqJEcOhC/3ROemVdt08eAAiOd
	 kQQC0R3+OpOmJRauom0KPVXVC4FFyaUy89IClXA8NA1sZTM95kpee/tkV9jb64Y63k
	 mYABO5C0gAg9O7gFHpmGC8Z5W/NVBR5i2TiqFPA1OlhA4d2RC2cgmXjsZx2pwJwE7d
	 TajWZ0o+VX54bspL0D9ik39WZnf2579ruacTVyk53sL0WKajc5b4Z9ACHvvRo9Go9z
	 0duLopJ0cIxlpKveXfedpgmgKoX0NaB2PQx5fxvjtcLkicidIy2s5Ix+On69DT6p2e
	 fuqiHkqGxpVHQ==
Message-ID: <9c56bbe5-6f33-4e67-82bf-01978b0e2519@kernel.org>
Date: Sun, 28 Apr 2024 17:08:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: fix false alarm on invalid block
 address
To: Daeho Jeong <daeho43@gmail.com>
Cc: Juhyung Park <qkrwngud825@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20240409203411.1885121-1-jaegeuk@kernel.org>
 <20240409203411.1885121-3-jaegeuk@kernel.org>
 <050a93dc-d9a8-44bd-9a83-83718e95f04d@kernel.org>
 <Zhmf4klcOr4eplin@google.com>
 <CAD14+f0Scnc1GTjqR1izHqPerCqgHsLMR9mfKocUxw_4hyZ+Zg@mail.gmail.com>
 <49a4cc15-299f-432c-85c7-ab1b1daaaad1@kernel.org>
 <CACOAw_wbCJfOpfHzsznofkP8nb=gigjwmMqrCaeUR+ago8Xo7Q@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_wbCJfOpfHzsznofkP8nb=gigjwmMqrCaeUR+ago8Xo7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/28 9:23, Daeho Jeong wrote:
> I have a question. Is it okay for META_GENERIC?

It seems all users of META_GENERIC comes from IO paths:
a) f2fs_merge_page_bio
b) f2fs_submit_page_bio
c) f2fs_submit_page_write - verify_fio_blkaddr

They are all impossible cases? so it's fine to record the error
for this case?

Thanks,

