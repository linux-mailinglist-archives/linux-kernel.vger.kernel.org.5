Return-Path: <linux-kernel+bounces-63310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AACDA852D81
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F2F2839F7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC80623750;
	Tue, 13 Feb 2024 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U+Da2rWn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p1U5ZyxP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E606222EFB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818964; cv=none; b=ACEu0pio8PLIc9xZBVp0ml+RYLYGhxbIq2taXhrQU8FCoT3k4icW3/3D+2KIKeZLbikzB5+xA7cDDpM3M1ncM9bRcJ+7WiqoLK81Muy4tca40F7A4TMMVNwyeu5G3ilHpHav9NSfTa87NEq+lVxun9oR5HP7xqJmltyM4qJrD9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818964; c=relaxed/simple;
	bh=GphGXcfPeV1w271bwB6kiGkWJYOz7jfSvTvrlYgE2jY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BUmdFAh09k9MR2bsIw9kVxpIrisOy3k19iYPnhmSRdpmH754FaZX8QoL5J00yT+qzIkE+cqHqqGvQKeabPJePL59Z0PEbLP5OMEyzw1vQNLmoCSLd6zOAOF7saet0ORI9ToabhOmb60IgfhRODiBZPN5a0RGpXJL4yabEOP/r7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U+Da2rWn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p1U5ZyxP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707818961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r10Uy9ySRh0hzDZGejebhY55a1QrOEs0Pc+wu7+8ezI=;
	b=U+Da2rWn+XlWbUMFsbOkiy8/EDCRTdu/Zt9TtFMb0NzA6yGSsyGBpYnGbcSMZ1ulPmr5Kj
	Cfhw9WPLh50qQelEnJ3q9CdVefCjUeEiPvejMgxT1WY/o9gfkwqDgpbi43zY3iAAJyH+vK
	XnT4scjRWhi1CrGpimj4BnRtz6oW9sCVeKIPRgB8ygABslNW3U4YCQJ+yag9DvhICO63EF
	MPiVzh8B8cHHd6mmfr/BHFKizBnzHf7/XskkkAHNnwTsyG/71/dYgIVQm5yrN41j10tmL6
	8VhhdASX4a5MVWpFTVMRMLuFiqAG7jOdCTndLRgRnqQeczErva572xV/rSkUqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707818961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r10Uy9ySRh0hzDZGejebhY55a1QrOEs0Pc+wu7+8ezI=;
	b=p1U5ZyxPfubsoGlhytTtxb0wNNASHLV0lGVTRoRhPYlDm+FyaSncM9KjgDhk6+5OCeD9k8
	1ZtvlM67/z35RIBQ==
To: Chen Jun <chenjun102@huawei.com>, linux-kernel@vger.kernel.org
Cc: xuqiang36@huawei.com, chenjun102@huawei.com
Subject: Re: [PATCH] irqchip/mbigen: Fix incorrect null pointer check
In-Reply-To: <20240129130003.18181-1-chenjun102@huawei.com>
References: <20240129130003.18181-1-chenjun102@huawei.com>
Date: Tue, 13 Feb 2024 11:09:21 +0100
Message-ID: <874jecisku.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jan 29 2024 at 21:00, Chen Jun wrote:

That's not about an incorrect NULL pointer check. That's about using a
function which is guaranteed to return NULL on your platform, no?

> bus_get_dev_root(&platform_bus_type) always returns NULL.

Lacks an explanation why this always returns NULL.

Thanks

        tglx


