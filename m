Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ED27DC1E3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjJ3VZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjJ3VZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:25:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5448E
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:25:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3F5C433C7;
        Mon, 30 Oct 2023 21:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698701144;
        bh=+b0YC2uQr6Lu6xgNwJdj0UnPpjDCBGsTQO6PZ1T3PWY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g/oYgCeNvrQ+caweHyevJAr7jN2Lt2kIc0lD3tiZBcWyxUqYhCAk4ETl32LBLt9R/
         4EYJj7jcvKJgAgsTg7nShwfTlAnd3GONwDEM5HGvu/LfTmdIrjs4Td0ze50ti4IUa+
         15fVLZ8GjGn9QZMIGxu+p6A3XoJWGUTjVVmFtWtKXg+np0DkEjGUh/lQs4MDqTHqJM
         oiSUvv8U5XOLSRrKxQOcX3nvjmTkSwsT6Arrr6hFsmQnVA+ODctbZaKlW2V4Snh3F6
         RvKiSn+jVUtfMaa13F5Njsm0Tnp51qcxApx+dw/pa3cQeRdsOEJNpLvKGsr1+PqF7x
         4LncKzFYsGizQ==
Date:   Mon, 30 Oct 2023 14:25:42 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     longli@linuxonhyperv.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Long Li <longli@microsoft.com>
Subject: Re: [Patch v2] hv_netvsc: Mark VF as slave before exposing it to
 user-mode
Message-ID: <20231030142542.6640190b@kernel.org>
In-Reply-To: <1698440390-13719-1-git-send-email-longli@linuxonhyperv.com>
References: <1698440390-13719-1-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2023 13:59:50 -0700 longli@linuxonhyperv.com wrote:
> When a VF is being exposed form the kernel, it should be marked as "slave"
> before exposing to the user-mode. The VF is not usable without netvsc running
> as master. The user-mode should never see a VF without the "slave" flag.
> 
> This commit moves the code of setting the slave flag to the time before VF is
> exposed to user-mode.

Can you give a real example in the commit message of a flow in user
space which would get confused by seeing the VF netdev without
IFF_SLAVE?

You're only moving setting IFF_SLAVE but not linking the master,
is there no code which would assume that if SLAVE is set there 
is a master?
