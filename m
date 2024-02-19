Return-Path: <linux-kernel+bounces-71713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF1F85A95D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3716A286402
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF94C41C9D;
	Mon, 19 Feb 2024 16:53:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E97B446AD
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361629; cv=none; b=lfbNXu+1m0WzIP6vAnVFKTlfge8/JYxiPUOk2g44xrsW2K+/uYBhSEFbk23ontCkgSgo5H5uj8CJcuMQJsBfA6n4idpR/VJC+3Cc7o0pQqgRnlkDdErqObxHNPfiKy7rY96eJ263glCz/sE3R1Ils5zWcOyN5tjTPNvcSoEKsew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361629; c=relaxed/simple;
	bh=+gM62Fr0tlm9SVE1a+AAW8arOdXdkRf5wez0pQBjaPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PWqyguvypMh0YtLCNt5V6anz9wEtYrLF+Y9zk41JVwObeB1acTCmupbWDFDjwwy016rek1YddHrbOOUakipooJtwJuThP0AKTLcPcIPqdhXqNAzi4S22Ydu1aPf27/GF4JgkMBCQtcBq1pUC0kGyy18o50+9WJvZIftTxYNA7Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99C671007;
	Mon, 19 Feb 2024 08:54:26 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C8CB3F762;
	Mon, 19 Feb 2024 08:53:44 -0800 (PST)
Message-ID: <ff3204d6-aff8-4cc9-b21d-191eea2a45e7@arm.com>
Date: Mon, 19 Feb 2024 16:53:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Content-Language: en-GB
To: babu.moger@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>
References: <20240213184438.16675-1-james.morse@arm.com>
 <68983917-3f99-424e-8181-fbfae105dea6@amd.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <68983917-3f99-424e-8181-fbfae105dea6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 14/02/2024 15:01, Moger, Babu wrote:
> Sanity tested the series again on AMD system. Everything looks good.
> 
> Tested-by: Babu Moger <babu.moger@amd.com>


Thanks!

James

