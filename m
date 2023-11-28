Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5217FC2D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345168AbjK1SCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjK1SCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:02:43 -0500
Received: from gentwo.org (gentwo.org [IPv6:2a02:4780:10:3cd9::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39F191
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:02:45 -0800 (PST)
Received: by gentwo.org (Postfix, from userid 1003)
        id 5DF5F46624; Tue, 28 Nov 2023 10:02:45 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 5CC1341AEC;
        Tue, 28 Nov 2023 10:02:45 -0800 (PST)
Date:   Tue, 28 Nov 2023 10:02:45 -0800 (PST)
From:   "Christoph Lameter (Ampere)" <cl@linux.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Valentin.Schneider@arm.com,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Matteo Carlini <Matteo.Carlini@arm.com>
Subject: Re: [PATCH ARM64]: Introduce CONFIG_MAXSMP to allow up to 512 cpus
In-Reply-To: <52b8a7d8-aa4c-46db-a7f5-f36c92ad5380@arm.com>
Message-ID: <01d7531b-3d5c-989d-58ac-60861249fd3e@linux.com>
References: <6a854175-5f89-c754-17b8-deda18447f1f@gentwo.org> <52b8a7d8-aa4c-46db-a7f5-f36c92ad5380@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023, Anshuman Khandual wrote:

>
>
> On 11/21/23 06:34, Christoph Lameter (Ampere) wrote:
>> Ampere Computing develops high end ARM processors that support an ever
>> increasing number of processors. The current default of 256 processors is
>> not enough for our newer products. The default is used by Linux
>> distros and therefore our customers cannot use distro kernels because
>> the number of processors is not supported.
>
> In the previous thread mentioned below, Catalin had mentioned that the
> distros do tweak the config for their needs. The default is applicable
> for an wide range systems, hence just wondering why default NR_CPUS be
> changed for all.

We would like the standard kernel to be able to boot on our systems and 
those have more than the current NR_CPU processors. The distros only 
tweaks things on request and with this change the tweaking is no longer
necessary.

> Also just curious, what might be the concern for distros to have large
> platform specific configs overriding the default.

There are numerous distributions as well as individuals who built kernels. 
It is surprising if someone builds an upstream kernel with the defaults 
that should fit all supported platforms only to find that only a portion 
of their cpus come up. The work of discovery why this is and how to fix it 
has to be done by numerous individuals and organizations in order to 
enable all cpus. That work is not necessary if the default is such that a 
sufficient number of processors are supported by the default configuration 
accommodating all ARM hardware.

The CONFIG_MAXSMP configuration on X86 was developed exactly for these 
situations and we have a special KCONFIG option to have potentially large 
bitmaps for cpus allocated as needed in the kernel core. The patch enables 
the use of that facility.


