Return-Path: <linux-kernel+bounces-105648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0350887E209
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA301F23161
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE061EA7E;
	Mon, 18 Mar 2024 02:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8mNoV9v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9291DFC4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710727450; cv=none; b=e8IAXtIy4WYTZxAEOq+EsHLecBgj1d/YXO9IdVv1ecZZ3+X+gMRyXIaefMDgtKDxBpSF3pl0zgnd+fSfpS8YSinzlCe4sNp+6t3FzJLDFTXkqlx8zq08MpdJc5HfsljNk+Zx2IeQSfn0YLQz2H2Hyzz7aYzMi/ZPFpuZSShkxfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710727450; c=relaxed/simple;
	bh=KMhE6hRfM33NYruxr6jXiXcV+i8SnK1dqM7sqogpB8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uzLW1NGH5Hj7QXO591VTzcGsyCO1EbptmQOiB8EsAZKm9MWcJ/WrsH1JZvssNyQgNMrAfvHHyNpM8wF04FUml0DGVVoS6oniWyz94N2HbQHR8SiyarO1XXSKgKVVDlvf72OJbz1pjmswYCS0tV4k/QPv123B+2BbaGdwanSL0xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8mNoV9v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710727447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KMhE6hRfM33NYruxr6jXiXcV+i8SnK1dqM7sqogpB8c=;
	b=R8mNoV9vCsCwF05gL3GyQNm5uhAWM6lq6je/f3wXKtc+ufZYErBtMGlOJPfeyIhA3XId6H
	LkF+/rGgkVFJps6Tr+OOknU6orr6LGdTqpxhHedkNA1XygRz4HLC1kjgI+TPsXcUCGIbkO
	Dhf0dfauT6eLw1dfzNtiG1Vd7mGbOZ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-VUS2bJ61OaqivXocvzhSQQ-1; Sun, 17 Mar 2024 22:04:00 -0400
X-MC-Unique: VUS2bJ61OaqivXocvzhSQQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DEE80858DB6;
	Mon, 18 Mar 2024 02:03:59 +0000 (UTC)
Received: from [10.22.8.101] (unknown [10.22.8.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E4ED73C20;
	Mon, 18 Mar 2024 02:03:58 +0000 (UTC)
Message-ID: <e0d1b16a-2880-4e3f-b3ca-b0b47494014a@redhat.com>
Date: Sun, 17 Mar 2024 22:03:38 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/tsc: Use topology_max_packages() to get package
 number
Content-Language: en-US
To: Feng Tang <feng.tang@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, paulmck@kernel.org,
 rui.zhang@intel.com, linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
References: <20240315112606.2248284-1-feng.tang@intel.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240315112606.2248284-1-feng.tang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1


On 3/15/24 07:26, Feng Tang wrote:
> Commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC
> on qualified platorms") was introduced to solve problem that
> sometimes TSC clocksource is wrongly judged as unstable by watchdog
> like 'jiffies', HPET, etc.
>
> In it, the hardware package number is a key factor for judging whether
> to disable the watchdog for TSC, and 'nr_online_nodes' was chosen as
> an estimation due to it is needed in early boot phase before
> registering 'tsc-early' clocksource, where all none-boot CPUs are not

"none-boot"? You mean "non-boot". Right?

Other than that, the patch looks reasonable to me.

Thanks,
Longman



