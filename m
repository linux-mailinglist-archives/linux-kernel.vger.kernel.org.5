Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2A779BDFF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbjIKUta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbjIKNFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:05:24 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC51DF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:05:19 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BD4WjN020555;
        Mon, 11 Sep 2023 08:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694437472;
        bh=l3EsvSktChO7TrFPn0emVwsdyYD0XfMxdQQKc9ZTbHk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=RgrZJ6I5abBlaqQ0Lct0j5m+QJXF5iPD34MARIPidmmM6bVGTvzIu97IcjAsHUA7J
         eIjybEqc2UldeP7u6MDqSDOC4QiEwhesJhFDa5muMM1QBzQqPn9Na0LV47pqFeW3ML
         GEr/2yxIV3cceV0fg/dVh9LJjCuFLSBQQY7Al95o=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BD4Wq9006471
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 08:04:32 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 08:04:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 08:04:31 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BD4VYn029854;
        Mon, 11 Sep 2023 08:04:31 -0500
Date:   Mon, 11 Sep 2023 08:04:31 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Davis <afd@ti.com>,
        Zhizhou Zhang <zhizhou.zh@gmail.com>, <rppt@kernel.org>,
        <akpm@linux-foundation.org>, <vishal.moola@gmail.com>,
        <arnd@arndb.de>, <wangkefeng.wang@huawei.com>,
        <willy@infradead.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Zhizhou Zhang <zhizhouzhang@asrmicro.com>
Subject: Re: [PATCH] ARM: mm: fix stack corruption when CONFIG_ARM_PV_FIXUP=y
Message-ID: <20230911130431.k35xp7gszgwqigl4@vendetta>
References: <20230907143302.4940-1-zhizhou.zh@gmail.com>
 <CACRpkdY=EYQfRrUaw5JL5e0x2p=KurYfwvfunJ+GF1PmupKNqg@mail.gmail.com>
 <ZPsmiV9I4qbqpAsO@shell.armlinux.org.uk>
 <CACRpkdYdf9H=LNRZMPurzTcA+bqoOHC1n-8TeCnVdz_iF7H+NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYdf9H=LNRZMPurzTcA+bqoOHC1n-8TeCnVdz_iF7H+NA@mail.gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23:00-20230908, Linus Walleij wrote:
> On Fri, Sep 8, 2023 at 3:50 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> 
> > However, it makes a total nonsense of the comment, which explains
> > precisely why the flush_cache_all() is where it is. Moving it before
> > that comment means that the comment is now rediculous.
> 
> Zhizhou, can you look over the comment placement?
> 
> > So, please don't put it in the patch system.
> >
> > The patch certainly needs to be tested on TI Keystone which is the
> > primary user of this code.
> 
> Added Andrew Davis and Nishanth Menon to the thread:
> can you folks review and test this for Keystone?

next-20230911 alone: (boots fine):
https://gist.github.com/nmenon/c097b4a7ce3971964a5a56a34b018c4d


With
https://lore.kernel.org/all/20230907143302.4940-1-zhizhou.zh@gmail.com/
applied on top (fails to boot):
https://gist.github.com/nmenon/308cfeb84098f41d340cd0e61845a507


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
