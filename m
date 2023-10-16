Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339B87CA89E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjJPM4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjJPM4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:56:20 -0400
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF99F1;
        Mon, 16 Oct 2023 05:56:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.kfki.hu (Postfix) with ESMTP id 6C1E8CC010E;
        Mon, 16 Oct 2023 14:56:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
        by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Mon, 16 Oct 2023 14:56:09 +0200 (CEST)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
        by smtp2.kfki.hu (Postfix) with ESMTP id AE4D6CC010A;
        Mon, 16 Oct 2023 14:56:06 +0200 (CEST)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id 8B45C3431A8; Mon, 16 Oct 2023 14:56:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by blackhole.kfki.hu (Postfix) with ESMTP id 89D09340D74;
        Mon, 16 Oct 2023 14:56:06 +0200 (CEST)
Date:   Mon, 16 Oct 2023 14:56:06 +0200 (CEST)
From:   Jozsef Kadlecsik <kadlec@netfilter.org>
To:     xiaolinkui <xiaolinkui@126.com>
cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, justinstitt@google.com,
        kuniyu@amazon.com, oe-kbuild-all@lists.linux.dev,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH] netfilter: ipset: wait for xt_recseq on all cpus
In-Reply-To: <202310161625.GDDBP8SZ-lkp@intel.com>
Message-ID: <20ae91c-155-32c5-c388-9fdaea5b1eed@netfilter.org>
References: <20231005115022.12902-1-xiaolinkui@126.com> <202310161625.GDDBP8SZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Besides the broken patch, the description simply cannot be true:

"Before destroying the ipset, take a check on sequence to ensure that the 
ip_set_test operation of this ipset has been completed."

Set can only be destroyed when there is no iptables rule (match/target) 
which refers to it. If this condition is not true, then the real reason 
must be fixed.

How can one reproduce the issue?

Best regards,
Jozsef

On Mon, 16 Oct 2023, kernel test robot wrote:

> Hi xiaolinkui,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on netfilter-nf/main]
> [also build test ERROR on nf-next/master horms-ipvs/master linus/master v6.6-rc6 next-20231016]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/xiaolinkui/netfilter-ipset-wait-for-xt_recseq-on-all-cpus/20231005-234042
> base:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git main
> patch link:    https://lore.kernel.org/r/20231005115022.12902-1-xiaolinkui%40126.com
> patch subject: [PATCH] netfilter: ipset: wait for xt_recseq on all cpus
> config: x86_64-buildonly-randconfig-006-20231016 (https://download.01.org/0day-ci/archive/20231016/202310161625.GDDBP8SZ-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231016/202310161625.GDDBP8SZ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310161625.GDDBP8SZ-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    ld: vmlinux.o: in function `wait_xt_recseq':
> >> ip_set_core.c:(.text+0x1c561ac): undefined reference to `xt_recseq'
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

-- 
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary
