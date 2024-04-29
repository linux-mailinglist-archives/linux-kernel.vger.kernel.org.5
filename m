Return-Path: <linux-kernel+bounces-162107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2178B55F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41537B23865
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A1E3BB43;
	Mon, 29 Apr 2024 11:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4zF/jeM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF17219F0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714388706; cv=none; b=Jc5qUIbAv0TpkIorMzFDPN5Lb15aFPJIVnME4UzcKPRxrkZr2VdExkIdvqaXEBQzEphjyozROdU/VQ/lu5WvLvWgnGGwsitMBkzEb92peSraNenU8NqZlld+YdZj8BNqn3aITUkD9OC1FgTNh3cnZvYnomYk71Uz6R8psr4vIaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714388706; c=relaxed/simple;
	bh=sTSSyBkKD7YDBb5NDHQWR7yiAGxYXMmKFxKGAunMYug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKSWwQs1ftLqXS0AjxtbY91V8cWLbPCHp3Dd8xvSZav/7fE5rzSTYX+jCz/kNsPB1kfbsyR6ds8eAHeQWvFapM6renq+6jZQ1lwySblNNjzLZweGVzyygesG/pHtmZ7rkZaf+HhZawU3ScmWcjh3iYgpP74LtnFDdg7uT3uP+D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H4zF/jeM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714388704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6VS08W4Uz8/bxiSCCoDd/kVVFCwVeCdJq9V0dytDy1w=;
	b=H4zF/jeM5ipBCwAqiYhNhYf/LPGMiHyZDGIOymKP0nUorR62QOY1fzNHUqdmerSKY+po6Q
	QZwOBdmJi1U/TmqZrXyj4/B4IN0ggmkiZTcce+CZ+Lg6Yf5LeLtxx8Mbf6oBXtX3AA7mCK
	dBwi+W43g7q1YjGGDdLhXQjejINUvi0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-uwHYflRGOua0fkQXp25JRA-1; Mon,
 29 Apr 2024 07:04:58 -0400
X-MC-Unique: uwHYflRGOua0fkQXp25JRA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C07D380621F;
	Mon, 29 Apr 2024 11:04:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.143])
	by smtp.corp.redhat.com (Postfix) with SMTP id D4D7D1C060D0;
	Mon, 29 Apr 2024 11:04:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 29 Apr 2024 13:03:32 +0200 (CEST)
Date: Mon, 29 Apr 2024 13:03:28 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] Revert "rcu-tasks: Fix synchronize_rcu_tasks() VS
 zap_pid_ns_processes()"
Message-ID: <20240429110328.GB1101@redhat.com>
References: <20240425142404.19927-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425142404.19927-1-frederic@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 04/25, Frederic Weisbecker wrote:
>
> This reverts commit 28319d6dc5e2ffefa452c2377dd0f71621b5bff0. The race
> it fixed was subject to conditions that don't exist anymore since:
>
> 	1612160b9127 ("rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks")
>
> This latter commit removes the use of SRCU that used to cover the
> RCU-tasks blind spot on exit between the tasklist's removal and the
> final preemption disabling. The task is now placed instead into a
> temporary list inside which voluntary sleeps are accounted as RCU-tasks
> quiescent states. This would disarm the deadlock initially reported
> against PID namespace exit.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  include/linux/rcupdate.h |  2 --
>  kernel/pid_namespace.c   | 17 -----------------
>  kernel/rcu/tasks.h       | 16 +++-------------
>  3 files changed, 3 insertions(+), 32 deletions(-)

LGTM. FWIW,

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


