Return-Path: <linux-kernel+bounces-46579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0832E84418D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8AD1F247C8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3243082899;
	Wed, 31 Jan 2024 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c57hcCXE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D163983CA0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710406; cv=none; b=czhv8Ca/EnXDrGTAMpZp+o0ulyFWto+plGkxyE5T80J6oLsxOzBIUJ9rK9wK0oarUt/MwuQKRCjQMI6fQ/yZ3ODx9EcAfgxkopmBKUESX2d3ZkuGsETmJUd0M6cdbogJU4CGOmAx3vbdSjbIRQz9lp4jad6Fnj9vC+WPS1nBerk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710406; c=relaxed/simple;
	bh=SSgcJTAtCezKBIlSDqex7c15iUz3dD6SPXbEzwWDyYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrJGLwXMtZmGkhT/ld1Ja4ClMZRiIniYxdXh4IwHzuwYsWZuJwSWxm/DhwQSR4CQTdlAFlQGi5RknSdOCID8jeDCEPj3pG3hJJ+8MYBZfu7yX/d1BPRYrSrpwuDgUmrSIeCarQz15040acalCSfx0MQClRBL+j38s4jmCkzTXHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c57hcCXE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706710404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E6N7rRVRfH9o+RQBIxOXu8QZ0PlRxq4vDv7nz6/O5wk=;
	b=c57hcCXEZQLTWc4Eub9DyRpgILQ2zQXQVqsNLke3PktV9te48NgcWDVw6rPQO8sw691UQY
	qBgKn1s1yKCdnb4TI+kKrAqbCHJkQDrfOKifGsoLyNXnOVH6IacB+MMpdJBuO+cne8QV8x
	xFNvsOn8dAHjWyor01rH+TkWxQ9nmQ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-7TeHyjMQNrOVJm7QSFuhZA-1; Wed, 31 Jan 2024 09:13:22 -0500
X-MC-Unique: 7TeHyjMQNrOVJm7QSFuhZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6848185A59A;
	Wed, 31 Jan 2024 14:13:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.249])
	by smtp.corp.redhat.com (Postfix) with SMTP id 2C5313C2E;
	Wed, 31 Jan 2024 14:13:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 31 Jan 2024 15:12:06 +0100 (CET)
Date: Wed, 31 Jan 2024 15:12:04 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/1] pidfd: implement PIDFD_THREAD flag for
 pidfd_open()
Message-ID: <20240131141204.GA24130@redhat.com>
References: <20240131132541.GA23632@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131132541.GA23632@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Before I forget this...

After this patch we can easily add another feature, pidfd_poll()
can add, say, POLLHUP to poll_flags if the pid is "dead".

So the user can do

	poll(pidfd, { .revents = POLLHUP });

and it will block until release_task() is called and this pid is
no longer in use (pid_task() == NULL).

Do you think this can be useful?

Oleg.


