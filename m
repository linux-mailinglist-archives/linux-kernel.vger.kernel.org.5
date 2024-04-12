Return-Path: <linux-kernel+bounces-143417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E80F8A38A5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2867F2857D2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E479B14EC78;
	Fri, 12 Apr 2024 22:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="AHMttIcm"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A67225D7;
	Fri, 12 Apr 2024 22:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712962173; cv=none; b=ZU6627XWmPu5P8IDw6/lvXKOJq1FlOQGnFVa5UyRCrS78RaVYJd26FtiDOADHtLCI44iNfLpvRwqQWjx9qFap45FfS/aJoku9AcTPUgVNWQaYARxrLJX47kbII0nW5oB0ipUrdnMGQ4LG/0Awse5yQMOlDXE2vjWZtZbGPTuics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712962173; c=relaxed/simple;
	bh=/jT/AmCpsrHeiPRDhEexKpZTtbNP+mUYlC8O4cRo/vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rv3zYxjF7Rad4QLYfnefGy4F293RzMVxfDiDIlVXWZ71KEb1Xazoqsf/RxYCi7cdkHY9b4/V080eboNcidN6nTYb3IUwBwpKpHrYK7oL3IPHk+07gGdTwQ6AIyd2dauR5EJnKj+pHp052Hbjm51qpUDTyXnQYZURCC3kukgsxNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=AHMttIcm; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VGWwB4QbQz6Cnk8t;
	Fri, 12 Apr 2024 22:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712962166; x=1715554167; bh=czbZbnWbOnnHwe4/SxmmZnUf
	rVFJbZlvz64gCqIYWi4=; b=AHMttIcmjmw0T39PNhphPSj+4P1PjotE5mhXPaYm
	AUtDNwHzyNOSpyerjkghvZrXc4Ul3vedUQq+G8hZ/HgS66uguilOhJAquPG8RFTj
	3fS5c9dP6ahi8fI6JPyV4FF/2jeOOya3HlwAHk+/U1XQtt5jo0lsPtiQIU4YbC9T
	QdXKajd2mWFwgkc0rZ0E3BJzwvOXaODWDNpMGKaV7Dmf22+rCyZQvpVfGzMAFPWc
	pC9vSm/5sMqMXmd28KoJ0TXsX9RrPSrTsFfyc5EZmEfIogJc1W240XIwsUjwciPH
	cQJhoGlHjGbMs13kS8wOPmG1r2TmO6tvvOebGHbpyVkpZA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id iI0JBVcoaPHh; Fri, 12 Apr 2024 22:49:26 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VGWw540GXz6Cnk8m;
	Fri, 12 Apr 2024 22:49:25 +0000 (UTC)
Message-ID: <2ab31b48-5f89-4ada-848d-89b844f6a6f5@acm.org>
Date: Fri, 12 Apr 2024 15:49:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug] UBSAN: shift-out-of-bounds in sg_build_indirect
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 martin.petersen@oracle.com, jejb@linux.ibm.com, dgilbert@interlog.com,
 syzkaller@googlegroups.com, xrivendell7@gmail.com
References: <CAEkJfYOs-szTK0rYvDw5UNGfzbTG_7RvjqFOZA=c6LXvxdUt2g@mail.gmail.com>
 <CAEkJfYMcdmXAhe9oTpEPGL+_661PNAvM58Y+irwnbLW8FKohNw@mail.gmail.com>
 <2d5e3b6c-3a66-4f74-8367-51fa55bf0a1a@acm.org>
 <CAEkJfYMcLycLfaRzhn=DmQjAuLHn29wSXN0b0Zf0oJr=sDVBTg@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAEkJfYMcLycLfaRzhn=DmQjAuLHn29wSXN0b0Zf0oJr=sDVBTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 4/10/24 6:17 PM, Sam Sun wrote:
> On Wed, Apr 10, 2024 at 12:59=E2=80=AFAM Bart Van Assche <bvanassche@ac=
m.org> wrote:
>>
>> On 4/9/24 05:51, Sam Sun wrote:
>>> We further analyzed the root cause of this bug. In function
>>> sg_build_indirect of drivers/scsi/sg.c, variable order of line 1900 i=
s
>>> calculated out using get_order(num), and num comes from
>>> scatter_elem_sz. If scatter_elem_sz is equal or below zero, the order
>>> returned will be 52, so that PAGE_SHIFT + order is 64, which is large=
r
>>> than 32 bits int range, causing shift-out-of bound. This bug is teste=
d
>>> and still remains in the latest upstream linux (6.9-rc3).
>>> If you have any questions, please contact us.
>>
>> Thank you for having root-caused this issue and also for having shared
>> your root-cause analysis. Do you perhaps plan to post a patch that fix=
es
>> this issue?
>=20
> Sure, I am glad to help! But it is my first time submitting a patch, I
> need to find some instructions. I would appreciate if you could help
> me out. Also, I need to double check the patch to avoid introducing a
> new one. It might take some time.

The process for contributing a patch is as follows:
1. Clone the Linux kernel tree for the subsystem you want to contribute
    to. For SCSI, this is the for-next branch in
    git://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git
2. Make your changes to the code.
3. Commit your changes (git commit -as), chose a patch title and explain
    what has been changed and also why.
4. Convert your changes into a patch, e.g. by running this command:
      git format-patch -1
5. Check the patch with scripts/checkpatch.pl.
6. Send your patch with git send-email to Martin Petersen and Cc the
    linux-scsi mailing list.

More information is available here:
https://docs.kernel.org/process/submitting-patches.html

Best regards,

Bart.

