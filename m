Return-Path: <linux-kernel+bounces-62455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 044FF852103
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366011C22FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EE64D595;
	Mon, 12 Feb 2024 22:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Uin792MN"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C694D135
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 22:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775722; cv=none; b=VAr1819swJI3sosNLPQGgm3gKJTKoudERZ7py04+SFUVCtyIg3JmauVQx1IqJM9IUhpP1Vhb6dcXHOM1bqWQwyexK+LJ3VXBwH7k9+jurzXCYvaC+bzlrTmVt07KGn0W4PKNLB93GLsi/Cy898IVBiejBMf3L28XADNHxqq/rFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775722; c=relaxed/simple;
	bh=gAbe+DaZz7ho9Xs/O1+sZUd+Q7Ss16k+L7gT59qsNpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=upOp+tUY4eV4eKn5hRVmTo38Zh1wb/rGRwrSWtg82mRSsmjv4MDtUc8FbUWRcRpZ6FccPkM9lfZBzeA9AOswD5EiDzuh62/jOIsfke4HVs8btus6C1Ntx8saWzGX5XAXsipfYH2nzexTO52+FoEZAYn/GPXmpZbp8CZybG0edHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Uin792MN; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-561519f8698so4073724a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707775719; x=1708380519; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uavn2lIFtdjKttrhD59+foSMVfR1WVZExe9j9lqEZVs=;
        b=Uin792MNjE0TRZnpj2U2D67WjrUmFSXtD3Q/ir6YODqIQtH0gzeSGrurZHjIjayIsi
         fUxkxJ5uK6DZs+M5lySFGq+r+U4gVbSN+3ER81p2+EVre0TRetvLAC2D1CdQw2jp1Vyy
         8e58BQPUuzuewQz9M2ykJ6QIvxcJoL4zRQ1Fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707775719; x=1708380519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uavn2lIFtdjKttrhD59+foSMVfR1WVZExe9j9lqEZVs=;
        b=OJTBU8gSLuOCWieol4HeIZANj9LBAmLfCjsyzGzjAwdfsSB8nEIb4rbezvn87Z+zJv
         fI0HliDd7CdQfzagxx+5MiVl0/EEsskcahFA0d3BUnNoVnTLR2p4HhcT+7UxMAV34lXT
         1P6DJ0TZOSdo/njKz7BEGs4bAvdc4hA20t9Y/JBtfWTo9qMGhYTZWB12HPpxG+bH7/Un
         Oe+/kOzeQ82Eal3GpumHZ++nG7AcwQlNLvUA8lhAyP9W+p5Wko1DydmhzadUajo6y8iQ
         UYIx+LBupAk0dw2Pif3b22rbSHKHVWzQA2IEp/9HW2p5IDcqQZGSgkz+hk+NrnVjB8jf
         s5/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQInDOUfgpabuq2jzIwFz1KfJ90hvKOGlrZ3YPU9ZiHQZknh7fdlZawWjUsKxE1MTEOtkKomOk0jhMkEk68GfW36Xm3nXWmV6SPHby
X-Gm-Message-State: AOJu0Yznjsc/sOujxO5oSjElerpfpGgacLCUfqFv15OCG9kp6Zs9bGIZ
	GC1TgBSkV2/P+XoO/E/pi70CHpdmYzNAIgYl164EpnkQsYCFjPQTKUXBfEFCkhbs9tarrg4HuUV
	RKI0=
X-Google-Smtp-Source: AGHT+IE0qpGkGHGylUZvi4BLGt2DW4pi/HoDWClvNeiVVR2PBy9g1PoaXv5RuCycQR8E0nRdQohY2g==
X-Received: by 2002:a50:fb0c:0:b0:561:ee74:51d9 with SMTP id d12-20020a50fb0c000000b00561ee7451d9mr158897edq.20.1707775719067;
        Mon, 12 Feb 2024 14:08:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+xavRfnFww++ulzaA64sJaFY6XwKL/UV3dm6g4N8D+vCjVIfkYSvPJwxdcQD96+U39qlx8y1ThSGnl6VjPx4DPdjos2AklmN+M9us
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id cs12-20020a0564020c4c00b00561e675a3casm302494edb.68.2024.02.12.14.08.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 14:08:38 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55ff5f6a610so4427842a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:08:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtSyS7CYLIOWe8NwROtNblOsBDfcAqVjdQVifUFprzC3fHyDp5A0qBFxhQIl/Atxf12a+vg3AA0vopoew/j8/7F4Rb/5PLtJ8xqTPr
X-Received: by 2002:aa7:cd66:0:b0:561:f173:6611 with SMTP id
 ca6-20020aa7cd66000000b00561f1736611mr60172edb.35.1707775717604; Mon, 12 Feb
 2024 14:08:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212163101.19614-1-mathieu.desnoyers@efficios.com>
 <20240212163101.19614-6-mathieu.desnoyers@efficios.com> <65ca95d086dfd_d2d429470@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <65ca95d086dfd_d2d429470@dwillia2-xfh.jf.intel.com.notmuch>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Feb 2024 14:08:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiqaENZFBiAihFxdLr2E+kSM4P64M3uPzwT4-K9NiVSmw@mail.gmail.com>
Message-ID: <CAHk-=wiqaENZFBiAihFxdLr2E+kSM4P64M3uPzwT4-K9NiVSmw@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] virtio: Treat alloc_dax() -EOPNOTSUPP failure as non-fatal
To: Dan Williams <dan.j.williams@intel.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, 
	Russell King <linux@armlinux.org.uk>, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-xfs@vger.kernel.org, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-s390@vger.kernel.org, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 14:04, Dan Williams <dan.j.williams@intel.com> wrote:
>
> This works because the internals of virtio_fs_cleanup_dax(), "kill_dax()
> and put_dax()", know how to handle a NULL @dax_dev. It is still early
> days with the "cleanup" helpers, but I wonder if anyone else cares that
> the DEFINE_FREE() above does not check for NULL?

Well, the main reason for DEFINE_FREE() to check for NULL is not
correctness, but code generation. See the comment about kfree() in
<linux/cleanup.h>:

 * NOTE: the DEFINE_FREE()'s @free expression includes a NULL test even though
 * kfree() is fine to be called with a NULL value. This is on purpose. This way
 * the compiler sees the end of our alloc_obj() function as [...]

with the full explanation there.

Now, whether the code wants to actually use the cleanup() helpers for
a single use-case is debatable.

But yes, if it does, I suspect it should use !IS_ERR_OR_NULL(ptr).

            Linus

