Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D34C76A9EF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjHAH1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjHAH1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:27:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B723519B0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 00:27:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 337D8614A7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CCDC433C7;
        Tue,  1 Aug 2023 07:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690874858;
        bh=TTI6XFfx2Tvftp6nyvhuHx+8knaITgZFjuONQQ1Qu6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o+E28iGDo8ZiTrhhKcK8afUgwtGkdg/o1AXAHT7K7DcAhhkfBibqWFn4TonwgjY4C
         BhWLdX/XisV4KP5r8owdHFN6+9Ee0V4zIx3FGETdpdj+8Qa1dNWPsQ4czh9akJ4JkY
         eqE1YgcrzKtSV6Piz42Lk8WIaYGo8iC3OL4Jom/MEPCE+7qm3RL7wWByA0kaX7w1lO
         heJXXX1exK59RUXCGHPX6ywIIZgdvNurw2tuVOLxeadrqgxY1+i7Gzlc4naXEey+oh
         +dDu6bE9eVPItetG5RiuEAtTbyUDjlpod0dgW0CbYpmnbopLIpvnoAmYs3Gq8wX8kr
         0b5pSZSaeHjXQ==
Date:   Tue, 1 Aug 2023 08:27:33 +0100
From:   Will Deacon <will@kernel.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        wangkefeng.wang@huawei.com, catalin.marinas@arm.com,
        ardb@kernel.org
Subject: Re: arm64: perf test 26 rpi4 oops
Message-ID: <20230801072732.GA25854@willie-the-truck>
References: <b39c62d29a431b023e98959578ba87e96af0e030.camel@gmx.de>
 <20230728141852.GA21718@willie-the-truck>
 <8c56256399e2e6c41bc574749d6170d5529f24fc.camel@gmx.de>
 <20230731104340.GA24767@willie-the-truck>
 <20230731115207.GB24767@willie-the-truck>
 <CAA5enKaUYehLZGL3abv4rsS7caoUG-pN9wF3R+qek-DGNZufbA@mail.gmail.com>
 <CAA5enKYaZ-daLeL3amr2QrQjtUdK=P8B+VbJdea7cB77QWY-eQ@mail.gmail.com>
 <42ad26cb6c98e028a331f5d73abf85bd965ff89d.camel@gmx.de>
 <21777dec0233b1bc65f51764ead9a03efa9baa64.camel@gmx.de>
 <7b94619ad89c9e308c7aedef2cacfa10b8666e69.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b94619ad89c9e308c7aedef2cacfa10b8666e69.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 06:34:15AM +0200, Mike Galbraith wrote:
> On Tue, 2023-08-01 at 01:48 +0200, Mike Galbraith wrote:
> >
> > root@rpi4:~# dmesg|tail -2
> > [  979.003019] __vm_enough_memory: pid: 12439, comm: objdump, not enough memory for the allocation
> > [  979.003080] __vm_enough_memory: pid: 12439, comm: objdump, not enough memory for the allocation
> 
> Ancient bug droppings are due to VMALLOC_END-VMALLOC_START=265885319168.

FWIW, I see the same thing on my x86 laptop. I'm guessing objdump tries
to read all of the vmalloc space into memory, which is going to end
pretty badly!

Will
