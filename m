Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C406A7803E3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 04:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357285AbjHRCkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 22:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357290AbjHRCj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 22:39:58 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8349F273C;
        Thu, 17 Aug 2023 19:39:56 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 6B4D192009C; Fri, 18 Aug 2023 04:39:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 63E9392009B;
        Fri, 18 Aug 2023 03:39:55 +0100 (BST)
Date:   Fri, 18 Aug 2023 03:39:55 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v3 1/3] MIPS: Remove noreturn attribute for
 nmi_exception_handler()
In-Reply-To: <1692005246-18399-2-git-send-email-yangtiezhu@loongson.cn>
Message-ID: <alpine.DEB.2.21.2308180227580.8596@angie.orcam.me.uk>
References: <1692005246-18399-1-git-send-email-yangtiezhu@loongson.cn> <1692005246-18399-2-git-send-email-yangtiezhu@loongson.cn>
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

On Mon, 14 Aug 2023, Tiezhu Yang wrote:

> In the later patch, we will remove noreturn attribute for die(), in order
> to make each patch can be built without errors and warnings, just remove
> noreturn attribute for nmi_exception_handler() earlier because it calls
> die(), otherwise there exists the following build error after the later
> patch:

 I find the wording a bit odd here, but you'll have to rewrite the change 
description for the update requested below, so let's defer any style fixes 
to v4.

>   arch/mips/kernel/traps.c:2001:1: error: 'noreturn' function does return [-Werror]

 Now that I've looked into it in detail, this change is incomplete and 
will make the kernel go astray if `nmi_exception_handler' actually ever 
does return.  See code in arch/mips/kernel/genex.S, which calls this 
function and doesn't expect it to return.  It has to be fixed before 2/3 
can be considered.  I wonder how you didn't catch it: you did check how 
this code is used, didn't you?

 Before submitting an updated version can you actually arrange for the 
NOTIFY_STOP condition to happen in your lab and verify it is handled as 
expected?  And what was the motivation for this code update, just a 
hypothetical scenario?

  Maciej
