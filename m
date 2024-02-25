Return-Path: <linux-kernel+bounces-80263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17A2862CB4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9431C20F6B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 20:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4751AADB;
	Sun, 25 Feb 2024 20:03:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64C38C10;
	Sun, 25 Feb 2024 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708891385; cv=none; b=ZCzvkFjI5MFerBUNZ7kCd/nnjzLbPsHiPBhOP/X+hk9ZUEYDXzn4t/ppjEM5OPSm8BxQKCtR+BafFoT7MPkBrUGCv9ncps7eMuQzwrmqTfOAYhdepc/M+lC5NktRQNyN39TS5WzFsy13nVw2FyX3BuNwA6QYTqS3yFcWhsEsV3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708891385; c=relaxed/simple;
	bh=JdjL58AeruKy3wjRZCMa8HNnw48yFKwrynnIiyQwEXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dA10lzhWNr3lP/9BBQvuD/Nr0jkJIIWclpVGqChbxkCDMkafhgm56yRyFHLMkvrtDgKLdFmfW+kDYa76utbFUjRkXzqlAtLJ1sv9h2mSVAlZczYGZVeoa1QVoVCABhBlUBEFshe5MX3fL3h+JxZtlUghFMsFNLSNOgCz8NLZ8NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343BAC433F1;
	Sun, 25 Feb 2024 20:03:04 +0000 (UTC)
Date: Sun, 25 Feb 2024 15:03:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linke li <lilinke99@qq.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: use READ_ONCE() to read
 cpu_buffer->commit_page in concurrent environment
Message-ID: <20240225150302.23c3c3c2@rorschach.local.home>
In-Reply-To: <tencent_5EC64EB49686EE61593AE541DB14CE490A08@qq.com>
References: <lilinke99@qq.com>
	<tencent_5EC64EB49686EE61593AE541DB14CE490A08@qq.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Feb 2024 11:05:06 +0800
linke li <lilinke99@qq.com> wrote:

> In function ring_buffer_iter_empty(), cpu_buffer->commit_page and
> curr_commit_page->page->time_stamp is read using READ_ONCE() in 
> line 4354, 4355
> 
> 4354    curr_commit_page = READ_ONCE(cpu_buffer->commit_page);
> 4355    curr_commit_ts = READ_ONCE(curr_commit_page->page->time_stamp);
> 
> while they are read directly in line 4340, 4341
> 
> 4340    commit_page = cpu_buffer->commit_page;
> 4341    commit_ts = commit_page->page->time_stamp;

Just because it's used in one place does not mean it's required in
another.

> 
> There is patch similar to this. commit c1c0ce31b242 ("r8169: fix the KCSAN reported data-race in rtl_tx() while reading tp->cur_tx")
> This patch find two read of same variable while one is protected, another
> is not. And READ_ONCE() is added to protect.
> 

Here's the entire code:

        cpu_buffer = iter->cpu_buffer;
        reader = cpu_buffer->reader_page;
        head_page = cpu_buffer->head_page;
        commit_page = cpu_buffer->commit_page;
        commit_ts = commit_page->page->time_stamp;

        /*
         * When the writer goes across pages, it issues a cmpxchg which
         * is a mb(), which will synchronize with the rmb here.
         * (see rb_tail_page_update())
         */
        smp_rmb();

The above smp_rmb() is a full read barrier. The commit_page and
timestamp are not going to be read again after this.

        commit = rb_page_commit(commit_page);
        /* We want to make sure that the commit page doesn't change */
        smp_rmb();

        /* Make sure commit page didn't change */
        curr_commit_page = READ_ONCE(cpu_buffer->commit_page);
        curr_commit_ts = READ_ONCE(curr_commit_page->page->time_stamp);

Now the reason for the above READ_ONCE() is because the variables *are*
going to be used again. We do *not* want the compiler to play any games
with that.

Thus, the first read of commit_page and time_stamp are read properly as
the compiler will not do anything that can hurt us beyond that
smp_rmb(). The second time we read those variables, we are using them
in the below code.


        /* If the commit page changed, then there's more data */
        if (curr_commit_page != commit_page ||
            curr_commit_ts != commit_ts)
                return 0;

        /* Still racy, as it may return a false positive, but that's OK */
        return ((iter->head_page == commit_page && iter->head >= commit) ||
                (iter->head_page == reader && commit_page == head_page &&
                 head_page->read == commit &&
                 iter->head == rb_page_commit(cpu_buffer->reader_page)));
}

*But* looking at this deeper, the commit_page may need a READ_ONCE()
but not for the reason you suggested.

        commit_page = cpu_buffer->commit_page;
        commit_ts = commit_page->page->time_stamp;

The commit_page above *is* used again, and we want commit_ts to be part
of the commit_page that was originally read and not a second reading.

So, I think for the commit_page we do need a READ_ONCE() but that's
because it is referenced again just below it and we don't want the
compiler to read the memory location again for the second reference.

-- Steve

