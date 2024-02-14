Return-Path: <linux-kernel+bounces-65588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD7A854F1D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB891F2384F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219B3605C1;
	Wed, 14 Feb 2024 16:51:00 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B155C5EA;
	Wed, 14 Feb 2024 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929459; cv=none; b=OixhP7uhMuS0zFMGygJkno3Ih6SY2CCLQ7ATlb9YJtpEbAZjP+Xaerg7YG31szdYm484/EDyBYxegvXnMH8z87kWpnNQBov5i7u2S6av4sV2Rw4dOATjC1w5hxRDK5qPSIJvUHdgQUdouGlNJmDCpwZrTbAUjaIM71v2H8WjfSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929459; c=relaxed/simple;
	bh=S42bjmD60jSOOw1MRkNUdJ295mrK6xebOQrF+1Ej8Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iz6KiRMaGm4kMPIPEnLJduz2uv141/Lis5h3qBYfKTch4SJEra+ZFn6fcEVbx8VD1im42GW/3ZnKH88ZC+VcwWvme4eLI6Di0uJfU4LqVRyO3cYIBlq6B+jMVia5X7dD4Yv+UPXG2XRwx4UUZsnCUi4/SC/KvLm9u5d4Hda34eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id A3C842F20258; Wed, 14 Feb 2024 16:50:54 +0000 (UTC)
X-Spam-Level: 
Received: from [192.168.0.103] (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 0D23F2F20256;
	Wed, 14 Feb 2024 16:50:52 +0000 (UTC)
Message-ID: <6cbbecf1-eba1-f3e1-259a-24df71f44785@basealt.ru>
Date: Wed, 14 Feb 2024 19:50:51 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] gtp: fix use-after-free and null-ptr-deref in
 gtp_genl_dump_pdp()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: pablo@netfilter.org, laforge@gnumonks.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, osmocom-net-gprs@lists.osmocom.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, nickel@altlinux.org,
 oficerovas@altlinux.org, dutyrok@altlinux.org
References: <20240124101404.161655-1-kovalev@altlinux.org>
 <20240124101404.161655-2-kovalev@altlinux.org>
 <CANn89iLKc8-hwvSBE=aSTRg=52Pn9B0HmFDneGCe6PMawPFCnQ@mail.gmail.com>
 <1144600e-52f1-4c1a-4854-c53e05af5b45@basealt.ru>
 <CANn89iKb+NQPOuZ9wdovQYVOwC=1fUMMdWd5VrEU=EsxTH7nFg@mail.gmail.com>
 <d602ebc3-f0e7-171c-7d76-e2f9bb4c2db6@basealt.ru>
 <CANn89iJ4hVyRHiZXWTiW9ftyN8PFDaWiZnzE7GVAzu1dT78Daw@mail.gmail.com>
From: kovalev@altlinux.org
In-Reply-To: <CANn89iJ4hVyRHiZXWTiW9ftyN8PFDaWiZnzE7GVAzu1dT78Daw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

09.02.2024 22:21, Eric Dumazet wrote:

> Maybe, but the patch is not good, I think I and Pablo gave feedback on this ?
>
> Please trace __netlink_dump_start() content of control->module
>
> gtp_genl_family.module should be set, and we should get it.
>
> Otherwise, if the bug is in the core, we would need a dozen of 'work
> arounds because it is better than nothing'
>
> Thank you.

Thanks.

I tracked the moment when the __netlink_dump_start() function was 
called, it turned out that in the gtp_init() initialization function 
before registering pernet subsystem (gtp_net_ops), therefore, outdated 
data is used, which leads to a crash.

The documentation says that ops structure must be assigned before 
registering a generic netlink family [1].

I have fixed and sent a new patch [2].

[1] 
https://elixir.bootlin.com/linux/v6.8-rc4/source/net/netlink/genetlink.c#L773

[2] 
https://lore.kernel.org/netdev/20240214162733.34214-1-kovalev@altlinux.org/T/#u

-- 
Regards,
Vasiliy Kovalev


