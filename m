Return-Path: <linux-kernel+bounces-160077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB0F8B38C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9D21C2279A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118EB1482E2;
	Fri, 26 Apr 2024 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b="RJo3fPxA"
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8A31F956;
	Fri, 26 Apr 2024 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139048; cv=none; b=YePP86PWhHa/fRiFyH2R0KKFIULr3tc3al3A3luiHWhg4kKHi2GEfvwCKgrtawmXKkNl9wTSFGck3h4lYyyx1C/RPtKVf1Mmi0i4+kNBZJUcr2mSdqVfUkHjVj4IFXuLJZhXqs5ZfZB9DTM2bWEj8BCkohCz7AXMXwH/x4qo8zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139048; c=relaxed/simple;
	bh=UZi8TXx9a8fjUIlUFGYdMkWm4qzSrLxmXgditYXOGGQ=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A9v4OOYb4tLQySPIBATOk3FdQ13NrcolksjmS2QhFNVmLZ9vrEsG0SPt/GPe0ZHZwt8fyZvUkdkh53o1sQbFANexck8DwXSG/PTJofMJTs79u8e263p4eFFowDTiwA4aM1Np1siqetoGfgeAT+uamAZLF2CgWbQJxUVEK8bZKmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b=RJo3fPxA; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1714139047; x=1745675047;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=fIo6JiWpcfuJdP9GV9sCAn384Sgayh04jC6d/BFYW58=;
  b=RJo3fPxAuoSpOUotwAlANuQ9Jil20slZr1KwbtRTMlP/Go4bFPL48k0u
   66qVAtC4B293edjuD88CsPsz3hwJko983QAWWu14FiQypyliyFf6dK5Gj
   o6W2CLyk0OWHYrLoOY1OWAo/5OX2VzqYBZnWXGlLI3/S9tx7TEmnmaAHD
   0=;
X-IronPort-AV: E=Sophos;i="6.07,232,1708387200"; 
   d="scan'208";a="290971147"
Subject: Re: [REGRESSION] Re: [PATCH] Revert "vmgenid: emit uevent when VMGENID
 updates"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 13:44:04 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:48160]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.21.244:2525] with esmtp (Farcaster)
 id 3e3dc579-38c9-447a-8e7d-ab1368f1c799; Fri, 26 Apr 2024 13:44:02 +0000 (UTC)
X-Farcaster-Flow-ID: 3e3dc579-38c9-447a-8e7d-ab1368f1c799
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 26 Apr 2024 13:44:01 +0000
Received: from [192.168.28.148] (10.1.213.14) by EX19D037EUB003.ant.amazon.com
 (10.252.61.119) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 26 Apr
 2024 13:43:56 +0000
Message-ID: <1f09319c-56e6-44d7-9175-c6307089447b@amazon.es>
Date: Fri, 26 Apr 2024 15:43:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Alexander Graf <graf@amazon.com>
CC: Lennart Poettering <mzxreary@0pointer.de>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Theodore Ts'o
	<tytso@mit.edu>, "Cali, Marco" <xmarcalx@amazon.co.uk>, Arnd Bergmann
	<arnd@arndb.de>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "Christian
 Brauner" <brauner@kernel.org>, <linux@leemhuis.info>,
	<regressions@lists.linux.dev>
References: <20240418114814.24601-1-Jason@zx2c4.com>
 <e09ce9fd-14cb-47aa-a22d-d295e466fbb4@amazon.com>
 <CAHmME9qKFraYWmzD9zKCd4oaMg6FyQGP5pL9bzZP4QuqV1O_Qw@mail.gmail.com>
 <ZieoRxn-On0gD-H2@gardel-login>
 <b819717c-74ea-4556-8577-ccd90e9199e9@amazon.com>
 <Ziujox51oPzZmwzA@zx2c4.com>
Content-Language: en-US
From: Babis Chalios <bchalios@amazon.es>
In-Reply-To: <Ziujox51oPzZmwzA@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)

Hi Jason,

On 4/26/24 14:52, Jason A. Donenfeld wrote:
> I don't think adding UAPI to an individual device driver like this is a
> good approach especially considering that the virtio changes we
> discussed some time ago will likely augment this and create another
> means of a similar notification. And given that this intersects with
> other userspace-oriented work I hope to get back to pretty soon, I think
> introducing some adhoc mechanism like this adds clutter and isn't the
> ideal way forward.
>

Correct me if I'm wrong, but the virtio changes were meant to mean "please
reseed your PRNGs". That's why we wanted to route them via random.c. We
designed them specifically so that virtio-rng would be only one of the 
potential
systems that would emit such notifications, whereas other systems might have
nothing to do with VM events.

With that in mind, could you describe how these events would be useful 
to the
use case of Lennart? systemd does not need a notification every time the 
system
believes PRNGs need to be reseeded. It explicitly needs a notification 
when a VM
was cloned. This has nothing to do with PRNGs and I don't believe random.c,
virtio-rng, or vgetrand() should be responsible for delivering this.

Cheers,
Babis

