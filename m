Return-Path: <linux-kernel+bounces-82163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88F3868010
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4F01F2C0FB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE6B12EBF6;
	Mon, 26 Feb 2024 18:52:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235FC12C53D;
	Mon, 26 Feb 2024 18:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973531; cv=none; b=pzngrsuRnKSDtxbAE9DTA/+g/+qCoICNuR25Q+ULNFS8vvKFvqDwRZZWDC9uj1eI/sBF5+joqIdUSLZySpvhPwGunWS7c9PMxM765HrGJCenFoqScAgk1LTF8hbZgmF0dt1JuLT6HBvEHpQcNFPgVURp5hYc+NrPyPrb34e/xrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973531; c=relaxed/simple;
	bh=3Gmla1nD+s6JL0VfGINBYQZbGiFVdJqDEG83H9jQ8uI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XPAcQImyXdffDIISkk/FGrQfmYZ0n4gZZQ28S30eLvQJFX72Y7gH0NCfKUXX8XtDPhJFdyDb9zGvG+QXHSZQURM/9+V/+gKOZm6RmhuVTG1p16bqLIV1D7N1Te+dK7/sljAEi2lI5wUdCVJrFw972V4R/1KdYYmA/2Z8Ht21VFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83819C433C7;
	Mon, 26 Feb 2024 18:52:04 +0000 (UTC)
Date: Mon, 26 Feb 2024 13:53:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linke li <lilinke99@qq.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: use READ_ONCE() to read
 cpu_buffer->commit_page in concurrent environment
Message-ID: <20240226135353.3103b360@gandalf.local.home>
In-Reply-To: <20240225150302.23c3c3c2@rorschach.local.home>
References: <lilinke99@qq.com>
	<tencent_5EC64EB49686EE61593AE541DB14CE490A08@qq.com>
	<20240225150302.23c3c3c2@rorschach.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Feb 2024 15:03:02 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> *But* looking at this deeper, the commit_page may need a READ_ONCE()
> but not for the reason you suggested.
> 
>         commit_page = cpu_buffer->commit_page;
>         commit_ts = commit_page->page->time_stamp;
> 
> The commit_page above *is* used again, and we want commit_ts to be part
> of the commit_page that was originally read and not a second reading.
> 
> So, I think for the commit_page we do need a READ_ONCE() but that's
> because it is referenced again just below it and we don't want the
> compiler to read the memory location again for the second reference.

Care to send a v2 patch that just adds READ_ONCE() for the commit_page, and
change the change log stating that it is to fix the possibility that the
time_stamp may come from a different page.

-- Steve

