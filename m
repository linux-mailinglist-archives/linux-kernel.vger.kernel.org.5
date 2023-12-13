Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B46810937
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 05:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378499AbjLMEoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 23:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378466AbjLMEoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 23:44:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B748EBE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 20:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702442668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G/cTbycJ6+L1OUYZmWcVqrZarTlp5To90eqHIi055Fw=;
        b=SQWa+zSmEN5NQSzSAfoJtJvggwHQzzdnE3cMhM7v3K4Sm/tysv1Zkp8G2yBpJ4HxSUW1mc
        Z8FfvozCtaUkPQ20rcyzLPkWVYGElR5QDvWNDUQ6tZpC5RwNomni+9owf1AVmVrFqVl8Ft
        8E6nrtsSyQnd3EXHsyfqV5tDjmfR018=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-EdM98yRTMVyc2x2QONcNOw-1; Tue, 12 Dec 2023 23:44:25 -0500
X-MC-Unique: EdM98yRTMVyc2x2QONcNOw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3040983106D;
        Wed, 13 Dec 2023 04:44:25 +0000 (UTC)
Received: from localhost (unknown [10.72.116.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B40251E3;
        Wed, 13 Dec 2023 04:44:24 +0000 (UTC)
Date:   Wed, 13 Dec 2023 12:44:16 +0800
From:   Baoquan He <bhe@redhat.com>
To:     fuqiang wang <fuqiang.wang@easystack.cn>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: avoid out of bounds in crash_exclude_mem_range()
Message-ID: <ZXk2oBf/T1Ul6o0c@MiWiFi-R3L-srv>
References: <20231127025641.62210-1-fuqiang.wang@easystack.cn>
 <ZWg9aZYoo0v+tCQ8@MiWiFi-R3L-srv>
 <e588c619-9b97-4627-bce1-b595c757e5c4@easystack.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e588c619-9b97-4627-bce1-b595c757e5c4@easystack.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/23 at 09:20pm, fuqiang wang wrote:
> 
> On 2023/11/30 15:44, Baoquan He wrote:
> > On 11/27/23 at 10:56am, fuqiang wang wrote:
> > > When the split happened, judge whether mem->nr_ranges is equal to
> > > mem->max_nr_ranges. If it is true, return -ENOMEM.
> > > 
> > > The advantage of doing this is that it can avoid array bounds caused by
> > > some bugs. E.g., Before commit 4831be702b95 ("arm64/kexec: Fix missing
> > > extra range for crashkres_low."), reserve both high and low memories for
> > > the crashkernel may cause out of bounds.
> > > 
> > > On the other hand, move this code before the split to ensure that the
> > > array will not be changed when return error.
> > If out of array boundary is caused, means the laoding failed, whether
> > the out of boundary happened or not. I don't see how this code change
> > makes sense. Do I miss anything?
> > 
> > Thanks
> > Baoquan
> > 
> Hi baoquan,
> 
> In some configurations, out of bounds may not cause crash_exclude_mem_range()
> returns error, then the load will succeed.
> 
> E.g.
> There is a cmem before execute crash_exclude_mem_range():
> 
>   cmem = {
>     max_nr_ranges = 3
>     nr_ranges = 2
>     ranges = {
>        {start = 1,      end = 1000}
>        {start = 1001,    end = 2000}
>     }
>   }
> 
> After executing twice crash_exclude_mem_range() with the start/end params
> 100/200, 300/400 respectively, the cmem will be:
> 
>   cmem = {
>     max_nr_ranges = 3
>     nr_ranges = 4                    <== nr_ranges > max_nr_ranges
>     ranges = {
>       {start = 1,       end = 99  }
>       {start = 201,     end = 299 }
>       {start = 401,     end = 1000}
>       {start = 1001,    end = 2000}  <== OUT OF BOUNDS
>     }
>   }
> 
> When an out of bounds occurs during the second execution, the function will not
> return error.
> 
> Additionally, when the function returns error, means the load failed. It seems
> meaningless to keep the original data unchanged. But in my opinion, this will
> make this function more rigorous and more versatile. (However, I am not sure if
> it is self-defeating and I hope to receive more suggestions).

Sorry for late reply.

I checked the code again, there seems to be cases out of bounds occur
very possiblly. We may need to enlarge the cmem array to avoid the risk.

In below draft code, we need add another slot to exclude the low 1M area
when preparing elfcorehdr. And to exclude the elf header region from
crash kernel region, we need create the cmem with 2 slots.

With these change, we can absolutely avoid out of bounds occurence.
What do you think?

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 1715e5f06a59..21facabcf699 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -147,10 +147,10 @@ static struct crash_mem *fill_up_crash_elf_data(void)
 		return NULL;
 
 	/*
-	 * Exclusion of crash region and/or crashk_low_res may cause
-	 * another range split. So add extra two slots here.
+	 * Exclusion of low 1M, crash region and/or crashk_low_res may
+	 * cause another range split. So add extra two slots here.
 	 */
-	nr_ranges += 2;
+	nr_ranges += 3;
 	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
 	if (!cmem)
 		return NULL;
@@ -282,7 +282,7 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	struct crash_memmap_data cmd;
 	struct crash_mem *cmem;
 
-	cmem = vzalloc(struct_size(cmem, ranges, 1));
+	cmem = vzalloc(struct_size(cmem, ranges, 2));
 	if (!cmem)
 		return -ENOMEM;
 

