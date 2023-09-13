Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21D079E4D4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbjIMK0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbjIMKZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:25:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF223D3;
        Wed, 13 Sep 2023 03:25:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040C1C433C8;
        Wed, 13 Sep 2023 10:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694600755;
        bh=4k2IeW5H9cEqbLtJFKkr6gJFeGtpZv+ntg6InyehTu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MsMiX7Bq3wu/ubrt9go4Zl2qtpZZZdKThoIZMlsHjdv+fHu2fusSjJfXcdrTL0+1h
         7c1jVIQcD03WR5z9RerPkcDNylNLW5Wq3XcKZ5bQYWy1wXrd9cTvRWfIPl3MwXFskV
         XPH3kH0v1uj9MuRwolV+w+vLF0LjVfOEoRv4JRCNrGQpP+Jxjf6cG7TlggmqUuLepJ
         Vat7PzDJUQrphDZ733Kkrcn9wU4VLMBBeNki+N7/G53aZI9TMUHiPzXSVDuhsMMjz9
         Dmy5ALThLPMKpNRjZyQfJhkygiiY63lqSxswU6AkAvbbdNCesDQtNF2bRM3DaEuEmo
         sHH75LxTD4r6w==
Date:   Wed, 13 Sep 2023 11:25:46 +0100
From:   Will Deacon <will@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     corbet@lwn.net, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        mathieu.poirier@linaro.org, catalin.marinas@arm.com,
        linus.walleij@linaro.org, andy.shevchenko@gmail.com,
        vigneshr@ti.com, nm@ti.com, matthias.bgg@gmail.com,
        kgene@kernel.org, alim.akhtar@samsung.com, bmasney@redhat.com,
        quic_tsoni@quicinc.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel@quicinc.com
Subject: Re: [REBASE PATCH v5 08/17] arm64: mm: Add dynamic ramoops region
 support through command line
Message-ID: <20230913102545.GA12021@willie-the-truck>
References: <1694429639-21484-1-git-send-email-quic_mojha@quicinc.com>
 <1694429639-21484-9-git-send-email-quic_mojha@quicinc.com>
 <20230912101820.GA10884@willie-the-truck>
 <14bf3fca-f031-d000-6fd6-d82f4de9b255@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14bf3fca-f031-d000-6fd6-d82f4de9b255@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 12:32:54PM +0530, Mukesh Ojha wrote:
> Thanks for the response.
> 
> On 9/12/2023 3:48 PM, Will Deacon wrote:
> > On Mon, Sep 11, 2023 at 04:23:50PM +0530, Mukesh Ojha wrote:
> > > The reserved memory region for ramoops is assumed to be at a fixed
> > > and known location when read from the devicetree. This may not be
> > > required for something like Qualcomm's minidump which is interested
> > > in knowing addresses of ramoops region but it does not put hard
> > > requirement of address being fixed as most of it's SoC does not
> > > support warm reset and does not use pstorefs at all instead it has
> > > firmware way of collecting ramoops region if it gets to know the
> > > address and register it with apss minidump table which is sitting
> > > in shared memory region in DDR and firmware will have access to
> > > these table during reset and collects it on crash of SoC.
> > > 
> > > So, add the support of reserving ramoops region to be dynamically
> > > allocated early during boot if it is request through command line
> > > via 'dyn_ramoops_size=' and fill up reserved resource structure and
> > > export the structure, so that it can be read by ramoops driver.
> > > 
> > > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > > ---
> > >   arch/arm64/mm/init.c       | 94 ++++++++++++++++++++++++++++++++++++++++++++++
> > 
> > Why does this need to be in the arch code? There's absolutely nothing
> > arm64-specific here.
> 
> Current clients of this cmdline would be only arm64, and that is the
> reason of putting this here.

I don't think that's a strong enough justification, tbh. We should at
least be able to compile this for other architectures using TEST_COMPILE
and so somewhere under drivers/ makes more sense to me.

Will
