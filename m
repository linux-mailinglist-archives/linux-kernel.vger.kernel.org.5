Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8BE79268A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbjIEQFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354811AbjIEOfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:35:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B71E189;
        Tue,  5 Sep 2023 07:35:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4823B811FC;
        Tue,  5 Sep 2023 14:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA49C433C9;
        Tue,  5 Sep 2023 14:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693924546;
        bh=mUv7viaR4QlhOU9eEIWkBwFQjliy5qzSydoTR+5jNRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hItTlG6DKaq9eTGg36u1qPRFPWE7r53/vFnmWFG1YNX5mUCJdUifX9YQvIYQ1ATUE
         eqS0b7zftUsg5F2Nf/uN46t4/4aQin9iB4CZ2qWMozK8cNz+GyIa8ezllt9ZM0eb7F
         z6jMAxFMQpsX9w43ofaVynlSikqa9QuU9PVJfXM2mXEVtqfJbVHZYOBX5DT8/Zg5yx
         XX4ysi/YOe7MD+EjzgneNQYFVH2C4/kU7ZYjRb2z61UAp1cDj06m+XtFxat7IAAmze
         33AslZb7VQSaLqi7TsinuXOukVbAwWXoU3itXfffHYgTY2WphsrSYBNAD635T+rqsq
         ZAVH7WdcaGm1g==
Date:   Tue, 5 Sep 2023 08:35:43 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Claudio Sampaio <patola@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Linux Stable <stable@vger.kernel.org>
Subject: Re: Fwd: Lexar NM790 SSDs are not recognized anymore after 6.1.50 LTS
Message-ID: <ZPc8v9-lHF4jAcxL@kbusch-mbp>
References: <8af186ba-5f64-2102-8f9c-3969b0906893@gmail.com>
 <faa245bf-e925-45b0-9827-b0c9c117e06c@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <faa245bf-e925-45b0-9827-b0c9c117e06c@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 01:37:36PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 04.09.23 13:07, Bagas Sanjaya wrote:
> > 
> > I notice a regression report on Bugzilla [1]. Quoting from it:
> >
> >> I bought a new 4 TB Lexar NM790 and I was using kernel 6.3.13 at the time. It wasn't recognized, with these messages in dmesg:
> >>
> >> [ 358.950147] nvme nvme0: pci function 0000:06:00.0
> >> [ 358.958327] nvme nvme0: Device not ready; aborting initialisation, CSTS=0x0
> >>
> >> My other NVMe appears correctly in the nvme list though.
> >>
> >>
> >> So I tried using other kernels I had installed at the time: 6.3.7, 6.4.10, 6.5.0rc6, 6.5.0, 6.5.1 and none of these recognized the disk.
> >> I installed the 6.1.50 lts kernel from arch repositories (I can compile my own too if this would be an issue) and then the device was correctly recognized:
> >>
> >> [    4.654613] nvme 0000:06:00.0: platform quirk: setting simple suspend
> >> [    4.654632] nvme nvme0: pci function 0000:06:00.0
> >> [    4.667290] nvme nvme0: allocated 40 MiB host memory buffer.
> >> [    4.709473] nvme nvme0: 16/0/0 default/read/poll queues
> 
> FWIW, the quoted mail missed one crucial detail:
> """
>  Claudio Sampaio 2023-09-02 19:04:29 UTC
> 
> Adding the two lines
> 
> │ 3457   { PCI_DEVICE(0x1d97, 0x1602), /* Lexar NM790 */
> │ 3458   │ .driver_data = NVME_QUIRK_BOGUS_NID, },
> 
> in file drivers/nvme/host/pci.c made my NVMe work correctly. Compiled a
> new 6.5.1 kernel and everything works.
> """
> 
> @NVME maintainers: is there anything more you need from Claudio at this
> point?

Yes: it doesn't really make any sense. The report says the device
stopped showing up with message:

  nvme nvme0: Device not ready; aborting initialisation, CSTS=0x0

That (a) happens long before the mentioned quirk is considered by the
driver, and (b) the "quirk" behavior is now the default in 6.5 and
several of the listed stable kernels anyway.

It more likely sounds like the device is flaky and either never becomes
ready due to some unspecified internal firmware condition, or
inaccurately reports how long it actually needs to become ready in
worst-case-scenario.
