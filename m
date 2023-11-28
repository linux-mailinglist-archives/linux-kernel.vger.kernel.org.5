Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388F37FC47E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjK1T4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjK1T4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:56:32 -0500
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B9619A6;
        Tue, 28 Nov 2023 11:56:38 -0800 (PST)
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by s1.sapience.com (Postfix) with ESMTPS id 44364480AAD;
        Tue, 28 Nov 2023 14:56:38 -0500 (EST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1701201398;
 h=message-id : date : mime-version : subject : from : to : cc :
 references : in-reply-to : content-type : content-transfer-encoding :
 from; bh=lvM7CD1aGwZ6qshcUNO7zZN11rYmgCaJQ5Sq7osdZss=;
 b=IZRTfrfUjKwUlBRh8e41JparbdbZbo/6pBbJFb3ZQr2St+s6trY7EA5hWDK3qOEVvDU5y
 FZ9yjIwQn1URbS+AA==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1701201398;
        cv=none; b=NybB63NQIXnbqFHjpq6kvsgL8G1eZLBXq49hlUNoByOOSAIbvNhiIymu6vcEmGhVM8kSYmcbSWRbjyznnd1zioRTuIcysPxwaV4D985pQ2isTXmAlzxuH7tp3PdphfZ5RQD0iGb7bRlODZR4wEDUDDKVxROyIJxTEzmtJc9vdYV/uVLYgwX3D5MsNHDf5AIOcQ3jG2rgNgjV/W4KXMb3VFOboqaTFlUYRy6YazWeJEmWBt/uqryoAbHBfbrVnXpNixsZaJyjVhGGcgtdiYa1klk/TXWUCBF9qalCKE+goDFDCHANeH0/FpS9f+tcZaneySaEoQhTx8JvKZagNsqC5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
        t=1701201398; c=relaxed/simple;
        bh=Kn+tnaE511rc7i46SK6IJUPRfkEyfvTf2ILD0jr1oJ0=;
        h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
         User-Agent:Subject:Content-Language:From:To:Cc:References:
         In-Reply-To:Content-Type:Content-Transfer-Encoding; b=GrHqwVzC6nFW1g0+DekoMrXY1Grrp+Ue7SUXw2UsWCesZZa3s6VVcc0utdGQwekaw4knr7u0WA346q06fv+dgF1bkEdAsHOch0qTKGU2/iXV+YcWo9azazxiOFgm+s62kU6PvY+uw67uypsCu4stmnOfeklUesTn0YVrijuz5ulR6b9zi2mkVoORnyVEBMVTp5so9XEas4JoXluS8HLi+lUtCuD3SvWwADpFeG75iAIw0vtNELq8Jjulo6h2m51RP2LfP7uu9Vk+cYVAPePV2NxxMEvH5GJHRNHKwhZSWAq3WV9zwsdVt9G6ZojBo+z9o8t2YNgSTqmbDGQ54+GQLA==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1701201398;
 h=message-id : date : mime-version : subject : from : to : cc :
 references : in-reply-to : content-type : content-transfer-encoding :
 from; bh=lvM7CD1aGwZ6qshcUNO7zZN11rYmgCaJQ5Sq7osdZss=;
 b=WNaQ/oksUMcpTrdlsLiTsCpjMWm6WGTlYXB4uga2kc59FNJgOvGqARdrUZSSZzvA27Hg7
 eIfAzrG1/HEqzaaGwy7C4PBqO/BOuCU9MOs1S/mj7aSGH6mDl1U3WDcD95tDjG+sZ/maiwb
 sFRyjNjVN2oPkf47PPzJ82zgFME1PVnsS2VerA6q2oUaaFqvQBjh+gRy5jMqqdIi65a7KqT
 4UyMmJtUcrOMvaNOulYrBwJCHtQRXihC0rHCt1tqhYoaJHHI22xJDSREPGocCcsZFaPFeD7
 i474uGU/0jde1peTIEIAoWyvLmKa+MidUbTbK+Gh9Zq4HTP8JnparjswExEw==
Message-ID: <022c67aa-b90a-4756-8725-5f7fba7dc780@sapience.com>
Date:   Tue, 28 Nov 2023 14:56:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: crash with 6.7 rc2 and rc3
Content-Language: en-US
From:   Genes Lists <lists@sapience.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, tglx@linutronix.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gregory.greenman@intel.com, kvalo@kernel.org,
        Linux Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Regressions <regressions@lists.linux.dev>
References: <c46a6462-8263-455c-a6ea-1860020f5fab@sapience.com>
 <ZWV7JworMrjHJHsO@archie.me>
 <cf2dcc97-845d-4860-be4d-5822d2ebbfca@sapience.com>
In-Reply-To: <cf2dcc97-845d-4860-be4d-5822d2ebbfca@sapience.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/23 05:39, Genes Lists wrote:
> On 11/28/23 00:31, Bagas Sanjaya wrote:
>> On Mon, Nov 27, 2023 at 03:55:37PM -0500, Genes Lists wrote:
>>>
>>> lenovo laptop boots fine under 6.7rc1 and older including 6.6.2 stable.
>>> but not for 6.7 rc2 or rc3.
>>>
>>> It has a intel 7260 (rev 3) wireless and :
>>>
>>> cpu family    : 6
>>> model        : 60
>>> model name    : Intel(R) Core(TM) i7-4800MQ CPU @ 2.70GHz
>>> stepping    : 3
>>> microcode    : 0x28
>>>
>>>
>>> As of 6.7 rc2 / rc3 it crashes towards the end of boot bringing up 
>>> services
>>> -  some parts of crash scrolled off the screen so I apologize if this
>>> (manually transcribed) trace didn't catch the first part.
>>>
>>> I did a git bisect between rc1 and rc2 but was unable to reproduce 
>>> the crash
>>> for some reason. (I did not do make clean between each bisects).
>>>
>>> During the bisect it booted every time, but networking was not 
>>> functional
>>> for any of the bisects.
>>>
>>> Hope it's okay to report even though git bisect didn't get anywhere.
>>>
>>> Gene
>>>
>>> This is the what I got from screen :
>>>
>>> CS: 0010 DS: 000 ES: 0000 CR0: 0000000080050033
>>> CR2: 00007f30cf49ba38 CR3: 000000025b620004 CR4: 00000000001706f0
>>> Call Trace:
>>>   <IRQ>
>>>   ? die_addr+0x36/0x90
>>>   ? exc_general_protection+0x1c5/0x430
>>>   ? asm_exc_gemeral_protection+0x26/0x30
>>>   ? iwl_phy_db_set_section+0xd6/0x1f0 [iwlwifi]
>>>   ? __kmem_cache_alloc_node+0x1d5/0x2b0
>>>   ? iwl_phy_db_set_section+0xd6/0x1f0 [iwlwifi]
>>>   ? iwl_phy_db_set_section+0xd6/0x1f0 [iwlwifi]
>>>   __kmalloc_node_track_caller+0x51/0x160
>>>   kmemdup+0x20/0x50
>>>   iwl_phy_db_set_section+0xd6/0x1f0 [iwlwifi]
>>>   iwl_wait_phy_db_entry+0x2f/0x40 [iwlmvm]
>>>   iwl_notification_wait+0xb0/0xf0 [iwlwifi]
>>>   iwl_mvm_rx_common+0x8e/0x320 [iwlwifi]
>>>   iwl_pcie_napi_poll+0x2d/0x150 [iwlwifi]
>>>   __napi_poll+0x2b/0x1c0
>>>   net_rx_action+0x2b4/0x320
>>>   __do_softirq+0xff/0x339
>>>   net_rx_action+0x2b4/0x320
>>>   __do_softirq.part.0+0x88/0xa0
>>> </IRQ>
>>> <TASK>
>>> __local_bh_enable_ip+0x91/0xa0
>>> iwl_pcie_irq_handler+0x58d/0xc40 [iwlwifi]
>>> ? __pfx_irq_thread_fn+0x10/0x10
>>> irq_thread_fn+0x23/0x60
>>> irq_thread+0xfe/0x60
>>> ? __pfx_irq_thread_dtor+0x10/0x10
>>> ? __pfx_irq_thread+0x10/0x10
>>> kthread+0xfa/0x130
>>> ? pff_kthread+0x10/0x10
>>> ret_from_fork+0x34/0x50
>>> ? __pfx_kthread+0x10/0x10
>>> ret_from_fork_asm+0x1b/0x30
>>
>> Do you have any full system logs that can be attached?
>>
>> Anyway, thanks for the regression report. I'm adding it to regzbot:
>>
>> #regzbot ^introduced: v6.7-rc1..v6.7-rc2
>>
> 
> journalctl -k for 6.6.2 and the last bisect
> 
> gene
> 

6.6.3 crashes for me same way - also an intel NUC also crashes with 
6.6.3 buty works on 6.6.2. Will take a while before I get additional 
info on the latter box.

gene




