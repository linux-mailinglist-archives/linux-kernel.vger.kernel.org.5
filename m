Return-Path: <linux-kernel+bounces-92186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAA1871C60
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FA32B24C8C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABD45BAD9;
	Tue,  5 Mar 2024 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Srfs5U+l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E6B5BACD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635872; cv=none; b=lf87Hkqp6vbm5+yakji3pUZzdmIgH7H9csrpSyiVKECHUL81cm3VUzqY6M6NgWjkPq6lhUWwDSm8P7OdiIpmFAZ3Qsqt4RbGs0uxgAxLbZxATpGnH+Wo3ZTqJfd3rfDrvTCOngBV6WUv1Y+ho8v97seKF8ufA2lEG4vBLdS3in0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635872; c=relaxed/simple;
	bh=uuGTQUXuFaXOzh/wQ2s7/ejrNxx+FQKVmJeanhHVZwE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EZkSpQEuhtysFFK27aFVfE89lbf0GDZC6ebJRViPEfpBYLMe6PKuT2zgeXyPX9/mAtVMK/0CYdoIAQeM75+Pi/Dye8g/sFxgkE2f2MfuLn/zVfZuUfsoTjH+Ynxls9opKc5GcU3oxpXX8AvXppvYNug3B3eH5lQuyEva73IWW8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Srfs5U+l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709635870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uuGTQUXuFaXOzh/wQ2s7/ejrNxx+FQKVmJeanhHVZwE=;
	b=Srfs5U+lPe/hXQ2Gn6/dLRmcqw0Ra9j7gr0G2dm5vzT+QhJxTNItb95s6MmCBVLGkBt6eJ
	uEWDh7XPC+fZp90L5V1GaSn3iwynSTpmBi5m4g1ORwGDdcTzWFsUUTWAEAJXgvIqiZOaVa
	ks4/FC5zdHB9tfiVdQotKfDJeavsUok=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-KQOIVjTNOdy-9mDYGkckjA-1; Tue, 05 Mar 2024 05:51:08 -0500
X-MC-Unique: KQOIVjTNOdy-9mDYGkckjA-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-59fdfc539aeso395726eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 02:51:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709635868; x=1710240668;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuGTQUXuFaXOzh/wQ2s7/ejrNxx+FQKVmJeanhHVZwE=;
        b=A4rdrhbrjzTWQjz/GjNGlzt1GWIJMPMfWk/V6GPD4TLMGP0EDenB1jwkWKNChXD/1Q
         wZNuXDtrzB9rVPSe745Hb9mFqoTTKIvjwQUPsjkCY0Ty9VM9LmffrnG+A/+VWGzWqFDS
         kfv1hnAoQ2x1jBRvRMt50dFDt/Ab9+UojIyPbP/tqq3PRz1NPT078JH9m1j49tOfNykC
         +VNn0/j48wEDytIyQz7bTtONBD5DTDxL2jl9AfLxGt59YbW+UxmAWQpYtjfNnWdf7db+
         bSXSGwZKuFob2AGxc5B+A2j0/CNQi73zL0Oct5cul/IdoBWh0qt/awX9TjBZ95R7XUKs
         KZHg==
X-Forwarded-Encrypted: i=1; AJvYcCUBwcGkiuSTYujOtyBnACJj+V5AOtfZJsNx+cT5PTkDYxBjUw7j+P3F79F6j2WOOMH1HiRT6oJL6foje/1I/P1OKEmgQZbmp0xK6iTL
X-Gm-Message-State: AOJu0Yyu2HwNMcVDXlx/vrTDSu8Dw4OEIy83aZnE01gHTrCwAcwO8TC5
	5XnhpzvNMpFabqu0RFQ2h4UjNdnyzQiqW1v9HfEQjQ6Yi8xXm4qvr7+vd98syqYpZF6eH3zwkn+
	V5ZyqfqQz0a5GWGUKPE9ImioEf6rHWlahg61qnKCi239Ex6onmZ7fRMRS6uVmlQ==
X-Received: by 2002:a05:6359:4c2a:b0:17a:f91c:825b with SMTP id kj42-20020a0563594c2a00b0017af91c825bmr1475818rwc.5.1709635868001;
        Tue, 05 Mar 2024 02:51:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvJYGUI2F46pCfqrxLnOgEJqyu/3ZHN9suULLOXKIpzgdiC6kaqBZVlMeyxj0XsZNWn6bF7g==
X-Received: by 2002:a05:6359:4c2a:b0:17a:f91c:825b with SMTP id kj42-20020a0563594c2a00b0017af91c825bmr1475813rwc.5.1709635867760;
        Tue, 05 Mar 2024 02:51:07 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id op8-20020a056214458800b0068fc5887c9fsm6091434qvb.97.2024.03.05.02.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:51:07 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Peter Zijlstra
 <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH 9/9] sched/balancing: Rename run_rebalance_domains() =>
 sched_balance_softirq()
In-Reply-To: <20240304094831.3639338-10-mingo@kernel.org>
References: <20240304094831.3639338-1-mingo@kernel.org>
 <20240304094831.3639338-10-mingo@kernel.org>
Date: Tue, 05 Mar 2024 11:51:05 +0100
Message-ID: <xhsmh7cihdk9y.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 04/03/24 10:48, Ingo Molnar wrote:
> run_rebalance_domains() is a misnomer, as it doesn't only
> run rebalance_domains(), but since the introduction of the
> NOHZ code it also runs nohz_idle_balance().
>
> Rename it to sched_balance_softirq(), reflecting its more
> generic purpose and that it's a softirq handler.
>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Valentin Schneider <vschneid@redhat.com>

Acked-by: Valentin Schneider <vschneid@redhat.com>


