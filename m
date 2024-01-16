Return-Path: <linux-kernel+bounces-27761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F1A82F578
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0DC2851E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198B71D53F;
	Tue, 16 Jan 2024 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="TKHCKZLZ"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342B21BF39
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705433807; cv=none; b=VjBYzW1kNvVRRRn5LvgcuiHR9+yxAwjQPzkdlO5wKPe7oyZ00dZPLK5dEkhFEvDkuv75Zp/FHLcSmfxqz8QrmU8DC4mJMPyA8Pq33HDOnwSU/oy1id1F5qNPC+sBeky4PGOPcVuM+R+6YC41NT/joaT4la9sTjBVA07/H6Q0ViI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705433807; c=relaxed/simple;
	bh=YH9I4mIwagxCplANYVB6qh/qLIS7W5riVXR8JjeVHCk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent; b=YnaW9d2gtJQl9uAkUEnPaIBkh5Qvgh7NGuVwDSB+SP5rrXY1Ccx30nAVVvrGkcEKOPJIhbJ8X7vT853lD2G/YQqhv78xZmn+xPjFplMT6zvgEbXiNDCXjwWeLt8Ja/fKOMyolsJBFbjBf9d8s0qMH1YTySMZnPSW6iwOnKKyAQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=TKHCKZLZ; arc=none smtp.client-ip=209.85.208.171
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cd1232a2c7so127190971fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 11:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1705433803; x=1706038603; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNYuziFWfl9MkUwCZOX6uEvosc04pHrqJNu/2pkS60A=;
        b=TKHCKZLZ2dE1VlQKL5KFR8xMYBddWn0fe5S2R5qtyA4yTfnMbauww2Q/puqo0e8V1I
         tJvWedNmAORceFInJQc6TYgvDj38fZNELjUrR6aEO7rcRe2JprNzdlN/LID9mhGkgj76
         pmAhm57mA4KqRzQ47BmUrXDtueCCE6LrQ/PIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705433803; x=1706038603;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNYuziFWfl9MkUwCZOX6uEvosc04pHrqJNu/2pkS60A=;
        b=qKUmPBbN3BbBg8UAPlk7PP6WqhPQ8Sef4y+LHhQOF54m0Z25yk+4YN+ASTcCEvQEEX
         dAImORUufch/D5DrhegPKe8FDsYEsW5r7aq/L9r4GU+TslYKAiURh8o4AjMu3Anq6p5F
         tZ4EqIrgssbZXRS3u5w/nP9NA5ofXF9/XpYyH/5erduHiWsslDZnIiXTagZCf+AmtrTh
         DLnWCmjoj9TBez83AoT8+3kGgaEZaqvKrgXtmFQp4bva1Pmf22lL+sweClZb7wmFnH/C
         nT/bLb4j8jaCrl6c2kikyP7zKZq9bx6oXRqF8hW2lwv06YbNA6PUj7AOcn9388LokoKJ
         NDWQ==
X-Gm-Message-State: AOJu0YwiC3rBhkRfLsSF24etsThaaKMqR70Qa2w/NO26aWyJcN4BFxh+
	XV/XD+FmoLPOApmSqAvHjak7KPNOT5yY1A==
X-Google-Smtp-Source: AGHT+IHHLv/HrDg3LpX9uLuJF5R6ejpXBS/hbsvxosqgj82njzmmB2g882OgUEjLdzAghkenrSucMw==
X-Received: by 2002:a2e:9b97:0:b0:2cc:9435:a5f8 with SMTP id z23-20020a2e9b97000000b002cc9435a5f8mr3606713lji.6.1705433803162;
        Tue, 16 Jan 2024 11:36:43 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8600:5ee4:2aff:fe50:f48d])
        by smtp.gmail.com with ESMTPSA id e11-20020a2e930b000000b002cd9e966ed1sm1400877ljh.127.2024.01.16.11.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 11:36:42 -0800 (PST)
Date: Tue, 16 Jan 2024 19:36:41 +0000
From: Chris Down <chris@chrisdown.name>
To: Petr Mladek <pmladek@suse.com>
Cc: "James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] scsi: core: Safe warning about bad dev info string
Message-ID: <ZabayZCoAHjiMb0d@chrisdown.name>
References: <20240111162419.12406-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240111162419.12406-1-pmladek@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

Petr Mladek writes:
>Both "model" and "strflags" are passed to "%s" even when one or both
>are NULL.
>
>It is safe because vsprintf() would detect the NULL pointer and print
>"(null)". But it is a kernel-specific feature and compiler warns
>about it:
>
><warning>
>   In file included from include/linux/kernel.h:19,
>                    from arch/x86/include/asm/percpu.h:27,
>                    from arch/x86/include/asm/current.h:6,
>                    from include/linux/sched.h:12,
>                    from include/linux/blkdev.h:5,
>                    from drivers/scsi/scsi_devinfo.c:3:
>   drivers/scsi/scsi_devinfo.c: In function 'scsi_dev_info_list_add_str':
>>> include/linux/printk.h:434:44: warning: '%s' directive argument is null [-Wformat-overflow=]
>     434 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
>         |                                            ^
>   include/linux/printk.h:430:3: note: in definition of macro 'printk_index_wrap'
>     430 |   _p_func(_fmt, ##__VA_ARGS__);    \
>         |   ^~~~~~~
>   drivers/scsi/scsi_devinfo.c:551:4: note: in expansion of macro 'printk'
>     551 |    printk(KERN_ERR "%s: bad dev info string '%s' '%s'"
>         |    ^~~~~~
>   drivers/scsi/scsi_devinfo.c:552:14: note: format string is defined here
>     552 |           " '%s'\n", __func__, vendor, model,
>         |              ^~
></warning>
>
>Do not rely on the kernel specific behavior and print the message a safe way.

Acked-by: Chris Down <chris@chrisdown.name>

While I agree with the other thread that in reality this is ok, it's worth 
reducing the addition to LKP noise for now and worrying about that later.

Thanks!

>
>Reported-by: kernel test robot <lkp@intel.com>
>Closes: https://lore.kernel.org/oe-kbuild-all/202401112002.AOjwMNM0-lkp@intel.com/
>Signed-off-by: Petr Mladek <pmladek@suse.com>
>---
>Note: The patch is only compile tested.
>
> drivers/scsi/scsi_devinfo.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
>index 3fcaf10a9dfe..ba7237e83863 100644
>--- a/drivers/scsi/scsi_devinfo.c
>+++ b/drivers/scsi/scsi_devinfo.c
>@@ -551,9 +551,9 @@ static int scsi_dev_info_list_add_str(char *dev_list)
> 		if (model)
> 			strflags = strsep(&next, next_check);
> 		if (!model || !strflags) {
>-			printk(KERN_ERR "%s: bad dev info string '%s' '%s'"
>-			       " '%s'\n", __func__, vendor, model,
>-			       strflags);
>+			pr_err("%s: bad dev info string '%s' '%s' '%s'\n",
>+			       __func__, vendor, model ? model : "",
>+			       strflags ? strflags : "");
> 			res = -EINVAL;
> 		} else
> 			res = scsi_dev_info_list_add(0 /* compatible */, vendor,
>-- 
>2.43.0
>

