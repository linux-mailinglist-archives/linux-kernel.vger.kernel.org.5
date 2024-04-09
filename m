Return-Path: <linux-kernel+bounces-137296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 652F589E019
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EEFA1F24E7A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DEF13D8B7;
	Tue,  9 Apr 2024 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoH/D2oG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E0513D885
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679156; cv=none; b=eJshlrfIRLYlAOQONprFV33Tc3ONkGM3YMCnw/OwPLy+Y4zkA+LVOGoLeIkvhVc+9fPr5YTfJoSaCYMo82wxRJOFVHTP4ODL3mTLKVeHoRfrJ7n8xMdakChPw/NWZFp1lnOFT5Dt0N9Fabmos9/cElhIGJPFZijWiUQctjW2EQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679156; c=relaxed/simple;
	bh=iokGLwsqJfb4NxRhk5ow1oSNlqc6dGVX7cO8ljBDKSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eSP3MsjJ4euPOHeGiwLatatSU25KFtdTysuwgO6HruslGzWDqc8n1ccrXeI3kJVBxi89aA5KBkQfOXojFKrs32GXWiFfxv/dtEd3CvxU1CmYpIo7NyiYuFHLwpDL3Na1cN04h+QE9eIA1BfmTvXGIB0f3ddhxWgFG+90ccedcPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WoH/D2oG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712679153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iokGLwsqJfb4NxRhk5ow1oSNlqc6dGVX7cO8ljBDKSA=;
	b=WoH/D2oGLu96Zo9Fcoxmffuaw5W2KJkrvYBuO4L+B0qYxp0P26BHr9z7Tm1xd5nrDUx0c+
	W4ZyYVTI9CxKDQseLVoLRACYgxgN5cotdZgR8EMQiYHBoSq10mLQIN2DrnQIH9qIBGOQ5A
	CQLxB/sTod0y4BAa9HWYgDyFHTgUH/c=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-t_zNaTyMPImZj4I4rJbpNQ-1; Tue, 09 Apr 2024 12:12:32 -0400
X-MC-Unique: t_zNaTyMPImZj4I4rJbpNQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-69a011f3069so48631216d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 09:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712679152; x=1713283952;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iokGLwsqJfb4NxRhk5ow1oSNlqc6dGVX7cO8ljBDKSA=;
        b=eFoMz+N9CF3w0iaYKlHWS0nR3KfD/SDVOOxiRZZ95axtMmPweY12FLht5lQ8DHQlaC
         oGx4aqTx/E0g5OUaSIjC088QtSNb5gzCi0Ztb+tj/9RjnV7UIn2yXOUBZMFleJs9XnAU
         5IqG7CXQY/EEH7HEcHNlSodhIfjW7jAXSp5qFo2I4UiDSqzknHtzmnif5/FbFO/4HNpU
         1wdaRSGnJ+jXp4D/E0pJVOsEXgXv3at2O3vDV+SXXiXF9Yhj7trofVvzkVd5zEjRJgqS
         ltStbNANMZk2ztMuEf8QIMJNmY81imewl0lFPzig+L3EFoBqfDBIpjSMKGNtPlyAudTU
         N0zg==
X-Forwarded-Encrypted: i=1; AJvYcCUVyrmMvnqKxC0phNRgeFROLnrOEB6uCWDGYyyej3BCkQ04xxrrXqV9EnGuvMLzlUKIhDRfPGlW7ftpYkEXCJAEYkiVf/pGw0R4l7Fo
X-Gm-Message-State: AOJu0YxcCOfpzCuVKt1dB8wmcg9smq/VECX2J+pWYwGma1kC8m+E1bIL
	vbIIwelRF69YfRNomGBYZv2yj5CDr5r84cnGo+1+wjno5vQh5VUY4HahNqGOpo8/kY1tGxIgayi
	HRyNYJJJW4oUFl46uzKlPd5AnmjZik9+i1vyNxc7MfyxZThSIbhZCBhVcLDkeqw==
X-Received: by 2002:a05:6214:aa8:b0:69b:f01:6fbb with SMTP id ew8-20020a0562140aa800b0069b0f016fbbmr4689376qvb.22.1712679151778;
        Tue, 09 Apr 2024 09:12:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG93zhGMVddyGB46z5gVtmxtUIAOe63e/8vzI7DtDyZWQ1wYJNVu71Eew4ofejY6k77HYYMrg==
X-Received: by 2002:a05:6214:aa8:b0:69b:f01:6fbb with SMTP id ew8-20020a0562140aa800b0069b0f016fbbmr4689326qvb.22.1712679151462;
        Tue, 09 Apr 2024 09:12:31 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id bp9-20020a05621407e900b00699376bcc9fsm4115136qvb.123.2024.04.09.09.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 09:12:30 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
 Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat
 <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de
 Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long
 <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, Xuewen
 Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, Connor
 O'Brien <connoro@google.com>, John Stultz <jstultz@google.com>
Subject: Re: [RESEND][PATCH v9 2/7] locking/mutex: Make mutex::wait_lock irq
 safe
In-Reply-To: <20240401234439.834544-3-jstultz@google.com>
References: <20240401234439.834544-1-jstultz@google.com>
 <20240401234439.834544-3-jstultz@google.com>
Date: Tue, 09 Apr 2024 18:12:26 +0200
Message-ID: <xhsmha5m2a51x.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 01/04/24 16:44, John Stultz wrote:
> From: Juri Lelli <juri.lelli@redhat.com>
>
> mutex::wait_lock might be nested under rq->lock.
>
> Make it irq safe then.
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

> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> [rebase & fix {un,}lock_wait_lock helpers in ww_mutex.h]
> Signed-off-by: Connor O'Brien <connoro@google.com>
> Signed-off-by: John Stultz <jstultz@google.com>


