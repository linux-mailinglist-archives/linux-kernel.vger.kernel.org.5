Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60A277B63A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbjHNKNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbjHNKNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:13:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D13133
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:13:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96BBA64C85
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB8DC433C7;
        Mon, 14 Aug 2023 10:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692007996;
        bh=Tw6xsKFT9/YLilCc8qW/d4Dahue6d9Rwz2kbqcD9t4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PJFTC2TSqzm0gkNfWgpvXzM5a662tGAadcpzrNwHL24QqhdQf9dJf2yeVVR6axJzY
         bV4KZ6xAMtYoA7Obv6jzXOEMmo59SfWfJ+K88bwZ25n9p8uxySGD9QDpGpiSt0Psvg
         fdWHsh+LQlEbzYEc/UD2Fn9Rg5FsNmIJuFwsG2dQxzvAihX1s4j9VOrFEDfrFd8BD4
         Xko85h4OV4pf7UfCA283BopFHNWgBAHpiLgeIwspoL310Z90GxCf4PLnmnr2qGWkXF
         YOQZRgcyB6MZpGhiTxYqrFkUxYFKUdqWc/FVDLSJjt/9SdjFbA9TYmHLsQ1Sil6rO/
         Bw5IuL1BlGj0A==
Date:   Mon, 14 Aug 2023 13:13:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Yuval Mintz <Yuval.Mintz@qlogic.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] qed: remove unused 'resp_size' calculation
Message-ID: <20230814101312.GF3921@unreal>
References: <20230814074512.1067715-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814074512.1067715-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 09:45:03AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Newer versions of clang warn about this variable being assigned but
> never used:
> 
> drivers/net/ethernet/qlogic/qed/qed_vf.c:63:67: error: parameter 'resp_size' set but not used [-Werror,-Wunused-but-set-parameter]
> 
> There is no indication in the git history on how this was ever
> meant to be used, so just remove the entire calculation and argument
> passing for it to avoid the warning.
> 
> Fixes: 1408cc1fa48c5 ("qed: Introduce VFs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/qlogic/qed/qed_vf.c | 45 +++++++++---------------
>  1 file changed, 17 insertions(+), 28 deletions(-)
> 

I don't think that Fixes tag is really needed here and title should be [PATCH
net] or [PATCH net-next].

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
