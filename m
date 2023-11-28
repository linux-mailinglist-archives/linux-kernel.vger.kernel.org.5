Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7AE7FB2CE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343742AbjK1Hef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbjK1Hed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:34:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926A11AE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701156878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OguxvPhmIBoZQOm1YAs1KZATE7vclINtSzPsNknfn1Q=;
        b=IS+LwxIOe1Hp5BzDJaC2tP7ZS47nahCxmQzYflhsNQ1VKGrI2sYryvdbdGFb90xIou8LTY
        8Yjt1CCSDc4JklhbAmzKMulITWexVDCFtwbue8Z8EZj3cDORXr2Q+a82C8Q4kJtBDw8kZD
        xtoI4wI0VZxkJ80VZToTFNqhjDgGm9o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-tZ0bR6CoP1e88YaGQA1QVg-1; Tue, 28 Nov 2023 02:34:37 -0500
X-MC-Unique: tZ0bR6CoP1e88YaGQA1QVg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97B9281B164;
        Tue, 28 Nov 2023 07:34:36 +0000 (UTC)
Received: from localhost (unknown [10.72.112.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D652B492BFA;
        Tue, 28 Nov 2023 07:34:35 +0000 (UTC)
Date:   Tue, 28 Nov 2023 15:34:32 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Shijie Huang <shijie@amperemail.onmicrosoft.com>,
        k-hagio-ab@nec.com
Cc:     Huang Shijie <shijie@os.amperecomputing.com>, lijiang@redhat.com,
        akpm@linux-foundation.org, vgoyal@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com
Subject: Re: [PATCH] crash_core: export vmemmap when CONFIG_SPARSEMEM_VMEMMAP
 is enabled
Message-ID: <ZWWYCLb73RYXGcpG@MiWiFi-R3L-srv>
References: <20231127020727.25296-1-shijie@os.amperecomputing.com>
 <ZWQEP4SczFh+GUHq@MiWiFi-R3L-srv>
 <33021b87-4c6a-45fc-a6ae-265765cfcd78@amperemail.onmicrosoft.com>
 <ZWVdxAv/PPHY3Ndl@MiWiFi-R3L-srv>
 <a7d85fee-23cd-4b85-adc6-16980b6e5e02@amperemail.onmicrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7d85fee-23cd-4b85-adc6-16980b6e5e02@amperemail.onmicrosoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/23 at 11:31am, Shijie Huang wrote:
> 
> 在 2023/11/28 11:25, Baoquan He 写道:
> > On 11/27/23 at 11:18am, Shijie Huang wrote:
> > > 在 2023/11/27 10:51, Baoquan He 写道:
> > > > Hi,
> > > > 
> > > > On 11/27/23 at 10:07am, Huang Shijie wrote:
> > > > > In memory_model.h, if CONFIG_SPARSEMEM_VMEMMAP is configed,
> > > > > kernel will use vmemmap to do the __pfn_to_page/page_to_pfn,
> > > > > and kernel will not use the "classic sparse" to do the
> > > > > __pfn_to_page/page_to_pfn.
> > > > > 
> > > > > So export the vmemmap when CONFIG_SPARSEMEM_VMEMMAP is configed.
> > > > > This makes the user applications (crash, etc) get faster
> > > > > pfn_to_page/page_to_pfn operations too.
> > > > Are there Crash or makedupfile patches posted yet to make use of this?
> > > I have patches for Crash to use the 'vmemmap', but after this patch is
> > > merged, I will send it out.
> > > 
> > > (I think Kazu will not merge a crash patch which depends on a kernel patch
> > > which is not merged.)
> > Maybe post these userspace patches too so that Kazu can evaluat if those
> > improvement is necessary?
> 
> No problem.  I will send out them later.

Thank, Shijie. Let's wait and see if Kazu has any comment about these.

