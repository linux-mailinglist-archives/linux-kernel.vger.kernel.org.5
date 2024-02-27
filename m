Return-Path: <linux-kernel+bounces-82752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A37868919
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4EE1C2108E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C16253388;
	Tue, 27 Feb 2024 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvQGAyOC"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB0D41C6A;
	Tue, 27 Feb 2024 06:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709016009; cv=none; b=pqeUR+Ok+qnU3jR2bjMl98fKs2Qo/5Du2o/zzb46WM2PaT0tr0plgD9H5YKfkTEKewnXTN78t20M+RM2uUhJa4rcWVNdMuWP7flnvxX6H71X0IQmAeO3TC7e0QGPriUq9+gHs9Db9cK19+fe/Ue4v+dVqZnZ37N86nMwBdjhFMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709016009; c=relaxed/simple;
	bh=mjGBzkk8NtbmFG0WlX04o018Vs4aUWGPZ3MgTwyCc3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5ZbW2bmtvMkOEBshdvt0fMjvsGvcowHxWR+T+Jfg8IYef8Yr07poBbgtzzHtbaB2YZDgyaLUoSms7xPwiceCBzkZRHsL51/Bx27IRaTtQ8cfBtrvDtYj3zuMU0Qq6SVNjboAWrRfX3lzPBQJIFKtzLaMqk0DOXeifMawzwNPtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvQGAyOC; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso3738233a12.1;
        Mon, 26 Feb 2024 22:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709016007; x=1709620807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dx2RNt3R8rZc7pTxB1fOzWWdwOyApPRS74B6TRm04bY=;
        b=MvQGAyOC0Cl6qaV6CWJ0rP7AkgDl8QrkZ+vNQzdm8mlGtyGMltXOuE88ZoLr7BZyPQ
         xetS7Iar2HONNQapWjMgRyoNfyax4EPt1X+AKeS+k90N/SX6acAQaVTNHak3NORxcqqY
         jdw+nDASBgHHLgvkJ7QtuSKf0XX/Z3UxuUkPIXHmmcfaYPklNlmHNXyHbGixmZyqWGfw
         tVo2icKckWxUa/Q2YTfhQPNBSD+oA3gU5gUk9n0L7eA5N1KiJT8nZstJdW4yEml27UNe
         A9kBBU9QwZz94rf2hQ3KUFk78OVpI7cp4RvsQBrgRRi4vuB8D05y7vPDMSzSMBGGgNvn
         ySLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709016007; x=1709620807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dx2RNt3R8rZc7pTxB1fOzWWdwOyApPRS74B6TRm04bY=;
        b=ib7H7jNxiJnS5urpEM6il7mG/yTQiHmPkZQn3aiQcZimYsZAXSAAw6SYDjgQWMPjZk
         ycgM6JxOnzND4em5T/qCvn79hikYgkWz7IsOnCwW3vnJ8FiyD8F3XcGBeWm8iaWlQXcU
         tk7wR7/c3OtLrrXb19uz0jqPvWSTrZt4BuvFlsD8mqoer0TIG7nm4OHr6rHkDtcnvF4T
         lJkZT8ZWK6USWrJF56A9yIeeQ/iy85O3eVtZkw4dCqy78TbJYJn7xBNorVvcOWMkIP/1
         d2604fdjBAFgGj+h4laMC18tyaCEDxWAR+0D+zagpz+SsZxhZWoJA1CEpmJMn4mvAzln
         xIDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVgkkHAOY/cKChK+Ln4yC1ci3nq7WEh06ihzgaHkmYJ7FUTIj03+e0mDx06QRKDYQHyPrk4qcsTpHgAhAaSBHfyQqzyB0je8z0Y2fhacqgiH5CZSvQdEodneuOCTR7upG9
X-Gm-Message-State: AOJu0YzLPJ4ZoKLYWyifwKHiIIFQcnU14ZutbhKKddkQuxcREK1PSCaQ
	9qswbVPyVLNMzs3504he8ZWORzgkLAG/ohL1Vfed/PypVSKkOlN3C2wHw090LpuucnOZtQbibUN
	70uZu76l8BWw9cR6C7fNNS43Y0NQ=
X-Google-Smtp-Source: AGHT+IGqLJtCxCqW74sPbB8bc8zeRicUUOZJdfUR+nz12lX/47nOgxa2MWpXMFQB4bVZa0k34OhY8CDLOFACH/9y2Kg=
X-Received: by 2002:a05:6a21:9103:b0:19e:bc8f:d0ca with SMTP id
 tn3-20020a056a21910300b0019ebc8fd0camr1212398pzb.58.1709016007197; Mon, 26
 Feb 2024 22:40:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220183115.74124-1-urezki@gmail.com> <20240220183115.74124-3-urezki@gmail.com>
 <Zd0ZtNu+Rt0qXkfS@lothringen>
In-Reply-To: <Zd0ZtNu+Rt0qXkfS@lothringen>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Tue, 27 Feb 2024 14:39:55 +0800
Message-ID: <CALm+0cUJ9tMsZpOGby_6B6c=XDBn_CJ6=o2WSFafaCwPzp6_4A@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] rcu: Reduce synchronize_rcu() latency
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>, 
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Hillf Danton <hdanton@sina.com>, Joel Fernandes <joel@joelfernandes.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Content-Type: text/plain; charset="UTF-8"

>
> On Tue, Feb 20, 2024 at 07:31:13PM +0100, Uladzislau Rezki (Sony) wrote:
> > +static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > +{
> > +     struct llist_node *done, *rcu, *next, *head;
> > +
> > +     /*
> > +      * This work execution can potentially execute
> > +      * while a new done tail is being updated by
> > +      * grace period kthread in rcu_sr_normal_gp_cleanup().
> > +      * So, read and updates of done tail need to
> > +      * follow acq-rel semantics.
> > +      *
> > +      * Given that wq semantics guarantees that a single work
> > +      * cannot execute concurrently by multiple kworkers,
> > +      * the done tail list manipulations are protected here.
> > +      */
> > +     done = smp_load_acquire(&rcu_state.srs_done_tail);
> > +     if (!done)
> > +             return;
> > +
> > +     WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
> > +     head = done->next;
> > +     done->next = NULL;
>
> Can the following race happen?
>
> CPU 0                                                   CPU 1
> -----                                                   -----
>
> // wait_tail == HEAD1
> rcu_sr_normal_gp_cleanup() {
>     // has passed SR_MAX_USERS_WAKE_FROM_GP
>     wait_tail->next = next;
>     // done_tail = HEAD1
>     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>     queue_work() {
>         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
>         __queue_work()
>     }
> }
>
>                                                       set_work_pool_and_clear_pending()
>                                                       rcu_sr_normal_gp_cleanup_work() {
> // new GP, wait_tail == HEAD2
> rcu_sr_normal_gp_cleanup() {
>     // executes all completion, but stop at HEAD1
>     wait_tail->next = HEAD1;
>     // done_tail = HEAD2
>     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>     queue_work() {
>         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
>         __queue_work()
>     }
> }
>                                                           // done = HEAD2
>                                                           done = smp_load_acquire(&rcu_state.srs_done_tail);
>                                                           // head = HEAD1
>                                                           head = done->next;
>                                                           done->next = NULL;
>                                                           llist_for_each_safe() {
>                                                               // completes all callbacks, release HEAD1
>                                                           }
>                                                       }
>                                                       // Process second queue
>                                                       set_work_pool_and_clear_pending()
>                                                       rcu_sr_normal_gp_cleanup_work() {
>                                                           // done = HEAD2
>                                                           done = smp_load_acquire(&rcu_state.srs_done_tail);
>
> // new GP, wait_tail == HEAD3
> rcu_sr_normal_gp_cleanup() {
>     // Finds HEAD2 with ->next == NULL at the end
>     rcu_sr_put_wait_head(HEAD2)

It seems that we should move rcu_sr_put_wait_head() from
rcu_sr_normal_gp_cleanup() to
rcu_sr_normal_gp_cleanup_work(), if find wait_head->next == NULL, invoke
rcu_sr_put_wait_head() to release wait_head.

Thanks
Zqiang

>     ...
>
> // A few more GPs later
> rcu_sr_normal_gp_init() {
>      HEAD2 = rcu_sr_get_wait_head();
>      llist_add(HEAD2, &rcu_state.srs_next);
>                                                           // head == rcu_state.srs_next
>                                                           head = done->next;
>                                                           done->next = NULL;
>                                                           llist_for_each_safe() {
>                                                               // EXECUTE CALLBACKS TOO EARLY!!!
>                                                           }
>                                                       }
>

