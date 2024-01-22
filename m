Return-Path: <linux-kernel+bounces-33629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E46A836C79
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A911C2579A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03C360DF2;
	Mon, 22 Jan 2024 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GkQ+KH9u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C401E60DDC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705938703; cv=none; b=ZmM8x7viu1FMwokyWmxFVACHhHTxIssg86KGIvQri84ZEiTjz5VeVR7e1R8nThne/v5SvwW3xIUAY25vNXR09BmWGdkiNwUwfjEJyqzFFWMlVJyBsb9+ckr4H6BYWSti64gEygvtEn5Fv4WKFfYla0qOqJZ+SFy8xJwgxwM5er0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705938703; c=relaxed/simple;
	bh=gNgSY7sQ/cryH2DH25H1X6wmZ7bJL/OuzyuB3hWtsNI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PTbR8UDRB9U5Tcrq3OdVcfV6WJBBl/go6CdrZaYC96vSR4XS6IXgeVIKmuDTUqLl+TuWOr9d2VtMGg+7jSJxyLQ8JcsTctrU+imKmoptA2J3r8MUEFpsxtoxluxVuZ6yMPfe/1uShns3561oEvOAQ+yOT5wxpqUNzliswbbBl+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GkQ+KH9u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705938700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=CJbFZnFVE0k9sLXl6WCeQPUBH9kz6oFaPydheeALry0=;
	b=GkQ+KH9upMXP5O7xOxAXFFb7+ZY+5tDMcNKi5wt2W9gQbc80N/7LTaked5VQTuGQ36rhmZ
	0hk0s8R412nQyS+zWzsdHedff61ZM0LyuEpjxD6/vnhv7w3jxuMsFgTiuOxexUCT3YUIg0
	CP88Vl8wDV8JlPAr1o0cu1rmDo9PBfM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-bxwumBEdMMCGfgN4KiHJ6Q-1; Mon, 22 Jan 2024 10:51:39 -0500
X-MC-Unique: bxwumBEdMMCGfgN4KiHJ6Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D884985A58B;
	Mon, 22 Jan 2024 15:51:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.26])
	by smtp.corp.redhat.com (Postfix) with SMTP id C2CC851D5;
	Mon, 22 Jan 2024 15:51:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 22 Jan 2024 16:50:25 +0100 (CET)
Date: Mon, 22 Jan 2024 16:50:23 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Dylan Hatch <dylanbhatch@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] getrusage: use sig->stats_lock
Message-ID: <20240122155023.GA26169@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Andrew,

this series replaces

	getrusage-move-thread_group_cputime_adjusted-outside-of-lock_task_sighand.patch
	getrusage-use-sig-stats_lock.patch

in mm-nonmm-unstable.

The patches are same, I only tried to improve the changelogs as we discussed.

Dylan, do you have something to add?

Oleg.


