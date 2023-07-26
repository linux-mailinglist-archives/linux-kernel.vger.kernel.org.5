Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECA27627D8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 02:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjGZArR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 20:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjGZArQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 20:47:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159701BFB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 17:47:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83CF9619BD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5F9C433C8;
        Wed, 26 Jul 2023 00:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690332433;
        bh=Wl5oBCsN+Rpuig2vlDDIl7wkx5DAqU7N9LpCXvvXqaU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tg2/mzATAsk2JQ0uYNT3N+GHenozvBgwCi5f4JqKBrUuAG9hn9CkOh1PBed16pjnw
         /+7KKpB/o60eGaGYvknDV1QoKFEpah9DpJ1b9dIUklCyhc0mP+mJ3ZxibWx8ciQstT
         rVQfH4ZZEWFWoPDVdydQQB9JFM/5JKe4g5kVpJGeyL11/FMYc/S69r9DsK+G2JyNjk
         o38r2xCRsC4a1uex6J70uX+oRoJnGsGYOvIYly5yvpmE/he4ykCc4IxsOI9jliSauJ
         3J0YBUclGBfQLxzzUgGSdzYhmdHFF7b/GcsQGDOCUfbo6qapiupE3r/DdNEYaUKFev
         T8loQZuGRMA9Q==
Date:   Tue, 25 Jul 2023 17:47:12 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
        Krystian Pradzynski <krystian.pradzynski@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>, hq.dev+kernel@msdfc.xyz,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Intel Ethernet Drivers 
        <intel-wired-lan@lists.osuosl.org>
Subject: Re: Unexplainable packet drop starting at v6.4
Message-ID: <20230725174712.66a809c4@kernel.org>
In-Reply-To: <ZMBf3Cu+MgXjOpvF@debian.me>
References: <e79edb0f-de89-5041-186f-987d30e0187c@gmail.com>
        <ZMBf3Cu+MgXjOpvF@debian.me>
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

On Wed, 26 Jul 2023 06:50:52 +0700 Bagas Sanjaya wrote:
> This time, the bisection points out to v6.4 networking pull, so:
> 
> #regzbot introduced: 6e98b09da931a0

Ask the reporter to test 9b78d919632b, i.e. the tip of net-next before
the merge. It seems quite unlikely that the merge itself is the problem.
