Return-Path: <linux-kernel+bounces-123410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A39789082C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19B2290F4D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB54B135A7E;
	Thu, 28 Mar 2024 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ARG4bkyD"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8935A783
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711650202; cv=none; b=UpfpIxobUcXNU5giMk4LOx/Qt7fRrkK1HX9m8rJ3LAGvXh0/p1a3B8JnZMOyMNW5WK6ZjC9pWo8sR+qBM3gXyoIqNSkSTIGYXvXnzj+iRuFZ5slstQ/OU6qogFU6AwHL4Lzwrh9Ngj2LAv++KhuqnRXyZ0UzymFuhMnxXYhoWYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711650202; c=relaxed/simple;
	bh=rhMs+IW+LjgjgJG2bjuDC2kRA/YBDohWPyTnq4wTmlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=UwmBR/LZwhnbB+O8nOhoJ9HxOjevzlv37rf7N6I3qWFIVwCxbii2nBYRu2u/tXXGby2OdhQ7Hgl/Vxj2ElrxTGeW0MxlTLr5lAVecMIwR+CQ8Kv/FmBgaAKwg1xCnDgXUB/I/uOaCgKE9zdZ9zuCaFJoDZVV0JA0dyoOU3bPUJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ARG4bkyD; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <16b32b53-5a01-43e8-93db-64778378fa09@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711650197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvccjBgvV8FPnWLETfwa5X6p1gUwr/hfB1axJ8LOH4E=;
	b=ARG4bkyDA/Vzrk5HPV4L8uXDHlS+KGa6BXgc+OWOCZOzz7yMadsTRX1+yWr1QLiRWQXK4Y
	5FJJjHUw4vhZdXTsHFY817EuoGtAsGuiYKpCMm0rH7CZiEEOUgYbNTM2iUAL002W3KPZEb
	LZaNF09ZJ9DXkVnlxWO0mx+/2tPYIlA=
Date: Thu, 28 Mar 2024 11:23:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] [net?] KMSAN: uninit-value in dev_map_lookup_elem
Content-Language: en-US
To: ast@kernel.org, yonghong.song@linux.dev
References: <000000000000c8d6b00614b599a2@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Cc: daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, sdf@google.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com, andrii@kernel.org,
 alexei.starovoitov@gmail.com, bpf@vger.kernel.org,
 syzbot <syzbot+1a3cf6f08d68868f9db3@syzkaller.appspotmail.com>
In-Reply-To: <000000000000c8d6b00614b599a2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/28/24 3:01 AM, syzbot wrote:
> Killed
> make[2]: *** [scripts/Makefile.vmlinux_o:62: vmlinux.o] Error 137
> make[2]: *** Deleting file 'vmlinux.o'
> make[1]: *** [/syzkaller/jobs/linux/kernel/Makefile:1141: vmlinux_o] Error 2
> make: *** [Makefile:240: __sub-make] Error 2

My second syzbot test attempt passed the build stage and passed the reproducer 
also. https://lore.kernel.org/all/000000000000b7bdd80614bc433f@google.com/

Not sure what caused the syzbot build error in the first attempt but should be 
unrelated to the fix. I will post the patch.


