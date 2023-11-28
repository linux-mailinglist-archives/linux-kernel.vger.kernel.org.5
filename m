Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA6B7FC84E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbjK1VZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjK1VZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:25:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDEA4207
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:18:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A538C433C7;
        Tue, 28 Nov 2023 21:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701206319;
        bh=2xJoqOXzowQov7rGEZ+wIhMYrsWPhUXeNx2JqUp3pIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=naCP1vOiWrIq2FSW6NNJWkk9c9jWrjCjm8q/MIxC9HcWht+n6mbrvnh8Tx1P7534Z
         bGxGnCGC0PgcjoH27gnoAEc6Otg/Fr1JqNK41HianawYpNwSABgi378Cg0ncrDaZLV
         tujCg8La1DutgwqrKcJoH8EqGbKIohwJvJtzrhbA=
Date:   Tue, 28 Nov 2023 21:18:37 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Fran=E7ois?= Valenduc <francoisvalenduc@gmail.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz
Subject: Re: Linux 6.1.64
Message-ID: <2023112822-extending-character-5e45@gregkh>
References: <2023112826-glitter-onion-8533@gregkh>
 <7f07bb2d-bb00-4774-8cc0-d66b7210380c@gmail.com>
 <2023112843-strep-goliath-875c@gregkh>
 <0d1087e9-a8f2-48ee-bc8d-bc2a5518571a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d1087e9-a8f2-48ee-bc8d-bc2a5518571a@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 10:11:32PM +0100, François Valenduc wrote:
> 
> Le 28/11/23 à 20:35, Greg Kroah-Hartman a écrit :
> > On Tue, Nov 28, 2023 at 08:22:22PM +0100, François Valenduc wrote:
> > > Build fails on my baremetal server on scaleway:
> > > 
> > > In file included from arch/x86/kvm/vmx/vmx.c:54:
> > > arch/x86/kvm/vmx/evmcs.h:215:20: note: previous definition of
> > > ‘evmptr_is_valid’ with type ‘bool(u64)’ {aka ‘_Bool(long long unsigned
> > > int)’}
> > >    215 | static inline bool evmptr_is_valid(u64 evmptr)
> > >        |                    ^~~~~~~~~~~~~~~
> > > In file included from arch/x86/kvm/vmx/vmx.c:55:
> > > arch/x86/kvm/vmx/hyperv.h:184:6: error: redeclaration of ‘enum
> > > nested_evmptrld_status’
> > >    184 | enum nested_evmptrld_status {
> > >        |      ^~~~~~~~~~~~~~~~~~~~~~
> > > In file included from arch/x86/kvm/vmx/vmx.c:54:
> > > arch/x86/kvm/vmx/evmcs.h:220:6: note: originally defined here
> > >    220 | enum nested_evmptrld_status {
> > >        |      ^~~~~~~~~~~~~~~~~~~~~~
> > > In file included from arch/x86/kvm/vmx/vmx.c:55:
> > > arch/x86/kvm/vmx/hyperv.h:185:9: error: redeclaration of enumerator
> > > ‘EVMPTRLD_DISABLED’
> > >    185 |         EVMPTRLD_DISABLED,
> > >        |         ^~~~~~~~~~~~~~~~~
> > > In file included from arch/x86/kvm/vmx/vmx.c:54:
> > > arch/x86/kvm/vmx/evmcs.h:221:9: note: previous definition of
> > > ‘EVMPTRLD_DISABLED’ with type ‘enum nested_evmptrld_status’
> > >    221 |         EVMPTRLD_DISABLED,
> > >        |         ^~~~~~~~~~~~~~~~~
> > > In file included from arch/x86/kvm/vmx/vmx.c:55:
> > > arch/x86/kvm/vmx/hyperv.h:186:9: error: redeclaration of enumerator
> > > ‘EVMPTRLD_SUCCEEDED’
> > >    186 |         EVMPTRLD_SUCCEEDED,
> > >        |         ^~~~~~~~~~~~~~~~~~
> > > In file included from arch/x86/kvm/vmx/vmx.c:54:
> > > arch/x86/kvm/vmx/evmcs.h:222:9: note: previous definition of
> > > ‘EVMPTRLD_SUCCEEDED’ with type ‘enum nested_evmptrld_status’
> > >    222 |         EVMPTRLD_SUCCEEDED,
> > >        |         ^~~~~~~~~~~~~~~~~~
> > > In file included from arch/x86/kvm/vmx/vmx.c:55:
> > > arch/x86/kvm/vmx/hyperv.h:187:9: error: redeclaration of enumerator
> > > ‘EVMPTRLD_VMFAIL’
> > >    187 |         EVMPTRLD_VMFAIL,
> > >        |         ^~~~~~~~~~~~~~~
> > > In file included from arch/x86/kvm/vmx/vmx.c:54:
> > > arch/x86/kvm/vmx/evmcs.h:223:9: note: previous definition of
> > > ‘EVMPTRLD_VMFAIL’ with type ‘enum nested_evmptrld_status’
> > >    223 |         EVMPTRLD_VMFAIL,
> > >        |         ^~~~~~~~~~~~~~~
> > > In file included from arch/x86/kvm/vmx/vmx.c:55:
> > > arch/x86/kvm/vmx/hyperv.h:188:9: error: redeclaration of enumerator
> > > ‘EVMPTRLD_ERROR’
> > >    188 |         EVMPTRLD_ERROR,
> > >        |         ^~~~~~~~~~~~~~
> > > In file included from arch/x86/kvm/vmx/vmx.c:54:
> > > arch/x86/kvm/vmx/evmcs.h:224:9: note: previous definition of
> > > ‘EVMPTRLD_ERROR’ with type ‘enum nested_evmptrld_status’
> > >    224 |         EVMPTRLD_ERROR,
> > >        |         ^~~~~~~~~~~~~~
> > > make[3]: *** [scripts/Makefile.build:250: arch/x86/kvm/vmx/vmx.o] Error 1
> > > make[2]: *** [scripts/Makefile.build:500: arch/x86/kvm] Error 2
> > > make[1]: *** [scripts/Makefile.build:500: arch/x86] Error 2
> > > 
> > > The configuration file is attached. Kernel 6.1.62 compiled fine.
> > > Does somebody have an idea about this ?
> > I just tried your .config file here and it builds just fine for 6.1.64,
> > what version of gcc are you using that causes failures?  I tried gcc-12
> > successfully.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Bisection gave very strange results until I found the tree was corrupted. I
> recreated it correctly and it works fine.
> Sorry for the noise.

No worries, thanks for reporting it, glad it is resolved.

greg k-h
