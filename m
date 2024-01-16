Return-Path: <linux-kernel+bounces-27662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2128F82F3D2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472711C238FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4FA1CD34;
	Tue, 16 Jan 2024 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XThYApht"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4821CD31
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428745; cv=none; b=NcjCNhQaGhhk8ia0xd9L9JkDmpdls3B+5643B/5RparYwaKV/kctxOqlrBhDFgHrkfqxzYasIM1GJOG4aLv3X+dUIBz2pKQMGPKhzjeQ1vlwjWni49XTEShzVGYhkxbZUyZmtXkzAfOMky1I4sQ4hQ7z66mP7P0mROS9KLgYGms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428745; c=relaxed/simple;
	bh=MzloDO27ZW8iHVaQfONrrD83ZThr7ywLNoiZklqYLQg=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent:
	 X-Scanned-By; b=W3wcwV/+4Z5mTtGT08b9RVnKp4zKvUKIOXHhBeXa752wzsWtaezg2cIYqFw4WowWzBRJMWbaQzr6XaV4lPUzDIpuza4LUYFO46ydUatN3EZfybzVN2gXtHdcxA5vjrrXppZRAUJTcx9m2pZwLdKRTKwe7VL+60jpyp/uI4pmtkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XThYApht; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705428743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MzloDO27ZW8iHVaQfONrrD83ZThr7ywLNoiZklqYLQg=;
	b=XThYAphtO5oC09pqbVpprFoMhGx3c1EwR8767fSji683MpUfwWcHRyDfvu1SJS0ytupayG
	SFI+I/fQQuYw6QSLfG0qsmrp8LFppZ/H7f7rvTh7P78jGxnGRi2ag6TePGUsUaoJC7HAsM
	9kPP4O+k+VuHvNKeQY8ZvS3PmWdzAzM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-7HYs3mdCN72aoZUinQmBcQ-1; Tue, 16 Jan 2024 13:12:17 -0500
X-MC-Unique: 7HYs3mdCN72aoZUinQmBcQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E26F8493E6;
	Tue, 16 Jan 2024 18:12:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.96])
	by smtp.corp.redhat.com (Postfix) with SMTP id 647A41BDB0;
	Tue, 16 Jan 2024 18:12:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 16 Jan 2024 19:11:03 +0100 (CET)
Date: Tue, 16 Jan 2024 19:10:59 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Onkarnarth <onkarnath.1@samsung.com>, frederic@kernel.org,
	quic_neeraju@quicinc.com, joel@joelfernandes.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, r.thapliyal@samsung.com,
	maninder1.s@samsung.com, tj@kernel.org, peterz@infradead.org
Subject: Re: [PATCH 1/1] rcu/sync: remove un-used rcu_sync_enter_start
 function
Message-ID: <20240116181058.GB12342@redhat.com>
References: <CGME20240111092805epcas5p2ebb993010ae31d039e8f9de1e7818f7c@epcas5p2.samsung.com>
 <20240111092722.322454-1-onkarnath.1@samsung.com>
 <de792eee-1f44-48e2-a122-c3ded1645155@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de792eee-1f44-48e2-a122-c3ded1645155@paulmck-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 01/16, Paul E. McKenney wrote:
>
> On Thu, Jan 11, 2024 at 02:57:22PM +0530, Onkarnarth wrote:
> > From: Onkarnath <onkarnath.1@samsung.com>
> >
> > With commit '6a010a49b63a ("cgroup: Make !percpu threadgroup_rwsem
> > operations optional")' usage of rcu_sync_enter_start is removed.
> >
> > So this function can also be removed.
> >
> > Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> > Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

Acked-by: Oleg Nesterov <oleg@redhat.com>



For the record, this was already discussed, see
https://lore.kernel.org/all/20220725121208.GB28662@redhat.com/

Note also the patch in this message, __rcu_sync_enter(wait => false)
is a better alternative if someone needs rcu_sync_enter_start() again.

This patch probably makes sense anyway. Not only cgroup_favor_dynmods()
can use __rcu_sync_enter(), freeze_super() can use it too to avoid
3 synchronize_rcu()'s in a row.

Oleg.


