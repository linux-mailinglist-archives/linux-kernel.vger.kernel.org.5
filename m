Return-Path: <linux-kernel+bounces-105643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F1387E1F7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883CA1F2107D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097D71DDE9;
	Mon, 18 Mar 2024 02:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Nios/d1Y"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5501BF3F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 02:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710727367; cv=none; b=GCUmKNTqEd/gA/GIO3NJIvGnACXPzl2NE33s89Gp7aH+KMR6yUjSpp8cXyJ0QSUf8q+rnmLbUTQldFHz7o0xDxGA1+lUvTVekRvLPIw1620sbgg6WSf9aeMecK/DXhvDJPmWDZJhR7gUsU/T0PPQRJKRnDxrmi9JsV4qgPpQYME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710727367; c=relaxed/simple;
	bh=cwQvNCEPhdKlimrOAhfEe/MamQsNHHK66iPQYtUyy8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ofDcGCRYpzumiLaDkvIxs1aM7ECR1zrxbxX4ln6/FQtuNmtSQjqYx8Lfb/woI4JD1bfw7R8T+0PZ4r40zEM0h3hFZVa4g0d5re9ApjvOlrTjiVnyXqZHc2OQtBgfsZjzM5I4LrVNUzKGEDrR0ZTC/yhKUHYv/HxHwamJprFgiPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Nios/d1Y; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e6ca65edc9so1349786b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 19:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710727363; x=1711332163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KRLUIM3R69u5cP86Pofeov2WFNQje7z1HVd/36/zkl0=;
        b=Nios/d1YIp/OLamPj8LPAtWIGMsGD+GHKBztU7mivdkFhV/MRsXh8rcK5sVGS6Ehm7
         weKjFX8N9bmIIqnxMnYoNZhd1FRlNbmROow0+3kbf1U98UdZeEZGS2WyaWKwQkjqpvn7
         0vMCtqUdS95Bz2c5be2CfcmiddcgrdsT7/vsPZkxi9wutA5xDsWR0Qp+v/w/AZpv4aK1
         +NNt4PrqJMip1xAk7GNoMg8LAz5XdETvG3jfbes+jUg4hz4qXc9NcTGZ+OpdibVyfy1W
         tsvzdoRyrlTeSMRisdMBvBeGlefeI+3E8/FwCTIy5M1jJG+cdUfzYAcK6xeWz+4ZOYw3
         PzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710727363; x=1711332163;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KRLUIM3R69u5cP86Pofeov2WFNQje7z1HVd/36/zkl0=;
        b=oOl65yjYlYVaN3RXXWwtkjcEIFMgxdVucEzS85nGfrz0KADES2atRCE6qp27q7yzNw
         Q2UrPcZbkCaW7NEYxuTRq6iKzMdLDFglqPsSN9xeTX+eoYJQsC1y7WNJ4/LJxo4QteHS
         Gxne+pani/a8V5NIERBniqOjfwl5zNGy5hCWyKSALY15uew4XJsBDNVtdlZv0PhoXGqH
         FkknbHlZaUkhPeM/6D3uKhsSFwYR2tBvpx/iBbmsNygXTveCi3oCz/vdlAZU0JivgMlb
         sFJj1Rb1d8szHR3j7n+sVv1g/j8NNu7IqpksBqzjZFkoayqAOvH1Oh5ubuh3vnGn6pFf
         MHjg==
X-Forwarded-Encrypted: i=1; AJvYcCX8jeJa68hYt1JwJXN7Jh9KkD4migm00XyWCuZ8j316F3w7+orYPeQxrrjl+OloNUhmUopkVBgB513kSzh22eprBMxlRgPmpnO0LXPg
X-Gm-Message-State: AOJu0YyTsU1s3bUTxe+6B50Oznedvdhmyz1SS7Ub8Agz9PWJH9Cz2QwP
	FCyu/G8fzwOnBvSwEZk4ovDRZQB79B43OiR0e3fHFJcdnSfIVR4GNh1dtUq95RAxdsHMtDd5sIC
	L
X-Google-Smtp-Source: AGHT+IF1cTU02AMNgA6RxkSPhBZHg6UnwaMDic1y4LysiED4LdAsG8A360oBIrD3QhtLaq/7udQyiQ==
X-Received: by 2002:a05:6a20:8e04:b0:1a3:69e9:46bd with SMTP id y4-20020a056a208e0400b001a369e946bdmr291183pzj.5.1710727362726;
        Sun, 17 Mar 2024 19:02:42 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id st6-20020a17090b1fc600b0029bbdc920besm6386959pjb.44.2024.03.17.19.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 19:02:42 -0700 (PDT)
Message-ID: <30d89cd2-7748-4285-a1c5-e1724bf5ec31@kernel.dk>
Date: Sun, 17 Mar 2024 20:02:40 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KASAN: null-ptr-deref Write in tctx_task_work_run
Content-Language: en-US
To: Ubisectech Sirius <bugreport@ubisectech.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
References: <4fb30f6c-cd4c-4fcc-97ad-7132a503f7f7.bugreport@ubisectech.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4fb30f6c-cd4c-4fcc-97ad-7132a503f7f7.bugreport@ubisectech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/24 6:59 PM, Ubisectech Sirius wrote:
> Hello.
> We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec. Recently, our team has discovered a issue in Linux kernel 6.8.0-ge5e038b7ae9d. Attached to the email were a POC file of the issue.
> 
> Stack dump:
> 
> ==================================================================
> BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
> BUG: KASAN: null-ptr-deref in llist_del_all include/linux/llist.h:266 [inline]
> BUG: KASAN: null-ptr-deref in tctx_task_work_run+0x7d/0x330 io_uring/io_uring.c:1267
> Write of size 8 at addr 00000000000001c0 by task iou-sqp-215603/215604
> 
> CPU: 0 PID: 215604 Comm: iou-sqp-215603 Not tainted 6.8.0-ge5e038b7ae9d #40
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:114
>  kasan_report+0xbd/0xf0 mm/kasan/report.c:601
>  check_region_inline mm/kasan/generic.c:183 [inline]
>  kasan_check_range+0xf4/0x1a0 mm/kasan/generic.c:189
>  instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
>  llist_del_all include/linux/llist.h:266 [inline]
>  tctx_task_work_run+0x7d/0x330 io_uring/io_uring.c:1267
>  io_sq_tw+0x12a/0x1d0 io_uring/sqpoll.c:245
>  io_sq_thread+0x8d7/0x18a0 io_uring/sqpoll.c:308
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
> ==================================================================
> Kernel panic - not syncing: KASAN: panic_on_warn set ...
> CPU: 0 PID: 215604 Comm: iou-sqp-215603 Not tainted 6.8.0-ge5e038b7ae9d #40
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014

I think you snipped the fault injection that came before this. It looks
like an allocation failure, so we don't get tsk->io_uring setup for the
SQPOLL thread. Not a great way to handle this, but can you try the
below? Would be nicer if we could just prune the task rather than wake
it and have it error.

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 363052b4ea76..db7b0fdfe1cb 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -274,6 +274,10 @@ static int io_sq_thread(void *data)
 	char buf[TASK_COMM_LEN];
 	DEFINE_WAIT(wait);
 
+	/* offload context creation failed, just exit */
+	if (!current->io_uring) {
+		goto err_out;
+
 	snprintf(buf, sizeof(buf), "iou-sqp-%d", sqd->task_pid);
 	set_task_comm(current, buf);
 
@@ -371,7 +375,7 @@ static int io_sq_thread(void *data)
 		atomic_or(IORING_SQ_NEED_WAKEUP, &ctx->rings->sq_flags);
 	io_run_task_work();
 	mutex_unlock(&sqd->lock);
-
+err_out:
 	complete(&sqd->exited);
 	do_exit(0);
 }

-- 
Jens Axboe


