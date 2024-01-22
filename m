Return-Path: <linux-kernel+bounces-34201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9362883757B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DFF028956D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A425648CC5;
	Mon, 22 Jan 2024 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V4Rk67bh"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E3B48CF3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959323; cv=none; b=F02r8OCrE/V/ZWLAKDJNxBX4ZiHqTZL0CY/BarsXEp6W7UsRT67a1h8EUT2eThHu2tGOnQ/fBTgdBZ23KFJJDKzYgd4VPuhBsEDYFqBniVPccHSDzT43f1H+kEspLCX8cmgDG3Kyi1L16DA9lTB20Rkn/HIPpE0hlYwOZ97Qzy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959323; c=relaxed/simple;
	bh=tir7kge5xaX08VMRW1qUzxTUu9x6OO0aQSyK1LncuuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cgxo6GIr7KCZ1Hk5ZznS1h2y+gSc0eVO461dLv/Nz23N7+/VDI+zMD/ComPxqakVkAU8jlc4m1gBA912MRcuULqsVOnN71kpv5bECIZ5zDx1R/qzyCuBit+MhlG8HOdl7PEjiDggl5e7WQs0HzzEO/Ny4DHGev8HSypW2JvAtO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V4Rk67bh; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6db0fdd2b8fso1716043b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705959320; x=1706564120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=La/pQA6UxU8t2n1gEI32Cqq0uc4Tew1m9B7OoRZQ8SI=;
        b=V4Rk67bhj38bUYpTgO1fXNT7hlYfhelV36xIeufYYXG/jyrFnpW3z+ZFIoQNE/eiSz
         7F7EblPvj8mBUqZ4tkfYTHThHDwRYOueP8p409VYLs5dsXEPMFIurqLUt9qGQ1wNQpvW
         yxofseEB9WDEY9pPwhthu+mwYY3hrzwhMJeb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705959320; x=1706564120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=La/pQA6UxU8t2n1gEI32Cqq0uc4Tew1m9B7OoRZQ8SI=;
        b=StMaJIp4Lc8V+YjAKyWbawZiEGTK0A3wpqJvZ0trzmjpacoMqazD6Ky61ZeW7yJmoa
         rfU8ZBX1j7APhjywP/PxaCA/k+HD+cHQFtxuespu7fjLtM0M21vYxeG5E+M2OyoPHExD
         WOPpwQWfYQk+AZAUx/HPDorSGXbFMLOUXpSmxe7hWeobnP4pMOG5hsr1S8qWcC53Hgx2
         t3FfibGC9zILJKbeAn9Os2GhtgHzzRhgyRswdgfdpgP78NwiXNugz3neYh+brk3e70Oo
         ohGr7PE2w1g4pit5zwZrdLo0pvRepSUifEGO+nuhrqPCO9yiLNmcwNAcwnuMe1At5LIi
         M3rA==
X-Gm-Message-State: AOJu0YxRWbjPM7FONF9n8wpE5qvtO443eJkbS1LDm/aDy+rebkO/NOUx
	FE8/8j8YhD8hfR/idhLpawQDV/pTterQpNn+PzWXzQ3P7yHe2gf3xOFi/GlEGA==
X-Google-Smtp-Source: AGHT+IEhye246jTya1RIC7tJ0lpkhYypKWEZO4ePXa0bxP/yrVeg7EyStXAcy9+TrTGZeyn+aV1J5Q==
X-Received: by 2002:a17:90a:c0f:b0:28a:b5ac:514f with SMTP id 15-20020a17090a0c0f00b0028ab5ac514fmr1976731pjs.95.1705959319837;
        Mon, 22 Jan 2024 13:35:19 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id pd5-20020a17090b1dc500b0028c5585fb41sm10145282pjb.45.2024.01.22.13.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:35:19 -0800 (PST)
Date: Mon, 22 Jan 2024 13:35:18 -0800
From: Kees Cook <keescook@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] eventfs: Save directory inodes in the eventfs_inode
 structure
Message-ID: <202401221334.A6BC4754@keescook>
References: <20240122152748.46897388@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122152748.46897388@gandalf.local.home>

On Mon, Jan 22, 2024 at 03:27:48PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The eventfs inodes and directories are allocated when referenced. But this
> leaves the issue of keeping consistent inode numbers and the number is
> only saved in the inode structure itself. When the inode is no longer
> referenced, it can be freed. When the file that the inode was representing
> is referenced again, the inode is once again created, but the inode number
> needs to be the same as it was before.
> 
> Just making the inode numbers the same for all files is fine, but that
> does not work with directories. The find command will check for loops via
> the inode number and having the same inode number for directories triggers:
> 
>   # find /sys/kernel/tracing
> find: File system loop detected;
> '/sys/kernel/debug/tracing/events/initcall/initcall_finish' is part of the same file system loop as
> '/sys/kernel/debug/tracing/events/initcall'.
> [..]
> 
> Linus pointed out that the eventfs_inode structure ends with a single
> 32bit int, and on 64 bit machines, there's likely a 4 byte hole due to
> alignment. We can use this hole to store the inode number for the
> eventfs_inode. All directories in eventfs are represented by an
> eventfs_inode and that data structure can hold its inode number.
> 
> That last int was also purposely placed at the end of the structure to
> prevent holes from within. Now that there's a 4 byte number to hold the
> inode, both the inode number and the last integer can be moved up in the
> structure for better cache locality, where the llist and rcu fields can be
> moved to the end as they are only used when the eventfs_inode is being
> deleted.
> 
> Link: https://lore.kernel.org/all/CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com/
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: 53c41052ba31 ("eventfs: Have the inodes all for files and directories all be the same")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Since I reviewed the earlier patch, I will repeat here for the formal
one too. :) Thanks for avoiding the hashing!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

