Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E612C80255C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 17:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjLCQWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 11:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCQWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 11:22:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E413D3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 08:22:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD6AC433C7;
        Sun,  3 Dec 2023 16:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701620546;
        bh=1D5FKtel1VuNniwfQ/musH6gWf5qfNnpEwCMYMUVgJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJfgYHrsypf112t+OadRsWcTxv/HX4EHyGz2Vo/29NF+Oc0dPsDRAkyjrLHDR4nd6
         IkxnDYdoXrbxNUbc12mTL2MqE4/fbGjML+61hS4zLGuStCUmi634qR2Ho5sJMk3YsA
         b8c7nehyG3aq34c1WReSXXf/WXNxxqAz4O2Jjum90C5v5pKyi7AhW18RE0iBxXLLEB
         G+OL8yUeejrO2qjS1GCMDJY6cgkXwFr+jyVcn4Y0gMIbgz5rd+s6WX6chcneVkaZkN
         g+sjBz3Ix7q0YG6r5i/4+yByVsxU3+CSQ8rixsthhIv3e4oGz1oH+ZbW4adeKDIbXd
         64KLuysIY+uyQ==
Date:   Sun, 3 Dec 2023 16:22:20 +0000
From:   Simon Horman <horms@kernel.org>
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     intel-wired-lan@lists.osuosl.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        mschmidt@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v5 4/5] i40e: Fix broken support for floating VEBs
Message-ID: <20231203162220.GI50400@kernel.org>
References: <20231124150343.81520-1-ivecera@redhat.com>
 <20231124150343.81520-5-ivecera@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124150343.81520-5-ivecera@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 04:03:42PM +0100, Ivan Vecera wrote:
> Although the i40e supports so-called floating VEB (VEB without
> an uplink connection to external network), this support is
> broken. This functionality is currently unused (except debugfs)
> but it will be used by subsequent series for switchdev mode
> slow-path. Fix this by following:
> 
> 1) Handle correctly floating VEB (VEB with uplink_seid == 0)
>    in i40e_reconstitute_veb() and look for owner VSI and
>    create it only for non-floating VEBs and also set bridge
>    mode only for such VEBs as the floating ones are using
>    always VEB mode.
> 2) Handle correctly floating VEB in i40e_veb_release() and
>    disallow its release when there are some VSIs. This is
>    different from regular VEB that have owner VSI that is
>    connected to VEB's uplink after VEB deletion by FW.
> 3) Fix i40e_add_veb() to handle 'vsi' that is NULL for floating
>    VEBs. For floating VEB use 0 for downlink SEID and 'true'
>    for 'default_port' parameters as per datasheet.
> 4) Fix 'add relay' command in i40e_dbg_command_write() to allow
>    to create floating VEB by 'add relay 0 0' or 'add relay'
> 
> Tested using debugfs:
> 1) Initial state
> [root@host net-next]# echo dump switch > $CMD
> [root@host net-next]# dmesg -c
> [  173.701286] i40e 0000:02:00.0: header: 3 reported 3 total
> [  173.706701] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
> [  173.713241] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
> [  173.719507] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
> 
> 2) Add floating VEB
> [root@host net-next]# CMD="/sys/kernel/debug/i40e/0000:02:00.0/command"
> [root@host net-next]# echo add relay > $CMD
> [root@host net-next]# dmesg -c
> [  245.551720] i40e 0000:02:00.0: added relay 162
> [root@host net-next]# echo dump switch > $CMD
> [root@host net-next]# dmesg -c
> [  276.984371] i40e 0000:02:00.0: header: 4 reported 4 total
> [  276.989779] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
> [  276.996302] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
> [  277.002569] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
> [  277.009091] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0
> 
> 3) Add VMDQ2 VSI to this new VEB
> [root@host net-next]# echo add vsi 162 > $CMD
> [root@host net-next]# dmesg -c
> [  332.314030] i40e 0000:02:00.0: added VSI 394 to relay 162
> [  332.337486] enp2s0f0np0v0: NIC Link is Up, 40 Gbps Full Duplex, Flow Control: None
> [root@host net-next]# echo dump switch > $CMD
> [root@host net-next]# dmesg -c
> [  387.284490] i40e 0000:02:00.0: header: 5 reported 5 total
> [  387.289904] i40e 0000:02:00.0: type=19 seid=394 uplink=162 downlink=16
> [  387.296446] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0
> [  387.302708] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
> [  387.309234] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
> [  387.315500] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
> 
> 4) Try to delete the VEB
> [root@host net-next]# echo del relay 162 > $CMD
> [root@host net-next]# dmesg -c
> [  428.749297] i40e 0000:02:00.0: deleting relay 162
> [  428.754011] i40e 0000:02:00.0: can't remove VEB 162 with 1 VSIs left
> 
> 5) Do PF reset and check switch status after rebuild
> [root@host net-next]# echo pfr > $CMD
> [root@host net-next]# echo dump switch > $CMD
> [root@host net-next]# dmesg -c
> [  738.056172] i40e 0000:02:00.0: header: 5 reported 5 total
> [  738.061577] i40e 0000:02:00.0: type=19 seid=394 uplink=162 downlink=16
> [  738.068104] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0
> [  738.074367] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
> [  738.080892] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
> [  738.087160] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
> 
> 6) Delete VSI and delete VEB
> [root@host net-next]# echo del vsi 394 > $CMD
> [root@host net-next]# echo del relay 162 > $CMD
> [root@host net-next]# echo dump switch > $CMD
> [root@host net-next]# dmesg -c
> [ 1233.081126] i40e 0000:02:00.0: deleting VSI 394
> [ 1239.345139] i40e 0000:02:00.0: deleting relay 162
> [ 1244.886920] i40e 0000:02:00.0: header: 3 reported 3 total
> [ 1244.892328] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
> [ 1244.898853] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
> [ 1244.905119] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

