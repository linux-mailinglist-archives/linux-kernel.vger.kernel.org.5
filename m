Return-Path: <linux-kernel+bounces-68054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADA2857567
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0CA1F230CC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68012111A5;
	Fri, 16 Feb 2024 04:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1FWQ8Yu"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB172F5A;
	Fri, 16 Feb 2024 04:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708058811; cv=none; b=WIAxaCQ5WvkPoNVpPZQJNSTBkdG9mVQVobqc/PVgynIYZ4XoA2I5cDP6YmGbVCyzjeisPrx4EnEZc0IahLyddfRa1MtueF0blG0nPFRr9CjzWtAx0f9TEDbSTO/G46awz2baV7nuNp4d1iSpf9uc4zkJnZptQXHRff7+J7X7W7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708058811; c=relaxed/simple;
	bh=jGWZcfoolQtJ4Y0ME/ZVjyNKfUiHj28zxeQ3cOw1K1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INDwGOYjQFaVWZDb0DBzlLqdUqRbkEP993jbBzHTv49iZO0+1x0UkF7urqjtrycsh5ZaMGue8e16Iqp3bGObqWPFSJCHDQnL1AjhmGPQqBKPDQdNtmWqR9weaVkbYwB/HCoUVlUjUS4VvbgINnTZnxUQo7km8IPWFh71YZC+1n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1FWQ8Yu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d731314e67so12829755ad.1;
        Thu, 15 Feb 2024 20:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708058809; x=1708663609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86rkIjG0PMkUt0ErBuuXEkQG7zaakNP7oJknORJyvG4=;
        b=L1FWQ8YuFfEX/qFetNES2nJuzw0D5R0RP+KQdc24DaaFGKETZdsZwGtlRstiqZgTJV
         w0Q+gje2xm75Ru1QDcdi04uaqdDtkGNo3M5dDzbVbsxo3g/VdHLKEoxOOfiNQp6zkPgF
         VkJKCAhDOOBTChd/fOGdIcs42fVqh4vJAn9Jpb/F0MO7A1v5jirOgO1EIkMRlb7/zhFB
         5FAdutN6KUYJP7walbN0gizEJ18jwNkVsS9xMLGqUE+INtKVm0CAojb06q/CApaJOuFP
         pHfIqTt9G7O6+24fv49sJN0LtVz/mLZ3msIV+GTnbVJleW9Y2Ha9lEJGcaV8eMLd5nec
         RVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708058809; x=1708663609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86rkIjG0PMkUt0ErBuuXEkQG7zaakNP7oJknORJyvG4=;
        b=LZ8np46s/DgWSNJTQomGlLl5846QbXHfGxkeiWM84G1sPtOHXL3OghFose4kUe4xy7
         9+4Fg/sX8F+SNkUXW2M1Cb0+ilG8Ynx5jmd3Y+Ot9GHepp1W4kE8uVu9nBwIMkq7kSOh
         X5N2b3MsHyDU0OXqZ6OBqIHn9GLZAnbmz+bhkIyVjYINe3LeCHOLpOaMSOMr/wSzzrbw
         o43qpTnhQiU25pMFiBNogNLkRRxD0VjdZG+L9+bO/KsVjL4pJqJxOUkgZ093Uf3mqyqK
         2B8nD4VfkbW2QrxkiDBT/TUgYfcY7haAJREKVB3LfXfJ//dqdut5UBQQomcqNr/9jQxQ
         5BnA==
X-Forwarded-Encrypted: i=1; AJvYcCUAdpODY5y2Z/plkSy9IWPBnUMZIt1ti3aSkRLBl39VLldQFUbTtx1U4jI0KxDCJkP0QJijWNTQHQD7ozuvgJ2OAgnWPkCjBxz72Q==
X-Gm-Message-State: AOJu0YzUZhrLHI7QJ06zC6vvcoqU32AoqAtnme8/EsmgBT4F0X7487Kn
	vMLbeT/vB93b+n1aVuNe+NTDSHtE0+2xyOo4/w725F8FK7FsuT9Q
X-Google-Smtp-Source: AGHT+IFa2TOBD36/by28pREaHr4D9Rp8Rku7TAbpjlscgkfcZgRSNzCykUfMjU/XvXAxLdVnX4f7CA==
X-Received: by 2002:a17:902:ee8c:b0:1da:1cdf:1cca with SMTP id a12-20020a170902ee8c00b001da1cdf1ccamr3457670pld.51.1708058809343;
        Thu, 15 Feb 2024 20:46:49 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902b60b00b001d8f0e4bc32sm2051238pls.144.2024.02.15.20.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 20:46:49 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 15 Feb 2024 18:46:47 -1000
From: Tejun Heo <tj@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the workqueues tree
Message-ID: <Zc7ot8BUke2Hwl3V@slm.duckdns.org>
References: <20240216140014.4842449a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216140014.4842449a@canb.auug.org.au>

Hello,

On Fri, Feb 16, 2024 at 02:00:14PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the workqueues tree, today's linux-next build (x86_64
> allnoconfig) produced this warning:
> 
> WARNING: unmet direct dependencies detected for IRQ_WORK
>   Depends on [n]: SMP [=n]
>   Selected by [y]:
>   - PRINTK [=y]
>   - PERF_EVENTS [=y] && HAVE_PERF_EVENTS [=y]
> 
> Other allnoconfig builds produced similar warnings.
> 
> Introduced by commit
> 
>   9d6efa8d0dd0 ("workqueue, irq_work: Build fix for !CONFIG_IRQ_WORK")

Ah, sorry. I made it worse. I should have selected IRQ_WORK from SMP not
depend on it. Will update. Thank you.

-- 
tejun

