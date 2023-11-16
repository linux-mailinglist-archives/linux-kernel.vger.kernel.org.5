Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325747EE0AC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345215AbjKPM3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345194AbjKPM3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:29:03 -0500
Received: from codesynthesis.com (codesynthesis.com [188.40.148.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C007E1A5;
        Thu, 16 Nov 2023 04:28:58 -0800 (PST)
Received: from brak.codesynthesis.com (unknown [105.186.92.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by codesynthesis.com (Postfix) with ESMTPSA id DBBED60B62;
        Thu, 16 Nov 2023 12:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codesynthesis.com;
        s=mail1; t=1700137737;
        bh=L8/2LumOofn84zXo/hfXIiuePhx2MJbJ78D9E/u+btg=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:From;
        b=ERgrdYPGWBEfLSc7qvrMU5juoz3+g0RVHUNxX2DP6FtG8RIdyzAabyWzF7RAnseLg
         93y6YMDpDr/EGrlOHVt0rzAvhIB8n3Ul53QT87WX/z0i9kaWn7aU8dTgDy3rdJoa/J
         6dQDjHp6EZdwp0LXZbr7fCawWp+6Fbg/GWc/oMGhS7FGxFziP8oScx7KAATZXbByjY
         9ClU96Li8prdToTs+nr9tuXQsaq0kDFHJPTcukHvBg85R1Cfzk4Ag8uo2iBCGmdrGl
         esd5oHhNCvAJNmlKT1anEwXtnRthHAi4EwpaHpXcZ4QXgaAJU/Pi7kibd9GnLoB5yj
         0kI3DJUkhqLaA==
Received: by brak.codesynthesis.com (Postfix, from userid 1000)
        id DC290146149; Thu, 16 Nov 2023 14:28:57 +0200 (SAST)
Date:   Thu, 16 Nov 2023 14:28:57 +0200
From:   Boris Kolpackov <boris@codesynthesis.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig: fix memory leak from range properties
Message-ID: <boris.20231116141906@codesynthesis.com>
References: <20231115041653.810045-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115041653.810045-1-masahiroy@kernel.org>
Organization: Code Synthesis
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> writes:

> Currently, sym_validate_range() duplicates the range string using
> xstrdup(), which is overwritten by a subsequent sym_calc_value() call.
> It results in a memory leak.
> 
> [After]
> 
>   LEAK SUMMARY:
>      definitely lost: 0 bytes in 0 blocks
>      indirectly lost: 0 bytes in 0 blocks
>        possibly lost: 0 bytes in 0 blocks
>      still reachable: 17,462 bytes in 20 blocks
>           suppressed: 0 bytes in 0 blocks

FYI, there are quite a few other memory leaks in Kconfig (as evident from
the still reachable value in the above report). I believe I've fixed most
of them in this commit:

https://github.com/build2-packaging/kconfig/commit/cd9910e3636515b2980ce1d37d1984ccfd6b4cb9

In particular, I could load the Linux kernel configuration repeatedly
in a loop without causing any memory leaks or crashes (which were common
due to the state not being reset properly).

I believe the above commit also includes a fix for the sym_validate_range()
leak in question, though the way it's fixed is different. The potential
problem with the proposed fix is that it may be impossible to decide who
should free the shared value.
