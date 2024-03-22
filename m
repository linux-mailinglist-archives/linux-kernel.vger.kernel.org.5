Return-Path: <linux-kernel+bounces-110834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F37886479
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A64D1C21DE2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C535A65C;
	Fri, 22 Mar 2024 00:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0jq/9Qyq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12481376
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 00:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711068464; cv=none; b=rmPvxgaZIxZp99s4vzeWh3hov2bjPba7FhzMNOpQ1Hx4FD1I5xJthtdXtU7ywEgrIgktM2tFGo2NExKyDLHxX2jKFDIMBQOtygNHXkWm4OiP++FMPT/bJIIRZMcqHIcqm9S40QPd570w5np8eM5BMbIrTtNIhluFAprHDeU8HRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711068464; c=relaxed/simple;
	bh=7jVrCeB8r4Jhz+Oth0tMnxg2wwc/cCnXPK5b+noYuzI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mE8YDZ1BhHda+vYYnw44BrhDWdSJoOJCU43xbtwVA0jv97DKbyUMrUwnxHfGFxusvIZ4iGga6I7JD2PH22w7CB9UbFh0hyS4WHCKH6gYT2AHh6EiTrVe6BGtUdoQmYFC7BpDt+H7R7JYWdhHnmXwTLZMLM6i7zgpBgIG/p/Mjko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0jq/9Qyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19590C433C7;
	Fri, 22 Mar 2024 00:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711068463;
	bh=7jVrCeB8r4Jhz+Oth0tMnxg2wwc/cCnXPK5b+noYuzI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0jq/9Qyqvev3SfPJwJcvNW8LTEnzWab/6cRd9shWI9urOkdwxu1yIruaSExNiafPd
	 Fpqz4beoIGVnXN+QIEEUJmWPIPi/yUmQP0SnWn7pTVyxu4nGyQnMc3vt35dPxmDbWq
	 sOhqhI0EDjZzkff2mD4D7gij31/aq/uSc8+hArEo=
Date: Thu, 21 Mar 2024 17:47:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
 kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
 david@redhat.com, axelrasmussen@google.com, bgeffon@google.com,
 jannh@google.com, kaleshsingh@google.com, ngeoffray@google.com,
 rppt@kernel.org, hdanton@sina.com,
 syzbot+49056626fe41e01f2ba7@syzkaller.appspotmail.com
Subject: Re: [PATCH] userfaultfd: fix deadlock warning when locking src and
 dst VMAs
Message-Id: <20240321174742.6c5622f4406673629e266db7@linux-foundation.org>
In-Reply-To: <20240321235818.125118-1-lokeshgidra@google.com>
References: <20240321235818.125118-1-lokeshgidra@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2024 16:58:18 -0700 Lokesh Gidra <lokeshgidra@google.com> wrote:

> Use down_read_nested() to avoid the warning.
> 
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1444,7 +1444,8 @@ static int uffd_move_lock(struct mm_struct *mm,
>  		 */
>  		down_read(&(*dst_vmap)->vm_lock->lock);
>  		if (*dst_vmap != *src_vmap)
> -			down_read(&(*src_vmap)->vm_lock->lock);
> +			down_read_nested(&(*src_vmap)->vm_lock->lock,
> +					 SINGLE_DEPTH_NESTING);
>  	}
>  	mmap_read_unlock(mm);
>  	return err;

Thanks, I added 

Fixes: 867a43a34ff8a ("userfaultfd: use per-vma locks in userfaultfd operations")


