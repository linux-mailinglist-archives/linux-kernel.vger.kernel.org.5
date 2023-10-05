Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25967BA900
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjJESZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJESZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:25:48 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [IPv6:2a01:4f8:121:31eb:3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CD290;
        Thu,  5 Oct 2023 11:25:46 -0700 (PDT)
Received: from [IPV6:2003:e9:d713:f546:fe91:5ada:5c69:ea2] (p200300e9d713f546fe915ada5c690ea2.dip0.t-ipconnect.de [IPv6:2003:e9:d713:f546:fe91:5ada:5c69:ea2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id CC188C0A55;
        Thu,  5 Oct 2023 20:25:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1696530344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BCz0xrZEJh/I2HqJVZxugSbqgKFbCIBzS8dZmHy4Zvc=;
        b=VX9GN7FUHLyHTV7HYN59Q2bt91mX08gzJXQNgDmmRPFL0AMsjTRYAISp/i2IQiaytfYJ04
        OBTK/K33VlnPbdB7dJaCNgPQxSnp2XKhNWupGAnWZmlAIJ+UGRb50oVaspWyz8xpkgkyoX
        iZIa7qZpG9ndBvzGR7zmCPcYoiuxpBIusv9NViGG6wG/vHkcZ/LWEXf2fgdFNYIeR9ygus
        zanBzgv11foBFHRs/I0mA3htXpeAI4fo1QQuyJ9iY88wcls2HmDwc7tirEPqBu+uR+7imL
        gcBiCR2nYGNArxeDnXdfiUgX7sGtf/W7Yn1e/nH7QekMQFwx034ZgV1IJzqHaw==
Message-ID: <1ed2f41f-ac5a-0b76-1012-410857d4da54@datenfreihafen.org>
Date:   Thu, 5 Oct 2023 20:25:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] [v3] ieee802154: ca8210: Fix a potential UAF in
 ca8210_probe
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     oe-kbuild-all@lists.linux.dev, stable@vger.kernel.org,
        Alexander Aring <alex.aring@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Harry Morris <harrymorris12@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231001054949.14624-1-dinghao.liu@zju.edu.cn>
 <202310011548.qyQMuodI-lkp@intel.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <202310011548.qyQMuodI-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dinghao,


On 01.10.23 09:19, kernel test robot wrote:
> Hi Dinghao,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v6.6-rc3 next-20230929]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Dinghao-Liu/ieee802154-ca8210-Fix-a-potential-UAF-in-ca8210_probe/20231001-135130
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20231001054949.14624-1-dinghao.liu%40zju.edu.cn
> patch subject: [PATCH] [v3] ieee802154: ca8210: Fix a potential UAF in ca8210_probe
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231001/202310011548.qyQMuodI-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231001/202310011548.qyQMuodI-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310011548.qyQMuodI-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>     drivers/net/ieee802154/ca8210.c: In function 'ca8210_register_ext_clock':
>>> drivers/net/ieee802154/ca8210.c:2743:13: warning: unused variable 'ret' [-Wunused-variable]
>      2743 |         int ret = 0;
>           |             ^~~
> 

Please take care of this now unused variable after your re-factor.
With this fixed and send out as v4 I am happy to get this applied to the 
wpan tree.

regards
Stefan Schmidt
