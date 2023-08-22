Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEE4783DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjHVK12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjHVK11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:27:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F79CC8;
        Tue, 22 Aug 2023 03:27:23 -0700 (PDT)
Received: from [192.168.10.12] (unknown [39.45.215.81])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AE4FD6607215;
        Tue, 22 Aug 2023 11:27:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692700042;
        bh=2DBcZcOC3jRRssDkdf7QwArSMcaYykvUqxjA+hZileU=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=Wn1oBb7N4ywT0/KiEWpkGF11gZ0GBXnPSlboUu9e7wICvdsVWI1tin1HHK5HoeHRC
         HyZ5kzANcQ51kt06kU886Ke3OzVPqsXIntnzhAm/32TR/YoGbnhuLl8DofIUZLdEpN
         wfgbNrr4pG95nnp1oB5t7fsugtJlMmY9CKHYNZLETsTFo+HWSzjQXK+itVBhHkaZDW
         vuGn2IP5Xkbk7X47q+I1tc+WIKapJhVnY9s6EtMV+ij4EEumBcynvks2+TZgWfOSMq
         hVa0/3FuKhZ4Vx+pGDRaFkJuwDwuNHvgb+4yAwaGQbs2rchSpp3pmyOkWS9Dd4olbf
         7KPXgZW+OAXoQ==
Message-ID: <1786e05a-300a-4259-be1e-2cc54db9c16b@collabora.com>
Date:   Tue, 22 Aug 2023 15:27:15 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jiri Slaby <jirislaby@kernel.org>, Ingo Molnar <mingo@elte.hu>,
        kernel@collabora.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] tty/sysrq: replace smp_processor_id() with
 get_cpu()
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230822090112.2601273-1-usama.anjum@collabora.com>
 <2023082259-blazer-charity-b58f@gregkh>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <2023082259-blazer-charity-b58f@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/23 2:15 PM, Greg Kroah-Hartman wrote:
> On Tue, Aug 22, 2023 at 02:01:11PM +0500, Muhammad Usama Anjum wrote:
>> The smp_processor_id() shouldn't be called from preemptible code.
>> Instead use get_cpu() and put_cpu() which disables preemption in
>> addition to getting the processor id. This fixes the following bug:
>>
>> [  119.143590] sysrq: Show backtrace of all active CPUs
>> [  119.143902] BUG: using smp_processor_id() in preemptible [00000000] code: bash/873
>> [  119.144586] caller is debug_smp_processor_id+0x20/0x30
>> [  119.144827] CPU: 6 PID: 873 Comm: bash Not tainted 5.10.124-dirty #3
>> [  119.144861] Hardware name: QEMU QEMU Virtual Machine, BIOS 2023.05-1 07/22/2023
>> [  119.145053] Call trace:
>> [  119.145093]  dump_backtrace+0x0/0x1a0
>> [  119.145122]  show_stack+0x18/0x70
>> [  119.145141]  dump_stack+0xc4/0x11c
>> [  119.145159]  check_preemption_disabled+0x100/0x110
>> [  119.145175]  debug_smp_processor_id+0x20/0x30
>> [  119.145195]  sysrq_handle_showallcpus+0x20/0xc0
>> [  119.145211]  __handle_sysrq+0x8c/0x1a0
>> [  119.145227]  write_sysrq_trigger+0x94/0x12c
>> [  119.145247]  proc_reg_write+0xa8/0xe4
>> [  119.145266]  vfs_write+0xec/0x280
>> [  119.145282]  ksys_write+0x6c/0x100
>> [  119.145298]  __arm64_sys_write+0x20/0x30
>> [  119.145315]  el0_svc_common.constprop.0+0x78/0x1e4
>> [  119.145332]  do_el0_svc+0x24/0x8c
>> [  119.145348]  el0_svc+0x10/0x20
>> [  119.145364]  el0_sync_handler+0x134/0x140
>> [  119.145381]  el0_sync+0x180/0x1c0
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 47cab6a722d4 ("debug lockups: Improve lockup detection, fix generic arch fallback")
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v1:
>> - Add "Cc: stable@vger.kernel.org" tag
>> ---
> 
> This is not a resend, it is a new version, v3.  Otherwise I would be
> confused with the original v2 which is different than this one...
Sorry, didn't relaize this. I've sent this as v3:
https://lore.kernel.org/all/20230822102606.2821311-1-usama.anjum@collabora.com

> 
> thanks,
> 
> greg k-h

-- 
BR,
Muhammad Usama Anjum
