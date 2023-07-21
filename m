Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB5675BD28
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 06:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjGUENq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 00:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGUENf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 00:13:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E602729;
        Thu, 20 Jul 2023 21:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=2F/PvH5rU8feN3Ho3myXK2A3ABweq+g65TCLK6TYKDE=; b=mhFljn3OHXTptF+4QQrQhkLabL
        J1AEPolOQJ/AFHluiQ24FPJSbQdHQGeNS1+fTOkLpkMM/f7ulFigcCt0kJ3GBsBsFfSTH4AKWjp3r
        XknHz+R0WZJHXf/mUaEi55TC+7Y2jR08Ny28I4lgbLCqbDkYPmmgbl/ylrqkGTooAemvgpMqBKR8H
        Mf9WFmluoUTxDXNSxt9lJJoRvOMAU9Zpwg9mwCrcqmumHxyeb5x6vc86MMUvGLKYHohGZFfYYZRKY
        7kd9U5/WdHAD4dIrACt9k/Gvp7VeiFt4fefu4jTWx4QxT+CtH4eq6fs07MKbZLbXBiUP3Bhnvhxyw
        iCucOs2g==;
Received: from c-71-59-149-187.hsd1.or.comcast.net ([71.59.149.187] helo=[10.0.0.152])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qMhW8-00CnxD-0o;
        Fri, 21 Jul 2023 04:13:24 +0000
Message-ID: <63a46a4e-53d4-6d18-7f6e-fee1c9890c79@infradead.org>
Date:   Thu, 20 Jul 2023 21:13:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Fwd: 6.4.4 breaks module-free builds of Debian kernel packages
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Brian Lindholm <brian_lindholm@users.sourceforge.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>
References: <e7292802-e517-6469-6fbd-a4d30887c99b@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <e7292802-e517-6469-6fbd-a4d30887c99b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas,

On 7/20/23 20:18, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> I'm on AMD64 with Debian testing (trixie), where I build my own kernels (with CONFIG_MODULES unset) using "make bindeb-pkg". The build proceeds through 99% of the process, but fails here:
>>
>> Kernel: arch/x86/boot/bzImage is ready  (#2)
>> make -f ./Makefile ARCH=x86     KERNELRELEASE=6.4.4-i5 intdeb-pkg
>> sh ./scripts/package/builddeb
>> ***
>> *** The present kernel configuration has modules disabled.
>> *** To use the module feature, please run "make menuconfig" etc.
>> *** to enable CONFIG_MODULES.
>> ***
>> make[5]: *** [Makefile:1969: modules_install] Error 1
>> make[4]: *** [scripts/Makefile.package:150: intdeb-pkg] Error 2
>> make[3]: *** [Makefile:1657: intdeb-pkg] Error 2
>> make[2]: *** [debian/rules:16: binary-arch] Error 2
>> dpkg-buildpackage: error: debian/rules binary subprocess returned exit status 2
>> make[1]: *** [scripts/Makefile.package:139: bindeb-pkg] Error 2
>> make: *** [Makefile:1657: bindeb-pkg] Error 2
>>
>> 6.3.13 contained the same error, but I "fixed" that by moving to 6.4.3.  But alas, 6.4.4 now has the same issue.
>>
>> I worked around the issue by changing "exit 1" to "exit 0" in the main Makefile (at "modules module_install", per the attached patch), but I don't know if this is a true fix or something that simply happens to work for my particular configuration.
> 
> See Bugzilla for the full thread and attached patch that ignores the error.
> 
> Josh: It looks like this regression is caused by a commit of yours
> (and also 1240dabe8d58b4). Would you like to take a look on it?
> 
> Anyway, I'm adding this regression to be tracked by regzbot:
> 
> #regzbot introduced: 4243afdb932677 https://bugzilla.kernel.org/show_bug.cgi?id=217689
> #regzbot title: always doing modules_install breaks CONFIG_MODULES=n builds
> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217689


Do you also take care of marking the bugzilla entries as completed/fixed/solved
etc.?

thanks.
-- 
~Randy
