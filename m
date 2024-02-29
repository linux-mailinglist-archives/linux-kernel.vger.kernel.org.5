Return-Path: <linux-kernel+bounces-87057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0627386CEC7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B427E28221E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ADA14BF27;
	Thu, 29 Feb 2024 16:11:02 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACDD144059;
	Thu, 29 Feb 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223061; cv=none; b=s9d2TcGw3XOuqgPfTiC7F1A0kTNQE+YN0Gg+cmvg78kRN1YJWVj/3z9MoOraiFha/Wa+/xhTdAxbNLJ2ZZZWJyJi9RnmTA2ktLrcGt+WUdNyhiy6dihJ6R48ha6WODxPhmd5D2pAnowU95YNomBHsQjZSSvJ86jN2nO0hRZoEE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223061; c=relaxed/simple;
	bh=X99fyzIl3BzdVUyIVfrX2sEXZjIkx/BM0jeCNyNhsHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAtGMUj9kYXk+m95AkVs7B95gWOAFS4CT/cBgVMPQdoiVYk3E1quP20TyONjVLybn3pHsv8E1NwVQqGZlDVEN9ZPQeV0BFAkRHpqdXjnxiXoLqfwbDrnXkzoxp+MIJCXFu1rbRDQrUD3ikIyCrF/BW0XNu5fbzlVg3oIJ8yI9ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.41.52] (port=35722 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rfizf-0066XT-HB; Thu, 29 Feb 2024 17:10:49 +0100
Date: Thu, 29 Feb 2024 17:10:46 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Vasiliy Kovalev <kovalev@altlinux.org>
Cc: Alexander Ofitserov <oficerovas@altlinux.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	edumazet@google.com, laforge@gnumonks.org, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, nickel@altlinux.org,
	dutyrok@altlinux.org, stable@vger.kernel.org
Subject: Re: [PATCH net] gtp: fix use-after-free and null-ptr-deref in
 gtp_newlink()
Message-ID: <ZeCshnw9Ac1fd5pV@calendula>
References: <20240228114703.465107-1-oficerovas@altlinux.org>
 <Zd_HAGqXSE6Nwcag@calendula>
 <3d8314ae-03d9-6e43-86ad-f830ea01c737@basealt.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d8314ae-03d9-6e43-86ad-f830ea01c737@basealt.ru>
X-Spam-Score: -1.8 (-)

On Thu, Feb 29, 2024 at 11:37:28AM +0300, Vasiliy Kovalev wrote:
[...]
> This patch fixes another problem, but a similar one, since the sequence is
> incorrect when registering subsystems.
> 
> Initially, the registration sequence in the gtp module was as follows:
> 
> 1) rtnl_link_register();
> 
> 2) genl_register_family();
> 
> 3) register_pernet_subsys();
> 
> During debugging of the module, when starting the syzkaller reproducer, it
> turned out that after genl_register_family() (2),
> 
> without waiting for register_pernet_subsys()(3), the /.dumpit/  event is
> triggered, in which the data of the unregistered pernet subsystem is
> accessed.
> 
> That is, the bug was fixed by the commit
> 
> 136cfaca2256 ("gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()")[1]
> 
> and the registration sequence became as follows:
> 
> 1) rtnl_link_register();
> 
> 2) register_pernet_subsys();
> 
> 3) genl_register_family();
> 
> However, syzkaller has discovered another problem:
> 
> after registering rtnl_link_register, the .newlink event is triggered, in
> which the data of the unregistered pernet subsystem is accessed.
> 
> This problem is reproducible on current stable kernels and the latest
> upstream kernel 6.8-rc6, in which the patch 136cfaca2256 [1] is applied.
> 
> Therefore, the correct sequence should be as follows:
> 
> 1)register_pernet_subsys();
> 
> 2) rtnl_link_register();
> 
> 3) genl_register_family();
> 
> The proposed patch is developed on top of the commit changes [1], does not
> conflict with it and fixes the described bug.
>
> [1] https://lore.kernel.org/lkml/20240220160434.29bcaf43@kernel.org/T/#mb1f72c2ad57b7ea6d47333e8616beccf8bce0e23

Thanks for explaining, fix LGTM.

