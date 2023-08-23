Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C148785CA5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbjHWPvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjHWPvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:51:49 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7FECD1;
        Wed, 23 Aug 2023 08:51:46 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37NFpXt4038893;
        Wed, 23 Aug 2023 10:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692805893;
        bh=W6V1upOtSdkrnnJgAfZkngCMorV465U5MgquJbm+CBM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=rgEnzlZVRAsltvaxt2Lw7e/JB5pIwgDNJ5z7gXFgyTUlUozLCmPbcUZz1Z4Gz9aUw
         qG/NHPERxiLA3KBo63RsXCv8xQf8UrKAaJioXhw084Sqf3/VUWZgfxhcrueSTdcJZC
         xcua6yH55WJ4ueFYP69Qxw1TRXVvRBnh9MyTY0a0=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37NFpXeC055323
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Aug 2023 10:51:33 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 10:51:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 10:51:33 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37NFpXj6008149;
        Wed, 23 Aug 2023 10:51:33 -0500
Date:   Wed, 23 Aug 2023 10:51:33 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Kevin Cahalan <kevinacahalan@gmail.com>
Subject: Re: [PATCH] remoteproc: core: Honor device tree /alias entries when
 assigning IDs
Message-ID: <20230823155133.v7r3uddautivowps@frail>
References: <20230807140247.956255-1-nm@ti.com>
 <ZOULmFR51C+9kEhZ@p14s>
 <20230822201205.4csoj4kym2yhuyrf@decrease>
 <ZOYkVec/aQSiCWxh@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZOYkVec/aQSiCWxh@p14s>
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

On 09:23-20230823, Mathieu Poirier wrote:
> On Tue, Aug 22, 2023 at 03:12:05PM -0500, Nishanth Menon wrote:
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
> 
> We are going around in circles.  In the above link using an alias will
> guarantee that "remoteproc18" is available but won't guarantee the
> functionality enacted by the FW loaded in that remote processor, which is distro
> dependent.

Apologies, but I am trying to comprehend the relationship and probably
am failing to see the linkage. Let me try:

If I understand you correctly, you are concerned that distros do not
have a mechanism to provide consistent firmware to the correct remote
proc for a specific functionality..

if so, distro loads / provides the requisite firmware. How
the package distribution scheme works to distribute the firmware
and versioning provided varies - One typical pattern has been to use
linux-firmware repo[1] (at least in other domains - say GPU, wlink or
the likes) and provide package distribution. The other pattern could
be build and deploy based on tag (this would be no different from any
other package deployment).

On the other hand, If we are looking at the fact that there can be
different types of firmware that could be loaded to a remoteproc
providing different functionality - that is correct, and at least in
case of TI processors very valid - something like openAMP endpoint
solutions probably help?

Let me know if I am off-track here..

[1] https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/tree/ti-ipc?h=ti-linux-firmware
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
