Return-Path: <linux-kernel+bounces-138152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8269B89ED5E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5B1DB2248A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7043A13D53B;
	Wed, 10 Apr 2024 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/nIuao5"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C00913D28C;
	Wed, 10 Apr 2024 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712736911; cv=none; b=P5keQDu4SX0R8O9acN10Ckgr955vjywYnFqvhgI5Q02Cx6tk/9r1cVRyZUhGnoNdFge8FatG8S/zg2ZkCFY3b6yxq8IAO2SygXBzn3YL6JngsRX/Ttro4/qTbkGx4IwjR2lcLL1sAtMpPGe6y5QRI253rjYk65acW825XU2pMMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712736911; c=relaxed/simple;
	bh=IgGwkIZ14ZOt67SYc3g0ja0ugvfqriafVrla9nxuiIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7c4F5Db01Onk0YojRQro/7wgFSvntxw6GjyIv2pzL1G50aT2TAMt80bOI+hEQUkUY7JF86MYS67b6ZrlG2XUHPl8stWaouGyuY676TOrllc5n1HbEogWKCieQdU79QgSl7uaWaJiWMzDmRa8j/htdH49VC63uJrrp5H3RQS9VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/nIuao5; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56fd7df9ea9so283878a12.0;
        Wed, 10 Apr 2024 01:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712736908; x=1713341708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXgE1tAZqXIMWQ7bLL01cW+V+9zyP81gyKIWZURm7Ug=;
        b=h/nIuao5EGK3q9F6nVUqjzeEzDmeuNwo2iVa0M2oXGI6NoZQxZs/rGfjnKNclEbetW
         1/gRB+DrMo/AZQQX7KvjAHdhYqqEKariAwwzTtAzNdhajcsSZYF8Te/KWjhj0F/Vuk6U
         cW/o0lQM42TZMUaaPvvfO65uwqES/XpyvV5uG+MXvfTHxRONL1kGoLCZwRCZUA0acuQv
         64Rmf34nz7kdoQqwO+QGmuCaAXf1ZadBjuY9VJ+srveIsyCY1JXoyzJ5xyLdZVjPp2I3
         zaj2oBZ6C1vV/MhbUhovv3dv1QUAf+JMZLzWBLxwzh7PKi6cniVr2YT3yQYHvfAIjgTb
         rGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712736908; x=1713341708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXgE1tAZqXIMWQ7bLL01cW+V+9zyP81gyKIWZURm7Ug=;
        b=Kd1Xox/O1z0Ur5jXOhLLc1tUBkRstlcz/5nXEpyyQIvCYsNUk4cw4tsKwqe9yC9fey
         qHsLHZzpJ5PQ2917vfBMrqoAsKlWkZOD8uSPFit+zwNefla/9BohYCAJS+Bctqt/VRgI
         IvrLPXufr/RWIKa/lBAbWbT92DgIfTCTuOjHnolGU44ZJjPIyJlftt39C3ICoMZaxR18
         JZeU9IY1sdaSGSIbfcUoCd8o36nVYPmIsKwsfoquIA3zR9vZMMnUb8QqB2SLUFZruDZV
         9J5X+2YQse20eI0fu3OSEe3p01uCoTKtfc2px1HUBDKBepXTeN8JRvFovxeN1EMF1Fpu
         bpWQ==
X-Gm-Message-State: AOJu0YwMfiiAHDBADtvLmalGXNhIkqp7XLgWTVqAWG6/KflewBQjKBIY
	UZ/jFJ40vn/pA7tze4M3R1f+ERQ6L8Sn4GcPHy4yhW8X71Uo3GVACDIG5DervySVFQ==
X-Google-Smtp-Source: AGHT+IFJ7Gp28D7H1fXAo88jDr8NWuLypyuLUL8JzFsO+iwf3jnA2ip/xwU8IsWfhmHP9tITI4YHKg==
X-Received: by 2002:a17:906:6812:b0:a4d:fc83:70e1 with SMTP id k18-20020a170906681200b00a4dfc8370e1mr834412ejr.56.1712736907847;
        Wed, 10 Apr 2024 01:15:07 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id a23-20020a1709062b1700b00a51dd26f6dcsm3029799ejg.51.2024.04.10.01.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 01:15:06 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 10 Apr 2024 10:15:04 +0200
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sean Anderson <sean.anderson@seco.com>, x86@kernel.org
Subject: Re: [tip: timers/urgent] timekeeping: Use READ/WRITE_ONCE() for
 tick_do_timer_cpu
Message-ID: <ZhZKiKyXsgSeABvD@gmail.com>
References: <87cyqy7rt3.ffs@tglx>
 <171269748856.10875.3911619468870441338.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171269748856.10875.3911619468870441338.tip-bot2@tip-bot2>


* tip-bot2 for Thomas Gleixner <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the timers/urgent branch of tip:
> 
> Commit-ID:     0200ddd723d6056d0b1c1ebde4b11e75a0f2ed7e
> Gitweb:        https://git.kernel.org/tip/0200ddd723d6056d0b1c1ebde4b11e75a0f2ed7e
> Author:        Thomas Gleixner <tglx@linutronix.de>
> AuthorDate:    Tue, 09 Apr 2024 12:29:12 +02:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Tue, 09 Apr 2024 23:09:44 +02:00
> 
> timekeeping: Use READ/WRITE_ONCE() for tick_do_timer_cpu

> @@ -232,7 +233,7 @@ static void tick_setup_device(struct tick_device *td,
>  						!tick_nohz_full_cpu(cpu)) {
>  			tick_take_do_timer_from_boot();
>  			tick_do_timer_boot_cpu = -1;
> -			WARN_ON(tick_do_timer_cpu != cpu);
> +			WARN_ON(READ_ON_ONCE(tick_do_timer_cpu) != cpu);

So there's no such thing as READ_ON_ONCE() - I've amended the commit with 
the fix below.

Thanks,

	Ingo


 kernel/time/tick-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index a285f4deb96d..d88b13076b79 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -233,7 +233,7 @@ static void tick_setup_device(struct tick_device *td,
 						!tick_nohz_full_cpu(cpu)) {
 			tick_take_do_timer_from_boot();
 			tick_do_timer_boot_cpu = -1;
-			WARN_ON(READ_ON_ONCE(tick_do_timer_cpu) != cpu);
+			WARN_ON(READ_ONCE(tick_do_timer_cpu) != cpu);
 #endif
 		}
 

