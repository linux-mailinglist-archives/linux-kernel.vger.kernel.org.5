Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3453E7FC1D4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346362AbjK1Ovu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346329AbjK1Ovt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:51:49 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFB3D4B;
        Tue, 28 Nov 2023 06:51:55 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Sflk36nr0z6K9B5;
        Tue, 28 Nov 2023 22:50:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
        by mail.maildlp.com (Postfix) with ESMTPS id 8A048140D1D;
        Tue, 28 Nov 2023 22:51:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 14:51:52 +0000
Date:   Tue, 28 Nov 2023 14:51:52 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
        <linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <x86@kernel.org>, <linux-csky@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
        <linux-parisc@vger.kernel.org>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <jianyong.wu@arm.com>, <justin.he@arm.com>,
        James Morse <james.morse@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH RFC 08/22] drivers: base: Implement weak
 arch_unregister_cpu()
Message-ID: <20231128145152.00003ce7@Huawei.com>
In-Reply-To: <ZVyxqoKBL8LsxXW+@shell.armlinux.org.uk>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
        <E1r0JLL-00CTxD-Gc@rmk-PC.armlinux.org.uk>
        <ZVyxqoKBL8LsxXW+@shell.armlinux.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > +
> > +#ifdef CONFIG_HOTPLUG_CPU
> > +void __weak arch_unregister_cpu(int num)
> > +{
> > +	unregister_cpu(&per_cpu(cpu_devices, num));
> > +}
> > +#endif /* CONFIG_HOTPLUG_CPU */  
> 
> I have previously asked the question whether we should provide a
> stub weak function for the !HOTPLUG_CPU case for this, which would
> alleviate the concerns around if (IS_ENABLED()) in some of the later
> hotplug vCPU patches... which failed to get _any_ responses.
> 
> So, I'm now going to deem the comment I received about if (IS_ENABLED())
> potentially causing issues to be unimportant, and thus there's no
> need for a stub weak function. If we start getting compile errors,
> then we can address the issue at that point. So far, however, the
> kernel build bot has not identified that this as an issue... and it's
> been chewing on this entire patch set for well over a month now.
> 

Make sense to fix this only if it's a real problem. 
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
