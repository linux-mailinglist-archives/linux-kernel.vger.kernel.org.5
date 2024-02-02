Return-Path: <linux-kernel+bounces-49716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B25F846EA2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 945EDB29A32
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3940B13DBAF;
	Fri,  2 Feb 2024 10:56:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594C7199C7
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871417; cv=none; b=OkUa3/AtYCewLj4vsIIwvKOKsVO5TWcGJD4a+xGTPjbHP+jgmQb1zB3vyKaRTG3q1n3wJkQArjG87/7OplkBdIXV3wZoFO4n3qYdnwAIspCPeKt45Xx4kuu2SkswWdbB5wAesE8mBB03y/3YyV3uDqsWjyVzpCDMf42aRzpoaQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871417; c=relaxed/simple;
	bh=UhmxrKkpaIwAPkg2ey4m3RwDio87j4qiq2Bw8ceoDqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxxRkoq+Ol1YzY/btvMBErS7WFqOURK8u2HyKARHphniFSUyuFgRRKqJos/doWnYZx2k94WRRxS7eAS2DYiAaplIWl3aVBOkVH9HzzjKz6cxtsWi21pXcicRfEys8BX05YHsOeVh9tV1jLa8+Hyee20xUyTeTlsbn+dLYMcaQag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2B1EDA7;
	Fri,  2 Feb 2024 02:57:36 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1895D3F738;
	Fri,  2 Feb 2024 02:56:52 -0800 (PST)
Date: Fri, 2 Feb 2024 10:56:50 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Pin-Chuan Liu <flash.liu@mediatek.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	wsd_upstream@mediatek.com, cylen.yao@mediatek.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] firmware: arm_scmi: Avoid to call mbox_client_txdone
 on txdone_irq mode
Message-ID: <ZbzKckIhn8HQv5pW@pluto>
References: <20240201095754.25374-1-flash.liu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201095754.25374-1-flash.liu@mediatek.com>

On Thu, Feb 01, 2024 at 05:57:52PM +0800, Pin-Chuan Liu wrote:
> On txdone_irq mode, tx_tick is done from mbox_chan_txdone.
> Calling to mbox_client_txdone could get error message
> and return directly, add a check to avoid this.
> 
> Signed-off-by: Pin-Chuan Liu <flash.liu@mediatek.com>

Hi Pin-Chuan,

thanks for this, it was indeed sort of on my todo-list too, to allow MHUs
equipped with Tx-Ack IRQ to work with SCMI.

Having said that, this looks good to me in general, my only pain points
are: the fact that we have to peek into the controller structures to know
how it is configured, BUT I wouldn't know how to do it in any other
way in fact as pof now...; and the fact that there is a constant runtime
conditional check for each message sent even though the tx_ack irq presence
can be detected once for all at setup time, BUT even this is not easily
solvable as of now in the SCMI stack.

So, after all of this babbling of mine, I would say that  your patch is fine
as it is, also because it is easy to backport; next week when I am back I'll
give it a go on a couple of platforms and get back to you with a proper
review/test.

Thanks again !
Cristian

