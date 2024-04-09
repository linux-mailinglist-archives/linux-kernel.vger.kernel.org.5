Return-Path: <linux-kernel+bounces-137297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B53F89E058
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE8AFB2E8B3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D6513D885;
	Tue,  9 Apr 2024 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fq3V/XDS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF2113D88B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679166; cv=none; b=UYpnsNcp2x/jNYniPEHllo2p24EObRdLuHjLIwMTCYu+f1kgRTDXzn84GT+DtIm5LSSa9aBGBaMf9fD9Bpo6M/HrxsbNdP7oHMJOciYdST7EvOFVjsz1fnviktLaWDkHK8IrDbuJzsaT1ZKZqbXCq+nrq+nh2T3jyNAHyKE+/Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679166; c=relaxed/simple;
	bh=wBQ/k1TOPC9twkZwrHPSVSAu5Zyocw5w5p2CJBNa7T8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B1890HZBZT65ITV80n7oQPxecQuboyfk0fjn4nErc7mDg5ACYGnaJaW4r96ZlnidnsRG2XhlX9YHc08BibooxwM+WJOQwD07KL+C+hKVczJUR3+NbYZq9GZNRrbbRW6NCc1BI/xnA9U56dzGR6r1/xEhChwc9byLoUCqszRRcvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fq3V/XDS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712679163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wBQ/k1TOPC9twkZwrHPSVSAu5Zyocw5w5p2CJBNa7T8=;
	b=fq3V/XDSNp67PgxjfhemHf0V3zvLER9U4YliL3baAHcu1G98ID6fdQ5iepRH3TXXqRSNpz
	mnWY9jtsv55qYHs5GDThDjvqOViXlx8GTYFe9kOSNb2n0RI72QAvDrUWrMzdqzvFTfRWJj
	wEDgSkQ7M0VyGpLXHSdcHXmjjAoWI8A=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-tiH82RWAN_CkTKqG1wEKPA-1; Tue, 09 Apr 2024 12:12:42 -0400
X-MC-Unique: tiH82RWAN_CkTKqG1wEKPA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6993edda019so54815136d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 09:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712679162; x=1713283962;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBQ/k1TOPC9twkZwrHPSVSAu5Zyocw5w5p2CJBNa7T8=;
        b=Xjj5TsJxYPf6D/frxWMGh+qeMABkwxOWwr8z9lH3diP5yhofK5WvqUrKnEwFptRsm1
         Eqovm9fnLU3EV/nCOHr2Udcm0AK2pR15OLZcSkb6llY3PcAllwXf/Z3do8uEBBMk1e2H
         udOKC83cTaWbJdn9ZsXuVG5UpJfi/YkV5DPBqh73Zfwten5RV/G8wLw3rHQQDG5aDDhv
         BSM90p2ZdjYr8hfju268m2oIkKOQXteH+6oO9Cd70lv0mcpHo0aNDVDkzNYh08mH/v2G
         5ocrCPRfrQ6OH8llh30sMk/kjZ+YOLS5nW4LzGosILMcs2I5X+aIi79CHTvB0wJVIuKf
         ptGA==
X-Forwarded-Encrypted: i=1; AJvYcCUVlvwJgq2DTydpc2ArYm15GphE4+ZLD9sCl9tJSmES+DRB5/R4BpE089Tm+f04nDo07z0llh/ue97TPKfkdP4Qa73bBLuKRpqgEh2/
X-Gm-Message-State: AOJu0YxptfNtU1ds9rKSBZkfRUyJt8mcC43oi+JMBGyZZBZlgFK/MmMA
	sHOS6D9X2yVemzlqEFiounY+t9E7/aCDYZPBZGe7cWecIMMt1W0yFRLgGXZPWK3U45HHucuyhbY
	XG63iRy3ctpz0TZ2R9UyH1OHGutgRv80L1sG1FahJW20ud5h++VDbDZOCmNlxnA==
X-Received: by 2002:a05:6214:cc9:b0:699:2d17:e7dd with SMTP id 9-20020a0562140cc900b006992d17e7ddmr14901219qvx.50.1712679162222;
        Tue, 09 Apr 2024 09:12:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwuAWktawPIcE64Y+ERtnPe34vG6fpA8uXZ+zhZYxat9HMrJRg7UNwPcGyjDASvDsajMspVQ==
X-Received: by 2002:a05:6214:cc9:b0:699:2d17:e7dd with SMTP id 9-20020a0562140cc900b006992d17e7ddmr14901188qvx.50.1712679161960;
        Tue, 09 Apr 2024 09:12:41 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id b14-20020a0cfb4e000000b0069b17d0f07esm2187974qvq.96.2024.04.09.09.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 09:12:41 -0700 (PDT)
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
 Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, Valentin
 Schneider <valentin.schneider@arm.com>, Connor O'Brien
 <connoro@google.com>, John Stultz <jstultz@google.com>
Subject: Re: [RESEND][PATCH v9 3/7] locking/mutex: Expose __mutex_owner()
In-Reply-To: <20240401234439.834544-4-jstultz@google.com>
References: <20240401234439.834544-1-jstultz@google.com>
 <20240401234439.834544-4-jstultz@google.com>
Date: Tue, 09 Apr 2024 18:12:36 +0200
Message-ID: <xhsmh8r1ma51n.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
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
> Implementing proxy execution requires that scheduler code be able to
> identify the current owner of a mutex. Expose __mutex_owner() for
> this purpose (alone!).
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
> [Removed the EXPORT_SYMBOL]
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Connor O'Brien <connoro@google.com>
> [jstultz: Reworked per Peter's suggestions]
> Signed-off-by: John Stultz <jstultz@google.com>


