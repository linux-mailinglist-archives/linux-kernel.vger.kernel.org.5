Return-Path: <linux-kernel+bounces-135842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7837989CBFE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358022823EC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE921448EE;
	Mon,  8 Apr 2024 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CsXNuZaM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BC2433BD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602318; cv=none; b=mdbExRKWT1PD+S8qbBZMOjQHPd/h0aIvqwHDmcZedZkQbh3yEExfChZDJBxJb/niXnhNHllWdFodSEEIqxzlHEn+36XI+F27O0NbAXVHkSq9T7ydyp2xxMa5H99zQcC1Sh+V4WhD4XydEunTzlm66/L5YPkonchDWP/1wFVRn1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602318; c=relaxed/simple;
	bh=KxP9VvzkBIh/ITMiBM/OmZA5vpjjIbNabDqh1TmLwoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbnMMghQIA9jHNDm1T5XkitlLVqNcSBkPijvoDIlvrYPjqbdHVN/0VJVmOKOAu1A7v57AyRboWHpOeHURSvbvZD9++JovKoZ+fjDtOzZm5zjEK0iRk+vmT7nCaQDDBmtJ+yGRk6THYJsRJvkycnBE/4MyjMuqQmQWxcwAZSjxH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CsXNuZaM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712602316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8dFnN+DVwM1sWsRYbzV9b0Y7Yoo7FUCyFFFRTCNFqQ=;
	b=CsXNuZaMrYx7gReBOWKpFUhANc5yFKYzS09DHRf4jZLUxP/hDOWtmNzxNIabu5M8XAXhOD
	7EevQ1Oxt1iz4SmuQf3EmFJGPQ6d13hdh3fzEU1dCLcm9530HpXnLw/+f4cyeduZs2V8aB
	GQWY9WAJjKWGzLZW9a8QSGeG6PlnAg4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-aQW-xCk8MX2eTz_blcr48A-1; Mon, 08 Apr 2024 14:51:47 -0400
X-MC-Unique: aQW-xCk8MX2eTz_blcr48A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE1D1802CA7;
	Mon,  8 Apr 2024 18:51:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.180])
	by smtp.corp.redhat.com (Postfix) with SMTP id DD1B3489;
	Mon,  8 Apr 2024 18:51:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  8 Apr 2024 20:50:21 +0200 (CEST)
Date: Mon, 8 Apr 2024 20:49:57 +0200
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
Message-ID: <20240408184957.GD25058@redhat.com>
References: <CANDhNCoGRnXLYRzQWpy2ZzsuAXeraqT4R13tHXmiUtGzZRD3gA@mail.gmail.com>
 <87o7aqb6uw.ffs@tglx>
 <CANDhNCreA6nJp4ZUhgcxNB5Zye1aySDoU99+_GDS57HAF4jZ_Q@mail.gmail.com>
 <87frw2axv0.ffs@tglx>
 <20240404145408.GD7153@redhat.com>
 <87le5t9f14.ffs@tglx>
 <20240406150950.GA3060@redhat.com>
 <20240406151057.GB3060@redhat.com>
 <CACT4Y+Ych4+pdpcTk=yWYUOJcceL5RYoE_B9djX_pwrgOcGmFA@mail.gmail.com>
 <20240408102639.GA25058@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408102639.GA25058@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 04/08, Oleg Nesterov wrote:
>
> On 04/08, Dmitry Vyukov wrote:
> >
> > >
> > >         if (ctd_failed)
> > >                 ksft_test_result_skip("No signal distribution. Assuming old kernel\n");
> >
> > Shouldn't the test fail here? The goal of a test is to fail when
> > things don't work.
>
> I've copied this from the previous patch from Thomas, I am fine
> either way.
>
> > I don't see any other ksft_test_result_fail() calls, and it does not
> > look that the test will hang on incorrect distribution.
>
> Yes, it should never hang.

Forgot to say...

To me this test should simply do

	ksft_test_result(!ctd_failed, "check signal distribution\n");
	return 0;

but I am not familiar with tools/testing/selftests/ and I am not sure
I understand the last email from Thomas.

I agree with whatever you and Thomas decide.

Oleg.


