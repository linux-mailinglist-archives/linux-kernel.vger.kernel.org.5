Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E667C941D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 12:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjJNKTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 06:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjJNKTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 06:19:10 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68224A2;
        Sat, 14 Oct 2023 03:19:08 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 829C440E01B0;
        Sat, 14 Oct 2023 10:19:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TFanxg4EsZFy; Sat, 14 Oct 2023 10:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697278743; bh=qPg+S/kRBxm8lPuVHVphsAidnPbVbymUJCgQF2Lo+KY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6Ia4AGMeu0o9uPcKjIjalp2+Ycy4Mq8nr280WKJHKXqz9/SXRLmXVnWVMM0GsYFK
         e1vufPdolIz6QrnRRdk0aePHwbWMXR0CldUOMKlSIpDsYk9Z6hxTdBlkWvuvUA/Vjr
         zA/7MuUwUFZcmmhd7Czx+ySgVvjPoj2ZJQNPNQvAFIZOuGlp5tLvZgZcxYwyGTlraZ
         MezA8YdiHme039IY0eqzR63DaV+F1RHciKcv9oo7F0YdPw2sUFF2fyeLArdQiKykas
         9JwGFrhZ/N0l134CdtI7qiyoqJtlIHDfgk5xlKAVYFUXBn6jOJJlaJg+wLfX74eZG4
         xShGWPN4TdaAnUjAXA/ClE6Evl4o1h1jkihfgdLQhD2/jPLx4Yz28ec+Z82wCIjuXq
         sOLh2p4B6mWGAQ8gM6aJ/dxJ6RnzPNiBgg2ZdRHtG615bWbQyRbYY4Mk6G1kvgAg/W
         HMmz5PhTdqrxPX3USGTc4qYZj/vWZZgORc05PcKO666avyTF85Xp/Qd9j+UDSqqe8+
         qW+mWwJQ4liGMNuqn56xbv8j0jIJQ0t3Sb2vdNGQsKOYA3MLjROp4c9vo547I9Jmmb
         zdUIaHaT1S8SznkTu1ZaIU24qIqEsIFGPero7CHKsSnz/fwzUNLBVX6OxU5mOjjoVk
         OoE55K0omXkvNkCU2mM9HTNA=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF21440E01AA;
        Sat, 14 Oct 2023 10:18:55 +0000 (UTC)
Date:   Sat, 14 Oct 2023 12:18:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhiquan Li <zhiquan1.li@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>
Subject: Re: [PATCH v3] x86/mce: Set PG_hwpoison page flag to avoid the
 capture kernel panic
Message-ID: <20231014101850.GAZSprCtc6QYEiGedU@fat_crate.local>
References: <20231014051754.3759099-1-zhiquan1.li@intel.com>
 <SJ1PR11MB6083A23BB89F4EE0F44B2794FCD1A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <233e17ac-0ae5-4392-a5e4-ab811a155805@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <233e17ac-0ae5-4392-a5e4-ab811a155805@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 05:34:12PM +0800, Zhiquan Li wrote:
> Oh, this is V3, not RESEND, I should reset the SoB chain.

You should slow down and take the time to read the document I pointed
you at.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
