Return-Path: <linux-kernel+bounces-4081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB1D8177BE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DA2286E48
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D034498B2;
	Mon, 18 Dec 2023 16:42:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B086B1E4AF;
	Mon, 18 Dec 2023 16:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6DEC433C8;
	Mon, 18 Dec 2023 16:42:12 +0000 (UTC)
Date: Mon, 18 Dec 2023 11:43:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v7 0/2] ring-buffer: Rename sub-buffer into buffer page
Message-ID: <20231218114308.4ed19608@gandalf.local.home>
In-Reply-To: <20231218112817.7f3c8847@gandalf.local.home>
References: <20231218151451.944907-1-vdonnefort@google.com>
	<20231218154618.954997-1-vdonnefort@google.com>
	<20231218112817.7f3c8847@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Dec 2023 11:28:17 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Remove all references to sub-buffer and replace them with either bpage
> > or ring_buffer_page.  

The user interface should not be changed.

But what I would like to have changed (and this will come after all other
changes are complete), is to do the following renaming:

  original structure name		new name		variable reference
  -----------------------		--------		------------------
 struct buffer_data_page		struct buffer_data	bdata  (was bpage)
 struct buffer_page			struct buffer_subbuf	subbuf (was also bpage)

Also change:

struct buffer_page {
	[..]
	struct buffer_data_page *page;	/* Actual data page */
};

Into:

struct buffer_subbuf {
	[..]
	struct buffer_data *data;	/* Actual data */
};



Then we can do a global rename of functions like:

 free_buffer_page() -> free_buffer_subbuf()

And things like rb_init_page() into rb_init_subbuf()

__rb_allocate_pages() -> rb_allocate_subbufs()

etc.

This should be broken up into steps of changes:

1. Rename the struct buffer_data_page and bpage->bdata
2. Rename the struct buffer_page and bpage->subbuf
3. Rename static functions

And I just realized that the two functions exposed outside of the file are
not used anywhere else. We can remove one and make the other one static (as
it is used within the file).

ring_buffer_nr_pages() -> delete
ring_buffer_nr_dirty_pages -> convert to static rb_nr_dirty_pages()


Thanks,

-- Steve

