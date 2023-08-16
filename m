Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1EC77E5C4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344451AbjHPP6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344450AbjHPP5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:57:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B364DF;
        Wed, 16 Aug 2023 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nnivj+BSqKMc+xwc+eEn6cXNwaHDAf2JZzgJFKNs6gY=; b=ixM0m4x1KK+72Y34H1B3ellzL2
        e/VO1yjQfDsZgBfqLfN1shRBNEQBCnZvhcveSDSFjVFxttO2Ck2lY0hUJ7kc7WW1ny9ydqWp+Fv6e
        nBojvUhdIpDZWxki/yBmWs0oeC8w8QQ3P/llr7BcBnCq7QPxEBXCSjpsCeE6rfT5pG2VuhgSHVfHf
        UeNmXsCkWaUheQOCpcoRd9oiRpE2VnBZovph3OUFE7RvwCxaMdn+A0vSw6bC8imST7rpH1/hiXDbY
        JgpfczMxDelpu8uLAui6vL10KaRakprKb69e56di+l/Sx5ljNey+jc4B8I8cFyyVvbb9OwIJGR/Fq
        e4jVm8ng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qWItw-00FYRH-Pa; Wed, 16 Aug 2023 15:57:40 +0000
Date:   Wed, 16 Aug 2023 16:57:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avadhut Naik <Avadhut.Naik@amd.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [RFC] Proposal to relax warnings of htmldocs
Message-ID: <ZNzx9IAtsqP3KC/P@casper.infradead.org>
References: <85964510-4f88-58d2-2687-f7fa76013cf9@amd.com>
 <87v8dgtb9o.fsf@meer.lwn.net>
 <CANiq72=8DH8SZS2TZF+nHzCq3onXz-OuyE-xmYZncDmiKqVfzQ@mail.gmail.com>
 <ZNvGz4v2QYowrhk0@casper.infradead.org>
 <87bkf79row.fsf@intel.com>
 <f7d0e554-b6ac-49ee-4caf-640967bc1053@amd.com>
 <ZNzoEVYE1dTOnni4@casper.infradead.org>
 <16011802-fb29-da56-a1b9-8cc1182dd449@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16011802-fb29-da56-a1b9-8cc1182dd449@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 10:21:07AM -0500, Carlos Bilbao wrote:
> On 8/16/23 10:15, Matthew Wilcox wrote:
> > I wasn't proposing making W=1 builds the default; I was proposing
> > running kernel-doc -none at all levels.
> 
> More strict warning level, right? My concern is the same.

The problem you're seeing with kernel-doc warning about undocumented
fields / parameters is due to people not running kernel-doc -none.
So I'm proposing this:

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 82e3fb19fdaf..52f57c0c5227 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -100,11 +100,9 @@ else ifeq ($(KBUILD_CHECKSRC),2)
         cmd_force_checksrc = $(CHECK) $(CHECKFLAGS) $(c_flags) $<
 endif

-ifneq ($(KBUILD_EXTRA_WARN),)
-  cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $(KDOCFLAGS) \
+cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $(KDOCFLAGS) \
         $(if $(findstring 2, $(KBUILD_EXTRA_WARN)), -Wall) \
         $<
-endif

 # Compile C sources (.c)
 # ---------------------------------------------------------------------------

Now everybody runs kernel-doc -none on every build and you don't get to
see that problem any more.
