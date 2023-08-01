Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2844376A732
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjHACxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjHACxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:53:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A981981
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:53:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A528261375
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D79C433C7;
        Tue,  1 Aug 2023 02:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690858380;
        bh=XcSi2fRJmzOTE7kbjFWduXKD2IOr2CcrRDOP0d+XB3U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ermuXP4TzbEIoP6HVCvunAJRX6wX39KTyEc/JSZDVZ0IDn0FuzR1R9e05X4pAw9Gi
         04QSRn/ikxukC5fqya9UhIgopkmXR6EreQieXZ1LEgWQHGWHTf4kgQmpHxn7Fk2Qlp
         zz0dl/cqnTygEo2ouoUUBbsPm1szil0aKaUdHT5lt7+VaMIH52Krj5L0laW99SUfji
         rhSaieTxKTV5P40aU2ROlYIIDOz/YSnZoZPudGCOZEToffKpN2Qy7xaBdAw7feJM9y
         Nf4UjAw5dDv/rXxK/6FocwPvR8/REuer9AcBWdeV5FXjJH1MxuJiVkisWeqzMISwtu
         b0kSixTNgUiNA==
Date:   Mon, 31 Jul 2023 19:52:58 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     rdunlap@infradead.org, benjamin.poirier@gmail.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, leit@meta.com,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next v2] netconsole: Enable compile time
 configuration
Message-ID: <20230731195258.16b3a53d@kernel.org>
In-Reply-To: <20230731083542.3665886-1-leitao@debian.org>
References: <20230731083542.3665886-1-leitao@debian.org>
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

On Mon, 31 Jul 2023 01:35:41 -0700 Breno Leitao wrote:
> +config NETCONSOLE_EXTENDED_LOG
> +	bool "Set kernel extended message as default"
> +	depends on NETCONSOLE
> +	default n
> +	help
> +	  Set extended log support for netconsole message. If this option is
> +	  set, log messages are transmitted with extended metadata header in a
> +	  format similar to /dev/kmsg.  See
> +	  <file:Documentation/networking/netconsole.rst> for details.
> +
> +config NETCONSOLE_PREPEND_RELEASE
> +	bool "Prepend kernel release version in the message"

... by default

> +	depends on NETCONSOLE_EXTENDED_LOG
> +	default n
> +	help
> +	  Set kernel release to be prepended to each netconsole message by
> +	  default. If this option is set, the kernel release is prepended into
> +	  the first field of every netconsole message, so, the netconsole
> +	  server/peer can easily identify what kernel release is logging each
> +	  message.  See <file:Documentation/networking/netconsole.rst> for
> +	  details.

I had to look at the code to see what this does, exactly.

I think you either need to make similar changes to
make_netconsole_target() so that instances created via sysfs
have the same default.

Or rewrite the help message to talk about forcing kernel
command line arguments, rather than setting defaults.
-- 
pw-bot: cr
