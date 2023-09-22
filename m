Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5BE7AAA41
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjIVHaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjIVHaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:30:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794E8F7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695367763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zkC0S9b0mdQkA+pj6scpIKU6y5C3DzihgVu5sFYoeZI=;
        b=GV4qLziZPKwlRVVdWSCYwPctzSKYp4BIbjkBD0g3BNQWXQO5i8meN8LE1h0rGKcunsxbiw
        CPqgo9dVWxFV8fF32UmnA68SatJDuLtmofcUFJuy7y2Vj0SP8Moj5vzSOlNByc2+EC5uyY
        O/JVhWVWFb43K9BcD9xO//tg2xrQDoE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-ICVV_mQKOaG-pfcCcUitWA-1; Fri, 22 Sep 2023 03:29:22 -0400
X-MC-Unique: ICVV_mQKOaG-pfcCcUitWA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98D2F3C0F376;
        Fri, 22 Sep 2023 07:29:21 +0000 (UTC)
Received: from localhost (unknown [10.72.112.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E171049BB9A;
        Fri, 22 Sep 2023 07:29:19 +0000 (UTC)
Date:   Fri, 22 Sep 2023 15:29:14 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Jay Patel <jaypatel@linux.ibm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm/slub: refactor calculate_order() and
 calc_slab_order()
Message-ID: <ZQ1CSgj5+Dy/rWEN@MiWiFi-R3L-srv>
References: <20230908145302.30320-6-vbabka@suse.cz>
 <20230908145302.30320-10-vbabka@suse.cz>
 <ZQUE0e4i8HrGUthB@MiWiFi-R3L-srv>
 <4662588e-fc8b-1854-57f8-d15e08a3c368@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4662588e-fc8b-1854-57f8-d15e08a3c368@suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/23 at 09:00am, Vlastimil Babka wrote:
> On 9/16/23 03:28, Baoquan He wrote:
> > On 09/08/23 at 04:53pm, Vlastimil Babka wrote:
> >> @@ -4152,7 +4147,7 @@ static inline int calculate_order(unsigned int size)
> >>  		 * order on systems that appear larger than they are, and too
> >>  		 * low order on systems that appear smaller than they are.
> >>  		 */
> >> -		nr_cpus = num_present_cpus();
> >> +		unsigned int nr_cpus = num_present_cpus();
> >>  		if (nr_cpus <= 1)
> >>  			nr_cpus = nr_cpu_ids;
> >>  		min_objects = 4 * (fls(nr_cpus) + 1);
> > 
> > A minor concern, should we change 'min_objects' to be a local static
> > to avoid the "if (!min_objects) {" code block every time?  It's deducing
> > the value from nr_cpus, we may not need do the calculation each time.
> 
> Maybe, although it's not a hot path. But we should make sure the
> num_present_cpus() cannot change. Could it be e.g. low (1) very early when
> we bootstrap the initial caches, but then update and at least most of the
> caches then reflect the real number of cpus? With a static we would create
> everything with 1.

Yeah, I was silly, didn't think about it. We may check via system_state,
but it's not worth to bother since it's not hot path as you said. Sorry for
the noise.

