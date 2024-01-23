Return-Path: <linux-kernel+bounces-35594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B89C8393D6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F094B2B0A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE4B612DD;
	Tue, 23 Jan 2024 15:50:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5753F604C4;
	Tue, 23 Jan 2024 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025020; cv=none; b=Nfy4jnDcVnc3AOKtA/ntqC6jAFpmxmZAsPzp4YL2pcWVPW6OiXr1aGN3yMLdWrWw2KH5gJqcA3N5glB1f9yXJUSBu5ihTpkl6KFyBpCT8XYdJFAGc13RXCvJZWIzBRTlsG6WEoLs7IptXJR7OArwdB2lgIyUpSg3Tuo+krWwcZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025020; c=relaxed/simple;
	bh=tf/dpxgcUBtYs+oE2E1+O79b0TAiJ4Gu5UtW7Lg9Q1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nekuT9e416/FKgiqXuXBfpODImZflugnrQaAGBqw+lhbIh+Veq6NJ3MTDkeVvVrXwDgMOKxa9ZsXAJxo5SA/jw5TfBAV8Zxbwle6ttCpUmwbX5T5yYMzThaO/pXiJa3xnrZE3x1+s4H4AcYiUVO1btFiq0CrC34PKBSFv5geZUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6E7C433F1;
	Tue, 23 Jan 2024 15:50:19 +0000 (UTC)
Date: Tue, 23 Jan 2024 10:51:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v12 2/6] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20240123105149.36abf019@gandalf.local.home>
In-Reply-To: <20240123110757.3657908-3-vdonnefort@google.com>
References: <20240123110757.3657908-1-vdonnefort@google.com>
	<20240123110757.3657908-3-vdonnefort@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 11:07:53 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> index 000000000000..5468afc94be7
> --- /dev/null
> +++ b/include/uapi/linux/trace_mmap.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _TRACE_MMAP_H_
> +#define _TRACE_MMAP_H_
> +
> +#include <linux/types.h>
> +
> +/**
> + * struct trace_buffer_meta - Ring-buffer Meta-page description
> + * @meta_page_size:	Size of this meta-page.
> + * @meta_struct_len:	Size of this structure.
> + * @subbuf_size:	Size of each subbuf, including the header.
> + * @nr_subbufs:		Number of subbfs in the ring-buffer.
> + * @reader.lost_events:	Number of events lost at the time of the reader swap.
> + * @reader.id:		subbuf ID of the current reader. From 0 to @nr_subbufs - 1
> + * @reader.read:	Number of bytes read on the reader subbuf.
> + * @entries:		Number of entries in the ring-buffer.
> + * @overrun:		Number of entries lost in the ring-buffer.
> + * @read:		Number of entries that have been read.


> + * @subbufs_touched:	Number of subbufs that have been filled.
> + * @subbufs_lost:	Number of subbufs lost to overrun.
> + * @subbufs_read:	Number of subbufs that have been read.

Do we actually need the above 3 fields?

What's the use case for them? I don't want to expose internals in the API
unless they are needed.

-- Steve

