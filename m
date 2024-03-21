Return-Path: <linux-kernel+bounces-110273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50891885C6F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87DE5B24930
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A1C86260;
	Thu, 21 Mar 2024 15:44:42 +0000 (UTC)
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356808627E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.28.154.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035881; cv=none; b=A12stnvR3E+Idif+cvGK20CGZIF+NBZVa/YsEG3FuiPaILMEOPQeeR/EVuLBXLIaXKrjpAy0BOE1iMwu0sBSjgfP75UvI2Ism9JcH2lisFRWpS1RHHAP71Jpe25mUFzc6FfBkzq9bWA3UFVrxXlSquQmvg17unqWtbJDgdjHcdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035881; c=relaxed/simple;
	bh=adoz/7Mb/2vqMcjNGOS37q+EBHMbbIROxQhxoqIrYyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9hR/qHLa/wtA5t5L/SQDQE4fsN2C93J7tanzc2JOOtcCSIPpwdePbGN//ocWg/HVGJeiim7+tZRhXsU/MOG6/z1hRYzGxahZ5OQbZyrNw6J5/fHQQ6uPbi7U06+b1OBvZ9MMngmjPgDr5wSfEoyFWDw9L2womV6Lv/WljPiZ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name; spf=pass smtp.mailfrom=maciej.szmigiero.name; arc=none smtp.client-ip=37.28.154.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maciej.szmigiero.name
Received: from MUA
	by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <mail@maciej.szmigiero.name>)
	id 1rnKEj-00065S-KK; Thu, 21 Mar 2024 16:21:45 +0100
Message-ID: <79125c93-285c-43f8-ac05-87c34c99e6bb@maciej.szmigiero.name>
Date: Thu, 21 Mar 2024 16:21:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/CPU/AMD: Improve the erratum 1386 workaround
Content-Language: en-US, pl-PL
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, X86 ML <x86@kernel.org>
References: <20240321120548.22687-1-bp@alien8.de>
 <20240321120548.22687-2-bp@alien8.de>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Disposition-Notification-To: "Maciej S. Szmigiero"
 <mail@maciej.szmigiero.name>
In-Reply-To: <20240321120548.22687-2-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.03.2024 13:05, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Disable XSAVES only on machines which haven't loaded the microcode
> revision containing the erratum fix.
> 
> This will come in handy when running archaic OSes as guests. OSes whose
> brilliant programmers thought that CPUID is overrated and one should not
> query it but use features directly, ala shoot first, ask questions
> later... but only if you're alive after the shooting.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> ---

Tested-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Thanks,
Maciej


