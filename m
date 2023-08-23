Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ADE785B24
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbjHWOxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbjHWOxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:53:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44DBFB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:53:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21E9265D11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 14:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD18BC433C7;
        Wed, 23 Aug 2023 14:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692802400;
        bh=I5gnC4HdDcDja7RTsPupoGDGGaOrcVOx4WcW/IaqU98=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nfwUVW7aNhFc7JyfsLlxFJTpFofGXSWfZKfKN/8ish5Uu6TZqxKqasrSGVy8Gy6IQ
         mHbAohqTOJxWAEx11kI9DClfk/krMaUk2wuJ3O/KM7Yz9WJNgzD7CCBo79Kd4vUg7J
         vPaSHeEOqiKQ/z4FUc3kx7hydlCm4sDChyKO78gMJTR79o9jgox4iyurRSTJn3EKFX
         gR2KPuu84DiZtyUAp7SvaNJD4Z7KC9tqC9srr4yxAX4Rw50ZMvqJ/AlaVEHEnnqE6G
         aZ3RunTgbc22Q3uyaDl0/39aAePkk1TdfJT/lYfky+9sOPv6kvatfZGCkJwz2jrjJP
         VCQz0dUTxLucg==
Date:   Wed, 23 Aug 2023 07:53:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     linux@weissschuh.net
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Marko <robimarko@gmail.com>
Subject: Re: [PATCH net-next] net: generalize calculation of skb extensions
 length
Message-ID: <20230823075318.4860cebc@kernel.org>
In-Reply-To: <1e1dde74-edc6-4306-9b1b-0a1b5a658b67@weissschuh.net>
References: <20230822-skb_ext-simplify-v1-1-9dd047340ab5@weissschuh.net>
        <20230822184644.18966d0f@kernel.org>
        <1e1dde74-edc6-4306-9b1b-0a1b5a658b67@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2023 10:14:48 +0200 (GMT+02:00) linux@weissschuh.net
wrote:
> > Could you include more info about the compiler versions you tried
> > and maybe some objdump? We'll have to take your word for it getting
> > optimized out, would be great if we had more proof in the commit msg.
> > --
> > pw-bot: cr  
> 
> Thanks for the feedback.
> I'll send a v2 with more background soon.
> 
> On the other hand this function is only ever
> executed once, so even if it is slightly inefficient
> it shouldn't matter.

Oh you're right, somehow I thought it was for every alloc.
You can mention it's only run at init in the commit msg if 
that's easier.
