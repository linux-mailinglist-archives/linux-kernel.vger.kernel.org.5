Return-Path: <linux-kernel+bounces-65411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CE4854C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE391F2A120
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC445CDC0;
	Wed, 14 Feb 2024 15:21:41 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258845D8F5;
	Wed, 14 Feb 2024 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924101; cv=none; b=lDrNm5QmHH0PIrNLekuOSkGsKgIS+iPX2Vj3WB3uAoH3uIhvDAjuJK/ZHwmjdETxs6KC6dXjP1kV4Ir4vD+ueR138fNblnkzKg56Y+xTLVzYJ0RRWUA61SXGQHwTlKiCZLrNgaNB2M2SLDq8cDCZzKOmIg66QYYFbc9doOuH57o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924101; c=relaxed/simple;
	bh=Y5qNsyPZ7LB9EL5+p5aaf86e06gBU3/WclTD7Z63ijk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCFQXSHxs/2cM9wjN/TWrd8Su+8BcrKX/sG+Bubdy2fo/WklPFBK2OOvMCIfcRo33tWwARrdptjEe07yVJVlrRzwWs50Vjj2KzfMBa9ktJpDFTlE9+GtK5Dn0ts8kwK1FNy8rSrTYj5Byoc84fk+Smgj0IkJHJP0W3ZFacHx3EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5770BC433C7;
	Wed, 14 Feb 2024 15:21:39 +0000 (UTC)
Date: Wed, 14 Feb 2024 10:23:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ira Weiny <ira.weiny@intel.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Smita
 Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] acpi/ghes: Prevent sleeping with spinlock held
Message-ID: <20240214102310.7ba53f3a@gandalf.local.home>
In-Reply-To: <20240214121153.00005c97@huawei.com>
References: <20240206-cxl-cper-smatch-v2-1-84ed07563c31@intel.com>
	<20240214121153.00005c97@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 12:11:53 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> So I'm thinking this is a won't fix - wait for the printk rework to land and
> assume this will be resolved as well?

That pretty much sums up what I was about to say ;-)

tp_printk is more of a hack and not to be used sparingly. With the right
trace events it can hang the machine.

So, you can use your internal patch locally, but I would recommend waiting
for the new printk changes to land. I'm really hoping that will be soon!

-- Steve

