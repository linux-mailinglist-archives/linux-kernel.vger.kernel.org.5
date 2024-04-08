Return-Path: <linux-kernel+bounces-135225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE7C89BD17
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B64F1F228BB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9793537E8;
	Mon,  8 Apr 2024 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXHoeFux"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9185D52F7E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572100; cv=none; b=Po6OZgr/S/9GiJksFWnRY9f8Fub8mCrkUKoXuZiQcq6yLx9br1QrYuviUbymF/xd01DyjK4+5NzQn+bpH0h1KnOR9/Ijp+sIao3E/4wHIh4KOk0fnhrEWaUUIN0OYtL6hmLw95g7zqZLhfMCnxoc5c8NjTEKNEnntLTk0uZ0vw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572100; c=relaxed/simple;
	bh=6a0a1WjW79c7b2kHhlwJtsBrCzJPwJXkLVW5NplQJfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Glo5LdqXmBIXPhWMMbe23baQHiQaW1LG51av6qRB6xnahk9ITQoeOZXplUo9HSjkJQiQxeVppmAfs6I3E+FzAL5iTDmo6u9K3Zq4DVfab+D0C7RlMQ7Z6B8XMdjeVPjxLdsoru8Y64DyfsElHJRBrm6LSjPvWSSJoqTOwxtOTH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXHoeFux; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712572097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yVwuBF0GMcngCoZS7e29Q9IFctmXTtqweEvVhF9yYKQ=;
	b=ZXHoeFuxMiaLmPs2SUgS3Uc9yyd4ddpnMHbLTENQUMID3rOpmSoqcmyxhd2o+fh8GXIpQ8
	BBBkXpYQdce8UgDVKMqIUnm1r/SHbzRDShQE6SmT9ThVcae8DhDcVJT0zNA+mNjqesm5R/
	uEmBOeuVlmW+6aIxt9CSIsiEizFj0ns=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-cRvw7A-sN3iP_MupvctXnA-1; Mon,
 08 Apr 2024 06:28:14 -0400
X-MC-Unique: cRvw7A-sN3iP_MupvctXnA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C8FD29AC007;
	Mon,  8 Apr 2024 10:28:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.180])
	by smtp.corp.redhat.com (Postfix) with SMTP id 290AF10061E0;
	Mon,  8 Apr 2024 10:28:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  8 Apr 2024 12:26:47 +0200 (CEST)
Date: Mon, 8 Apr 2024 12:26:39 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
	Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kasan-dev@googlegroups.com, Edward Liaw <edliaw@google.com>,
	Carlos Llamas <cmllamas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] selftests/timers/posix_timers: reimplement
 check_timer_distribution()
Message-ID: <20240408102639.GA25058@redhat.com>
References: <87r0fmbe65.ffs@tglx>
 <CANDhNCoGRnXLYRzQWpy2ZzsuAXeraqT4R13tHXmiUtGzZRD3gA@mail.gmail.com>
 <87o7aqb6uw.ffs@tglx>
 <CANDhNCreA6nJp4ZUhgcxNB5Zye1aySDoU99+_GDS57HAF4jZ_Q@mail.gmail.com>
 <87frw2axv0.ffs@tglx>
 <20240404145408.GD7153@redhat.com>
 <87le5t9f14.ffs@tglx>
 <20240406150950.GA3060@redhat.com>
 <20240406151057.GB3060@redhat.com>
 <CACT4Y+Ych4+pdpcTk=yWYUOJcceL5RYoE_B9djX_pwrgOcGmFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Ych4+pdpcTk=yWYUOJcceL5RYoE_B9djX_pwrgOcGmFA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 04/08, Dmitry Vyukov wrote:
>
> >
> >         if (ctd_failed)
> >                 ksft_test_result_skip("No signal distribution. Assuming old kernel\n");
>
> Shouldn't the test fail here? The goal of a test is to fail when
> things don't work.

I've copied this from the previous patch from Thomas, I am fine
either way.

> I don't see any other ksft_test_result_fail() calls, and it does not
> look that the test will hang on incorrect distribution.

Yes, it should never hang.

Thanks,

Oleg.


