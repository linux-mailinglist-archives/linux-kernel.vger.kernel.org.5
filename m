Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D858040FE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjLDVb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjLDVbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:31:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F711AA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 13:31:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87769C433C8;
        Mon,  4 Dec 2023 21:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701725491;
        bh=jZE8WhQFFk5OHFb1w+ll7JB5KoaZRmBWaeDlAuQbU04=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Yu51sE3vS37G/VqsMHOxqKss2H9lLc4fVXXc5Sswc7TWVZjCgeKTO9ir8aGro4AeS
         K+Mdx7AbXDvIaTiNM7EJLY6Kz13WkF/5sEcmT2/1rFAokfwoKLWJKZstos9WHut7bE
         JUZ8TcEAGE9K+XFxplS2TnChfCNABEy0P3SsvlGMr6qu5da3hWCuc9PiDaees+tkhp
         7dV2Ee3diB7OkvxVY3U043mJCUsBP7aejaGnpmqJ7SAF4M0ZuZgbdwi/xNEgdLu73w
         cgXGTviVpjT7CtDCU3eeWQ1JePKAjfPB5FI2JU+ySDBuAobRBAcQ46WkQzOwDXXi8q
         g5naLxareX1NQ==
Date:   Mon, 4 Dec 2023 13:31:27 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     "Chen, Jiqian" <Jiqian.Chen@amd.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Stabellini, Stefano" <stefano.stabellini@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
        "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
        "Huang, Honglei1" <Honglei1.Huang@amd.com>,
        "Zhang, Julia" <Julia.Zhang@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [RFC KERNEL PATCH v2 1/3] xen/pci: Add xen_reset_device_state
 function
In-Reply-To: <BL1PR12MB5849F2E24E00BF7B20A0B4A6E786A@BL1PR12MB5849.namprd12.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2312041331210.110490@ubuntu-linux-20-04-desktop>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com> <20231124103123.3263471-2-Jiqian.Chen@amd.com> <87edg2xuu9.ffs@tglx> <BL1PR12MB5849F2E24E00BF7B20A0B4A6E786A@BL1PR12MB5849.namprd12.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Dec 2023, Chen, Jiqian wrote:
> >> vpci device state when device is reset on dom0 side.
> >>
> >> And call that function in pcistub_init_device. Because when
> >> we use "pci-assignable-add" to assign a passthrough device in
> >> Xen, it will reset passthrough device and the vpci state will
> >> out of date, and then device will fail to restore bar state.
> >>
> >> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> >> Signed-off-by: Huang Rui <ray.huang@amd.com>
> > 
> > This Signed-off-by chain is incorrect.
> > 
> > Documentation/process/submitting-patches.rst has a full chapter about
> > S-O-B and the correct usage.
> I am the author of this series of patches, and Huang Rui transported the v1 to upstream. And now I transport v2. I am not aware that the SOB chain is incorrect.
> Do you have any suggestions?

I think he means that your Signed-off-by should be the second one of the
two as you are the one submitting the patch to the LKML
