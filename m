Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68147FB094
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbjK1D0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbjK1D0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:26:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B661A7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701141964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dymokLtc+Ixha61+4f7cZK1W1d0w612OLAA0dg5oPzE=;
        b=CyN9BibCviQ7ZSskR12WrFIBs/H4w/U+5KGHK3GpZpN20iRVoGtKr3k2X86h03IBm9IGc0
        lBS7fEBIjCwmCmx+jiJCvzMJViQNSs/r4UXsT0CHOfVE2YPYCO3eCtIZVi7a+oMakskN6K
        EshQ5az7J+R4wkP5xOn9gkBuFOUxmiw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-WLJMPzMwPQKD8zSJIA65RQ-1; Mon, 27 Nov 2023 22:26:00 -0500
X-MC-Unique: WLJMPzMwPQKD8zSJIA65RQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5490485A5BD;
        Tue, 28 Nov 2023 03:26:00 +0000 (UTC)
Received: from localhost (unknown [10.72.112.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 64EDD1121307;
        Tue, 28 Nov 2023 03:25:59 +0000 (UTC)
Date:   Tue, 28 Nov 2023 11:25:56 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Shijie Huang <shijie@amperemail.onmicrosoft.com>
Cc:     Huang Shijie <shijie@os.amperecomputing.com>, k-hagio-ab@nec.com,
        lijiang@redhat.com, akpm@linux-foundation.org, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com
Subject: Re: [PATCH] crash_core: export vmemmap when CONFIG_SPARSEMEM_VMEMMAP
 is enabled
Message-ID: <ZWVdxAv/PPHY3Ndl@MiWiFi-R3L-srv>
References: <20231127020727.25296-1-shijie@os.amperecomputing.com>
 <ZWQEP4SczFh+GUHq@MiWiFi-R3L-srv>
 <33021b87-4c6a-45fc-a6ae-265765cfcd78@amperemail.onmicrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33021b87-4c6a-45fc-a6ae-265765cfcd78@amperemail.onmicrosoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 at 11:18am, Shijie Huang wrote:
> 
> 在 2023/11/27 10:51, Baoquan He 写道:
> > Hi,
> > 
> > On 11/27/23 at 10:07am, Huang Shijie wrote:
> > > In memory_model.h, if CONFIG_SPARSEMEM_VMEMMAP is configed,
> > > kernel will use vmemmap to do the __pfn_to_page/page_to_pfn,
> > > and kernel will not use the "classic sparse" to do the
> > > __pfn_to_page/page_to_pfn.
> > > 
> > > So export the vmemmap when CONFIG_SPARSEMEM_VMEMMAP is configed.
> > > This makes the user applications (crash, etc) get faster
> > > pfn_to_page/page_to_pfn operations too.
> > Are there Crash or makedupfile patches posted yet to make use of this?
> 
> I have patches for Crash to use the 'vmemmap', but after this patch is
> merged, I will send it out.
> 
> (I think Kazu will not merge a crash patch which depends on a kernel patch
> which is not merged.)

Maybe post these userspace patches too so that Kazu can evaluat if those
improvement is necessary?

