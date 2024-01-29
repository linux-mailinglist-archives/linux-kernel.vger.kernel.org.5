Return-Path: <linux-kernel+bounces-43407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828A0841371
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE1028A6AC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4D9657A8;
	Mon, 29 Jan 2024 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5tNszZV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1DC4C637
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556437; cv=none; b=gYZWP4EfjMGIGZDbMYCJDz4NS6KPMH1yzGVHKl6MPxbElwLxZA08TxbF3aWtV31gNTKQcXsJFDL5azp7aYuEqIoehYwYXeDZwYnYZiTDUHaIR2GJu+7BHtmTnaFwtgwYJf5LjDRhadN3UCUWsKAX4wnrIbKbwDF0KT3dhRCBEyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556437; c=relaxed/simple;
	bh=5bZskXGQ0jfrMSSDC5uZCp869pKyT+/gw6vmr10wqB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=YqoyrkMPv43F3qM9qK3t9BFuySszh8Ms3JyJsN/jBfmUs1Yx2nAW6EOa7NKllyp17YbSVdVexYZ5d1qqTADptNvAqYcK38SEZYT791YBLa31eV57dQlLD3+ibCMzaUB027FP30x5Hj4wWAkDLS5bJHOuqbTFr6QZE3UPz/fjVU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5tNszZV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706556434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcB13Ws5ITW4j3Ksvky6I24v6iNlRk+OZKw84teW+XM=;
	b=U5tNszZVgYkfsGV+BdyVSFbrXog5w1TccMU9DIgk3EagWxnX+Xn2As5KxcuJeAOw+7QUSs
	eOv/dDFvY+8bY8jiElxaO1xtcZ4AkBNyqmHloqptf4smNdtByCT4YkkG4GxCxn7njLXnfr
	qEUigO5MOx2/FZAUJFLXxWKp7EXmi94=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-3ghIsIl-NOyOVoWalGWu8A-1; Mon, 29 Jan 2024 14:27:12 -0500
X-MC-Unique: 3ghIsIl-NOyOVoWalGWu8A-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1d8cff976a9so7766245ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:27:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706556431; x=1707161231;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcB13Ws5ITW4j3Ksvky6I24v6iNlRk+OZKw84teW+XM=;
        b=QvKOUv5vN686SW1hUG3nOKxvcGm4yjwRQdTL+vNSDBmdwKbzGBjKc7I02BeT61vSLy
         B5qhSerRE2hLADy3p8y0jVyWETYFK1Ahlxuz6ARh48Io5CEOHGAPWfw3aHtT8FdMMMhM
         0/7Gd1RzyfomTBkNWdyp17CwoYg8CJNb5EjYWabftB2Z8/aaOX2QUH9hIMVB3/XLsdrX
         xPCOaSmnRSe+zHGPNj/PAdsEO+N5H50u/0xuFxf5fLK9AMijAsbIxuSkFgPztWX61IqU
         c3bA7dUxCILpfC06UT0+A5XiFVnoBWwtXgJMaD8jvqzuULMy59FV3XDPYJwW367/mLAS
         qbmQ==
X-Gm-Message-State: AOJu0Yw97u0klSSzcgmebVS/Kr4VK73dTzjfAUwLCBwYCFLsVNzDXfMG
	buTZnJwk0NMIBXZJsQS8rhJnd0h6H4HMUqLLPxBaHWEjiQyrijTgW2k2GQKdsLtkS0VuYksGgTU
	olK3JZc7eVdvs/HfLyTQ1c1XHP9DXOrm24t1BuCUMASredRcSYauaOrsqXluXWA==
X-Received: by 2002:a17:903:2306:b0:1d8:8f4d:4d15 with SMTP id d6-20020a170903230600b001d88f4d4d15mr3754214plh.17.1706556431655;
        Mon, 29 Jan 2024 11:27:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwIbziEfElU//WKCaof7xs7huJJ3bAWVrza33UwPuE1Ye6yCd/a2oCgZe4h+bYoZwzTEdwPQ==
X-Received: by 2002:a17:903:2306:b0:1d8:8f4d:4d15 with SMTP id d6-20020a170903230600b001d88f4d4d15mr3754204plh.17.1706556431345;
        Mon, 29 Jan 2024 11:27:11 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a803:e70d:8905:313f:9514:fada])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902c78900b001d8d6c1fcafsm2732025pla.163.2024.01.29.11.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 11:27:10 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] wq: Avoid using isolated cpus' timers on unbounded queue_delayed_work
Date: Mon, 29 Jan 2024 16:26:57 -0300
Message-ID: <Zbf8AVZaXwmExroX@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Zbfr52x97-tLP66t@slm.duckdns.org>
References: <20240126010321.2550286-1-leobras@redhat.com> <ZbQozqY9qOa4Q8KR@slm.duckdns.org> <ZbQsr1pNSoiMbDrO@LeoBras> <Zbfr52x97-tLP66t@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jan 29, 2024 at 08:18:15AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Jan 26, 2024 at 07:05:35PM -0300, Leonardo Bras wrote:
> > > 	if (housekeeping_enabled(HK_TYPE_TIMER)) {
> > > 		cpu = smp_processor_id();
> > > 		if (!housekeeping_test_cpu(cpu, HK_TYPE_TIMER))
> > > 			cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
> > > 		add_timer_on(timer, cpu);
> > > 	} else {
> > > 		if (likely(cpu == WORK_CPU_UNBOUND))
> > > 			add_timer(timer, cpu);
> > > 		else
> > > 			add_timer_on(timer, cpu);
> > > 	}
> > > 
> > > Thanks.
> > 
> > I am not really against it, but for me it's kind of weird to have that many 
> > calls to add_timer_on() if we can avoid it. 
> > 
> > I would rather go with:
> > 
> > ###
> > if (unlikely(cpu != WORK_CPU_UNBOUND)) {
> > 	add_timer_on(timer, cpu);
> > 	return;
> > }
> > 
> > if (!housekeeping_enabled(HK_TYPE_TIMER)) {
> > 	add_timer(timer);
> > 	return;
> > }
> > 
> > cpu = smp_processor_id();
> > if (!housekeeping_test_cpu(cpu, HK_TYPE_TIMER))
> > 	cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
> > 
> > add_timer_on(timer, cpu);
> > ###
> > 
> > What do you think?
> 
> Isn't that still the same number of add_timer[_on]() calls?

Yeah, sorry about this, what I meant was: If we are ok on calling 
add_timer_on() multiple times, I would rather go with the above version, as 
I think it's better for readability.

> 
> Thanks.

Thank you for reviewing!
Leo

> 
> -- 
> tejun
> 


