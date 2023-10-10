Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921C07BEF69
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 02:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379124AbjJJAB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 20:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377918AbjJJAB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:01:57 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9982DA3;
        Mon,  9 Oct 2023 17:01:56 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 4F17692009C; Tue, 10 Oct 2023 02:01:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 4B7CF92009B;
        Tue, 10 Oct 2023 01:01:53 +0100 (BST)
Date:   Tue, 10 Oct 2023 01:01:53 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Arnd Bergmann <arnd@kernel.org>
cc:     Ian Abbott <abbotti@mev.co.uk>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] comedi: Fix driver module dependencies since HAS_IOPORT
 changes
In-Reply-To: <8728313c-997a-46c1-8225-d57369e9292c@app.fastmail.com>
Message-ID: <alpine.DEB.2.21.2310100018361.48714@angie.orcam.me.uk>
References: <20230901192615.89591-1-abbotti@mev.co.uk> <33c2292b-08cb-44c7-9438-07d4060976ab@app.fastmail.com> <f0e88ae3-d38e-40d1-900c-395ddc9c8231@mev.co.uk> <65d620b2644e2d60b041815fa4bb544a818ae55a.camel@linux.ibm.com> <ab5baa69-ae3c-4973-8563-670395a3c976@mev.co.uk>
 <8728313c-997a-46c1-8225-d57369e9292c@app.fastmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Sep 2023, Arnd Bergmann wrote:

> Yes, I think that will always be a safe assumption, ISA without port I/O
> is just not a sensible configuration. A few of the later ISA devices use
> PCI style memory mapped I/O, but I can't think of any driver that doesn't
> also require port I/O, and you wouldn't find ISA slots in a system that
> lacks support for port I/O.

 FWIW for the 8086 CPU as it was designed back in 1970s (and borrowing 
from the 8080/8085) and consequently IBM PC systems of 1980s memory and 
I/O bus cycles were meant for resource accesses as the respective names 
implied, there was no concept of MMIO for those systems back then, which 
came later from CPU architectures that only have a single address space.

 With those ISA option cards memory bus cycles were typically decoded by 
an option ROM where implemented (for system BIOS expansion), sometimes 
socketed (e.g. for a network card's optional boot ROM), and video adapters 
(graphics or text-only such as the MDA) also decoded memory bus cycles to 
video RAM.  There were also ISA memory expansion cards, exceedingly rare, 
which decoded memory bus cycles to onboard RAM.

 For anything else I/O bus cycles were used, so for the purpose of our 
consideration ISA pretty much equals I/O and the presence of ISA implies a 
way to generate 8086 bus I/O cycles in a system, regardless of what native 
bus protocols the host CPU might implement.

  Maciej
