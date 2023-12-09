Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B83180B10D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 01:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574936AbjLIAdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 19:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbjLIAdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 19:33:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F961723
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 16:33:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DFFC433C8;
        Sat,  9 Dec 2023 00:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702082026;
        bh=AfLb7lzkekGavRKpv+fk7GiWlvNDaLb3U1ZIzEmK8vc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=s/AC66OH8JYebqlwn7OY8iCTM3N3Z5QjmwjeORQmgOQYNGEUxU9lFRuUytR5985NK
         w5QAAdBIPHdBfee73BSoMsySU7ilCs76Ck6nvwyS7eZpX7wQPt1uLuXKDpxcfseJ7h
         15UoWofUJQRlDqCiz8Z/dNBhkkqtrhyPL3sGTX9lxt8dsNVX4jdfKnFFIGEAPMGyv2
         cunwV+v7cpv0F1m3S7yluXxE4l99rWVFIN7sFUyOBVM8Wf8f6IteZJl84BuJHfVQob
         4EAF0rIMtyEc7TY7GUHoF4umQEeAoW6AWeCn7EsqJXV1bnFryCyrMzVggpjTh2vGnw
         9Dz4oSRZJE/+w==
Message-ID: <b78607e5-6965-4e7f-b43a-c1ca58eecf89@kernel.org>
Date:   Fri, 8 Dec 2023 16:33:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: arch/arc/kernel/setup.c:203 arcv2_mumbojumbo() error:
 uninitialized symbol 'release'.
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        oe-kbuild@lists.linux.dev, Vineet Gupta <vgupta@kernel.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org
References: <c2148229-bea9-40ef-bbf3-6019555f3f1a@suswa.mountain>
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <c2148229-bea9-40ef-bbf3-6019555f3f1a@suswa.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 22:22, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
> commit: fad84e39f116035ae8d550c6020107b8ac113b45 ARC: boot log: eliminate struct cpuinfo_arc #4: boot log per ISA
> config: arc-randconfig-r071-20231128 (https://download.01.org/0day-ci/archive/20231128/202311280906.VAIwEAfT-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231128/202311280906.VAIwEAfT-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Closes: https://lore.kernel.org/r/202311280906.VAIwEAfT-lkp@intel.com/
>
> New smatch warnings:
> arch/arc/kernel/setup.c:203 arcv2_mumbojumbo() error: uninitialized symbol 'release'.

Thx, I've posted a fix.

> Old smatch warnings:
> arch/arc/include/asm/thread_info.h:62 current_thread_info() error: uninitialized symbol 'sp'.

This seems like a false warning. Its a register variable and thus can't
possibly be initialized.

static inline __attribute_const__ struct thread_info
*current_thread_info(void)
{
    register unsigned long sp asm("sp");
    return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
}
