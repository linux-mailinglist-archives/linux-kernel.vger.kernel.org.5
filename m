Return-Path: <linux-kernel+bounces-27442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC6D82F017
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D99DB237EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ACE1BDE5;
	Tue, 16 Jan 2024 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTMfQOaC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E961BDDE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705413591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FqhlVC483d/Jp5V2BSEbp0a7wISrFNvy6LiACtWbELo=;
	b=DTMfQOaCPyr7xmMQX6fchvGuP6Ftj3FKdOih3/9wrd2QQcc3p8sQ/PySk/nZcsAfh2FhgA
	jWZWpATIw3+jLnpbgFD9uZQOTRVRx1WE7+G/LuoKyMt2mF/gWimmqCUP98GusZxMF9vgDQ
	vlUiCkW9V82LBwLAbLZORJBDwwveJJM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-l80-S4AtMuiiBeFQ4oJLsg-1; Tue, 16 Jan 2024 08:59:48 -0500
X-MC-Unique: l80-S4AtMuiiBeFQ4oJLsg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B145385CBA6;
	Tue, 16 Jan 2024 13:59:47 +0000 (UTC)
Received: from bfoster (unknown [10.22.8.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F4193C25;
	Tue, 16 Jan 2024 13:59:47 +0000 (UTC)
Date: Tue, 16 Jan 2024 09:01:05 -0500
From: Brian Foster <bfoster@redhat.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] bcachefs: remove redundant variable tmp
Message-ID: <ZaaMIYDL/4AzG758@bfoster>
References: <20240116110723.2247265-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116110723.2247265-1-colin.i.king@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Tue, Jan 16, 2024 at 11:07:23AM +0000, Colin Ian King wrote:
> The variable tmp is being assigned a value but it isn't being
> read afterwards. The assignment is redundant and so tmp can be
> removed.
> 

I assume this intends to refer to s/tmp/ret/ ...

> Cleans up clang scan build warning:
> warning: Although the value stored to 'ret' is used in the enclosing
> expression, the value is never actually read from 'ret'
> [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  fs/bcachefs/rebalance.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/bcachefs/rebalance.c b/fs/bcachefs/rebalance.c
> index 95f46cb3b5bd..827316a27431 100644
> --- a/fs/bcachefs/rebalance.c
> +++ b/fs/bcachefs/rebalance.c
> @@ -385,7 +385,6 @@ static int bch2_rebalance_thread(void *arg)
>  	struct bch_fs *c = arg;
>  	struct bch_fs_rebalance *r = &c->rebalance;
>  	struct moving_context ctxt;
> -	int ret;
>  
>  	set_freezable();
>  
> @@ -393,8 +392,7 @@ static int bch2_rebalance_thread(void *arg)
>  			      writepoint_ptr(&c->rebalance_write_point),
>  			      true);
>  
> -	while (!kthread_should_stop() &&
> -	       !(ret = do_rebalance(&ctxt)))
> +	while (!kthread_should_stop() && !do_rebalance(&ctxt))

Part of me wonders if this was intended to return ret, as that appears
to bubble back through kthread_stop(). That said, we don't check for
error there either (i.e. bch2_rebalance_stop()), so this seems
reasonable enough to me to address the warning:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  		;
>  
>  	bch2_moving_ctxt_exit(&ctxt);
> -- 
> 2.39.2
> 


