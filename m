Return-Path: <linux-kernel+bounces-136730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8391D89D7A9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68B871C236D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F74085C59;
	Tue,  9 Apr 2024 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FcCQOh3h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F33F1E885
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712661168; cv=none; b=FyUTq7ZnsS4Kb4Jr8eq+xirYQqHInP0xry7KhaO+dtBoFDVMEMbPqWC9udXpUNllcseIcoFjPn4zs7I4HOugHiIk32egkACS1gLBhsognEU4045Pu/qI9CbYCAYIKhKk0jXqsqZ5qD0hd63GqC4LYdRn4L/nHXfB4MjF3dAj4iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712661168; c=relaxed/simple;
	bh=5IHeNi8OymAQFbI+jNsuhBZ3ynbYcnFKx8ZYuNMcYX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zdz75x4/3sMtlD8tRCDkf5r6NJn3CBjwJxj5+LHGWBwErs4a56MQM9fjFL84KGbz3VT1nR4b/Oyunh2P6XT/Et4viFtYRmQ3x99sE0LTpLoqpkUl9cfcooZh90jseOgDTHjY/ZZGjLuD9fpXpdRfX7YcPbYIsCykJGVIAyy9w20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FcCQOh3h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712661165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WHx3oMFq8PtDxKa6+YzeOhtGXt27WMV38UwSpfqK1lA=;
	b=FcCQOh3hUPNYEKV5C1C45ZsdbNiBF3GAZMu8OY9rUUmTqorBLqxvUwlrA7huDM7cC9HE6O
	VL8lZr91S3iSrHdOmlGyZ/qdpese6H15MnM9mA8iRu6u0exJ8YECb770xkPpF9F682uvm+
	y+qB6tELt+buTWwRDdy9WyBTul24tjU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-KwcDvaYCNkWlpBEde6-CnA-1; Tue, 09 Apr 2024 07:12:42 -0400
X-MC-Unique: KwcDvaYCNkWlpBEde6-CnA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4135104B502;
	Tue,  9 Apr 2024 11:12:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.56])
	by smtp.corp.redhat.com (Postfix) with SMTP id 8D73647F;
	Tue,  9 Apr 2024 11:12:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  9 Apr 2024 13:11:15 +0200 (CEST)
Date: Tue, 9 Apr 2024 13:10:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Vyukov <dvyukov@google.com>, John Stultz <jstultz@google.com>,
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
Message-ID: <20240409111051.GB29396@redhat.com>
References: <CANDhNCreA6nJp4ZUhgcxNB5Zye1aySDoU99+_GDS57HAF4jZ_Q@mail.gmail.com>
 <87frw2axv0.ffs@tglx>
 <20240404145408.GD7153@redhat.com>
 <87le5t9f14.ffs@tglx>
 <20240406150950.GA3060@redhat.com>
 <20240406151057.GB3060@redhat.com>
 <CACT4Y+Ych4+pdpcTk=yWYUOJcceL5RYoE_B9djX_pwrgOcGmFA@mail.gmail.com>
 <20240408102639.GA25058@redhat.com>
 <20240408184957.GD25058@redhat.com>
 <87il0r7b4k.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il0r7b4k.ffs@tglx>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 04/09, Thomas Gleixner wrote:
>
> The discussion started about running new tests on older kernels. As this
> is a feature and not a bug fix that obviously fails on older kernels.

OK, I see... please see below.

> So something like the uncompiled below should work.

Hmm... this patch doesn't apply to Linus's tree...

It seems that this is because in your tree check_timer_distribution() does

	if (timer_delete(id)) {
		ksft_perror("Can't delete timer");
		return 0;
	}

while in Linus's tree it returns -1 if timer_delete() fails. Nevermind.

Thomas, I am almost shy to continue this discussion and waste your time ;)
But ...

> +static bool check_kernel_version(unsigned int min_major, unsigned int min_minor)
> +{
> +	unsigned int major, minor;
> +	struct utsname info;
> +
> +	uname(&info);
> +	if (sscanf(info.release, "%u.%u.", &major, &minor) != 2)
> +		ksft_exit_fail();
> +	return major > min_major || (major == min_major && minor >= min_minor);
> +}

this looks useful regardless. Perhaps it should be moved into
tools/testing/selftests/kselftest.h as ksft_ck_kernel_version() ?

> +static int check_timer_distribution(void)
> +{
> +	const char *errmsg;
> +
> +	if (!check_kernel_version(6, 3)) {
> +		ksft_test_result_skip("check signal distribution (old kernel)\n");
>  		return 0;

..

> +	ksft_test_result(!ctd_failed, "check signal distribution\n");

Perhaps

	if (!ctd_failed)
		ksft_test_result_pass("check signal distribution\n");
	else if (check_kernel_version(6, 3))
		ksft_test_result_fail("check signal distribution\n");
	else
		ksft_test_result_skip("check signal distribution (old kernel)\n");

makes more sense?

This way it can be used on the older kernels with bcb7ee79029d backported.

Oleg.


