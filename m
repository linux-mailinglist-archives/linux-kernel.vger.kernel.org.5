Return-Path: <linux-kernel+bounces-140192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD1E8A0CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9923328113E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476ED145FE6;
	Thu, 11 Apr 2024 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EH4GLPYB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D5D145B08
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712828433; cv=none; b=gxVyqVTXeBj+giUnn3Ktq1BFvwMcCHqWV0YEi4iAflLQ8jnG1DGZ88ZAHSE9dc3Rv/Ic30PmMIwkBqpwTPaRfjWo1+3u2OavcXfrpDAs7r6F9s0bak3Ftsv4KF9pdZenJRok0P3jd4TzsOYIqWMaLO9lBseZADP7kbAnUfJ4CD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712828433; c=relaxed/simple;
	bh=azO9wtV6llgdxAslyD4HARSVVta3ZzPnL/RhPI/orH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m58aghmw78Yqq/kRsiYyQlBRmAWB1VhTRvduT02YnXj15ciLJX1fL3bna8ki2EzbG0x/qEyXuDlB4U/j74xPOpsuP/nq7OkAjKmaBt3mr+xz/T2yyGeJYNjLRbj9LkJi/WkIxPUQB/Qy0LISoHKEIgG7iaNuVyHIfPosfzmLXDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EH4GLPYB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712828430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EmraJ1/O9LsKt0hu6c7bP8/lU6CtsirLWmswTT7M3Eg=;
	b=EH4GLPYBlpBMECP8CoRzhDJ37RBiMrDR4aqy5sILSrV/Nb5JhlZg+lZw6tHq0EhF/MSooC
	kMvagcLlE3YFFBXuT3SPoW70PQ9nf1bgXbgvi0YKSZJmKgzlMMbVXZP/6WPMSZmwlQZGjj
	ijPwaXmPv2zpqXbfaj3qu4HQaeo+QY4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-NDfhiVXhNJqRSFUu2Uapog-1; Thu, 11 Apr 2024 05:40:27 -0400
X-MC-Unique: NDfhiVXhNJqRSFUu2Uapog-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3909C104456D;
	Thu, 11 Apr 2024 09:40:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.235])
	by smtp.corp.redhat.com (Postfix) with SMTP id 83B30C28102;
	Thu, 11 Apr 2024 09:40:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 11 Apr 2024 11:39:00 +0200 (CEST)
Date: Thu, 11 Apr 2024 11:38:51 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Edward Liaw <edliaw@google.com>,
	Carlos Llamas <cmllamas@google.com>, kernel-team@android.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests: timers: Fix posix_timers ksft_print_msg
 warning
Message-ID: <20240411093851.GB5494@redhat.com>
References: <20240410232637.4135564-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410232637.4135564-1-jstultz@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 04/10, John Stultz wrote:
>
> After commit 6d029c25b71f ("selftests/timers/posix_timers:
> Reimplement check_timer_distribution()") I started seeing the
> following warning building with an older gcc:
>
> posix_timers.c:250:2: warning: format not a string literal and no format arguments [-Wformat-security]
>   250 |  ksft_print_msg(errmsg);
>       |  ^~~~~~~~~~~~~~

..

> -	ksft_print_msg(errmsg);
> +	ksft_print_msg("%s", errmsg);
>  	return -1;

Thanks,

Oleg.


