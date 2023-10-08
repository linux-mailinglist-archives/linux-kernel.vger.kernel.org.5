Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039427BCE7D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 15:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344815AbjJHNIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 09:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344817AbjJHNIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 09:08:53 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC8ACF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 06:08:52 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 217B240E01AA;
        Sun,  8 Oct 2023 13:08:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MhSRB1D9gSHT; Sun,  8 Oct 2023 13:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696770528; bh=iVnBaxug3GYNobU6zx+iEf9aprmPGaeNIblCJJtzfIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZI8ibVB0w/+5U4hWivnAcat7bw1WG7Tm4kr6raUsj+WLIcKGES2GLK2ZUdFv6HLRM
         cajs6fD/WmPEWu9UC5t8cr17caPXR4DeVOZKCAKkQznUKpXSsJjz7kjWIdq3smQ498
         c2U+I7bGd3Curz0kB8iO+AamoXLOfVfVD0dcS4+lYPnnXebss9qSD4In6mttz/FHa/
         0qOKHlQ5Ez+jvZXIiKIex+p9yo4FavwRGPw9Yc2dmV2h66BJuuf4RTNip/u7BspV+B
         y363/yg3lvp7s4PR39iNGHgLDhrV/0MBHflO5LOo07nJlsJh1aQ3avNqP7WMzzC1oC
         sew6lPnJH/ZLHGxjmxgPTVtQ9atE76FkjvXVuCMzH7sUHCzJsGZ4W4WcU4qKbJlcLV
         +IQFKMyOnVh0p3z4LpHr/VXDzplXzbxJPi+9PSswTWtLAZc9oe2fRGA78u4QMlYAgh
         XB7O9J/KKc0mMrtP+7zZNmixBJ3zyNZHq3vRBGLf8XKxwAJcFN/bQiamy4K73FYQz+
         eIhk4iYLTun4ENmXMZuAetO6PLOOdHWOvX2xymP5hMS9UhnN7T+5bOp2LXyHlSqllg
         RxCYqtQZsvxZAv2acESgXIb3Drlj8qWzvv7s2I6IQABw81SPvHCxD9TPWf2M8dbqtM
         w7dHqouVAFgVZJ+6lW1fdAec=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 66CE140E0187;
        Sun,  8 Oct 2023 13:08:41 +0000 (UTC)
Date:   Sun, 8 Oct 2023 15:08:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc:     tglx@linutronix.de, arjan@linux.intel.com,
        chang.seok.bae@intel.com, linux-kernel@vger.kernel.org,
        nik.borisov@suse.com, x86@kernel.org
Subject: Re: [patch V4 00/30] x86/microcode: Cleanup and late loading
 enhancements
Message-ID: <20231008130840.GCZSKp2NbHAOB3h69z@fat_crate.local>
References: <20231002115506.217091296@linutronix.de>
 <20231008085456.71646-1-qiuxu.zhuo@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231008085456.71646-1-qiuxu.zhuo@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 04:54:56PM +0800, Qiuxu Zhuo wrote:
> Test Result (same as ucode-v3)
> ------------------------------
> Tested 'ucode-v4' on an Intel Sapphire Rapids server that both early load
> and late load worked well. For more details, please refer to the test below:

Thanks.

I've found a couple of issues and once I'm done with my testing, I'll
push tip:x86/microcode and you could run it then to make sure it all is
still ok.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
