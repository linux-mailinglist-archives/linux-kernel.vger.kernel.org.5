Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844E8758A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 02:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjGSAyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 20:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGSAyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 20:54:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF171FE6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 17:53:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B8F4615BF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7645BC433C7;
        Wed, 19 Jul 2023 00:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689727959;
        bh=HfJ9IwkZpA0DnsGaCCPzZGNvi3wNsmCaWhNsFEfRRfw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L8xrRIhgHZIA2vZzZcyfRAaoy16jSE6VTUL4iQ5afl+1gx7H9K6qRoWf4UT++eyM3
         t9FupmSc1LxUt6LDKAFxRR7UWwIFTUNoIZkWBFL+g5yHcX9PqnoVn3XnQrLia8fO0E
         cnWqfYUIBSrq2lUJaUKWXkV5bbVeqlJlzR3sXb7VF10519O1IitxMcxBg71TpdSnxX
         hKpL4JHOQiwVh4tiA60p7eSVAHCaCYW9ODoWpOd0aQKunvp550gxXmSMjsl8AhtcR9
         pfFKQXJ5TqMZneCmUvONnOAwHN1miSjYmBrLi9HzePPOhwNibdvZQZ59zw9dAbCL7O
         hG17WwBrvfpaQ==
Date:   Tue, 18 Jul 2023 17:52:38 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Minjie Du <duminjie@vivo.com>
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com (maintainer:MICROCHIP LAN966X ETHERNET
        DRIVER), "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        netdev@vger.kernel.org (open list:MICROCHIP LAN966X ETHERNET DRIVER),
        linux-kernel@vger.kernel.org (open list),
        opensource.kernel@vivo.com,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net v4] net: lan966x: fix parameter check in two
 functions
Message-ID: <20230718175238.226810e3@kernel.org>
In-Reply-To: <20230717022235.1767-1-duminjie@vivo.com>
References: <20230717022235.1767-1-duminjie@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 10:22:35 +0800 Minjie Du wrote:
>  	vrule = vcap_get_rule(lan966x->vcap_ctrl, rule_id);
> -	if (vrule) {
> +	if (!IS_ERR_OR_NULL(vrule)) {

Please make vcap_get_rule() return an error pointer rather than NULL.
Mixing the two is a common source of errors.
-- 
pw-bot: cr
