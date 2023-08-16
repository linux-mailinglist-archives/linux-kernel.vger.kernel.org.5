Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4613D77EB53
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346352AbjHPVEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346418AbjHPVE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:04:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235382736
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:04:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B21B866EE7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 21:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0189C433C7;
        Wed, 16 Aug 2023 21:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692219860;
        bh=mMTfeKxGVaY+Llzxiq+JdTAw0bShPwSNTGJpRtPVghU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J9BPGJFQQwO12dgLBeIPuJpXSTPAa2GDKIUiYQx/xfKLQw2UgZ7KoJ3Vk5bt6V4or
         d2o3C11X45pJJiMlwRMwyyrgQCwrA+UDzJxLGbQJbqmdFjdhfC9iLzoYZaef4h2X02
         zKFtRjYl7gTrjMZ/69YiLq/1vqYwo6QEN1LSQhttjOqRmDs2NP/CcknbiJTc0LuEKU
         YFlnnxUrmyqNGiFprF5HTH37CB8iyaJmpY6Usqp/YYFbH8VeZJfbfgOf4eiAgXjZ7V
         +YhWtQTtG8rjemiuXGvqoSHfe/YD9bkzk3Eg07j4tQMCZYnthC7lauH6rZqcVVKVUL
         TaSU9kNIinIsQ==
Date:   Wed, 16 Aug 2023 15:04:17 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Genes Lists <lists@sapience.com>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: Possible nvme regression in 6.4.11
Message-ID: <ZN050TFnKZ54LJ5v@kbusch-mbp.dhcp.thefacebook.com>
References: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 04:39:34PM -0400, Genes Lists wrote:
> Also reported to bugzilla [1]
> 
> Failure happens on 1 laptop with samsung ssd.
> 
> Boot log manually transcribed:
> 
> kernel: nvme nvme0: controller is down; will reset: CSTS:0xffffffff,
> PCI_STATUS=0xffff
> kernel: nvme nvme0: Does your device have a faulty power saving mode
> enabled?
> kernel: nvme nvme0: try "nvme_core.default_ps_max_latency_us=0
> pcie_aspm=off" and report a bug
> kernel: nvme 0000:04:00.0: Unable to change power state from D3cold to D0,
> device inaccessible
> kernel: nvme nvme0: Disabling device after reset failure: -19
> mount[353]: mount /sysroot: can't read suprtblock on /dev/nvme0n1p5.
> mount[353]:       dmesg(1) may have more information after failed moutn
> system call.
> kernel: nvme0m1: detected capacity change from 2000409264 to 0
> kernel: EXT4-fs (nvme0n1p5): unable to read superblock
> systemd([1]: sysroot.mount: Mount process exited, code=exited, status=32/n/a
> ...
> 
> All kernels are upstream, untainted and compiled on Arch using:
> 
>  gcc version 13.2.1
> 
> Kernels Tested:
>  - 6.4.10 - works fine
>  - 6.4.11 - fails
>  - 6.5-rc6 - fails
>  - 6.4.11 + nvme_core.default_ps_max_latency_us=0 pcie_aspm=off - fails
>  - 6.4.11 with 1 revert below - fails
> 
>     Revert "nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G and
> 512G"
>     This reverts commit 061fbf64825fb47367bbb6e0a528611f08119473.

It sounds like you can recreate this. Since .10 worked and .11 doesn't,
could you bisect the git commits? It looks like it will take 7 steps
between those two versions.

I don't think there are any nvme specific patches that could contribute
to what you're seeing, it's more likely some lower level platform patch
if a kernel change really did cause the regression. None of the recent
commits really stood out to me, so bisect is what I'd recommend.
