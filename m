Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4E2774D6D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjHHVz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjHHVz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:55:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1F6EE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 14:55:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B093C62D86
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 21:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1B4C433C8;
        Tue,  8 Aug 2023 21:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691531726;
        bh=DfGJgoICFpbwodUyconrw7br4Y/aAGzc5ytewSxQ1sU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OzJPPGPOV+tbgfBpKAWCXhCHqQLkYp/qSVn7Ph8ut4zwTxbqQ5Mvl8PpBVN5JGN2+
         B53k0ySEc+F15n1+2eRyv/qDqJLvpen8L23BbGg+ArWPRMpo5c292tnFElyGhHsnQw
         FnXm6Me5Q3G5v3Uk3/8+eHSVhs/Vs9U271Th0qrkA1aQ1mDWdVIXbXgGZrP2n/A/ST
         0OohWs5TnIFvQnNrG34m8/9BKTetBq9Xbl3vI7mWHdGPvbX5j6Vn8QHrKY5pATDTY6
         K2x75VlEe1Tke4++VcJT1VxMbW1yUICJz+ZEUVCuFtyFBDNWmmo541X2Mijk7OmVUw
         33g84hDLwwEFQ==
Date:   Tue, 8 Aug 2023 14:55:25 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     rdunlap@infradead.org, benjamin.poirier@gmail.com,
        davem@davemloft.net, edumazet@google.com,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next v4 1/2] netconsole: Create a allocation helper
Message-ID: <20230808145525.61840a76@kernel.org>
In-Reply-To: <20230804124322.113506-2-leitao@debian.org>
References: <20230804124322.113506-1-leitao@debian.org>
        <20230804124322.113506-2-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Aug 2023 05:43:20 -0700 Breno Leitao wrote:
> +	struct netconsole_target *nt = alloc_and_init();
> +	int err = -ENOMEM;
> +
> +	if (!nt)
> +		goto fail;

No complex code in the variable init, please.
Makes the code harder to read.

	struct netconsole_target *nt;
	int err;

	nt = alloc_and_init();
	if (!nt) {
		err = -ENOMEM;
		goto fail;
	}
-- 
pw-bot: cr
