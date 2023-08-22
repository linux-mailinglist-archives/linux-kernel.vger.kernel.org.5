Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E232B784C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjHVVuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjHVVux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:50:53 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB59CD1;
        Tue, 22 Aug 2023 14:50:51 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MLohE4105792;
        Tue, 22 Aug 2023 16:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692741043;
        bh=CMfL4wwoDhsfeUYN9y/IzifVg95H+zdZDy8rPvWU0As=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=WCqWqqNZIGylQTAAnALXBdNY+6L2xyQ/W+y7rM7U4RPOz96pxjbY51Jcf7ev9KP4R
         ceMi/bc/dxtcvaVh2z82bVb5f7smvtSdSz1kPV5YIt+Ni8KUql7TglPx7WOUeiT6Md
         3mf5BW7SFL2AnAXo9L3LMsMTtTIfbF1UGHOMAfW4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MLohxX093742
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Aug 2023 16:50:43 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 16:50:42 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 16:50:42 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MLog8r004285;
        Tue, 22 Aug 2023 16:50:42 -0500
Date:   Tue, 22 Aug 2023 16:50:42 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Kevin Cahalan <kevinacahalan@gmail.com>
Subject: Re: [PATCH] remoteproc: core: Honor device tree /alias entries when
 assigning IDs
Message-ID: <20230822215042.yjaqtwhuhls57pbu@glamour>
References: <20230807140247.956255-1-nm@ti.com>
 <ZOULmFR51C+9kEhZ@p14s>
 <20230822201205.4csoj4kym2yhuyrf@decrease>
 <949a8814-2084-2636-7a1b-a9d1188a16f8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <949a8814-2084-2636-7a1b-a9d1188a16f8@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:45-20230822, Andrew Davis wrote:
> On 8/22/23 3:12 PM, Nishanth Menon wrote:
> > On 13:25-20230822, Mathieu Poirier wrote:
> > > Hi Nishanth,
> > > 
> > > On Mon, Aug 07, 2023 at 09:02:47AM -0500, Nishanth Menon wrote:
> > > > On many platforms, such as Beaglebone-AI64 with many remote
> > > > processors, firmware configurations provided by the distributions can
> > > > vary substantially depending on the distribution build's functionality
> > > > and the specific remote cores enabled in that variant. Ensuring
> > > > consistent udev rules mapping remoteproc nodes to constant remote
> > > > proc device indices across distributions (yocto, ubuntu, debian and
> > > > it's variants, ...) on a board basis can be challenging due to the
> > > > various functions of these distributions. Varied device node paths
> > > > create challenges for applications that operate on remote processors,
> > > > especially in minimal embedded systems(initrd like) that may not
> > > > have udev-like capabilities and rely on a more straightforward bare
> > > > filesystem. This challenge is similar to that faced by I2C, RTC or the
> > > > GPIO subsystems.
> > > > 
> > > 
> > > I'm puzzled by this patch.  I can see how using an alias can help in boards with
> > > various HW configuration.  That said, and as written above, FW files for remote
> > > processors can vary based on the build's functionality.  As such "remoteproc3"
> > > will reference the same HW device on all distributions but the functionality
> > > enacted by the FW may be different.  As such I don't see how an alias can help
> > > here.  Can you provide a concrete example that highlights the benefits?
> > 
> > Correct - *if* remoteproc3 is the constant node reference.
> > 
> > To take a trivial example: We ran into this issue with:
> > https://github.com/kaofishy/bbai64_cortex-r5_example/blob/main/Makefile#L28
> > 
> > remoteproc18 apparently changed numbering in a different build.
> > 
> > If remoteproc18 remained the same between different distro builds that
> > would have probably kept the userspace constant. but it does'nt. it
> > dependent purely on probe order, which does'nt let userspace remain
> > consistent.
> > 
> > Same reason and motivation to do the following:
> > https://git.beagleboard.org/beagleboard/repos-arm64/-/blob/main/bb-customizations/suite/bookworm/debian/86-remoteproc-noroot.rules
> > in one technique to do it - but that only works if all the distros
> > follow the same udev rules - and there is no reasonable way to enforce
> > that across distributions.
> > 
> 
> Enforcing distros to behave the same isn't the job of Device Tree, udev
> rules seems like a reasonable place. Anyone dealing with Linux should know
> they should not rely on kernel provided device names/numbers
> (like with disks, network interfaces, etc.).
> 
> If you want to have a path that will always work you could use:
> 
> /sys/devices/platform/bus@f4000/bus@f4000\:r5fss@78400000/78400000.r5f/remoteproc/
> 
> for the same. I don't like that it makes an ABI out of node names,
> but better than putting any more Linux configuration in DT IMHO.

aliases are there for real reasons. So lets not confuse the two. End of
the day being able to help userspace is what it does.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
