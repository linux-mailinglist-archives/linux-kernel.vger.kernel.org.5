Return-Path: <linux-kernel+bounces-4751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D5C818190
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04FD728564D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE498832;
	Tue, 19 Dec 2023 06:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="GHUNt1qM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0118826
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 06:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1702967616;
	bh=R/lROIQ+DrOtwuEYqrniGOZ6zIfORHny9dL8QsDnOwg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GHUNt1qM5TJLSUCcp4Z0csWIQa/ffReOZRkyC+IT6YdiUiwx7tKW7hS6iI6gC0h+7
	 B0Sj6omz+iMahV8P6Wzmc8DVGFBig6aB4mj4POnnpSwBPNg6xousZ2TAKQrkfcfETE
	 7RPH9xnxiVn46l0u+435mFv1IbDS1Hm95PiuAOdxAWcnMEvSxeFkH2d+dK/9t8wm65
	 yHFhLdKu4P1e0oE+fmCbZ7MeRwfyuobTIl8rmKHnwuf5Ab6MCTNIFRvQ0fkc+EjcKZ
	 AiRKRUk7TeMIdEXavNdigEluCe5PDHR/ham/6BPql32/rWR9yja1hbUsPsg9RogvDt
	 jmuWxSQWCB0RQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvRjD0f6jz4wxx;
	Tue, 19 Dec 2023 17:33:36 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Luming Yu
 <luming.yu@shingroup.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, npiggin@gmail.com,
 christophe.leroy@csgroup.eu
Cc: luming.yu@gmail.com, ke.zhao@shingroup.cn, dawei.li@shingroup.cn,
 shenghui.qu@shingroup.cn, Luming Yu <luming.yu@shingroup.cn>
Subject: Re: [PATCH v1 2/2] powerpc/debug: hook to user return notifier
 infrastructure
In-Reply-To: <8734vzsw0q.fsf@kernel.org>
References: <B375A36C9C4D73FF+20231218031338.2084-1-luming.yu@shingroup.cn>
 <8734vzsw0q.fsf@kernel.org>
Date: Tue, 19 Dec 2023 17:33:33 +1100
Message-ID: <8734vyn1ky.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:
> Luming Yu <luming.yu@shingroup.cn> writes:
>
>> Before we have powerpc to use the generic entry infrastructure,
>> the call to fire user return notifier is made temporarily in powerpc
>> entry code.
>>
>
> It is still not clear what will be registered as user return notifier.
> Can you summarize that here?

fire_user_return_notifiers() is defined in kernel/user-return-notifier.c

That's built when CONFIG_USER_RETURN_NOTIFIER=y.

That is not user selectable, it's only enabled by:

arch/x86/kvm/Kconfig:        select USER_RETURN_NOTIFIER

So it looks to me like (currently) it's always a nop and does nothing.

Which makes me wonder what the point of wiring this feature up is :)
Maybe it's needed for some other feature I don't know about?

Arguably we could just enable it because we can, and it currently does
nothing so it's unlikely to break anything. But that also makes it
impossible to test the implementation is correct, and runs the risk that
one day in the future when it does get enabled only then do we discover
it doesn't work.

cheers

