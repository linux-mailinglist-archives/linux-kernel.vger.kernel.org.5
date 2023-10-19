Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2467CECCB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 02:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjJSAcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 20:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSAcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 20:32:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B39FE;
        Wed, 18 Oct 2023 17:32:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFE6C433C7;
        Thu, 19 Oct 2023 00:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697675525;
        bh=iZGL4wXAMICOUSQLyjE/36oHOPVmQqhi52ipPzUGeYw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pvcQUM17nHbvllmRLn1w5S27ng0/xLgzsSqEHrhlwPtI9KqXwCOnqVzfVQ+W2R0LW
         5XGZGQ0WDiXaamqqF1XkxLKzweaEia53bLeqlnjZFdZ16rDNSFhmnwE4fOPNjANOE/
         1k7cED0ubG5P6RiT5hxaAjmiFmFe70Q6gqfmBw3nmBZwVQI6Gz3a7VAOeMGZmbpTxe
         9nzhiAP5wcqT+zBrxjuxv86wwSX3nhS6UPjBULhJVsKFHazZuIw3fi2ycFH4Ff8ybk
         +Vks/CAOKs/yvnxy/pfD3OYwgLqaWyb4mlqJwotDWryulYQgA8zhBbtcizc3tVCM/m
         2a0H+dmJ2rD5Q==
Message-ID: <13d7cf46270082855174414b691fb3be.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230827023932.501102-1-sergio.paracuellos@gmail.com>
References: <20230827023932.501102-1-sergio.paracuellos@gmail.com>
Subject: Re: [PATCH v2] clk: ralink: mtmips: quiet unused variable warning
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     tsbogend@alpha.franken.de, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        arnd@kernel.org, yangshiji66@outlook.com,
        kernel test robot <lkp@intel.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org
Date:   Wed, 18 Oct 2023 17:32:02 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergio Paracuellos (2023-08-26 19:39:32)
> When CONFIG_OF is disabled then the matching table is not referenced and
> the following warning appears:
>=20
> drivers/clk/ralink/clk-mtmips.c:821:34: warning: unused variable 'mtmips_=
of_match' [-Wunused-const-variable]
> 821 |   static const struct of_device_id mtmips_of_match[] =3D {
>     |                          ^
>=20
> There are two match tables in the driver: one for the clock driver and the
> other for the reset driver. The only difference between them is that the
> clock driver uses 'data' and does not have 'ralink,rt2880-reset' compatib=
le.
> Both just can be merged into a single one just by adding the compatible
> 'ralink,rt2880-reset' entry to 'mtmips_of_match[]', which will allow it to
> be used for 'mtmips_clk_driver' (which doesn't use the data) as well as f=
or
> 'mtmips_clk_init()' (which doesn't need get called for 'ralink,rt2880-res=
et').
>=20
> Doing in this way ensures that 'CONFIG_OF' is not disabled anymore so the
> above warning disapears.
>=20
> Fixes: 6f3b15586eef ("clk: ralink: add clock and reset driver for MTMIPS =
SoCs")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307242310.CdOnd2py-lkp@i=
ntel.com/
> Suggested-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---

Applied to clk-next
