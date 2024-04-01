Return-Path: <linux-kernel+bounces-127184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F356E8947D2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94AE01F22953
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4F557300;
	Mon,  1 Apr 2024 23:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KhaRwQ+z"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AAAC139;
	Mon,  1 Apr 2024 23:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712014766; cv=none; b=QT2PA+0/eeBQu7cJtNLTNB6OvtwEfykJXm1EfOGFZ43eoRpXkGsh/kRfbuBnancQGwpJrLdA1ApUeKh7FXoQzLaroOFoqy+2svKMNXrZC0h70UgyTq+3CvyOl5EocuiXzu7dzd5M5hizymg6pdMagTJqRIqQPnpIMfUCuMxI5YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712014766; c=relaxed/simple;
	bh=qDL79W4tDRSoCxziPmtQJDLHj5eXaeFBf36CANPZYOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XxDK6y7afTFNN1QBQfvGVu4oC34wZ5wAWExtmt6WanNUwfagdZTdHIgR6ORZH7FBIRKBdAGmNPFiD9m/dKZWglZJ0NtKT93nnYO9OH7r3UiQDkMIx5y714yEEltTAxOCY005HgW2DNuGGlyHQTOJz5fM9TIVRuOU3PeI4uYXKmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KhaRwQ+z; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 431NdKDh129217;
	Mon, 1 Apr 2024 18:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712014760;
	bh=KJec4Lr4hS/3zoW/qDar4/1YlvfzINb6rbydkKiyH4E=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=KhaRwQ+z38nUV3md7+zGyORisTOSw5HWQ5FjwmZfFXgCAkpfpygf7SYFqEdFXWdC2
	 WI9V2IzZWKSAdSvHcUdxgUcMGu0u8AKvnVuLiNf04LC/4TL930dMnR0+aKZ/7RpuiD
	 sYUwchQaEKHeuEtORnfhmg++cy4ES5WDEXXDuL90=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 431NdKmu087524
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Apr 2024 18:39:20 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Apr 2024 18:39:21 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Apr 2024 18:39:21 -0500
Received: from [10.249.48.175] ([10.249.48.175])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 431NdKCO095046;
	Mon, 1 Apr 2024 18:39:20 -0500
Message-ID: <761aa56f-55c4-e0d4-9f75-eef8035aa25b@ti.com>
Date: Mon, 1 Apr 2024 18:39:20 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 13/13] mailbox: omap: Remove kernel FIFO message queuing
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Jassi Brar <jassisinghbrar@gmail.com>,
        Nick
 Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu
 Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240325172045.113047-1-afd@ti.com>
 <20240325172045.113047-14-afd@ti.com>
From: Hari Nagalla <hnagalla@ti.com>
In-Reply-To: <20240325172045.113047-14-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 3/25/24 12:20, Andrew Davis wrote:
> The kernel FIFO queue has a couple issues. The biggest issue is that
> it causes extra latency in a path that can be used in real-time tasks,
> such as communication with real-time remote processors.
> 
> The whole FIFO idea itself looks to be a leftover from before the
> unified mailbox framework. The current mailbox framework expects
> mbox_chan_received_data() to be called with data immediately as it
> arrives. Remove the FIFO and pass the messages to the mailbox
> framework directly.
Yes, this would definitely speed up the message receive path. With RT 
linux, the irq runs in thread context, so that is Ok. But with non-RT 
the whole receive path runs in interrupt context. So, i think it would 
be appropriate to use a threaded_irq()?

