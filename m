Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298ED8064A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376563AbjLFBrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbjLFBre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:47:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CD1D5B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:47:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21887C433C7;
        Wed,  6 Dec 2023 01:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701827248;
        bh=m3OXxxaNOcCbca66NX0B9W3SqJV3ZbMjQp5zBskM9iI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fewuHwMfF7zXS1KUN/yTlis/ON6ZzuoLEyVFUGPZ9e0JM1b5qkBEecx3SbLP+A37V
         a/zKC02fLbBZZPpc0mgpq429kLVSQFKqQEsqzFL93X3zu5IVKo/cKFbVkKTZJd5Q1S
         I2L71pZtRcUtVBwYOwdNraE0eqvY23jcqGWw4uVgmSE4wIEU4KSlFMWwupnyQK8GbX
         qDztWGvvIwum5XxJAv2Io7HNrLcPdOjpN2LdpuMlMWWURAu3XVrGheH3uoeun4M6ab
         Zotz94GIIYhaQu02K5yIPlbabSBak30TMDqUN3ctur3BFI+PwiYxSktdXmpiWbeWJJ
         49ab9W3qz4atQ==
Date:   Wed, 6 Dec 2023 02:47:14 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Jochen Friedrich <jochen@scram.de>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] i2c: cpm: Fix data type
Message-ID: <20231206014714.etrj4ecnt4tln5ev@zenone.zhora.eu>
References: <de07101166ac0e4649cf3b57fdf960748c9ecc75.1701800124.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de07101166ac0e4649cf3b57fdf960748c9ecc75.1701800124.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Tue, Dec 05, 2023 at 07:16:53PM +0100, Christophe Leroy wrote:
> sparse reports an error on some data that gets converted from be32.
> 
> That's because that data is typed u32 instead of __be32.
> 
> Fix it.

the reason for this sparse error is that the data variables is
then parsed with a be32_to_cpup() and I think that's not
necessary.

I think the real fix here is to not use be32_to_cpup().

Andi
