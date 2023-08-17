Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9322277EEBA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 03:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347528AbjHQBbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 21:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347530AbjHQBai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 21:30:38 -0400
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14378271E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 18:30:37 -0700 (PDT)
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by s1.sapience.com (Postfix) with ESMTPS id 167D2480AB8;
        Wed, 16 Aug 2023 21:30:36 -0400 (EDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1692235835;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=WfMGBtaGHGLIJ63kT4rLPlN6AQGC+kGBWir4Ap9VMDg=;
 b=gphYlJDVky3wE2hL3f1mn+IoOgTKuJo6oFJY+Gdgo9RVrzGDbzOMZkZkE0LzMtjOQ5Qa+
 6ORwySW7xiYuKx5BA==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1692235835;
        cv=none; b=lrdEHT9PaPyfu7m5kWc+m4Zb0nM7K0NIUa74pb4/9yyzMpZzoga0HISmLBTspX6pY+kSbtosk/TmxwRYoQOsRQHizm5TSwT+qX1+Ycqn0bXcHQx2uyKYVZ8T9nvvO+X03dofcfJGLx73XBLuJt7VlIEWXlE6oJXBo5SEMxCmq3W3xf7DxLOlK0HnGaPNze24AiyUTlqfTcWaDhfsfLL6qQUJbLaUwxp7cFYtFfMh3/sbAmZqDxKJEWErfMGQNMWZ42ImNeR5WAaq0m7CSUCRkXtarC6myYG1dxB31oMYB3uiF1KD3Jz8Z05A0QTmzqOdEsKKfh0XRAYRhPHl4rGFCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
        t=1692235835; c=relaxed/simple;
        bh=BOzc6PlAXaMR/fEo/2en+w7lwkZ2f41MeeT2eay7BRw=;
        h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
         User-Agent:Subject:Content-Language:To:Cc:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding; b=HE6BFlyQrcp8sRwL45ZrTHLxHyWUpuUD4ZENpwKhGzol6g1QHvtgG5ws/Zrsf/b3Sb6/6w0PVRylVxjKbaSDL62uZF3e2U0VM/Cta6jLLn7qSFr1nmA+JKT5Bme0oijZ/nhQRkBwZ2xeofv+siE4bDDVKEtNSEb946OZeLm6kU2O1TlmSpgIQMXyjAu+uKzmBtQaVoNlbQNRM/cSgjse8qQ9aMsnSiu5+Z3BguEP24OAYpkOby8PlXGbOTuDZEfN9M+UVPgbRo5vKCBFC+2fWHiLPb7bu03vmyuZO3sfdotzfLVVd7L+F0jmUQDQTVPlZOBc80CNksQzSUfhZElUMQ==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1692235835;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=WfMGBtaGHGLIJ63kT4rLPlN6AQGC+kGBWir4Ap9VMDg=;
 b=evjYAZhmSgRn7TUk8Vj4Q84iOQsleiyHQPcJnt+XbqrvZF6DuaTTc8n1uLJxmbOgsWzZx
 li1iSCEu9iGICYjNOtlUs/hhkbutGm8K+C99GI2cnJt2eHSwVv+PK+DRA/3WvZVzexV9ll/
 XPAioP5TYSsKVgBiACDN3nAVJBP8MOUkwCYMxzvWX5tWyzydGKqDHyMpFdjuXeA7mjMV58y
 hOgjimyjAvmlm4iV8c7HdI7hM3iKsC5raJtpOFLXydIfs61T5NfiVqNKpv5C9U5ES9XgoK7
 JH9xtT57bCNANBRo0f7YFA6YPUaHRk2xywz/SPkujqbzW8BC8PdGZlxb991w==
Message-ID: <30b69186-5a6e-4f53-b24c-2221926fc3b4@sapience.com>
Date:   Wed, 16 Aug 2023 21:30:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible nvme regression in 6.4.11
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, hch@lst.de
References: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
 <ZN050TFnKZ54LJ5v@kbusch-mbp.dhcp.thefacebook.com>
From:   Genes Lists <lists@sapience.com>
In-Reply-To: <ZN050TFnKZ54LJ5v@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/23 17:04, Keith Busch wrote:
...
> It sounds like you can recreate this. Since .10 worked and .11 doesn't,
> could you bisect the git commits? It looks like it will take 7 steps
> between those two versions.
> 
> I don't think there are any nvme specific patches that could contribute
> to what you're seeing, it's more likely some lower level platform patch
> if a kernel change really did cause the regression. None of the recent
> commits really stood out to me, so bisect is what I'd recommend.

Thank you

Bisect done - This is result:

----------------------------------------------------------------
69304c8d285b77c9a56d68f5ddb2558f27abf406 is the first bad commit
commit 69304c8d285b77c9a56d68f5ddb2558f27abf406
Author: Ricky WU <ricky_wu@realtek.com>
Date:   Tue Jul 25 09:10:54 2023 +0000

     misc: rtsx: judge ASPM Mode to set PETXCFG Reg

     commit 101bd907b4244a726980ee67f95ed9cafab6ff7a upstream.

     ASPM Mode is ASPM_MODE_CFG need to judge the value of clkreq_0
     to set HIGH or LOW, if the ASPM Mode is ASPM_MODE_REG
     always set to HIGH during the initialization.

     Cc: stable@vger.kernel.org
     Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
     Link: 
https://lore.kernel.org/r/52906c6836374c8cb068225954c5543a@realtek.com
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

  drivers/misc/cardreader/rts5227.c  |  2 +-
  drivers/misc/cardreader/rts5228.c  | 18 ------------------
  drivers/misc/cardreader/rts5249.c  |  3 +--
  drivers/misc/cardreader/rts5260.c  | 18 ------------------
  drivers/misc/cardreader/rts5261.c  | 18 ------------------
  drivers/misc/cardreader/rtsx_pcr.c |  5 ++++-
  6 files changed, 6 insertions(+), 58 deletions(-)

------------------------------------------------------

And the machine does have this hardware:

03:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS525A 
PCI Express Card Reader (rev 01)
         Subsystem: Dell RTS525A PCI Express Card Reader
         Physical Slot: 1
         Flags: bus master, fast devsel, latency 0, IRQ 141
         Memory at ed100000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [80] Power Management version 3
         Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Capabilities: [b0] Express Endpoint, MSI 00
         Kernel driver in use: rtsx_pci
         Kernel modules: rtsx_pci



