Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241027609E1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjGYFzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjGYFyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:54:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591F21BD6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:54:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBF756154C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B69C433C8;
        Tue, 25 Jul 2023 05:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690264479;
        bh=aOySNSCJEoaRaJl24Sk+OTpPeYecm1osaIYiLeFOqSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YRx0OBU1SEI1SJ4LSmLkEPob1QuK5WFkuUqdVeYph9ed/UsG2IwyOFk7Kxeh+D7xA
         LawFmu2khRnM9557VkZ83V2GFmQQu/DXj2xET+YiR4qIOIVkir7lORnqdQBDi+c/4c
         m40Effm/hR8qO96KDgp7YURxsFrLShrUciFeYS6BMeTQUrr0SSDHg+EhkBPdwoEDsq
         VgSHNlvNLX1Qem3CDFHb5fCdKlTQlOVlNtWuP6iteR1YMcSBbbTBFrhUb36StgyciG
         2b04uwx98ow9qLqZYrVsbQQcAz2E4cao6cEXLDuGqzOIQqqGSSx2IgOkRBTv/jVN7E
         YWW79NAqNUNbw==
Date:   Tue, 25 Jul 2023 08:54:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, ast@kernel.org, martin.lau@kernel.org,
        yhs@fb.com, void@manifault.com, andrii@kernel.org,
        houtao1@huawei.com, inwardvessel@gmail.com, kuniyu@amazon.com,
        songliubraving@fb.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] bpf: Add length check for
 SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
Message-ID: <20230725055434.GM11388@unreal>
References: <20230725023330.422856-1-linma@zju.edu.cn>
 <20230725044409.GF11388@unreal>
 <15dc24fc.e7c38.1898b81ac08.Coremail.linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15dc24fc.e7c38.1898b81ac08.Coremail.linma@zju.edu.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 01:24:38PM +0800, Lin Ma wrote:
> Hello Leon,
> 
> > 
> > Jakub, it seems like Lin adds this check to all nla_for_each_nested() loops.
> > IMHO, the better change will be to change nla_for_each_nested() skip empty/not valid NLAs.
> > 
> > Thanks
> 
> I guess you just get these fixes misunderstood. I do not add the nla_len check
> to  **all nla_for_each_nested** :(. I only add checks to those who do not access 
> the attributes without verifying the length, which is buggy.
> 
> The others, either do a similar nla_len check already or just do nla_validate
> somewhere else. That is to say, they **validate** the relevant attributes.
> 
> In short, nla_for_each_nested is just a loop macro that iterates the nlattrs,
> like nla_for_each macro. It is weird for them to do nlattr validation as there
> could have already been a call to nla_validate to ensure those attributes are
> correct. That is, for those who do not, a simple nla_len check is the simplest
> and most efficient choice.

My concern is related to maintainability in long run. Your check adds
another layer of cabal knowledge which will be copied/pasted in other
places.

Thanks

> 
> Regards
> Lin
