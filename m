Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D743F7C88A6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjJMP2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjJMP2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:28:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE82FDE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:28:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E84CC433C8;
        Fri, 13 Oct 2023 15:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697210897;
        bh=iiew/laD+Q3haHwMxgaUmOJOpF//XuI1aJ4hOlOKh6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B6aOhjI4W3T3qqRBW/NsttzXu5HUYLUV0lP13HpcxULbCsY8haM+fvx/hkj6ifjtz
         5uZCpSp2yYae/IoUGpnXO1b3PAiCRuxJ2QNmSgt762IP05AQmV1jLJKNvfC3fo3Nff
         Z1eyDfRCPYIEucr4zoADjXI4vRzVrqegikLNsl094KykJc8hZMs9isjWNn37ugG4mL
         b7BS7rV1TDFjqx3xH9xB/2V45Bkqj8K5qirF/WyXBzb1dv9lhsMC7rfYLnjJAqVQfh
         xNspCeaor9aeIXP83je9bdwKF47wno/dy555mpvKuCdCi1hRXBYmhqlW+lJOw1Ar8m
         CQCLt2ppkzeJA==
Date:   Fri, 13 Oct 2023 17:28:10 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        ankita@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
        aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
        targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
        apopple@nvidia.com, jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZSliChc3poZNM4f9@lpieralisi>
References: <ZQIFfqgR5zcidRR3@nvidia.com>
 <ZRKW6uDR/+eXYMzl@lpieralisi>
 <ZRLiDf204zCpO6Mv@arm.com>
 <ZR6IZwcFNw55asW0@lpieralisi>
 <20231012123541.GB11824@willie-the-truck>
 <ZSf6Ue09IO6QMBs1@arm.com>
 <20231012144807.GA12374@willie-the-truck>
 <ZSgsKSCv-zWgtWkm@arm.com>
 <20231013092934.GA13524@willie-the-truck>
 <ZSlBOiebenPKXBY4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSlBOiebenPKXBY4@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 02:08:10PM +0100, Catalin Marinas wrote:

[...]

> Yes, we end up with mismatched aliases but they only matter if the VMM
> also accesses the I/O range via its own mapping. So far I haven't seen
> case that suggests this.
> 
> > > Things can go wrong but that's not because Device does anything better.
> > > Given the RAS implementation, external aborts caused on Device memory
> > > (e.g. wrong size access) is uncontainable. For Normal NC it can be
> > > contained (I can dig out the reasoning behind this if you want, IIUC
> > > something to do with not being able to cancel an already issued Device
> > > access since such accesses don't allow speculation due to side-effects;
> > > for Normal NC, it's just about the software not getting the data).
> > 
> > I really think these details belong in the commit message.
> 
> I guess another task for Lorenzo ;).

I will do, I start wondering though whether this documentation belongs
in this commit log only or at Documentation/arch/arm64 level (or both),
I am pretty sure this thread can turn out quite useful as a reference
(it is for me) if we manage to summarize it that would benefit
everyone.

Lorenzo
