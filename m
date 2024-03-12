Return-Path: <linux-kernel+bounces-100575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A14879A40
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366F51F21431
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBD813A883;
	Tue, 12 Mar 2024 17:06:10 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08FF13A868;
	Tue, 12 Mar 2024 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263170; cv=none; b=g+SpK7iT5S/1kFszMBrVgFgP5NtAjRUMNpgaQ1p3XfZKaqglsIq4aeR2mz5RXA8EhVD7RnkD1KuKIvEthdAWhZeeia+Naqe0ie5OLyG1Z2yVIaGk8ThWl7ZcQSbyP9Gu/hV8Wuy0biXMkVQiT8tFffZNhby0jzHtkf60BOwI4hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263170; c=relaxed/simple;
	bh=idgAQMXJKPF4HCVM9XW5bm7ejrX4/AFEN2rYgN7+R1A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hA9ZZpvohCMHZAF/+4fJUPN94Mmw1hOwynkUDjs+ITy6VyyfkiLRipgCI3N23LKoYWlNsFKrRdZj5dlNkIMCoy94NO2YZiMJ/nkQzANh78KyqlXe1AJXIqMhsRRXM0yDiceVb/USOpQYnHU5WtbZA9P57vAVPikkxDOCjNq08L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id E34C540AB1; Tue, 12 Mar 2024 10:06:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id E264E40A97;
	Tue, 12 Mar 2024 10:06:06 -0700 (PDT)
Date: Tue, 12 Mar 2024 10:06:06 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Catalin Marinas <catalin.marinas@arm.com>
cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
    Mark Rutland <mark.rutland@arm.com>, 
    "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <vireshk@kernel.org>, 
    Will Deacon <will@kernel.org>, Jonathan.Cameron@huawei.com, 
    Matteo.Carlini@arm.com, Valentin.Schneider@arm.com, 
    akpm@linux-foundation.org, anshuman.khandual@arm.com, 
    Eric Mackay <eric.mackay@oracle.com>, dave.kleikamp@oracle.com, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, linux@armlinux.org.uk, robin.murphy@arm.com, 
    vanshikonda@os.amperecomputing.com, yang@os.amperecomputing.com, 
    Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
In-Reply-To: <9352f410-9dad-ac89-181a-b3cfc86176b8@linux.com>
Message-ID: <bf1757ca-6d41-87e7-53dd-56146eef5693@linux.com>
References: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org> <CGME20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f@eucas1p1.samsung.com> <c1f2902d-cefc-4122-9b86-d1d32911f590@samsung.com> <Ze9TsQ-qVCZMazfI@arm.com>
 <9352f410-9dad-ac89-181a-b3cfc86176b8@linux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 11 Mar 2024, Christoph Lameter (Ampere) wrote:

> This could be an issue in the ARM64 arch code itself where there maybe an 
> assumption elsewhere that a cpumask can always store up to NR_CPU cpus and 
> not only nr_cpu_ids as OFFSTACK does.
>
> How can I exercise the opp driver in order to recreate the problem?
>
> I assume the opp driver is ARM specific? x86 defaults to OFFSTACK so if there 
> is an issue with OFFSTACK in opp then it should fail with kernel default 
> configuration on that platform.

I checked the ARM64 arch sources use of NR_CPUS and its all fine.

Also verified in my testing logs that CONFIG_PM_OPP was set in all tests.

No warnings in the kernel log during those tests.

How to reproduce this?


