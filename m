Return-Path: <linux-kernel+bounces-110284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BD5885CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1841F2135A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6B912B17E;
	Thu, 21 Mar 2024 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NOYQ4dW4"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A9B1292C9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036351; cv=none; b=Bh9mc3yPR5h2cnsbq76qd8aw0F0ZTAW0P42UKEexIm7yrxBhycQ9qQOhGia+nQVOwFRSPnZbocmgGI26C/SIV0AUJRmK4APkdzkcxJqsNrmFBY0+rkcAP+azl7RJ+U0Dv8WS42rwf3+PBROO525ZkxL8zxlYGC8te9HRvzVJTio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036351; c=relaxed/simple;
	bh=vO+59LF2DNwWH2sqIy5zoxEXnKGofXS98o6iGB9I1VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayEAOGevtF1PTRPYruEw9obPInFqinQeSAF7yFi0GA0mMCxLWbulBn3UbEcBpAyBr/ue6p+AKY50Gtgdbz3mMYQy7buYQfZ4hfKiDHxxXZIzw6J198V2j1IuGJzUrGjdooYFdr5jtTovr1ZrS6364JGd/JAoPoSSS1J8EhzB0MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NOYQ4dW4; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <53b2df23-d5ea-498b-a501-b64f753c0074@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711036347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2reTOytJMh5foizD5SWaFSRwZSD2WulrWEB+iTZT+JA=;
	b=NOYQ4dW4Jm1mvANK62WuzMcS2fhb/Cz2mmzJ6a6obOy1x/zCVi9iJrokRVLaSp8ymgicJ1
	O6pMTLiEF44xOjsTQyjS+MmwWPUCZNd03HfTM5NOEg2IrOMCX1fxtfG4WlkkRLr97b3OSz
	rk28k0t9IEvkCpxUQqE2T71VIEfM5Ro=
Date: Thu, 21 Mar 2024 11:52:23 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/8] drm: zynqmp_dp: Don't retrain the link in our IRQ
Content-Language: en-US
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Michal Simek <michal.simek@amd.com>, David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 linux-arm-kernel@lists.infradead.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
References: <20240319225122.3048400-1-sean.anderson@linux.dev>
 <20240319225122.3048400-6-sean.anderson@linux.dev>
 <ca4de45b-302c-4eea-bd6b-8c04e2ed89cb@ideasonboard.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <ca4de45b-302c-4eea-bd6b-8c04e2ed89cb@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/20/24 02:53, Tomi Valkeinen wrote:
> On 20/03/2024 00:51, Sean Anderson wrote:
>> Retraining the link can take a while, and might involve waiting for
>> DPCD reads/writes to complete. This is inappropriate for an IRQ handler.
>> Just schedule this work for later completion. This is racy, but will be
>> fixed in the next commit.
> 
> You should add the locks first, and use them here, rather than first
> adding a buggy commit and fixing it in the next one.

I didn't think I could add the locks first since I only noticed the IRQ
was threaded right before sending out this series. So yeah, we could add
locking, add the workqueue, and then unthread the IRQ.

>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> Actually, on second look this IRQ is threaded. So why do we have a
>> workqueue for HPD events? Maybe we should make it unthreaded?
> 
> Indeed, there's not much work being done in the IRQ handler. I don't know why it's threaded.
> 
> We could move the queued work to be inside the threaded irq handler,
> but with a quick look, the HPD work has lines like "msleep(100)" (and
> that's inside a for loop...), which is probably not a good thing to do
> even in threaded irq handler.
> 
> Although I'm not sure if that code is good to have anywhere. Why do we
> even have such code in the HPD work path... We already got the HPD
> interrupt. What does "It takes some delay (ex, 100 ~ 500 msec) to get
> the HPD signal with some monitors" even mean...

The documentation for this bit is

| HPD_STATE	0	ro	0x0	Contains the raw state of the HPD pin on the DisplayPort connector.

So I think the idea is to perform some debouncing.

> Would it be possible to clean up the work funcs a bit (I haven't
> looked a the new work func yet), to remove the worst extra sleeps, and
> just do all that inside the threaded irq handler?

Probably not, since a HPD IRQ results in link retraining, which can take a while.

> Do we need to handle interrupts while either delayed work is being done?

Probably not.

> If we do need a delayed work, would just one work be enough which
> handles both HPD_EVENT and HPD_IRQ, instead of two?

Maybe, but then we need to determine which pending events we need to
handle. I think since we have only two events it will be easier to just
have separate workqueues.

--Sean

