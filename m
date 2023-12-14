Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE782812CE4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443631AbjLNK3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443599AbjLNK3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:29:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C637AF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702549748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WEGnuAcA6vcyz/hnSV1HfLQ52Yc/OzlpLIbZnnIF9xo=;
        b=LYtNkeeviHlxPafvma9BTHbdjfRDFw9xGdqvok9ku27K176f0uUN3hN4ZqdKYNV9L+KdGF
        MY9dcWnCCiFGSJlDBcuwcae0ue0HN5sod8ATEVuNsz7LyR5Y4P4Th1TvUaCw7x+5TO13kG
        WJbqVCNeJlflnUCuKuDCroMHwyuTmOA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-saQwzr8LNLeC1X0oZg-3ow-1; Thu, 14 Dec 2023 05:29:05 -0500
X-MC-Unique: saQwzr8LNLeC1X0oZg-3ow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10B6885A58A;
        Thu, 14 Dec 2023 10:29:05 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AC703C25;
        Thu, 14 Dec 2023 10:29:03 +0000 (UTC)
Date:   Thu, 14 Dec 2023 18:29:01 +0800
From:   Baoquan He <bhe@redhat.com>
To:     fuqiang wang <fuqiang.wang@easystack.cn>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: avoid out of bounds in crash_exclude_mem_range()
Message-ID: <ZXrY7QbXAlxydsSC@MiWiFi-R3L-srv>
References: <20231127025641.62210-1-fuqiang.wang@easystack.cn>
 <ZWg9aZYoo0v+tCQ8@MiWiFi-R3L-srv>
 <e588c619-9b97-4627-bce1-b595c757e5c4@easystack.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e588c619-9b97-4627-bce1-b595c757e5c4@easystack.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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

Let me borrow your example and copy them here, but I will switch the
order of start/end params 100/200, 300/400 executing at below:

There is a cmem before execute crash_exclude_mem_range():

  cmem = {
    max_nr_ranges = 3
    nr_ranges = 2
    ranges = {
       {start = 1,      end = 1000}
       {start = 1001,    end = 2000}
    }
  }

After executing twice crash_exclude_mem_range() with the start/end params
300/400, the cmem will be:

  cmem = {
    max_nr_ranges = 3
    nr_ranges = 3                    <== nr_ranges == max_nr_ranges
    ranges = {
      {start = 1,       end = 299  }  i=0
      {start = 401,     end = 1000}   i=1
      {start = 1001,    end = 2000}   i=2
    }
  }
When it's executing the 100/200 excluding, we have:

  cmem = {
    max_nr_ranges = 3
    nr_ranges = 4                    <== nr_ranges > max_nr_ranges
    ranges = {
      {start = 1,       end = 99  }   i=0
      {start = 401,     end = 1000}
      {start = 1001,    end = 2000}  
    }
  }

Then splitting happened, i == 0, then for loop is broken and jump out.
Then we have the condition checking here:

	/* Split happened */
        if (i == mem->max_nr_ranges - 1)
                return -ENOMEM;

Obviously the conditonal checking is incorrect (given the i == 0 in
above case), it should be 

	/* Split happened */
	if (mem->nr_ranges == mem->max_nr_ranges)
                return -ENOMEM;

So, now there are two things which need be combed up in
crash_exclude_mem_range():

1) the above conditional check is incorrect, need be fixed;
2) whether we need have the cmem->ranges[] partly changed, or keep it
unchanged when OOB happened;

And also the incorrect handling in crash_setup_memmap_entries():
1) the insufficient array slot in crash_setup_memmap_entries();
2) the uninitialized cmem->max_nr_ranges;


> 
> When an out of bounds occurs during the second execution, the function will not
> return error.
> 
> Additionally, when the function returns error, means the load failed. It seems
> meaningless to keep the original data unchanged. But in my opinion, this will
> make this function more rigorous and more versatile. (However, I am not sure if
> it is self-defeating and I hope to receive more suggestions).
> 
> Thanks
> fuqiang
> 
> 
> > > Signed-off-by: fuqiang wang <fuqiang.wang@easystack.cn>
> > > ---
> > >   kernel/crash_core.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > > index efe87d501c8c..ffdc246cf425 100644
> > > --- a/kernel/crash_core.c
> > > +++ b/kernel/crash_core.c
> > > @@ -611,6 +611,9 @@ int crash_exclude_mem_range(struct crash_mem *mem,
> > >   		}
> > >   		if (p_start > start && p_end < end) {
> > > +			/* Split happened */
> > > +			if (mem->nr_ranges == mem->max_nr_ranges)
> > > +				return -ENOMEM;
> > >   			/* Split original range */
> > >   			mem->ranges[i].end = p_start - 1;
> > >   			temp_range.start = p_end + 1;
> > > @@ -626,9 +629,6 @@ int crash_exclude_mem_range(struct crash_mem *mem,
> > >   	if (!temp_range.end)
> > >   		return 0;
> > > -	/* Split happened */
> > > -	if (i == mem->max_nr_ranges - 1)
> > > -		return -ENOMEM;
> > >   	/* Location where new range should go */
> > >   	j = i + 1;
> > > -- 
> > > 2.42.0
> > > 
> > > 
> > > _______________________________________________
> > > kexec mailing list
> > > kexec@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kexec
> > > 
> 

