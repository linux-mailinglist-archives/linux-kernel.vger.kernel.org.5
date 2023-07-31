Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7882876A24A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjGaU7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjGaU65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:58:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CA01996
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 13:58:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 180E461298
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 20:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261EDC433C7;
        Mon, 31 Jul 2023 20:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690837135;
        bh=r5eukuyVDYrGLrNULe36nyXrnyzoReTEKShm4Q8CiuA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dCt+PG6O2oxSwfiG6ExP2KO9J0t7rdhKRbVUFewtDhwE1LAbAJYzX8EWR1LE2sh5v
         gHgaCR6zrK9ZpYFSVVdvhgFH3L1P5+2jCytQ/okSBzgjGy9vXGKQxitU4tXzmNbOdj
         jZWkd+WUc52ICEK1F1IxEl/IYq1/8lpqRP3dC6XsISK73poSKpXKv0KvyRFCgYK0pC
         pm3JbaSFAUp3kTofXmIy5P1FVJljLXcs0BCO10yATOYNONfHqyrwxvaYcbu3u5afsD
         MYvOX4PwewYY7bpkwaEU3NOYYI+HRnSKb+octG2CFPrIAuzcwhebDg1PLOI0Mjx9Qx
         Xnvlml+b5BgKQ==
Date:   Mon, 31 Jul 2023 13:58:54 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Tahsin Erdogan <trdgn@amazon.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tun: avoid high-order page allocation for packet header
Message-ID: <20230731135854.3628918b@kernel.org>
In-Reply-To: <20230726030936.1587269-1-trdgn@amazon.com>
References: <20230726030936.1587269-1-trdgn@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 20:09:36 -0700 Tahsin Erdogan wrote:
> @@ -1838,6 +1838,9 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  			 */
>  			zerocopy = false;
>  		} else {
> +			if (linear == 0)
> +				linear = min_t(size_t, good_linear, copylen);

nit: would you mind changing to !linear instead of linear == 0 ?

Also - I don't see linear explicitly getting set to 0. What guarantees
that? What's the story there?

Otherwise seems reasonable. One more allocation but hopefully nobody
will notice.
-- 
pw-bot: cr
