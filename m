Return-Path: <linux-kernel+bounces-15547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACFC822DF1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69BAE28260A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85801946B;
	Wed,  3 Jan 2024 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="EvJXkIjH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294C61944F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id E5C041A3C63;
	Wed,  3 Jan 2024 13:51:54 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1704286315; bh=wKn5TMlthQCZ3vs0qTpEXgCIHH7fKp9SdgkEDZ0ZHZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EvJXkIjHo6OQAa1ocgCSe/azb5fwTjmqztDGKgAZikY6aglX32yMZNKe35ufw5hWL
	 p86sarBKbG+zkVlQoAjwg6iYJLw5G61op2fXj2it/MKk0+LahlcSNtEQ72VzgmabsH
	 KkgkXuNoofUkg2jYlyLGnrSn/67JM221k1eEgIMibxlQ7YeBSq48rR03wgIo8rUmLa
	 yctwIORqq5QZ1rzUTuqWMGwONlOZRFmnMOtp6E0S4On7zl/bHmeBL4Rm7vZkzB99BB
	 npQaaM3Z1nni1vu1W9zCLLRHJd2sB6telxpL/mCn7RumviAndxz1CJ+USsDZqeqrBR
	 EQpITYk0UGv3A==
Date: Wed, 3 Jan 2024 13:51:53 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>, linux-um@lists.infradead.org
 (open list:USER-MODE LINUX (UML)), linux-kernel@vger.kernel.org (open
 list), Roberto Sassu <roberto.sassu@huaweicloud.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH 0/2] um: improve UML page fault handling
Message-ID: <20240103135153.4696cb0f@meshulam.tesarici.cz>
In-Reply-To: <20231215121431.680-1-petrtesarik@huaweicloud.com>
References: <20231215121431.680-1-petrtesarik@huaweicloud.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Happy New Year, everyone!

I can fully understand that you all have had other priorities around
the year end; it was no different with me. ;-)

However, may I kindly ask for some feedback on my proposed fixes?

Petr T

On Fri, 15 Dec 2023 13:14:29 +0100
Petr Tesarik <petrtesarik@huaweicloud.com> wrote:

> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> 
> Improve UML handling of segmentation faults in kernel mode. Although
> such page faults are generally caused by a kernel bug, it is annoying
> if they cause an infinite loop, or panic the kernel. More importantly,
> a robust implementation allows to write KUnit tests for various guard
> pages, preventing potential kernel self-protection regressions.
> 
> Petr Tesarik (2):
>   um: do not panic on kernel mode faults
>   um: oops on accessing an non-present page in the vmalloc area
> 
>  arch/um/kernel/trap.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 


