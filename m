Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D817B0A90
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjI0QrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0QrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:47:21 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B0D91
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:47:20 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9FA8E40E00B3;
        Wed, 27 Sep 2023 16:47:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JGsWM40zxlwq; Wed, 27 Sep 2023 16:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695833236; bh=xw60lT64g2eEHLQowTPfIB3UZgMfj9tuQlmikCFaZKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SIC0LVNElbxDgcFnE4WpidUdqrThfOAjDHHzLS3GSITf6mnHicoK7IL0ev2APmQJe
         6rmZVOqckgrZsQv1NMaluRo1Q7zpFp1yNwbTPaF2bg+YPI10AUAN+eI+jOeXXMEeG+
         +H1L1ykFD7pvpIF77nStrb11CsTsxtOUF7PXSK/vN40dnu9pUerHee+KI928lyYOoT
         NKkO2+ZGnUwU7azVqG0/lW+WydyKnGGgL88+WnW9QQD50+yAf3dAw6FzrL6417ybsd
         72XPHCnL9//txtZJbn7zWt4+sKTvtJwddv/DJnQz18KRldMk2ysWMpgNsMosM6R5Gx
         3KJufrUpWn7A7vqXFxEwqpsdCGAMcGbIISYBbX24as4bh/vElnhvwLkFK+QdZG7eJR
         P33AZ7ht2b7DHV9Chzyfv0+vdVJbt1oZJC27UWu4IBN1hWRV8ht3dfGKkEGKY+EuzU
         0BVQY3CUaTcd8+tnJvS25VIolRdFLyIohzRAxknxxS/JnbEqgO7ZS04Dm99SvWqY/W
         eT6NYxnUaWZTx7QlHkT5d87er8PCjGsglKXE+t3mqG9X/0YS0s4kxr/FbNNQ8oATVr
         z/Zai0Iaut7dnSIMeqofyhV7lv4uv9XW5aEgXdt2FzwOwoFJCiOAFc/k/6w2yyNUUW
         VIcglz1bCCCGuAyfh/ErElaM=
Received: from nazgul.tnic (cust-west-par-46-193-35-178.cust.wifirst.net [46.193.35.178])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 74EBE40E014B;
        Wed, 27 Sep 2023 16:47:10 +0000 (UTC)
Date:   Wed, 27 Sep 2023 18:47:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 24/30] x86/microcode: Replace the all in one rendevouz
 handler
Message-ID: <20230927164727.GAZRRcn8HkSIIVKEEo@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065502.265405353@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912065502.265405353@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:58:21AM +0200, Thomas Gleixner wrote:
> -	ret = microcode_ops->apply_microcode(cpu);
> -	this_cpu_write(ucode_ctrl.result, ret);
> +	/* No point to wait here. The CPUs will all wait in stop_machine(). */

Niice.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
