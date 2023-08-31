Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3204378E4B5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 04:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241633AbjHaC0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 22:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbjHaC0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 22:26:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C72CD2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 19:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WvZo355H4sRaXT6dcpJuCYQoTvTM4NTFOhepAiKS2qo=; b=NTE5rtIgr6W7Qi8piSZsGaq1TD
        Lofva6kduxuyWnvHtwhzt5udAdoWoquR7EsaAlyU+yr7L5CfJtaA2EtW6Dg8ZFGQo6+ijEoXKqePw
        PjaJ97avELLQKMiOGBiJy6bvgbxE4BsvksjDyneX6pOoFdHfJV39w3xB3Ktb+5G3I5K7Zkq14M6uF
        cPwA0Nrq4kPSzFLwS9JShV3fFLHsYh/ZASKvPKOCRCMuveZM9oWuaUccqHZkcLMuDF4C/hOkDfv2U
        uandfVcdzPCPr25SYRkHNOEsVTe5sHOA/KnR9kLCvqU/5rrNn5m2cUFXiivAvD5HU+pNVnBjDRDL+
        CRYu2pKg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qbXNN-00GLLp-AY; Thu, 31 Aug 2023 02:25:41 +0000
Date:   Thu, 31 Aug 2023 03:25:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Xie XiuQi <xiexiuqi@huaweicloud.com>
Cc:     akpm@linux-foundation.org, irogers@google.com, acme@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH RESEND] tools/mm: fix undefined reference to pthread_once
Message-ID: <ZO/6JcbLV7+Eb0Vz@casper.infradead.org>
References: <20230828122157.1541087-1-xiexiuqi@huaweicloud.com>
 <ZOyZ9FgRUOGPh3qm@casper.infradead.org>
 <e4027374-88a9-9484-1619-8c3f887a58ca@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4027374-88a9-9484-1619-8c3f887a58ca@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 09:13:24AM +0800, Xie XiuQi wrote:
> Hi,
> 
> On 2023/8/28 20:58, Matthew Wilcox wrote:
> > On Mon, Aug 28, 2023 at 08:21:57PM +0800, Xie XiuQi wrote:
> >> diff --git a/tools/mm/Makefile b/tools/mm/Makefile
> >> index 6c1da51f4177..9997b2e401ae 100644
> >> --- a/tools/mm/Makefile
> >> +++ b/tools/mm/Makefile
> >> @@ -9,7 +9,7 @@ LIB_DIR = ../lib/api
> >>  LIBS = $(LIB_DIR)/libapi.a
> >>  
> >>  CFLAGS += -Wall -Wextra -I../lib/
> >> -LDFLAGS += $(LIBS)
> >> +LDFLAGS += $(LIBS) -lpthread
> > 
> > Is this the right fix?  I'm pretty sure you're suppose to use -pthread
> > in CFLAGS in case there are other things the compiler/linker/whatever
> > need.
> > 
> 
> Thanks for your comment. I'll fix it and send v2.

You added it to LDFLAGS, not CFLAGS.

> > '-pthread'
> >      Define additional macros required for using the POSIX threads
> >      library.  You should use this option consistently for both
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >      compilation and linking.  This option is supported on GNU/Linux
         ^^^^^^^^^^^^^^^^^^^^^^^
> >      targets, most other Unix derivatives, and also on x86 Cygwin and
> >      MinGW targets.
> > 
> 
> 
