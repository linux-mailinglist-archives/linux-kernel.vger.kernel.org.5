Return-Path: <linux-kernel+bounces-135259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6613E89BE0A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C6D280FA1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA8B69D37;
	Mon,  8 Apr 2024 11:20:00 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E4C651AB;
	Mon,  8 Apr 2024 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575200; cv=none; b=nfUOMZkxpKyY0MWDNFEV0nY9OoldGjq43JWZJKZzXxVHmF+HTuVxAWBQWDprLJBcdPRWrsf9c4SyrGvBLz7cIWP0kRcGrVrO5/ARTkujQyvze35aS3leevZm0KRSmtH7qbJ6qFpqN4K34U4n7UAYtmLtMcvz3rtrEgukkdcJflY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575200; c=relaxed/simple;
	bh=wD+Fo20bnrhoPJfi7YZ187f/1U0jGmS8VTzoEFMI1NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDvSo5NDFNeE+rfgUqQ+ktPD0iJg/p5VAIXGbqlsIqv+yoPeJUEuhaFHf46lmsJthT0ZjKuVXfqBfOKVPlgdQiF4Z5DU3RxnFN81Hmx8BS+7NPxT3V7rANxwCqAEE4mYfUjt4JT89TOIBWRHZJj+0OWMLGuO2vc6vXt63H77RRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B7E8261E5FE07;
	Mon,  8 Apr 2024 13:18:53 +0200 (CEST)
Message-ID: <256fdb2e-9b83-4837-bd31-0c34e4267c31@molgen.mpg.de>
Date: Mon, 8 Apr 2024 13:18:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NOHZ tick-stop error: local softirq work is pending, handler
 #08!!! on Dell XPS 13 9360
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
References: <354a2690-9bbf-4ccb-8769-fa94707a9340@molgen.mpg.de>
 <87o7ak411y.fsf@somnus>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <87o7ak411y.fsf@somnus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Anna-Maria,


Thank you for your response.


Am 08.04.24 um 12:10 schrieb Anna-Maria Behnsen:

> Paul Menzel writes:

>> On Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022, with Linux 6.9-rc2+
>> built from commit b1e6ec0a0fd0 (Merge tag 'docs-6.9-fixes' of
>> git://git.lwn.net/linux) the external USB-C adapter Dell DA300 stopped
>> working (only the Ethernet port was used). Linux logged:
> 
> thanks for the report. Can you please provide a trace beside the dmesg
> output? The following trace events should be enabled (via kernel command
> line):
> 
> trace_event=timer:*,timer_migration:*,sched:sched_switch,sched:sched_wakeup,sched:sched_process_hang,irq:softirq_entry,irq:softirq_raise,irq:softirq_exit
Unfortunately I haven’t been able to reproduce it until now. Should it 
happen again, I am going to try your suggestion.


Kind regards,

Paul

