Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E579D761FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjGYRBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjGYRBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:01:10 -0400
Received: from mailrelay2-1.pub.mailoutpod2-cph3.one.com (mailrelay2-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:401::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0778E1988
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=sduBUGWe44xQWwq5ehD9FZfNDPxgCDY8mIHiqy0iMz0=;
        b=ajkMW1PbXV5ZNeCv6fGQDs8eCTKwm7tceSP+u4iKBg3fNgHNE5tV7E89uNWKbRZqpuCxzKkrJawHl
         yZU3If0GP8ob2d0p3XB9VXvIVdrDkRxKoyhDrBpdtFTi2zket7AWCHMsbEuLLBJi/9yY2Ms/6kaMSb
         iIi3sHzlOuMqcdRacGOcZ+YQvG7FbiE4V3usqsPR+psnzErUFIVQ3mKBQQytHSMsCIerdLp87Ap4Td
         Vja0V543JkCFspeWF/652AuyFvyEPdg4xrxTvwa7zXia8h2N/jKULJp2EGJnNzeCPQWNt63WGu6VO2
         OXhW0cGJGqGY4httMvwl2WXUcaj7i9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=sduBUGWe44xQWwq5ehD9FZfNDPxgCDY8mIHiqy0iMz0=;
        b=ZO9RvjKMywyAQZYeVC+Ms4lsmJ/5kmXCirU8i8gP9NL5789egvdahQABh7frEO38MtS2NdXXsBrUx
         QTBqrcmBA==
X-HalOne-ID: d70c573f-2b0c-11ee-880d-5ba399456a4a
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay2 (Halon) with ESMTPSA
        id d70c573f-2b0c-11ee-880d-5ba399456a4a;
        Tue, 25 Jul 2023 17:01:05 +0000 (UTC)
Date:   Tue, 25 Jul 2023 19:01:04 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     linux@treblig.org
Cc:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Use shared font data
Message-ID: <20230725170104.GA838289@ravnborg.org>
References: <20230725000141.165985-1-linux@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725000141.165985-1-linux@treblig.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Tue, Jul 25, 2023 at 01:01:41AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> PowerPC has a 'btext' font used for the console which is almost identical
> to the shared font_sun8x16, so use it rather than duplicating the data.
> 
> They were actually identical until about a decade ago when
>    commit bcfbeecea11c ("drivers: console: font_: Change a glyph from
>                         "broken bar" to "vertical line"")
> 
> which changed the | in the shared font to be a solid
> bar rather than a broken bar.  That's the only difference.
> 
> This was originally spotted by PMD which noticed that sparc does
> the same thing with the same data, and they also share a bunch
> of functions to manipulate the data.  I've previously posted a near
> identical patch for sparc.
> 
> One difference I notice in PowerPC is that there are a bunch of compile
> options for the .c files for the early code to avoid a bunch of security
> compilation features;  it's not clear to me if this is a problem for
> this font data.
> 
> Tested very lightly with a boot without FS in qemu.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Yep, looks very similar to sparc, so

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
