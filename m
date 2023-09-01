Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4502F78FB99
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 12:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345415AbjIAKJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 06:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238801AbjIAKJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 06:09:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7E41BF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 03:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693562943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i8CdRaFuyX7B1sgP28cqTdKjALW2usXqlIRObbQvCxc=;
        b=UCGikrnOJY5ezuMXY74FDTPoS9+KzIWrrcOwKoEYUCKe9tSeFMGLJYnH0loZSgOnof/7KE
        lrivAO42mKYmeN9QF4h2H/I1oFDXhtW3jJGq13tOUHrXAVi4XRPBkV480FwojmDpH12aBa
        Tk4ZheM0ZNKYn+Z4xBVo2IM/yxp9TUw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-Xs10w53IOouXn1DUb9QA0g-1; Fri, 01 Sep 2023 06:09:00 -0400
X-MC-Unique: Xs10w53IOouXn1DUb9QA0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA83F185A78F;
        Fri,  1 Sep 2023 10:08:59 +0000 (UTC)
Received: from localhost (unknown [10.72.113.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08A0621EE560;
        Fri,  1 Sep 2023 10:08:58 +0000 (UTC)
Date:   Fri, 1 Sep 2023 18:08:55 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, thunder.leizhen@huawei.com,
        dyoung@redhat.com, prudo@redhat.com, samuel.holland@sifive.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v2 4/8] crash_core: add generic function to do reservation
Message-ID: <ZPG4Nzd/4JdU1Ft4@MiWiFi-R3L-srv>
References: <20230829121610.138107-1-bhe@redhat.com>
 <20230829121610.138107-5-bhe@redhat.com>
 <df395f20-55e9-169b-846b-f55d21d00861@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df395f20-55e9-169b-846b-f55d21d00861@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/23 at 11:23am, Leizhen (ThunderTown) wrote:
......
> > +void __init reserve_crashkernel_generic(char *cmdline,
> > +			     unsigned long long crash_size,
> > +			     unsigned long long crash_base,
> > +			     unsigned long long crash_low_size,
> > +			     bool high)
> > +{
> > +	unsigned long long search_end = CRASH_ADDR_LOW_MAX, search_base = 0;
> > +	bool fixed_base = false;
> > +
> > +	/* User specifies base address explicitly. */
> > +	if (crash_base) {
> > +		fixed_base = true;
> > +		search_base = crash_base;
> > +		search_end = crash_base + crash_size;
> > +	}
> > +
> > +	if (high) {
> 
> It might be a little clearer to use "else if (high) {"

Makes sense, will update.

> 
> > +		search_base = CRASH_ADDR_LOW_MAX;
> > +		search_end = CRASH_ADDR_HIGH_MAX;
> > +	}
> > +
> > +retry:
> > +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> > +					       search_base, search_end);
......

