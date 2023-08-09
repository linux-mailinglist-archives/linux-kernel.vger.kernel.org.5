Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57EC7762F9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbjHIOso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbjHIOsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:48:42 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09A52704
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:48:30 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-63cffc0f95eso34946016d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 07:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691592505; x=1692197305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m4bISbA3t+yh3hAsX3GX16FfloCmjYYwoOgy/YO987g=;
        b=hQyQFawRvch/vrwsE1c4VcH8/I/37cjfRv53xh3z+C3J10ieZX2v/VwO3tZpFABOaM
         v5TOpGidPc7LPAr+vIBVlHx3ii9jMKu97ZCWLbrc4khP5xymRspT9XsE2mP2YndlQnbv
         QGyEAVLApPpT3nFaHk178DUyBaZOudxpbciJOH4XvfE7IwBBp6QCRDzweEX1Ttc1/rus
         Dd9oVW25SC9k5IWoRxW5mQ86wpxFV2ik0O7LwEf3ZhuQL5EIDRZ6HRvE/22u0CHwFf4y
         KB7MRNS7+IOayj1ck8GYw4o6sFaQS+W2oRAAcbzDTU2bbLxP8f7xBSpwnHagMv9hj2al
         UIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691592505; x=1692197305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4bISbA3t+yh3hAsX3GX16FfloCmjYYwoOgy/YO987g=;
        b=TyH7Rm3b5IbCFh+pH0Eon269aYlY157OkuaJdJCp+fZHTd7s6MQuIARZSLp/SFId6F
         +2ei13+M5nhnlLs0Xxs//sqb2pIp3iEN+gr5Px1JaT9i6UglknyFY9PIwT2sDhjw2FBp
         lmh3W1JLtny2AEZRes/O0OyU9wQWojoy5/aHjCwsVpIrLyztlUyQJVV1yPFwdp7chvsH
         SOpWE/uVkkIrjTGmfZ/Ji1ZMjXkI/jcpmxj7u7fE+vB8cafplDcXhxcGXWSDzDZ26+lG
         eMWzRx325DZIlO/vsscoBPncijqcfea12YSMMIy8DSLaSDcp/miteMBfs6YZFepiBdhw
         ahkw==
X-Gm-Message-State: AOJu0YxeLTA/23IuUDyU0sKGn4MqIDu1XtnJP8S17TmnAL9oxju9Dzh2
        s+ynCtUsDwBIEVks4wAFDVg07g==
X-Google-Smtp-Source: AGHT+IFgpbmLdpjQ1gAKEz+zkG6hBf1mGwlCmh/weIzumrbnKNHa8HANKleEhFnF76ZwV/rj6sLhbQ==
X-Received: by 2002:ad4:4047:0:b0:63f:78bc:85de with SMTP id r7-20020ad44047000000b0063f78bc85demr2462304qvp.56.1691592505716;
        Wed, 09 Aug 2023 07:48:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id pc41-20020a05620a842900b0076cc0a6e127sm4019495qkn.116.2023.08.09.07.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 07:48:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qTkU4-0053aa-MQ;
        Wed, 09 Aug 2023 11:48:24 -0300
Date:   Wed, 9 Aug 2023 11:48:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Zhang, Tina" <tina.zhang@intel.com>,
        Michael Shavit <mshavit@google.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] iommu: Call helper function to get assigned pasid
 value
Message-ID: <ZNOnOGTfpXzrrRTz@ziepe.ca>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-3-tina.zhang@intel.com>
 <f3d8692e-b13d-97ee-2288-c2be1858dcfa@linux.intel.com>
 <BN9PR11MB52767F29A6C11157659D375B8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c0e94e88-94b8-69de-69c8-ed132ae28951@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0e94e88-94b8-69de-69c8-ed132ae28951@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 06:58:15PM +0800, Baolu Lu wrote:
> On 2023/8/9 17:49, Tian, Kevin wrote:
> > > From: Baolu Lu <baolu.lu@linux.intel.com>
> > > Sent: Wednesday, August 9, 2023 8:22 AM
> > > 
> > > On 2023/8/8 15:49, Tina Zhang wrote:
> > > > Use the helper function mm_get_pasid() to get the mm assigned pasid
> > > > value.
> > > 
> > > For internal iommu drivers, perhaps we should use another helper.
> > > Something like sva_domain_get_pasid()?
> > > 
> > > Suppose that the iommu drivers should have no idea about the "mm".
> > > 
> > 
> > Aren't all touched functions accept a struct mm_struct pointer?
> 
> In the end we should remove all mm reference in the individual drivers.
> The drivers only need to know what they need to know. All mm-aware code
> should eventually be moved to the core.
> 
> For now, at least we should avoid using mm in the set/remove_dev_pasid
> code path. Later, once we complete consolidating mm notification in the
> core, drivers will have no need to use "mm" anymore.

I'm not sure how this will play out...

We don't want extra function indirections here so ultimately the
driver needs to hook the arch_invalidate_range() in the mm_notifier
with its own function.

The core could put the mm_notifier in a common iommu_domain_sva struct
and it could stick in the driver's invalidate ops, that would be a
nice simplification (and discourage drivers from doing the crazy
things they are currently doing)

Jason
