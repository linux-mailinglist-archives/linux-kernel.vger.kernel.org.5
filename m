Return-Path: <linux-kernel+bounces-16902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA578245B1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F57E28633B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1787D249F8;
	Thu,  4 Jan 2024 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="wsSLcZiX";
	dkim=pass (2048-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="QXSJM0nv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCBF249FD;
	Thu,  4 Jan 2024 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nerdbynature.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nerdbynature.de
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=nerdbynature.de; i=@nerdbynature.de; q=dns/txt; s=key1;
 t=1704384237; h=date : from : to : cc : subject : in-reply-to :
 message-id : references : mime-version : content-type : from;
 bh=rrGKHe2f3y4VKmAyR7Fx+uVliEqutjVtxNY3p/bCrkc=;
 b=wsSLcZiXTBMTIwxlPAHtieNO+X2Y3LurxQvZwVgPoLoxD+R9TzU9cWHQa5rTayz2xuPhl
 ZSxsCuom8ZcCjyBDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nerdbynature.de;
 i=@nerdbynature.de; q=dns/txt; s=key0; t=1704384237; h=date : from :
 to : cc : subject : in-reply-to : message-id : references :
 mime-version : content-type : from;
 bh=rrGKHe2f3y4VKmAyR7Fx+uVliEqutjVtxNY3p/bCrkc=;
 b=QXSJM0nve2SOphNRhA6XNdjd67FddJVIqIMg6iTtf7eeIX7eDM/tUqOUzKjATYjsuyB7z
 MGcADKUE6wzlEXkxgrpAWOw4vky5fyMoxiEuhQXQt/qcHZjglp8t+dYPxqlfNXaqH2iKSRi
 zUolMf7ho+nzyYyCOyxruQz7U55Y3Z9nl6GH5JVp2AI7KBP9I6NncNyNpvgco0v78RGUxaW
 BbFACfF8CMQe0lG0R2P6xaq+l2Uh20E1DlbwQgm0Bmk6djWl2G/FTERIL/suF8wmVtAnMXS
 JoiOCkDKCRXpm9FFMXZjeq+1oKRQ7U28WeoBa2LdVeQFk4Z0d9ttsvSwh4zQ==
Received: from localhost (localhost [IPv6:::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by trent.utfs.org (Postfix) with ESMTPS id 3151860639;
	Thu,  4 Jan 2024 17:03:57 +0100 (CET)
Date: Thu, 4 Jan 2024 17:03:57 +0100 (CET)
From: Christian Kujau <lists@nerdbynature.de>
To: Dmitry Safonov <dima@arista.com>
cc: netdev@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>, 
    Francesco Ruggeri <fruggeri@arista.com>, 
    Salam Noureddine <noureddine@arista.com>, David Ahern <dsahern@kernel.org>, 
    linux-kernel@vger.kernel.org
Subject: Re: syslog spam: TCP segment has incorrect auth options set
In-Reply-To: <fe1752a6-9866-45e6-b011-92a242304fce@arista.com>
Message-ID: <491b1b19-f719-1aa6-7757-ba4168228bbd@nerdbynature.de>
References: <f6b59324-1417-566f-a976-ff2402718a8d@nerdbynature.de> <fe1752a6-9866-45e6-b011-92a242304fce@arista.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

On Thu, 4 Jan 2024, Dmitry Safonov wrote:
> Yeah, I guess it's possible to down the severity of these logs, but may
> be unexpected by admins: TCP-MD5 messages existed for long time and
> there may be userspace that expects them (i.e. in arista there are tests
> that look for these specific messages - those would be easy to fix, but
> there may be others outside this company).

Understood, thanks for explaining that.

> While thinking on the origin of your issue, it seems that the logs
> produced by either TCP-MD5 or TCP-AO are desired by a user when they
> add/use the authentication. Could you try this and see if that solves
> the issue for you?

Thanks for preparing that patch so quickly, did not expect that :-)

I've applied this on top of 6.7.0-rc8 and will report back if I see those 
messages again in the next days.

Thank you!
Christian.
-- 
BOFH excuse #127:

Sticky bits on disk.

