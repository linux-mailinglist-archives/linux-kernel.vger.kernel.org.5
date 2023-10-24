Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D727D4585
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjJXCdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJXCdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:33:42 -0400
Received: from out0-215.mail.aliyun.com (out0-215.mail.aliyun.com [140.205.0.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA6BE8;
        Mon, 23 Oct 2023 19:33:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047202;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---.V6N0APV_1698114808;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.V6N0APV_1698114808)
          by smtp.aliyun-inc.com;
          Tue, 24 Oct 2023 10:33:29 +0800
Date:   Tue, 24 Oct 2023 10:33:28 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "moderated list:XEN HYPERVISOR X86" <xen-devel@lists.xenproject.org>,
        "open list:X86 PLATFORM DRIVERS - ARCH" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/xen/pvh: Set up percpu for stack canary in
 32-bit kernel entry
Message-ID: <20231024023328.GA29837@k08j02272.eu95sqa>
References: <cover.1698051454.git.houwenlong.hwl@antgroup.com>
 <90df6cf5674241a85ac7dfe0a1558f1fd025cc17.1698051454.git.houwenlong.hwl@antgroup.com>
 <CAHp75VeXiOprRDNakewo2iSe==EeLUxfxuPYS3R+ZsY2KDmQBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeXiOprRDNakewo2iSe==EeLUxfxuPYS3R+ZsY2KDmQBQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 08:02:02PM +0800, Andy Shevchenko wrote:
> On Mon, Oct 23, 2023 at 12:10 PM Hou Wenlong
> <houwenlong.hwl@antgroup.com> wrote:
> >
> > In a 32-bit SMP kernel, the stack canary is a percpu variable accessed
> > as %fs:__stack_chk_guard. However, the ABI for PVH entry does not
> > specify the %fs register state. It currently works because the initial
> > %fs register is 0x10 for QEMU, which is the same as $PVH_DS_SEL.
> 
> > %However, for added safety, the percpu should be set up explicitly
> > %before calling xen_prepare_pvh(), which accesses the stack canary.
> 
> Stray leading % in two lines above.
>
Oh, sorry for that. It was added by mistake by my editor, and I didn't
carefully review it before sending.
 
Thanks!

> -- 
> With Best Regards,
> Andy Shevchenko
