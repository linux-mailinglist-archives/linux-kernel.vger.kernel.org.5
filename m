Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0068E771A88
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjHGGkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjHGGj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:39:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B374BA;
        Sun,  6 Aug 2023 23:39:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2730161554;
        Mon,  7 Aug 2023 06:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C00C433C7;
        Mon,  7 Aug 2023 06:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691390396;
        bh=cLRE+sII7UxJ95Wse28eozoKbP82elCRGURB4T28oU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xv3pC6z4NdGXo6fFO2mAE0b7pnfTYgjb109MExyrfTcLvK1Nb0Ld75UnbO+0aByN3
         /yyKCBy5B+XW5LNWCm1k1MgrJirKlbInMghvuZJw7m1cAPmaBiRJYIxrFUra4Jsubx
         KIqy2yPpqlk6KnycbxENlR3VzDHUoGHteVhNLduE=
Date:   Mon, 7 Aug 2023 08:39:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jannik =?iso-8859-1?Q?Gl=FCckert?= <jannik.glueckert@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Huang Rui <ray.huang@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux LLVM Build Support <llvm@lists.linux.dev>
Subject: Re: Fwd: CFI violation when reading amd_pstate/status
Message-ID: <2023080747-outsider-despite-acd2@gregkh>
References: <c7f1bf9b-b183-bf6e-1cbb-d43f72494083@gmail.com>
 <2023080743-amendable-moonlit-15b7@gregkh>
 <CAFqe=zJ9uRTVG=jny2PzUrrFGW2E_mZrGKF-3YMRkjzMUdu_7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqe=zJ9uRTVG=jny2PzUrrFGW2E_mZrGKF-3YMRkjzMUdu_7A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 08:21:37AM +0200, Jannik Glückert wrote:
> Hi Greg,
> 
> our kernel uses the Fedora config and has a homeopathic patchset on
> top of upstream - see
> https://gitweb.gentoo.org/proj/linux-patches.git/tree/?h=6.4 except
> the 50** patches.
> Namely we don't touch cpufreq or pm.
> 
> > Comm: cat Tainted: P
> 
> I am not using any out of tree modules, the kernel switches to
> Tainted: P on the first CFI violation.

Ah, ok.  Then work with the amd_pstate driver authors on this, odds are
one of the sysfs callbacks is incorrectly created which is quite easy to
do for stuff like this.  CFI also gets confused at times when dealing
with sysfs attributes due to them being cast in all sorts of crazy ways.

good luck!

greg k-h
