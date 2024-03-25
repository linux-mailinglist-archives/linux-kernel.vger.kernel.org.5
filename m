Return-Path: <linux-kernel+bounces-116620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FC588A14D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283DA1F3AC56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5A315CD6C;
	Mon, 25 Mar 2024 09:11:25 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F16215E1F5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711351851; cv=none; b=OtD5htYJ1X0X4wvCemGNQ7EjbXM+fKozvBK5e3b8KiIQ6nYcVuak2p6qNA4ODYJvbJttZ5TtpLVBB/u7z6mORKGQVJYsvPt02a3N45JVLO5mQtoD4h5K0E9/gZ+RqzNopGMQu+aKEXQra+iviZ5MsM9ezK1hmM5jVFi/UKUSM/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711351851; c=relaxed/simple;
	bh=sVHZa3jrZmfABtaZ0lWF5Is6RcXMa1ISTkVnlYOC8SE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cxA9j9ZQ4j4PqnzzZzd3ScROgp0yNApUQerEU7cm5N6xBHy+TnuhQ7u2ZWFnQf8v/7obMxxWatiA8r+Lxdt6/57oKMBqIOQY2PFHS3NT+IYo/R1LWk0JxiBOnL90M5tRwYHy4PVUGI76QPSw9wf94rT6aWHo4U2zleBeCqCdgtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6555D20002;
	Mon, 25 Mar 2024 07:30:37 +0000 (UTC)
Message-ID: <d323eb10-c79b-49cb-94db-9b135e6fd280@ghiti.fr>
Date: Mon, 25 Mar 2024 08:30:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Define TASK_SIZE_MAX for __access_ok()
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>,
 Samuel Holland <samuel.holland@sifive.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 Albert Ou <aou@eecs.berkeley.edu>, Andrew Morton
 <akpm@linux-foundation.org>, Charlie Jenkins <charlie@rivosinc.com>,
 Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Xiao Wang <xiao.w.wang@intel.com>,
 Yangyu Chen <cyy@cyyself.name>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240313180010.295747-1-samuel.holland@sifive.com>
 <CAHVXubjLWZkjSapnsWJzimWg_2swEy7tQ-DQ6ri8yMk8-Qsc-A@mail.gmail.com>
 <88de4a1a-047e-4be9-b5b0-3e53434dc022@sifive.com>
 <b5624bba-9917-421b-8ef0-4515d442f80b@ghiti.fr>
 <f786e02245424e02b38f55ae6b29d14a@AcuMS.aculab.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <f786e02245424e02b38f55ae6b29d14a@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi David,

On 24/03/2024 20:42, David Laight wrote:
> ...
>> The use of alternatives allows to return right away if the buffer is
>> beyond the usable user address space, and it's not just "slightly
>> faster" for some cases (a very large buffer with only a few bytes being
>> beyond the limit or someone could fault-in all the user pages and fail
>> very late...etc). access_ok() is here to guarantee that such situations
>> don't happen, so actually it makes more sense to use an alternative to
>> avoid that.
> Is it really worth doing ANY optimisations for the -EFAULT path?
> They really don't happen.
>
> The only fault path that matters is the one that has to page in
> data from somewhere.


Which is completely avoided with a strict definition of access_ok(). I 
see access_ok() as an already existing optimization of fault paths by 
avoiding them entirely when they are bound to happen.

Thanks,

Alex


>
> Provided there is a gap between the highest valid user address and the
> lowest valid kernel address (may not be true on some 32bit systems)
> and copy_to/from_user() do 'increasing address' copies then the
> access_ok() check they do can almost certainly ignore the length.
>
> This may be true for pretty much all access_ok() tests?
> It would certainly simplify the test.
>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

