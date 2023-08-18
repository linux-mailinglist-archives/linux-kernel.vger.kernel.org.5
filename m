Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C931780C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377117AbjHRNSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377094AbjHRNSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:18:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E13D2723;
        Fri, 18 Aug 2023 06:18:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 124026419A;
        Fri, 18 Aug 2023 13:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD58C433C8;
        Fri, 18 Aug 2023 13:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692364706;
        bh=IKd1RReQYPqG4VwaJKrR1V+GcZ7FENZQ32BY/mi7Tm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ldvO5xlU53sBjF0dHgumsaQwepXbBcOl8j72QxCUrXI/BiEaBY5nPmSGvq8cPCQIt
         UR4oljnyBo36YaByjA8hcZbkzBzkCp2z+yhx2O+2kGeNeJrbPUdkL0IZ6InD1JQUQM
         q/SfhARlrW+FreCxnXUVHL9UfRE8Kccw4aqft02+vfH+C60uVjuS/JE0qz/4M7wF1g
         G06+T0mmh16B6DsIgS+KDSSHpc7nMpcBO2xyVDODe8JJMdFpGaIDwXOU8PI3hyKK7U
         7yp5q9/1HISXENCXq+fdwTokunyKpSUzY/Z8dH5BLq3u948j9+rvCl+xupPbh4Vxme
         pSB3Ax81NIB3A==
Date:   Fri, 18 Aug 2023 15:18:16 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Tyler Hicks <code@tyhicks.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 0/3] fs/ecryptfs: Replace kmap{,_atomic}() with
 kmap_local_page()
Message-ID: <20230818-merklich-lagebericht-003a3e9c0357@brauner>
References: <20230426172223.8896-1-fmdefrancesco@gmail.com>
 <20230630-umfang-pumpt-a0cd2d6cdd91@brauner>
 <4506725.LvFx2qVVIh@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4506725.LvFx2qVVIh@suse>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 07:13:56PM +0200, Fabio M. De Francesco wrote:
> On venerdì 30 giugno 2023 10:45:17 CEST Christian Brauner wrote:
> > On Wed, 26 Apr 2023 19:22:20 +0200, Fabio M. De Francesco wrote:
> > > kmap() and kmap_atomic() have been deprecated in favor of
> > > kmap_local_page().
> > > 
> > > Therefore, replace kmap() and kmap_atomic() with kmap_local_page().
> > > 
> > > Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
> > > HIGHMEM64GB enabled.
> > > 
> > > [...]
> > 
> > Picking this up. Please tell me if this should be routed somewhere else.
> > vfs.misc will be rebased once v6.5-rc1 is released.
> 
> Christian,
> 
> v6.5-rc1 has been released since a while, but I can't yet see this series. Are 
> there problems with these patches that stop their merge?

Nothing stops them. I just planned to send all of this for v6.6. as I
didn't see a need to sent it earlier.

This message made neomutt crash like crazy btw. So I had to get create
to be able to reply to so hopefully that message gets through...
