Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28D27D40A7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 22:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjJWULY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 16:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJWULW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 16:11:22 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BC561A4;
        Mon, 23 Oct 2023 13:11:19 -0700 (PDT)
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C580F72C8D3;
        Mon, 23 Oct 2023 23:11:18 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id BC0037CFF64; Mon, 23 Oct 2023 23:11:18 +0300 (IDT)
Date:   Mon, 23 Oct 2023 23:11:18 +0300
From:   "Dmitry V. Levin" <ldv@strace.io>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     dave.hansen@linux.intel.com, bp@alien8.de, x86@kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/uapi: fix SHADOW_STACK_SET_TOKEN type
Message-ID: <20231023201118.GA19800@altlinux.org>
References: <20231022222134.GA5334@altlinux.org>
 <006699efc5ccdce1bd62f45ef2852ab0233e295c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <006699efc5ccdce1bd62f45ef2852ab0233e295c.camel@intel.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 04:36:48PM +0000, Edgecombe, Rick P wrote:
> On Mon, 2023-10-23 at 01:21 +0300, Dmitry V. Levin wrote:
> > Fix the type of SHADOW_STACK_SET_TOKEN to match the type of the
> > corresponding "flags" argument of map_shadow_stack syscall which
> > is of type "unsigned int".
> > 
> > Fixes: c35559f94ebc3 ("x86/shstk: Introduce map_shadow_stack
> > syscall")
> > Signed-off-by: Dmitry V. Levin <ldv@strace.io>
> > ---
> > šarch/x86/include/uapi/asm/mman.h | 2 +-
> > š1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/include/uapi/asm/mman.h
> > b/arch/x86/include/uapi/asm/mman.h
> > index 46cdc941f958..8419e25bb617 100644
> > --- a/arch/x86/include/uapi/asm/mman.h
> > +++ b/arch/x86/include/uapi/asm/mman.h
> > @@ -6,7 +6,7 @@
> > š#define MAP_ABOVE4Gšššš0x80šššššššššššš/* only map above 4GB */
> > š
> > š/* Flags for map_shadow_stack(2) */
> > -#define SHADOW_STACK_SET_TOKENš(1ULL << 0)ššššš/* Set up a restore
> > token in the shadow stack */
> > +#define SHADOW_STACK_SET_TOKENš(1U << 0)ššššššš/* Set up a restore
> > token in the shadow stack */
> > š
> > š#include <asm-generic/mman.h>
> 
> Good point that they are mismatched. I don't remember why flags is not
> an unsigned long though. I wonder if we should quick change it to an
> unsigned long, if it's not too late. We probably won't run out of
> flags, but maybe some value could get stuffed in the upper bits or
> something someday.

We usually don't use unsigned long for flags because we support 32-bit
architectures.


-- 
ldv
