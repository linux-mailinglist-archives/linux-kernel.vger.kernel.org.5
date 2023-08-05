Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FFD770F76
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 13:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjHELdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 07:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjHELdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 07:33:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FB4E55
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 04:33:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7493660CBB
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 11:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BAEC433C8;
        Sat,  5 Aug 2023 11:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691235229;
        bh=BzmzOuQh1iU+dc3h9XOJmPxsH1ETWoPd8fdiuvtrdjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CDAfg8gKkeWIOvV2LJQ5QdoOi9YmuwJ0LmWJcG1r3ZSJMPh6U2ZBJKgab1T8T683f
         I8knNLLFXVpR22H4eAYp269A4BA8ISGygWIue1JwHzx5QV/KmWP8t/RhiqjAvy7feZ
         IJ3r1gp1y8TTmxd/bP32Gfm2dzHGyQxV/51V6JhZeDv2D2BuJSz1THjXYXfI/cTilz
         ijIFgW84drX1xNaQUWgpimMCeMJYVTKOFCJX35d+BKCUL7rkrN+HKN9lWH+33z7KVg
         G4GOiOVeCXxQYtOg5DcmunWdiyW0BmwWkiUWxYKRWyzeapXxNrIEVZmpkdxVmJOILO
         ma1XUzvcjvK+g==
Date:   Sat, 5 Aug 2023 13:33:44 +0200
From:   Simon Horman <horms@kernel.org>
To:     Sai Krishna <saikrishnag@marvell.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sgoutham@marvell.com,
        gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
        richardcochran@gmail.com,
        Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net-next PATCH] octeontx2-pf: Use PTP HW timestamp counter
 atomic update feature
Message-ID: <ZM4zmG55sEr9b62l@vergenet.net>
References: <20230804093014.2729634-1-saikrishnag@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804093014.2729634-1-saikrishnag@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 03:00:14PM +0530, Sai Krishna wrote:
> Some of the newer silicon versions in CN10K series supports a feature
> where in the current PTP timestamp in HW can be updated atomically
> without losing any cpu cycles unlike read/modify/write register.
> This patch uses this feature so that PTP accuracy can be improved
> while adjusting the master offset in HW. There is no need for SW
> timecounter when using this feature. So removed references to SW
> timecounter wherever appropriate.
> 
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>

...

>  struct npc_get_field_status_req {
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c

...

>  
> -static bool is_ptp_tsfmt_sec_nsec(struct ptp *ptp)
> +static inline bool is_tstmp_atomic_update_supported(struct rvu *rvu)

Hi Sai,

Please avoid using the inline keyword for functions in .c files.
Unless there is a demonstrable advantage to doing so it should
be left up to the compiler to inline or not.

...

-- 
pw-bot: changes-requested
