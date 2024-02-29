Return-Path: <linux-kernel+bounces-85924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C56FF86BCDD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621A51F24D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F3C168AB;
	Thu, 29 Feb 2024 00:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeuCFgpw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B38F23A2
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167091; cv=none; b=NCvKRnMi20egUzlJ/8DBY96uUD6ZGqQEDpy5PE+OI1aRd+6nFiIcyqDOxR3Zw3zAwgo/IuMNSPjJ856BxQ0zbvhWwKLLMs+D3V50mT6VCc5arbXJwdqCyQXy9srYfxPZUVpUsog0MvfbjN7LB33pXxi3IjXnsy5BsaDf6/uAHm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167091; c=relaxed/simple;
	bh=zdmDmZBOd3SFC0jwS2ekHtoLe9Wo02yDanRCzI2UXqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mf0XlNiVQEW+vIMG3PpIiIarGot60Oojo6Ve5dw09LYlpWHPHprLzBuyCFQruaSoUVEZp9uUU65Yp3+P0iLl160XgS/jg44egEQTtwHY5u+hztvUSHaR9Pur8YnsLz7zpSEiX9Q8hICX4W5O1PSoy9t0UfOX8YY3ZuS2G1jkM3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XeuCFgpw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709167088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YfpEyRdMnEBOuDbLwr2jbhFRxgF9v/FYFNIfm+Be1aI=;
	b=XeuCFgpwa9I9oXVYWNbBgIgfyjQ0YMdJ65GGR6cH+PPZcrrE82taBRBRRT1bVw7VVNWeVy
	XUbrNKEqGfRARbdRM9OPdOGLNBTU2b94wq+RPo9MEhV/M9Mlz4GeKGvH8c5f42/9VITnP+
	B41bPDruhXr9mQEmQJTN3llshhl/B+U=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-xHnLUIoGPbOH7XAppqmKFg-1; Wed, 28 Feb 2024 19:38:06 -0500
X-MC-Unique: xHnLUIoGPbOH7XAppqmKFg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29a90e49c67so170287a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:38:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709167085; x=1709771885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfpEyRdMnEBOuDbLwr2jbhFRxgF9v/FYFNIfm+Be1aI=;
        b=TEY67P/Ctwb4DddF7HvsDx9QUFoYt/OVTdLfoGw2IqoWDuBeUjpjCfeq8D05ZZ+HRu
         lXO/b3TdfpSIrGF2499uUoGis2keJj5J+bI7gYEvZZuv8WxapGRyzJm/sz23+nMJcRn0
         WN7mGxUel5Ph2/ViJjdlJlOSPKQCvJDBVC7s2Denv50N7CyGDJYLRjkjivfUtwp5dQBz
         aQ/NRImTVNtfGN20PI5rU8tgnWW0MaDW562vCtebQg4+Oxun5ZWUGV3K+UdNh81wGxBH
         xtkM/uG7fYwXOPQoRSrCSFeu1K53feMWSQ+M8A4FXkjs40YRqVFYh2duGymkBDYy8wDo
         GjFw==
X-Gm-Message-State: AOJu0YwcJl2tK/P+Lwe6LSBZTIozeTskvighc92Mqw8p4Ds2XMRf9Qog
	VZsvYiIO3ixZBKctLrzC4wFAWgFQt8GfG2+3bNFDNkO4G85bE59DUpPKq3LEMUK0fQGTg5MgzD0
	P5JCF/UWOHV0HsHg8GxgMQwLU6fAtnoNjYUOKFIEgiCYbxJaH8PYqGPuIS3Heuw==
X-Received: by 2002:a17:90a:734a:b0:29a:6cf0:57a3 with SMTP id j10-20020a17090a734a00b0029a6cf057a3mr780163pjs.8.1709167085433;
        Wed, 28 Feb 2024 16:38:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGszdfYRJZp6tlT4Iv+7U3f3pqW70sm2nHeFWfeGFuTKrfVroRvZkuQ39/PNYPi7byINkwM9g==
X-Received: by 2002:a17:90a:734a:b0:29a:6cf0:57a3 with SMTP id j10-20020a17090a734a00b0029a6cf057a3mr780152pjs.8.1709167085101;
        Wed, 28 Feb 2024 16:38:05 -0800 (PST)
Received: from [10.72.112.85] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g10-20020a17090a714a00b0029ab460019asm158574pjs.1.2024.02.28.16.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 16:38:04 -0800 (PST)
Message-ID: <b0e7dc61-d595-4f26-9db4-c223b725bc47@redhat.com>
Date: Thu, 29 Feb 2024 08:37:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] printk_index: Fix false positives
Content-Language: en-US
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Chris Down <chris@chrisdown.name>, Petr Mladek <pmladek@suse.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jessica Yu <jeyu@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
 Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
References: <cover.1709127473.git.geert+renesas@glider.be>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <cover.1709127473.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/28/24 22:00, Geert Uytterhoeven wrote:
> 	Hi all,
>
> When printk-indexing is enabled, each printk() invocation emits a
> pi_entry structure, containing the format string and other information
> related to its location in the kernel sources.  This is even true when
> the printk() is protected by an always-false check, as is typically the
> case for debug messages: while the actual code to print the message is
> optimized out by the compiler, the pi_entry structure is still emitted.
> Hence when debugging is disabled, this leads to the inclusion in the
> index of lots of printk formats that cannot be emitted by the current
> kernel.
>
> This series fixes that for the common debug helpers under include/.
> It reduces the size of an arm64 defconfig kernel with
> CONFIG_PRINTK_INDEX=y by ca. 1.5 MiB, or 28% of the overhead of
> enabling CONFIG_PRINTK_INDEX=y.
>
> Notes:
>    - netdev_(v)dbg() and netif_(v)dbg() are not affected, as
>      net{dev,if}_printk() do not implement printk-indexing, except
>      for the single global internal instance of __netdev_printk().
>    - This series fixes only debug code in global header files under
>      include/.  There are more cases to fix in subsystem-specific header
>      files and in sources files.
>
> Thanks for your comments!
>
> Geert Uytterhoeven (4):
>    printk: Let no_printk() use _printk()
>    dev_printk: Add and use dev_no_printk()
>    dyndbg: Use *no_printk() helpers
>    ceph: Use no_printk() helper
>
>   include/linux/ceph/ceph_debug.h | 18 +++++++-----------
>   include/linux/dev_printk.h      | 25 +++++++++++++------------
>   include/linux/dynamic_debug.h   |  4 ++--
>   include/linux/printk.h          |  2 +-
>   4 files changed, 23 insertions(+), 26 deletions(-)
>
This series LGTM.

Reviewed-by: Xiubo Li <xiubli@redhat.com>


