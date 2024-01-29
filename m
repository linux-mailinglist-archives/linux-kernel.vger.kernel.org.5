Return-Path: <linux-kernel+bounces-43150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4C5840C72
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB7D1C22C43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397F815703A;
	Mon, 29 Jan 2024 16:53:58 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4744155A5F;
	Mon, 29 Jan 2024 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547237; cv=none; b=gV5T3B4Cd7CaDduuOVmv5e98THryBCYyQ7fYg+KwJeNxTjtLSKqQrUqvvFrX6Ua6QaYT9ynhxS8fo8HA6vJaEFqNLWuo/CEYQrCY5VILeP6M67oNrqPhhW3qzOMvuhu9iGhyNrBWfDlbE7ruqWiY0Td0dZlWDN0oPoG3mKY4iRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547237; c=relaxed/simple;
	bh=yKVwxPL9/WhewZ+dYuTA0bQAlhJjqWdNUHkstcnn35Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=peeNDg+n7asnHsvq8UI7Cya/69Dbgujai2gtNzQs/ZcNt8IuSEVFIzQDg2JDjNmYoRQ2ad3h0zDNxcArLPwN3G+f6+9sKQ3z4mUOj37KZspMGy7nqDbHRK3uRSMrwcOv/b8Z+l+Bn1OqLaFOSv0JaN+SicYl0/Pls7wEI5Jlj1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 2E9922F2023D; Mon, 29 Jan 2024 16:53:52 +0000 (UTC)
X-Spam-Level: 
Received: from [10.88.144.178] (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 160432F2023F;
	Mon, 29 Jan 2024 16:53:50 +0000 (UTC)
Message-ID: <f0e01978-cd8b-3670-2b31-fd39f90a92fb@basealt.ru>
Date: Mon, 29 Jan 2024 19:53:49 +0300
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
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Eric Dumazet <edumazet@google.com>, laforge@gnumonks.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nickel@altlinux.org, oficerovas@altlinux.org,
 dutyrok@altlinux.org
References: <20240124101404.161655-1-kovalev@altlinux.org>
 <20240124101404.161655-2-kovalev@altlinux.org>
 <CANn89iLKc8-hwvSBE=aSTRg=52Pn9B0HmFDneGCe6PMawPFCnQ@mail.gmail.com>
 <1144600e-52f1-4c1a-4854-c53e05af5b45@basealt.ru>
 <ZbeT31rUh0h3CctO@calendula>
From: kovalev@altlinux.org
In-Reply-To: <ZbeT31rUh0h3CctO@calendula>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

29.01.2024 15:02, Pablo Neira Ayuso wrote:
> __netlink_dump_start() is called at the beginning of the dump, which is
> grabbing a reference on this module.
>
> do you have a reproducer?
Hi, yes, in the cover letter [PATCH 0/1] 
https://lore.kernel.org/all/20240124101404.161655-1-kovalev@altlinux.org/

-- 
Regards,
Vasiliy Kovalev


