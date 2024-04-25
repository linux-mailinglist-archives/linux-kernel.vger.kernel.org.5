Return-Path: <linux-kernel+bounces-158860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 744AE8B25E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF824B26714
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD8114D281;
	Thu, 25 Apr 2024 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWS/aITh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A881494BF;
	Thu, 25 Apr 2024 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714060990; cv=none; b=R2/FG6xEhD1nSZ8xidYK4HdbV/q5XkVGOvKm1A3AOm+HT6672SF/VYu9n3M/y7bSLVnUQvdsmbueACJb18z8+sq9ZntcQfk0IDeIVQPEqkUXdpeHU5B9dhlauRNm5AcJOP5aIIR01DgoEiDCcZm9a3GbjpdGjq4tfknBWJezRfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714060990; c=relaxed/simple;
	bh=3hP3govGe0OHHTR4xCJ9CZzV7UIniHmuOXenpQjPGHM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=jpayrqBEwoLX2VKWaHLXNEYGswEFqxEmckzBDEXWbhluJWVWhsdoeInocvAl6APkvZ9bwbwMUHeYh3l17uD6FFqqKF9g/NTYlqn5Y7PO+Tw0QFKkilr4xooBJUaJpSMhir4VvJ389bypBvmVsJndFtIhQDpyoVAzqwp2hnNUCM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWS/aITh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBA9C113CE;
	Thu, 25 Apr 2024 16:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714060990;
	bh=3hP3govGe0OHHTR4xCJ9CZzV7UIniHmuOXenpQjPGHM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=pWS/aIThsXtBIX+S9GHI0HOm1qEbdbgE3Mv/ZcTnQ9kLV0W7SOP1KgU+O79ook+wV
	 24PedWk/FlcF36EhhcLbn88aAkgn/rLgqrG/ErHpOsUURYJO0zippRVB8jhvCHBcE5
	 9E1pYkNz3+5vAppMZ4SrfUlEQzjSPAy4ZFtQBpZKFiPQy8IehsCSCvr45hRe4ZNjBY
	 fxJoOw4DMGvU5ZavFFlKFYoByumDNYBUwTLbeG3P7C1NlJo++2iG25jSXjwD4px6eE
	 ZQQllJgrFU7HnhlQbp17Lu56AFaxVqYCLuUoGgnz1WyuoBNt9+G1lSnWLkPTUpJBT9
	 2D2ZPlFbqjH1Q==
From: Kalle Valo <kvalo@kernel.org>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Wu Yunchuan <yunchuan@nfschina.com>,  Johannes Berg
 <johannes.berg@intel.com>,  "Breno Leitao" <leitao@debian.org>,
  <linux-wireless@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <lvc-project@linuxtesting.org>,
  <syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2] wifi: ar5523: enable proper endpoint verification
References: <20240408121425.29392-1-n.zhandarovich@fintech.ru>
	<171406032921.2967849.6111681305541795423.kvalo@kernel.org>
Date: Thu, 25 Apr 2024 18:58:19 +0300
In-Reply-To: <171406032921.2967849.6111681305541795423.kvalo@kernel.org>
	(Kalle Valo's message of "Thu, 25 Apr 2024 15:52:23 +0000 (UTC)")
Message-ID: <87a5lhh1t0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Nikita Zhandarovich <n.zhandarovich@fintech.ru> wrote:
>
>> Syzkaller reports [1] hitting a warning about an endpoint in use
>> not having an expected type to it.
>> 
>> Fix the issue by checking for the existence of all proper
>> endpoints with their according types intact.
>> 
>> Sadly, this patch has not been tested on real hardware.
>> 
>> [1] Syzkaller report:
>> ------------[ cut here ]------------
>> usb 1-1: BOGUS urb xfer, pipe 3 != type 1
>> WARNING: CPU: 0 PID: 3643 at drivers/usb/core/urb.c:504
>> usb_submit_urb+0xed6/0x1880 drivers/usb/core/urb.c:504
>> ...
>> Call Trace:
>>  <TASK>
>>  ar5523_cmd+0x41b/0x780 drivers/net/wireless/ath/ar5523/ar5523.c:275
>>  ar5523_cmd_read drivers/net/wireless/ath/ar5523/ar5523.c:302 [inline]
>>  ar5523_host_available drivers/net/wireless/ath/ar5523/ar5523.c:1376 [inline]
>>  ar5523_probe+0x14b0/0x1d10 drivers/net/wireless/ath/ar5523/ar5523.c:1655
>>  usb_probe_interface+0x30f/0x7f0 drivers/usb/core/driver.c:396
>>  call_driver_probe drivers/base/dd.c:560 [inline]
>>  really_probe+0x249/0xb90 drivers/base/dd.c:639
>>  __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
>>  driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
>>  __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:936
>>  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:427
>>  __device_attach+0x1e4/0x530 drivers/base/dd.c:1008
>>  bus_probe_device+0x1e8/0x2a0 drivers/base/bus.c:487
>>  device_add+0xbd9/0x1e90 drivers/base/core.c:3517
>>  usb_set_configuration+0x101d/0x1900 drivers/usb/core/message.c:2170
>>  usb_generic_driver_probe+0xbe/0x100 drivers/usb/core/generic.c:238
>>  usb_probe_device+0xd8/0x2c0 drivers/usb/core/driver.c:293
>>  call_driver_probe drivers/base/dd.c:560 [inline]
>>  really_probe+0x249/0xb90 drivers/base/dd.c:639
>>  __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
>>  driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
>>  __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:936
>>  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:427
>>  __device_attach+0x1e4/0x530 drivers/base/dd.c:1008
>>  bus_probe_device+0x1e8/0x2a0 drivers/base/bus.c:487
>>  device_add+0xbd9/0x1e90 drivers/base/core.c:3517
>>  usb_new_device.cold+0x685/0x10ad drivers/usb/core/hub.c:2573
>>  hub_port_connect drivers/usb/core/hub.c:5353 [inline]
>>  hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
>>  port_event drivers/usb/core/hub.c:5653 [inline]
>>  hub_event+0x26cb/0x45d0 drivers/usb/core/hub.c:5735
>>  process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
>>  worker_thread+0x669/0x1090 kernel/workqueue.c:2436
>>  kthread+0x2e8/0x3a0 kernel/kthread.c:376
>>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
>>  </TASK>
>> 
>> Reported-and-tested-by: syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com
>> Fixes: b7d572e1871d ("ar5523: Add new driver")
>> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>
> Does anyone have a real device to test this? I have had so much problems with
> syzbot fixes in the past that I'm hesitant to take such patches without
> testing.

Actually should we just remove ar5523 driver? Has anyone heard anyone
using this driver still?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

