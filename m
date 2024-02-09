Return-Path: <linux-kernel+bounces-59359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8028884F5C7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA5E1F22B4A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8476F381DA;
	Fri,  9 Feb 2024 13:25:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E65381AF;
	Fri,  9 Feb 2024 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485158; cv=none; b=phMJBEegu2Ex9QtvMVDFGnCq0QSg4QT20haoFmeF5GGACvdfr4HwcjuhAqNJNBrkYXUXZvXuA2gSzesEXuB/+dZRZTPyXXh1qORGHrk4t7d5ELftXx1OmcJIKTIqvBED5qNZAJ90Y8t59/76c8E/A/0jlOBw2+teKtNxzZhNb28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485158; c=relaxed/simple;
	bh=tQUeUFmRa0OyLDyoC1Z9oHBdLuOcPOL6eT6C/1w5p44=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9w5hrcGGU0m7ClVHUMXiTIuTxjUCxmQYK9+7O5dcXh7Tx2jnGHjsSvodyY+u7ck1I17jux0HcM7SxXhOVTtFVJJE5FgVRd1e7Pau+LyAjwf2o9RKW6Ij4kpfQtugoWASad7nOKvKVx2fY8WVndy9Fx6Tj1zqdf2Et7e/6ehWD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B14C433F1;
	Fri,  9 Feb 2024 13:25:55 +0000 (UTC)
Date: Fri, 9 Feb 2024 08:25:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v15 2/6] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20240209082552.1ab5c9b1@rorschach.local.home>
In-Reply-To: <20240209102202.649049-3-vdonnefort@google.com>
References: <20240209102202.649049-1-vdonnefort@google.com>
	<20240209102202.649049-3-vdonnefort@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Feb 2024 10:21:58 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> +static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> +{
> +	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
> +
> +	WRITE_ONCE(meta->reader.read, cpu_buffer->reader_page->read);
> +	WRITE_ONCE(meta->reader.id, cpu_buffer->reader_page->id);
> +	WRITE_ONCE(meta->reader.lost_events, cpu_buffer->lost_events);
> +
> +	WRITE_ONCE(meta->entries, local_read(&cpu_buffer->entries));
> +	WRITE_ONCE(meta->overrun, local_read(&cpu_buffer->overrun));
> +	WRITE_ONCE(meta->read, cpu_buffer->read);
> +

Small nit, but we should add a comment to the two flush_dache_folio() calls:

	/* Some archs do not have data cache coherency between kernel and user space */
> +	flush_dcache_folio(virt_to_folio(cpu_buffer->meta_page));
> +}
> +


-- Steve

