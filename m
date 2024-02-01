Return-Path: <linux-kernel+bounces-48107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2470E845750
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F061C22D6D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C36915DBC3;
	Thu,  1 Feb 2024 12:21:48 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9926E15AAB9
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790107; cv=none; b=Ti1yIjdU8uv0a2OXyzy+lTtnOXG/dtTOy8IrKBiqAwIDByw8EMANv1SvTPynFCDLj7IF/UQgTvO3rfkQQLjluRUmko2ALQPgPZuyx8pz95q3Mahqf8P6Gk4jj9mDDJyqhdfHTBafeQTG1sERBikKySm7T3MOqN8yO1qOkuhC9TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790107; c=relaxed/simple;
	bh=vaLdbaLRwXVHsBkr/tc4RRKyddRu3QROiEgFWWQ1wcs=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=p3qZXTHCg8QQgdWLORiPkyuLYzTzR3oM3Ykm2DlEzF9TM1EX8hRCiR+4ehtyGguMTtzywATduh9jg+/fsQ9zErxok8Chy0yFpRX3qK8Pta/tQ1EiKz2w+yef8tNccZOMAHVc0HXsVxA4xdV3+JSFs3aQqmyfKck/g3vLi+x2uEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1rVW4X-0000w9-Vf; Thu, 01 Feb 2024 13:21:38 +0100
Message-ID: <d33e5271-219d-4b8e-be5a-8903219d7fd6@pengutronix.de>
Date: Thu, 1 Feb 2024 13:21:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
To: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Boot-time dumping of ftrace fuctiongraph buffer
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello,

I semi-regularly debug probe failures. For drivers that use dev_err_probe
rigorously, this is a quick matter: The probe function records a deferral reason
and if the deferral persists, deferred_probe_timeout_work_func() will print
the collected reasons, even if PID 1 is never started.

For drivers that don't call dev_err_probe, I find myself sometimes doing printf
debugging inside the probe function.

I would like to replace this with the function graph tracer:

  - record the probe function, configured over kernel command line
    (The device indefinitely deferring probe is printed to the console,
     so I know what I am looking for on the next boot)

  - Dump the function graph trace

  - See if the last call before (non-devm) cleanup is getting a clock, a GPIO,
    a regulator or w/e.

For this to be maximally useful, I need to configure this not only at boot-time,
but also dump the ftrace buffer at boot time. Probe deferral can hinder the kernel from
calling init and providing a shell, where I could read /sys/kernel/tracing/trace.

I found following two mechanisms that looked relevant, but seem not to
do exactly what I want:

  - tp_printk: seems to be related to trace points only and not usable
    for the function graph output

  - dump_on_oops: I don't get an Oops if probe deferral times out, but maybe
    one could patch the kernel to check a oops_on_probe_deferral or dump_on_probe_deferral
    kernel command line parameter in deferred_probe_timeout_work_func()?


Is there existing support that I am missing? Any input on whether this
would be a welcome feature to have?

Thanks!

Cheers,
Ahmad
    
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
 

