Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D827781EA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbjHJT7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjHJT7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:59:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5EE2723;
        Thu, 10 Aug 2023 12:59:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2890C66874;
        Thu, 10 Aug 2023 19:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078CBC433C9;
        Thu, 10 Aug 2023 19:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691697575;
        bh=HFKdKTvWgmTJ9zRaGAXhGFqBtI9abzBHPJqju93sW88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zGZoTZnUcAssR0Tl8d3QKvjObNm8LtePSJif55CNW5b/Y/IUUeax+ZKa1vITgDi5J
         VHT3MuUZ6V1EBkJ2BiLcStIodSYbbHdzwVsxb5Qq1e2Kj8M3MQyv44FJ0rQmtoZTnF
         1y6zTGgAFm1P4N0Z9RJwI6824TVhiIyQnTx0m5Ik=
Date:   Thu, 10 Aug 2023 21:59:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        lyude@redhat.com
Subject: Re: [PATCH 4.19 000/323] 4.19.291-rc1 review
Message-ID: <2023081020-graveyard-enjoying-c933@gregkh>
References: <20230809103658.104386911@linuxfoundation.org>
 <CAEUSe787p3uDD9Q0wq=Y=PY0-wLxbYY8oY6T24dhm+qgK1MjNw@mail.gmail.com>
 <CAHk-=wiTzjgRRPmfkwOr89uMuk5wdoG_6edMAnEdubX9bq8OSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiTzjgRRPmfkwOr89uMuk5wdoG_6edMAnEdubX9bq8OSw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:36:41PM -0700, Linus Torvalds wrote:
> On Thu, 10 Aug 2023 at 12:28, Daniel Díaz <daniel.diaz@linaro.org> wrote:
> >
> > Two new warnings are introduced on x86_64 with GCC-8 (defconfig):
> >
> > -----8<-----
> > drivers/gpu/drm/drm_edid.o: warning: objtool:
> > drm_mode_std.isra.34()+0xbc: return with modified stack frame
> > drivers/gpu/drm/drm_edid.o: warning: objtool:
> > drm_mode_std.isra.34()+0x0: stack state mismatch: cfa1=7+112 cfa2=7+8
> > ----->8-----
> >
> > Bisection points to the quoted commit ("drm/edid: Fix uninitialized
> > variable in drm_cvt_modes()"), 991fcb77f490 upstream. Reverting makes
> > the warnings disappear.
> 
> Bah. Stable should pick up commit d652d5f1eeeb ("drm/edid: fix objtool
> warning in drm_cvt_modes()") from mainline too.
> 
> Sadly it didn't have a 'Fixes:' tag, so it didn't get picked up
> automatically. My bad.
> 
> Although it's not like the commits it fixes were actually ever marked
> for stable either. I guess commit 3f649ab728cd ("treewide: Remove
> uninitialized_var() usage") got picked up as some kind of "make it
> easier to apply other patches" thing.

I applied the uninitialized_var patch here because I was trying to
attempt to reduce the number of build warnings I am getting using gcc-12
on 4.19.y  It helped out a tiny bit, but we still have lots of warnings
left.

I'll pick up d652d5f1eeeb as well now, thanks for pointing it out.

greg k-h
