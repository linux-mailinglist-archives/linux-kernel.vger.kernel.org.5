Return-Path: <linux-kernel+bounces-167508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 920E08BAA91
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D531F2183C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4374314F9FC;
	Fri,  3 May 2024 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b="kjIaCDxJ"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4579B53372;
	Fri,  3 May 2024 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714731274; cv=none; b=Xxpwwpl2/sVteAE4tnelDdmpAUvkVFKfGOUlW/OPw9DtT+b8LvJ+A1LtWNgM6jnB1qrYbe9Pv7E9JXuvWbVf2P2LfitiksscSrS5TaCJrNyf+Ic4bivmoquyiSBvM8BihVsioTJxVTgTODEsADkpX2QJfkTrzA7HX8eAVrRQx3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714731274; c=relaxed/simple;
	bh=17qSeGyfDCB1GStmoPezQtiO2dhyRdy/CKq8DCneBHA=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Pqzallqgt3qlq08gHBwU/sZUC/XokbG8TXgi4+a+2uUhv8IUXQlymvwFUhOQ5QY76/hmzhRLg2V/oW5I/b1Ff91cPjLGnQjMyMIE5nJPofzncJXBPhEpbht/Vykm6JE9JbcgNhdzipksHbhPgdiAyIbXMGbjCXkdApGt+rlhDWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b=kjIaCDxJ; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1714731273; x=1746267273;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=JcL/qLwhid4bdK8Y23Pw20bwrhQLtuNYndPmUZOI95c=;
  b=kjIaCDxJ3MaJAKNk6oh2befqTBY67qRpZ2S+U1JRLhrCSmRgEetNNglT
   Ycbu26YfzuyXMP1HsEfOItqXg3Vrakywk5Sp8kZq+oqRAP+AQvnqMFFsz
   SMegDwjTxXWoKOKv4WQ7SW2/hAcGuqJBUtC10QjCqcvs+XEJ7EYNKBlyw
   c=;
X-IronPort-AV: E=Sophos;i="6.07,251,1708387200"; 
   d="scan'208";a="86564562"
Subject: Re: [REGRESSION] Re: [PATCH] Revert "vmgenid: emit uevent when VMGENID
 updates"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 10:14:30 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:3868]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.38.151:2525] with esmtp (Farcaster)
 id 6c3b5fc8-b2e8-467f-a00a-a1b21b6041fb; Fri, 3 May 2024 10:14:29 +0000 (UTC)
X-Farcaster-Flow-ID: 6c3b5fc8-b2e8-467f-a00a-a1b21b6041fb
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 3 May 2024 10:14:29 +0000
Received: from [192.168.6.112] (10.1.213.20) by EX19D037EUB003.ant.amazon.com
 (10.252.61.119) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 3 May
 2024 10:14:24 +0000
Message-ID: <9cd37dda-29ea-4a4a-ae43-1cab0449ab0e@amazon.es>
Date: Fri, 3 May 2024 12:14:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: Alexander Graf <graf@amazon.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Theodore Ts'o
	<tytso@mit.edu>, "Cali, Marco" <xmarcalx@amazon.co.uk>, Arnd Bergmann
	<arnd@arndb.de>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "Christian
 Brauner" <brauner@kernel.org>, <linux@leemhuis.info>,
	<regressions@lists.linux.dev>, Lennart Poettering <mzxreary@0pointer.de>
References: <20240418114814.24601-1-Jason@zx2c4.com>
 <e09ce9fd-14cb-47aa-a22d-d295e466fbb4@amazon.com>
 <CAHmME9qKFraYWmzD9zKCd4oaMg6FyQGP5pL9bzZP4QuqV1O_Qw@mail.gmail.com>
 <ZieoRxn-On0gD-H2@gardel-login>
 <b819717c-74ea-4556-8577-ccd90e9199e9@amazon.com>
 <Ziujox51oPzZmwzA@zx2c4.com> <Zi9ilaX3254KL3Pp@gardel-login>
Content-Language: en-US
From: Babis Chalios <bchalios@amazon.es>
In-Reply-To: <Zi9ilaX3254KL3Pp@gardel-login>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)

Hi Jason,

Friendly ping?

IMHO Lennart, Alex and myself have raised (what I think to be) valid 
technical points regarding your concerns about your belief that the 
uevent mechanism is an ad-hoc mechanism that you don't consider viable.

Just to summarize:

* Upon VM clone, user space needs to adjust various components (DHCP 
leases, MAC addresses, etc.) that have nothing to do with PRNGs.
* The path of exposing the VM clone event via vgetrandom() (or any other 
interface of random.c) is simply wrong. The random subsystem is the 
natural component to inform about when cached entropy is stale. It 
should not be responsible for informing user space about VM clone 
events. IOW, "reseed your PRNGs" is not equivalent to "your VM has been 
cloned".

Given all this, it would help the discussion if you explained why you 
believe random.c should propagate VM clone events and how.

If you don't believe that, could you explain what is the problem with 
the proposed uevent mechanism? Personally, I agree with Lennart that 
VMGenID is a generic ACPI device built for exactly this purpose. VMGenID 
is not an "ad-hoc driver". It is a standard which is supported by most 
(all?) major VMMs out there today and its whole purpose is to deliver 
inside the VM a notification that it was cloned.

Cheers,
Babis



