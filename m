Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1687E7EFCA5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 01:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346368AbjKRAjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 19:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjKRAjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 19:39:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBA910C6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 16:39:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6F8C433C7;
        Sat, 18 Nov 2023 00:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700267981;
        bh=Je/ApF2K7SYvSPIxFVB5Me2FUgzHHhsUTSYdaPeNC2M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IiRkNMZEHCZKk9mAEgz3XMwp/Kpr1kMZDf5cAY6rG5HeZZDPzixvMd8qR6Fj8xuFD
         cZqwHUjLKhh2b1MGD4eETVLU/2Bchjyb1yqxJL0X4/cf16yqpnAN3AcaURv+uNDNNa
         T/6M6T/aO9SSqKVhXMXSTjgy5BCB3CIRQut3i0KoAllyNEh+d6BhNb0dfKCGv+GbsF
         r6Qp0qCQ7GaWaPnhc2x5B4L0eSzAT1mWQ1HIiAgGoN9AQRC4invZO4owDjYwXRSfpw
         0JWb7TKjy3qlzWhfyvOxzr6FqW759agQIXUTWV0my+k4T2//Lx1iLWA66ymCW5pgx8
         7djxeRIbw8KmQ==
Date:   Fri, 17 Nov 2023 16:39:39 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     leit@meta.com
Cc:     Jonathan Corbet <corbet@lwn.net>, Breno Leitao <leitao@debian.org>,
        netdev@vger.kernel.org, donald.hunter@gmail.com,
        linux-doc@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Document each netlink family
Message-ID: <20231117163939.2de33e83@kernel.org>
In-Reply-To: <87y1ew6n4x.fsf@meer.lwn.net>
References: <20231113202936.242308-1-leitao@debian.org>
        <87y1ew6n4x.fsf@meer.lwn.net>
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

On Fri, 17 Nov 2023 15:17:02 -0700 Jonathan Corbet wrote:
> In principle I like this approach better.  There is one problem, though:
> 
> - In current kernels, on my machine, "make htmldocs" when nothing has
>   changed takes about 6s to complete.
> 
> - With this patch applied, it takes a little over 5 *minutes*.
> 
> Without having delved into it too far, I am guessing that the
> unconditional recreation of the netlink RST files is causing the rebuild
> of much of the documentation.  Even so, I don't quite get it.
> 
> That, clearly, would need to be fixed before this can go in.

FWIW on the C code-gen side we avoid touching the files if nothing
changed both at the Makefile level:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/tools/net/ynl/generated/Makefile#n28

And the tool itself actually generates to a tempfile and compares
if the output changed:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=2b7ac0c87d985c92e519995853c52b9649ea4b07
