Return-Path: <linux-kernel+bounces-137341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC7089E0D3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF9D284504
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9812C15380D;
	Tue,  9 Apr 2024 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WE/VmO/l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B5013A267
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681567; cv=none; b=QWv3p0I9uBAF5xmY82R3GarECf8Lt/jsg0R7+5TcnjiDy2u5ANP1+Y2j65jpFnOB2WzyR9IV9re3qXY9ekT72Z99JLwS0wBk5IUi1ckFuWXdrJ21oFdx4KwnWnWf5dU3QVvtWVban/PXg8iPhImoz4gS7AhwkFAJm2KGumRdRPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681567; c=relaxed/simple;
	bh=j2Y+94KbsbY7acQxdTX6z539hRaKkg/fO5uMKEch7SU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o0OJF6+9isDR+H5hTUmVsZilXcJVFMlGIWgZk3Okq9RjaJioxYBJY+7Nm2bw+Xw3NNnik/f/fzA5rGMHog5JxRxulWeqcGHQXsxPhvwQeFPa/gmxzqfgSVzGu4sO7gaDbq4yVWQ+gHskYjiwfM5PvnQGwRDiM4r+UIIQ/FET1EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WE/VmO/l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712681565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+NKidzKW/DTvBc1tQ8E4kYeb8ojdS1p5BOYrq1bKV6k=;
	b=WE/VmO/lSgEB8sVWrgRnbqY+oMv95WvOVRD7Jt52twwg4sPiPbN9eXhp+pa9mj78nIZYGO
	9Go4efK6gXuA8mvvvBjo5DAEV0TWctW1GaWWJKr2kQ0kEF9PFkS3f06VmYTH3jU8oEEd95
	hAQ1G1FeZH+PYMSmd45otwjlTCZFSkc=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-Omczv-P3MNKVA1LM5H_T3Q-1; Tue, 09 Apr 2024 12:52:43 -0400
X-MC-Unique: Omczv-P3MNKVA1LM5H_T3Q-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-4d40305ddb3so1289282e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 09:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712681563; x=1713286363;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+NKidzKW/DTvBc1tQ8E4kYeb8ojdS1p5BOYrq1bKV6k=;
        b=YqFPAJoSOWKpT1CoN4F8NoI1cZHlYULpgmC/XqMzSUhu4oZk8r/0cZtoAtKKb6MtXk
         tTPINaxrktibOPABkNos0ryHKWLIA8MaEtYjOUTKbnObgijTjge42doDV0aHs3AsfbQy
         W4nnSJ4dDJUtiqpl/ZUsThUeaegu2wnNDi4sV50kTJp95ZIUECofeLA3szS6HOEBO/hq
         fL8XCUDvVQx52WoIiCMy82x4Nvj90YQubqDg6/kmXCmiuZxw6vIOnoKHKWDeRr+b/0kT
         SUpkVRk7w8qpz9tO42SMJJG5xMjSUzSeu1eJJomGOYE/k9RDGEzMldFsSKNSvtX3xWG5
         jabg==
X-Forwarded-Encrypted: i=1; AJvYcCVu8cZo3II0goE6COaaHDMqhKzRyyWPzS+YwzhOQY8tS+yFPbIe5PIRAlAKI0GZx6EQW1DQL0BNkHQ4em+aMLLrBFwmxxxC2PENP81A
X-Gm-Message-State: AOJu0YxdHrOXjv2Smq7qI3ji6D0lF5jifoaWzitUOUjI+ET9PkXIQb/r
	/hYPvAjHgRoZkynmJiNRBzhzMMCf1TavCty2j4taebzKDdfwFgpOs57Nt8I4wdllj0lemRlm2j2
	iBBxn53MZ1gh5DmbHPM6KHc+SKpicAgz0G8b2I4dqV230sGsduhesl9QmUk04Jg==
X-Received: by 2002:a05:6122:90c:b0:4d3:4ac2:29f4 with SMTP id j12-20020a056122090c00b004d34ac229f4mr484247vka.2.1712681563217;
        Tue, 09 Apr 2024 09:52:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE40zvLEF0ZBb59hoel0B1fp7t336yp12pBAvKmKmGFQvM2VaoTV61WKM8Kbw1z3qCiHsrz9Q==
X-Received: by 2002:a05:6122:90c:b0:4d3:4ac2:29f4 with SMTP id j12-20020a056122090c00b004d34ac229f4mr484208vka.2.1712681562863;
        Tue, 09 Apr 2024 09:52:42 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id fe4-20020a0562140b8400b00698facb19d5sm4093118qvb.106.2024.04.09.09.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 09:52:41 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Connor O'Brien <connoro@google.com>, Joel Fernandes <joelaf@google.com>,
 Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Youssef
 Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, Daniel
 Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul
 E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, Xuewen
 Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, John Stultz
 <jstultz@google.com>
Subject: Re: [RESEND][PATCH v9 5/7] sched: Consolidate pick_*_task to
 task_is_pushable helper
In-Reply-To: <20240401234439.834544-6-jstultz@google.com>
References: <20240401234439.834544-1-jstultz@google.com>
 <20240401234439.834544-6-jstultz@google.com>
Date: Tue, 09 Apr 2024 18:52:36 +0200
Message-ID: <xhsmh34rua36z.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 01/04/24 16:44, John Stultz wrote:
> From: Connor O'Brien <connoro@google.com>
>
> This patch consolidates rt and deadline pick_*_task functions to
> a task_is_pushable() helper
>
> This patch was broken out from a larger chain migration
> patch originally by Connor O'Brien.
>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Qais Yousef <qyousef@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Zimuzo Ezeozue <zezeozue@google.com>
> Cc: Youssef Esmat <youssefesmat@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Metin Kaya <Metin.Kaya@arm.com>
> Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: kernel-team@android.com
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> Signed-off-by: Connor O'Brien <connoro@google.com>
> [jstultz: split out from larger chain migration patch,
>  renamed helper function]
> Signed-off-by: John Stultz <jstultz@google.com>


