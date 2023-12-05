Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B45805C72
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345185AbjLERCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjLERCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:02:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5561B6;
        Tue,  5 Dec 2023 09:02:57 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701795775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tKj/G59HmDBT/RcKJNhjfacQG0y6lbGXbN5/YyhoGFQ=;
        b=gBs2xU/8H+BYBNLyCeYcxWGK2DZm4IabnOmpFdODKMdgkBPuxusYpkJuD8d5nh/R3KLnbv
        x5HOmiKZACda/7MqInA95GLLoSjFc6ZbPAHItZhCLbXpNfG3vEP8PEeAv0Dyhl0ZN/i5p4
        D36nAXuQqr6TgdWMOQNCHWsCvy69bXXMfTa4MjCEVvmGElsCn7OmsxHPtkilqKWMZmCn8s
        WgGntur+yfvv0BQdbGoMsjQqWyqyXeiiJ0BlpPUYpuPujZWY1I4IA7ixlnPTzRjMbnL3E9
        ql34epQy/+k5Z+geYL3XccPv8qe8KR/gW2//csS7+XQIbeTKK4sr4lXiM6fONw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701795775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tKj/G59HmDBT/RcKJNhjfacQG0y6lbGXbN5/YyhoGFQ=;
        b=ycX4aADBX6fBhOk+amfiCNFdHlR2j22kpskGtkhiZY8tFpmyEFOH2YLz4yXuMW8J2h7zyH
        rHbpCWNVp2OWgABA==
To:     Stefano Stabellini <sstabellini@kernel.org>,
        "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,
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
In-Reply-To: <alpine.DEB.2.22.394.2312041331210.110490@ubuntu-linux-20-04-desktop>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
 <20231124103123.3263471-2-Jiqian.Chen@amd.com> <87edg2xuu9.ffs@tglx>
 <BL1PR12MB5849F2E24E00BF7B20A0B4A6E786A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <alpine.DEB.2.22.394.2312041331210.110490@ubuntu-linux-20-04-desktop>
Date:   Tue, 05 Dec 2023 18:02:54 +0100
Message-ID: <87fs0gwpj5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04 2023 at 13:31, Stefano Stabellini wrote:
> On Mon, 3 Dec 2023, Chen, Jiqian wrote:
>> >> vpci device state when device is reset on dom0 side.
>> >>
>> >> And call that function in pcistub_init_device. Because when
>> >> we use "pci-assignable-add" to assign a passthrough device in
>> >> Xen, it will reset passthrough device and the vpci state will
>> >> out of date, and then device will fail to restore bar state.
>> >>
>> >> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
>> >> Signed-off-by: Huang Rui <ray.huang@amd.com>
>> > 
>> > This Signed-off-by chain is incorrect.
>> > 
>> > Documentation/process/submitting-patches.rst has a full chapter about
>> > S-O-B and the correct usage.
>> I am the author of this series of patches, and Huang Rui transported the v1 to upstream. And now I transport v2. I am not aware that the SOB chain is incorrect.
>> Do you have any suggestions?
>
> I think he means that your Signed-off-by should be the second one of the
> two as you are the one submitting the patch to the LKML

No.

   Mailfrom: Jiqian Chen <Jiqian.Chen@amd.com>
   <body>

   Changelog-text

   Signed-off-by: Huang Rui <ray.huang@amd.com>
   Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>

is equally wrong because that would end up with Chen as author and Huang
as first S-O-B which is required to be the author's S-O-B

To make the above correct this would require:

   Mailfrom: Jiqian Chen <Jiqian.Chen@amd.com>
   <body>

   From: Huang Rui <ray.huang@amd.com>

   Changelog-text

   Signed-off-by: Huang Rui <ray.huang@amd.com>
   Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>

   which tells that Huang is the author and Chen is the 'transporter',
   which unfortunately does not reflect reality.

Or:

   Mailfrom: Jiqian Chen <Jiqian.Chen@amd.com>
   <body>

   Changelog-text

   Co-developed-by: Huang Rui <ray.huang@amd.com>
   Signed-off-by: Huang Rui <ray.huang@amd.com>
   Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>

   which tells that Checn is the author and Huang co-developed the
   patch, which might be true or not.


V1 which was sent by Huang has the ordering is correct:

   Mailfrom: Huang Rui <ray.huang@amd.com>
   <body>

   From: Jiqian Chen <Jiqian.Chen@amd.com>

   Changelog-text

   Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
   Signed-off-by: Huang Rui <ray.huang@amd.com>

   i.e. Chen authored and Huang transported

Now this V2 has not really much to do with V1 and is a new
implementation to solve the problem, which was authored by Chen, so
Huang is not involved at all if I understand correctly.

So what does his S-O-B mean here? Nothing...

It's very well documented how the whole S-O-B business works and it's
not really rocket science to get it straight.

It has a meaning and is not just for decoration purposes.

Thanks,

        tglx
