Return-Path: <linux-kernel+bounces-52029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9782684930A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52991282CEB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 04:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9A3B654;
	Mon,  5 Feb 2024 04:49:12 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C720AD32
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 04:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707108552; cv=none; b=ffY162xhF945pycH3ALcoOP2Xx2tDnuOhAlRtnvtTunldSzQxI3vfYFHXsZhMs6mTcIs9BS3c/idzngteccB2b2U8iwWA3JvZXwnOZkfhCkrtTVnCX9NC7jRx0TpUneP7QWcpVdjUkUsp4XnLRzEFgdsvAda7KglSCOgPpaV0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707108552; c=relaxed/simple;
	bh=cdJQFz6hZUzWJNGzDH63QwKkJo4AU14dQ2yGTGVLD10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Va2mNJSCPyajXiyrHx8QQvT4cM9ITbnKTvL4kYCJq+FfzBldPiqMTbYTXMu9zlecqap7WxQp57X0HBcQNxr0b/OaXxM5C+pGCnVpmqNRdP2OBshOHbxQFvXEfB/1iORYnjtUVr8yGce1emvdvyd1kEWjPi8/4+4WBOFDKriUDdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.117])
	by sina.com (172.16.235.24) with ESMTP
	id 65C0689A000008B5; Mon, 5 Feb 2024 12:48:29 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 60248245089159
X-SMAIL-UIID: 810C1F7E0DE348C6A2CB06103849C575-20240205-124829-1
From: Hillf Danton <hdanton@sina.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org,
	mpatocka@redhat.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH v3 3/8] workqueue: Implement BH workqueues to eventually replace tasklets
Date: Mon,  5 Feb 2024 12:48:17 +0800
Message-Id: <20240205044817.593-1-hdanton@sina.com>
In-Reply-To: <ZcABypwUML6Osiec@slm.duckdns.org>
References: <20240130091300.2968534-1-tj@kernel.org> <20240130091300.2968534-4-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 4 Feb 2024 11:28:06 -1000 Tejun Heo <tj@kernel.org>
> +static void bh_worker(struct worker *worker)
> +{
> +	struct worker_pool *pool = worker->pool;
> +	int nr_restarts = BH_WORKER_RESTARTS;
> +	unsigned long end = jiffies + BH_WORKER_JIFFIES;
> +
> +	raw_spin_lock_irq(&pool->lock);
> +	worker_leave_idle(worker);
> +
> +	/*
> +	 * This function follows the structure of worker_thread(). See there for
> +	 * explanations on each step.
> +	 */
> +	if (!need_more_worker(pool))
> +		goto done;
> +
> +	WARN_ON_ONCE(!list_empty(&worker->scheduled));
> +	worker_clr_flags(worker, WORKER_PREP | WORKER_REBOUND);
> +
> +	do {
> +		struct work_struct *work =
> +			list_first_entry(&pool->worklist,
> +					 struct work_struct, entry);
> +
> +		if (assign_work(work, worker, NULL))
> +			process_scheduled_works(worker);
> +	} while (keep_working(pool) &&
> +		 --nr_restarts && time_before(jiffies, end));
> +
> +	worker_set_flags(worker, WORKER_PREP);
> +done:
> +	worker_enter_idle(worker);
> +	kick_pool(pool);
> +	raw_spin_unlock_irq(&pool->lock);
> +}

I see no need to exec bh works for 2ms with irq disabled.

