Return-Path: <linux-kernel+bounces-43526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED62284152B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E691F2334A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD65158D71;
	Mon, 29 Jan 2024 21:28:17 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7141157E79;
	Mon, 29 Jan 2024 21:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706563697; cv=none; b=NrPZOJ0VdIY43mGeGkdSje71JUNdq/mdl+MChcldJgESDujW/CNy4Pd6oASmozRH+1Om1g34UHisgqygVhcrQ593G2kzTwMaQ+FqLgH/aTz20vPlkhqq9x9dwS09NOEXrnaEkC5RNk17KnvMwAhRLvHVGtmBBlL4tGWzCnuLY/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706563697; c=relaxed/simple;
	bh=nlR7TkSdtDDX6+CuKv4AwSsmM+koGCZsA7ddVOj/tGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VxHr7K+XZQwWW+2hpmIiC8qLlrDL7hp+ONmIeNmDxGm977zpGHKoqbTOSyU2JTiM2RlOh6rAQcGVUYnsIDIW54JWjVFi3hDvzhH4KdTnTJGRD9j8VcnXeaOW9FojSxNN7tVkiRsT9vLZJxeWWrv5mIqGONFRYSWEIeldATjm3sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.6] (unknown [95.90.246.18])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0197161E5FE04;
	Mon, 29 Jan 2024 22:27:44 +0100 (CET)
Message-ID: <b1f77ee7-0684-4260-bcaf-d826af19978d@molgen.mpg.de>
Date: Mon, 29 Jan 2024 22:27:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IHR5cGVjX2FsdG1vZGVfcmVsZWFzZSDihpIgcmVmY291bnRfdDog?=
 =?UTF-8?Q?underflow=3B_use-after-free=2E?=
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e12b5e52-1c94-472d-949b-2ee158857584@molgen.mpg.de>
 <Zbf3M2+r5RP9K8jJ@cae.in-ulm.de>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <Zbf3M2+r5RP9K8jJ@cae.in-ulm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Christian,


Am 29.01.24 um 20:06 schrieb Christian A. Ehrhardt:

> On Mon, Jan 29, 2024 at 12:57:11PM +0100, Paul Menzel wrote:

>> I noticed the message first time with Linux 6.6.8 on December 26th, and also
>> with 6.6.11, 6.7 and 6.7.1. I am unsure how to reproduce it though.
>>
>> Here the trace from Linux 6.7.1-1~exp1:
>>
>> ```
>> [    0.000000] Linux version 6.7-amd64 (debian-kernel@lists.debian.org) (x86_64-linux-gnu-gcc-13 (Debian 13.2.0-10) 13.2.0, GNU ld (GNU Binutils for Debian) 2.41.90.20240115) #1 SMP PREEMPT_DYNAMIC Debian 6.7.1-1~exp1 (2024-01-22)
>> […]
>> [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
>> […]
>> [ 9068.294345] ucsi_acpi USBC000:00: failed to re-enable notifications (-110)
>> [ 9068.499156] ------------[ cut here ]------------
>> [ 9068.499172] refcount_t: underflow; use-after-free.
>> [ 9068.499199] WARNING: CPU: 0 PID: 5598 at lib/refcount.c:28 refcount_warn_saturate+0xbe/0x110

[…]
>> [ 9068.499517] Call Trace:
>> [ 9068.499521]  <TASK>
>> [ 9068.499522]  ? refcount_warn_saturate+0xbe/0x110
>> [ 9068.499526]  ? __warn+0x81/0x130
>> [ 9068.499533]  ? refcount_warn_saturate+0xbe/0x110
>> [ 9068.499545]  ? report_bug+0x171/0x1a0
>> [ 9068.499549]  ? console_unlock+0x78/0x120
>> [ 9068.499553]  ? handle_bug+0x3c/0x80
>> [ 9068.499557]  ? exc_invalid_op+0x17/0x70
>> [ 9068.499565]  ? asm_exc_invalid_op+0x1a/0x20
>> [ 9068.499570]  ? refcount_warn_saturate+0xbe/0x110
>> [ 9068.499576]  typec_altmode_release+0x49/0xc0 [typec]
>> [ 9068.499615]  device_release+0x34/0x90
>> [ 9068.499624]  kobject_put+0x78/0x190
>> [ 9068.499629]  ucsi_unregister_altmodes+0x41/0xa0 [typec_ucsi]
>> [ 9068.499648]  ucsi_unregister_partner.part.0+0x77/0xa0 [typec_ucsi]
>> [ 9068.499662]  ucsi_handle_connector_change+0x1bb/0x310 [typec_ucsi]
>> [ 9068.499671]  process_one_work+0x171/0x340
>> [ 9068.499676]  worker_thread+0x27b/0x3a0
>> [ 9068.499679]  ? __pfx_worker_thread+0x10/0x10
>> [ 9068.499681]  kthread+0xe5/0x120
>> [ 9068.499690]  ? __pfx_kthread+0x10/0x10
>> [ 9068.499693]  ret_from_fork+0x31/0x50
>> [ 9068.499698]  ? __pfx_kthread+0x10/0x10
>> [ 9068.499700]  ret_from_fork_asm+0x1b/0x30
>> [ 9068.499714]  </TASK>
>> [ 9068.499715] ---[ end trace 0000000000000000 ]---
>> ```
>>
>> Please find the full output of `dmesg` attached.
> 
> This should be fixed by
> 
> | commit 5962ded777d689cd8bf04454273e32228d7fb71f
> | Author: RD Babiera <rdbabiera@google.com>
> | Date:   Wed Jan 3 18:17:55 2024 +0000
> |
> |     usb: typec: class: fix typec_altmode_put_partner to put plugs
> 
> which is in mainline and 6.7.2.

Awesome. Thank you for mentioning this, and nice timing, as the commit 
referenced in the Fixed-by tag is from v4.19-rc1 from August 2018. ;-)


Kind regards,

Paul

