Return-Path: <linux-kernel+bounces-137359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E58D89E104
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5414E1C20E67
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AF115697B;
	Tue,  9 Apr 2024 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="oiZC+F1g"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D71A152DEB;
	Tue,  9 Apr 2024 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682143; cv=none; b=YCBmMHqaAJ1dwtGwNUkrM+nCgVlDo84einYYQ0DrCTJWJxurH4rYP34CzLSV8Mc9O8wS2iuHB5x0hR1IemN9snmdAUE1TVvQLWVX+TwDGQvsU003ViCk7A9/Qn8OgrCYgmyrJlz/7ZU7JuS8uT24k3rRYIO9ZkeVeKDFmU+DCcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682143; c=relaxed/simple;
	bh=xMBAFyCImdaKb3r2DLoNbPckcYgZ3zLmo+ZqO4XFWL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QETABvo3E+qmWdkE6XTNw0Lqz9Js42EHz6GAAG5S643J0WzGoCkMD2UPsReHWDf5g9bL/VQV5/s+frZ5JWExvf37XU2yYSp8RoJteuba6QccR3TC2UEH/O7LQ9EPxv7I85bOvxna6dEPLPrTGysz8fTxKdMflV/YsaLkIxdjV8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=oiZC+F1g; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VDXHf0cNKzlgTHp;
	Tue,  9 Apr 2024 16:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712681963; x=1715273964; bh=xMBAFyCImdaKb3r2DLoNbPck
	cYgZ3zLmo+ZqO4XFWL0=; b=oiZC+F1gHyh2MCFa2GPI6qMD96ekIAzYLwKB7mIs
	zWsmrozvDzYF3LAu9N6BybOG8TZLCXsvzrdnLJNXNGERPGHh/x6UReXSiOoFD2th
	FSkOfkpl111rQroI9XFcWhVlz/33vmOpB5J0rPcuHkFecHPkWzaXPuHxN8QrnQsV
	Vm7Z52s1gw09Mlm1RZuanbVPbYTXkD463rft1/w7lET2jwkC0c9xVZ535j8GtU5P
	45dBZ8hHZtuEmPOmIZqQBTpwKYyL054WKTo4HpZ47fimmThaO/l9pH20Y4MQgOu4
	TQooLOxwBwpUL0DZO7AD+rmRcSgKf+ymob/46w6d+gybhw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id kWFEugA1JXck; Tue,  9 Apr 2024 16:59:23 +0000 (UTC)
Received: from [IPV6:2620:0:1000:5e10:2f27:e696:1b04:6e53] (unknown [104.132.0.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VDXHY3WrtzlgTsK;
	Tue,  9 Apr 2024 16:59:21 +0000 (UTC)
Message-ID: <2d5e3b6c-3a66-4f74-8367-51fa55bf0a1a@acm.org>
Date: Tue, 9 Apr 2024 09:59:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug] UBSAN: shift-out-of-bounds in sg_build_indirect
Content-Language: en-US
To: Sam Sun <samsun1006219@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
 jejb@linux.ibm.com, dgilbert@interlog.com, syzkaller@googlegroups.com,
 xrivendell7@gmail.com
References: <CAEkJfYOs-szTK0rYvDw5UNGfzbTG_7RvjqFOZA=c6LXvxdUt2g@mail.gmail.com>
 <CAEkJfYMcdmXAhe9oTpEPGL+_661PNAvM58Y+irwnbLW8FKohNw@mail.gmail.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAEkJfYMcdmXAhe9oTpEPGL+_661PNAvM58Y+irwnbLW8FKohNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/24 05:51, Sam Sun wrote:
> We further analyzed the root cause of this bug. In function
> sg_build_indirect of drivers/scsi/sg.c, variable order of line 1900 is
> calculated out using get_order(num), and num comes from
> scatter_elem_sz. If scatter_elem_sz is equal or below zero, the order
> returned will be 52, so that PAGE_SHIFT + order is 64, which is larger
> than 32 bits int range, causing shift-out-of bound. This bug is tested
> and still remains in the latest upstream linux (6.9-rc3).
> If you have any questions, please contact us.

Thank you for having root-caused this issue and also for having shared
your root-cause analysis. Do you perhaps plan to post a patch that fixes
this issue?

Thanks,

Bart.


