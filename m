Return-Path: <linux-kernel+bounces-150290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A83478A9CE5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D91285978
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8528016C840;
	Thu, 18 Apr 2024 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7SucZRs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE2A16C6A4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450015; cv=none; b=JY/mV0HMYRFEVuO4RYfpU5DjrPeZxyTpmVpwI4E46c6Uu8FYFZZ7okPj3cQ6eunOrbf9V4oPqUMUr7iv6OipcjFNTFyZyEF6wnMgoSIm/6xmusIQqXTBp6W6CCX1q+M+OZzsvkHdt5WbDBjYQp/mQkuIYTs1qeTLkrSBclTIg/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450015; c=relaxed/simple;
	bh=4bNa8afCH4lot+IghKymgJGbI+oGdAQXU26GVAG+67Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZGOnUD6BgyuwRpjabn5YwUuC19rxYMZqSHExMPeQHH/IlgGzzpCq3eIR7bxHIwGq3/KSVFFffNgubNmZ9bJd9mXvHbkB1Ha8gxIS2ODbsIWFYkBMg7cUmU0TKdDMaT8QBXzq0Zeo0o4xH0sUC7xubUew4ljryWOLNADoH6wfjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e7SucZRs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713450012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xzDmscmhNUUyb7+nP9/RYULiSYndJ+L0g8+7/DTmi+E=;
	b=e7SucZRsEtdy+JIv7IcdOs4xalC25DnD8zDCuxObybWhMxDv2K2Q+OwM9HHI8mq0hs2Q7g
	2/x9BLeWHScxI1UujHPVm7B0zb2pDK591E/uRQtRBXkRM6jqkhNBrsDyGOk6KMevau8CXk
	9c/EEoH5bj0E3zZZ7bwtKMme6Xxt4jY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-cwLkf_YmMUKceoMHpXgPAA-1; Thu,
 18 Apr 2024 10:20:05 -0400
X-MC-Unique: cwLkf_YmMUKceoMHpXgPAA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 089C41C3F10B;
	Thu, 18 Apr 2024 14:20:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.182])
	by smtp.corp.redhat.com (Postfix) with SMTP id 761E4200AD74;
	Thu, 18 Apr 2024 14:20:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 18 Apr 2024 16:18:38 +0200 (CEST)
Date: Thu, 18 Apr 2024 16:18:33 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [patch V2 23/50] signal: Remove task argument from
 dequeue_signal()
Message-ID: <20240418141833.GA19794@redhat.com>
References: <20240410164558.316665885@linutronix.de>
 <20240410165552.381760138@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410165552.381760138@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 04/11, Thomas Gleixner wrote:
>
> The task pointer which is handed to dequeue_signal() is always current. The
> argument along with the first comment about signalfd in that function is
> confusing at best. Remove it and use current internally.
>
> Update the stale comment for dequeue_signal() while at it.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  fs/signalfd.c                |    4 ++--
>  include/linux/sched/signal.h |    5 ++---
>  kernel/signal.c              |   23 ++++++++++-------------

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


