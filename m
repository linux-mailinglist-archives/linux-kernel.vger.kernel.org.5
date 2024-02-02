Return-Path: <linux-kernel+bounces-49891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760F18470FE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317A728740C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CB146425;
	Fri,  2 Feb 2024 13:19:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F79D1773D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879994; cv=none; b=n6WYkuOiSI/fdHY/21C0p9wWLUZhd9fFTj8eBb5qvk3HATyTBifVcIT0XtUneYwc+Wnbf6/kyDDcoAnvpVBWGBHQHJh+CSfeUAJ4FiaFOnQICMYIeXkyNPRwWZY2dw/134AjmTaGUmEPDHHpRKZtemRHYYaUiCYll6wHWFYwCxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879994; c=relaxed/simple;
	bh=oZHUavBtNPdmVsPG9WWBLfxVsvO5hsWg0lk+25BOilg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXg/OjcrT7nvlEJ4Ewb4TjhEyZ9RF/xn/2pqQxT5O8ulxAlmGreNzhhl+VATTO/wWBFNUOuYWX5si5qBktn0DWRkZRnNLkeEyjEy16O25m/ZcrMhYBQSShxdNxIn3i/0+pwP/iZSTOAn7JSE1xxp8dTIZYNtrJHjbWuo20PIDWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1rVtSC-0004Gn-EC; Fri, 02 Feb 2024 14:19:44 +0100
Message-ID: <13f53836-b1f8-4e2a-a3df-80b60102d396@pengutronix.de>
Date: Fri, 2 Feb 2024 14:19:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Boot-time dumping of ftrace fuctiongraph buffer
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
References: <d33e5271-219d-4b8e-be5a-8903219d7fd6@pengutronix.de>
 <20240201204637.2afab2db@gandalf.local.home>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20240201204637.2afab2db@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello Steve,

On 02.02.24 02:46, Steven Rostedt wrote:
> On Thu, 1 Feb 2024 13:21:37 +0100
> Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>> For this to be maximally useful, I need to configure this not only at boot-time,
>> but also dump the ftrace buffer at boot time. Probe deferral can hinder the kernel from
>> calling init and providing a shell, where I could read /sys/kernel/tracing/trace.
> 
> OK so the driver is built in.

Yes. The modules are easy, because I will have an access to shell by then
on my systems.

>> I found following two mechanisms that looked relevant, but seem not to
>> do exactly what I want:
>>
>>   - tp_printk: seems to be related to trace points only and not usable
>>     for the function graph output
>>
>>   - dump_on_oops: I don't get an Oops if probe deferral times out, but maybe
>>     one could patch the kernel to check a oops_on_probe_deferral or dump_on_probe_deferral
>>     kernel command line parameter in deferred_probe_timeout_work_func()?
>>
>>
>> Is there existing support that I am missing? Any input on whether this
>> would be a welcome feature to have?
> 
> Well you can start function_graph on the kernel command line and event
> filter on a give function
> 
>  ftrace=function_graph function_graph_filter=probe_func

Ye, that's what I am doing, but I was stuck on actually outputting the log
at boot time.

> You can add your own ftrace_dump() on some kind of detected error and put
> that in the kernel command line. For example RCU has:
> 
>   rcupdate.rcu_cpu_stall_ftrace_dump=
> 
> Which will do a ftrace dump when a RCU stall is triggered.

Ah, thanks for the pointer. I take this as meaning that there is no builtin
way to dump on arbitrary function return. I will see if it's possible with
bootconfig before looking into adding a probe deferral specific kernel
command-line parameter.

Thanks,
Ahmad

> 
> -- Steve
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


