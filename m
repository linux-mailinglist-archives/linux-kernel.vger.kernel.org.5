Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B577CD1C2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 03:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344371AbjJRBUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 21:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjJRBUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 21:20:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA8EF7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 18:20:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480CEC433CA;
        Wed, 18 Oct 2023 01:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697592004;
        bh=4EUpHRPi3sFqaSYjaI49krLGltGU968DKkzms82feiw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QcqGpRx3+kcTLTVNI7lD/dxyFo/BXM4Av6Z1cTZ3c9AIu9ZRpvxOVmmPVbxbndYNa
         n/BB4SRL5Ks4vF6dnAAZv3OLPJCWfEW+2DDp4LGH1eUUP7v7I0mmGlAYNoq5aCeVnD
         vK7FBgGVwnYqPLQOKccPTZcUWiLm1LS/j0GPZPugJ/73KUNIF9K6Rnd8pUi5tTqDXZ
         fUGWDbA7MIHCvT7spPIgT3AP0J9rIE4Z4CxdCdD1R4DPRET0HasrVnmE27LEgMac6b
         Lwy+++ghCKIRq+7DdAS0hy7YYswGeenzZ+/Dxcyx0wJOLO07PZEjNz2sDYDH2oIu5o
         ZmBk9FoRZfrgg==
Date:   Tue, 17 Oct 2023 18:20:02 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc:     Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        George Cherian <george.cherian@marvell.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Coiby Xu <coiby.xu@gmail.com>,
        Brett Creeley <brett.creeley@amd.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Aya Levin <ayal@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH net-next v2 02/11] netdevsim: devlink health: use
 retained error fmsg API
Message-ID: <20231017182002.716ae87b@kernel.org>
In-Reply-To: <20231017105341.415466-3-przemyslaw.kitszel@intel.com>
References: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
        <20231017105341.415466-3-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 12:53:32 +0200 Przemek Kitszel wrote:
> Drop unneeded error checking.
> 
> devlink_fmsg_*() family of functions is now retaining errors,
> so there is no need to check for them after each call.
> 
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
