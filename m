Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD451781226
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379143AbjHRRjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379231AbjHRRjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:39:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A74E3C25;
        Fri, 18 Aug 2023 10:39:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD87667E56;
        Fri, 18 Aug 2023 17:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A31C433C8;
        Fri, 18 Aug 2023 17:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692380347;
        bh=4mrMBMQCt3eC/q7RwFbH0gGMN9gDD6qugmRXW2bkuOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZKinp7UZ9KJ92P7fJU5Nymt/UY1x44pWnjgR4gMHJyYeuAmHxTTjQecajXghL8VlT
         gOPO62VL3dKQ/R1xYz11JiFmiQCssmFvFeHkJQDVJM7/SzOB0PgZJ11IYDkCR6FZzC
         jMuCVz/TJhG19D2EfmO8OnIrQAxyPt3E8b/eu28hwkeLz4wgy57aBV9YH1nMLpkhUa
         HNYv+u3OtDBCXECVLEWFMwk8VXFk2RMELRVHmrR6nwTBuBu+H8hf+8TPqCF+hIhdLB
         ZdP5FbgJeFeXYqldPjVmakqp1DN4b8LRcbwN1p/28cMn6Z4ORmHe0D20LzvieocvRc
         /OJ3YN60PrHDw==
Date:   Fri, 18 Aug 2023 18:39:02 +0100
From:   Lee Jones <lee@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Justin Stitt <justinstitt@google.com>, Pavel Machek <pavel@ucw.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] leds: pca955x: fix -Wvoid-pointer-to-enum-cast warning
Message-ID: <20230818173902.GE986605@google.com>
References: <20230816-void-drivers-leds-leds-pca955x-v1-1-2967e4c1bdcc@google.com>
 <20230818160154.GZ986605@google.com>
 <20230818160648.GA939927@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230818160648.GA939927@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023, Nathan Chancellor wrote:

> On Fri, Aug 18, 2023 at 05:01:54PM +0100, Lee Jones wrote:
> > On Wed, 16 Aug 2023, Justin Stitt wrote:
> > 
> > > When building with clang 18 I see the following warning:
> > > |      drivers/leds/leds-pca955x.c:487:15: warning: cast to smaller integer
> > > |      type 'enum pca955x_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> > > |        487 |                 chip_type = (enum pca955x_type)md;
> > > 
> > > This is due to the fact that `md` is a void* while `enum pca995x_type` has the
> > > size of an int.
> > > 
> > > Add uintptr_t cast to silence clang warning while also keeping enum cast
> > > for readability and consistency with other `chip_type` assignment just a
> > > few lines below:
> > > |	chip_type = (enum pca955x_type)id->driver_data;
> > > 
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/1910
> > > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > 
> > A review from Nathan would be good here.
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Thank you.

-- 
Lee Jones [李琼斯]
