Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3491580DF20
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345170AbjLKW7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345166AbjLKW7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:59:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B1E9A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:59:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5B7C433C8;
        Mon, 11 Dec 2023 22:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702335585;
        bh=t7nQKTTeGh65bU29w+Bc8SK2+uEhQ8nX0LrViq7JYqk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V/ayCjsP1FkvVFM17OEH03CfEKEOd2MP64ffO019moohHMBAdYMxM5wQ7lLiPowaw
         gxescu6QOlqk99izlWGLWswXQLkz5ItDrmoIvvWQodLnU/faMboH+eT+XG0OrS1Q2h
         tRi4+rt1enNLzJtYP+djQEOAHnND0Sz51/8/5xFqWeXdymJfoZ9AdvRT6fsuKu/EfF
         WLPhwPCLSMFAewuDZvjD4tNBsUa3gJpGoyIren8v1orQnVNzQnDK1BDCpiYv7in+2X
         sxXVAxPiGeW3FNMlzlnF2SAmfftk6XZwbbKVPltqcpp9HpRvIPK/zFqQpkdVC8UwhT
         hfmR1+icdW39A==
Date:   Mon, 11 Dec 2023 14:59:44 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Jianheng Zhang <Jianheng.Zhang@synopsys.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        James Li <James.Li1@synopsys.com>,
        Martin McKenny <Martin.McKenny@synopsys.com>
Subject: Re: [PATCH net-next] net: stmmac: xgmac3+: add FPE handshaking
 support
Message-ID: <20231211145944.0be51404@kernel.org>
In-Reply-To: <zx7tfojtnzuhcpglkeiwg6ep265xpcb5lmz6fgjjugc2tue6qe@cmuqtneujsvb>
References: <CY5PR12MB63726FED738099761A9B81E7BF8FA@CY5PR12MB6372.namprd12.prod.outlook.com>
        <zx7tfojtnzuhcpglkeiwg6ep265xpcb5lmz6fgjjugc2tue6qe@cmuqtneujsvb>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 14:14:00 +0300 Serge Semin wrote:
> Although in this case AFAICS the implementation is simpler and the
> only difference is in the CSR offset and the frame preemption residue
> queue ID setting. All of that can be easily solved in the same way as
> it was done for EST (see the link above).
> 
> Jakub, what do you think?

Yup, less code duplication would be great. Highest prio, tho, is to
focus on Vladimir's comment around this driver seemingly implementing
FPE but not using the common ethtool APIs to configure it, yet :(
