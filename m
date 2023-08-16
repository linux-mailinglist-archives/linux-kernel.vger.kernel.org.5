Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5539C77E88D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242561AbjHPSSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344333AbjHPSRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:17:41 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80BA1BE6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:17:39 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0357740E00F4;
        Wed, 16 Aug 2023 18:17:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8JJHD26WMmm6; Wed, 16 Aug 2023 18:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692209853; bh=Sl1Z/CI1SVtQenmcaikkZbJCiWOXFJQAnorOYMFQmWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IU1nTjIl94J8idI8JYuVzmjXs6UIvF1ghoiGvGjCZWA6XeXtdvxaUCwlhbY6cPJ/Y
         ML4GYq98V7nQRb4vW3cNCsn4MRVX9bjN/xHJt/M9EVvurIpyYJEHBYTwtnGWX40Rkv
         njdPPmTlLNYHE8wp1iqVUReumdi2r0pYRWAsL0QmuRnmj5s4ID7QbT1P34ukanFQ8M
         2hDHgLTDpIRIuIIPqtl5dCptxf4myqwoHNRjAofsWsqY2SNFTzRo5g2UUWQlovIJVM
         2d9XMLoLzAxUKDrzeOPabZQ+6JzHNjgchMNSxbpWm6+xsN/InGBY7SV/tIhpRRcNTk
         5fkVmhoveSdxOmJya223XQviylPmjc1jBtbKpN8WcM39PdSHY+lHjHXBqc4HU0yOJs
         xtWyXSfgMZPv8Tg1ZWdZSRePaoBa8TkHYy+baCXgwkWyF1syXSnPBSOh+mNTC19V3g
         UcRpHdJXzMQzP7E4EyLF9KNcjDfy+orCLOQNGL/Lq/8uVX3ajeZg6WCZm2HqKMIhAC
         4jHHIef9eBBFZntx/LbwsgNo1MpN7cbvrOTxPVuP8tVqooJ9YwTGFgb/CuSp1DfvWb
         ISd+s0GCoo2IcVfrnXL2S4wHoMJ0k/NKMR8ZMpWpN8KfWjYgzNAT8K+cSk7GI3YLO0
         GBkSfLYZ4DjOJIeuEnCS+qVQ=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C6EB440E0193;
        Wed, 16 Aug 2023 18:17:24 +0000 (UTC)
Date:   Wed, 16 Aug 2023 20:17:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, keescook@chromium.org,
        elver@google.com, dvyukov@google.com, glider@google.com
Subject: Re: [BUG] missing return thunk: __ret+0x5/0x7e-__ret+0x0/0x7e: e9 f6
 ff ff ff
Message-ID: <20230816181720.GNZN0SsKi/B4eCsZHu@fat_crate.local>
References: <4dc3d0ec-b827-4bce-8927-cfa5d837fd03@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4dc3d0ec-b827-4bce-8927-cfa5d837fd03@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Paul,

On Wed, Aug 16, 2023 at 10:54:09AM -0700, Paul E. McKenney wrote:
> I hit the splat at the end of this message in recent mainline, and has
> appeared some time since v6.5-rc1.  Should I be worried?

does it go away if you try the latest tip:x86/urgent branch?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
