Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB436804F97
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbjLEJ6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbjLEJ6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:58:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7950D65
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701770257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2OrUBFUhakwtF1xCLN9g9kW7+oSzP8RjoKeN3OJBDHI=;
        b=dXBC5XgmSdkrsIOiLjwy194kP/x3j3lYBK0nabWHven2ZDOn1yQSYpXgnfb28hz4l1sBvt
        VXt8qUJA5QP5jMaPckNmKlangNQn9tiLhUUKKH3Q5Mq9nlFZasDP972hTKmYcsRy1mNZiR
        tic99nFtDsgxfx5ExEhgz/gQRgr+oO4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156--lYEoxYZOU-pjewfoKPq9Q-1; Tue, 05 Dec 2023 04:57:35 -0500
X-MC-Unique: -lYEoxYZOU-pjewfoKPq9Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b4096abc8so41722705e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 01:57:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701770254; x=1702375054;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2OrUBFUhakwtF1xCLN9g9kW7+oSzP8RjoKeN3OJBDHI=;
        b=hvBqHqwlJVMk+CDLwcwXxeY8CrzA4I4q/9ukzUPzPVq9nv9IpyHojaBQgC7SsYnZjL
         2gkFnX+BerFzL0Mzf8PQugPVCm4TjKJAsHQy9BYy6TQI0sNVbuW5VWTEQTSoNeYgATcZ
         zqf6goEY8eZt3APKKv2A09r5K2WfWUNMrorBiY1ZJbXjCGUe+FTBco2t3AB8U6gmvKLv
         joxAt+lXS0B75D2fqblTJ7j8ledTwGXsKffrDuxC4yBhaUDgNnneZaYPmohH5bZGoYKL
         SH2MV0pMH/twhcGHt8PDanhfjrQAv0W+/9BSLXu3FaMCfBCMgdCmCl4a4io+kFK+2D2/
         Dgzg==
X-Gm-Message-State: AOJu0Yw6XPCrO/O8ZJMl+c33BLQ7OUxMCBFeS8l6sDYfqR1YV3ndmNbr
        icgGrcmpjZWJi4fzwQJs0QZj7l+WeuM+O2+JyiRnnAJdDix3sz8MmmX4bGu9uUNNMXIE2pHVeFL
        uiI9zfghnM+6lCfIHdSvIO2YN
X-Received: by 2002:a05:600c:8a4:b0:40b:5e59:99d8 with SMTP id l36-20020a05600c08a400b0040b5e5999d8mr197462wmp.248.1701770254592;
        Tue, 05 Dec 2023 01:57:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcGMbovZBUpY1Dnbx1AH2plPXeeYz64KJ2yt/AetdTyeHkanIxz5g43gecoJYqsrGfehOzag==
X-Received: by 2002:a05:600c:8a4:b0:40b:5e59:99d8 with SMTP id l36-20020a05600c08a400b0040b5e5999d8mr197456wmp.248.1701770254282;
        Tue, 05 Dec 2023 01:57:34 -0800 (PST)
Received: from starship ([89.237.98.20])
        by smtp.gmail.com with ESMTPSA id d17-20020adff851000000b0033335c011e0sm9599559wrq.63.2023.12.05.01.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:57:33 -0800 (PST)
Message-ID: <7ca548b082608862ed1c5896294b393648e40def.camel@redhat.com>
Subject: Re: [PATCH v7 06/26] x86/fpu/xstate: Create guest fpstate with
 guest specific config
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     "Yang, Weijiang" <weijiang.yang@intel.com>
Cc:     dave.hansen@intel.com, pbonzini@redhat.com, seanjc@google.com,
        peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 05 Dec 2023 11:57:31 +0200
In-Reply-To: <0112b446-ee7e-4b78-b3a4-671d3ba67299@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-7-weijiang.yang@intel.com>
         <e1469c732e179dfd7870d0f4ba69f791af0b5d57.camel@redhat.com>
         <0112b446-ee7e-4b78-b3a4-671d3ba67299@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-12-01 at 16:36 +0800, Yang, Weijiang wrote:
> On 12/1/2023 1:36 AM, Maxim Levitsky wrote:
> 
> [...]
> 
> > > +	fpstate->user_size	= fpu_user_cfg.default_size;
> > > +	fpstate->user_xfeatures	= fpu_user_cfg.default_features;
> > The whole thing makes my head spin like the good old CD/DVD writers used to ....
> > 
> > So just to summarize this is what we have:
> > 
> > 
> > KERNEL FPU CONFIG
> > 
> > /*
> >     all known and CPU supported user and supervisor features except
> >     - "dynamic" kernel features" (CET_S)
> >     - "independent" kernel features (XFEATURE_LBR)
> > */
> > fpu_kernel_cfg.max_features;
> > 
> > /*
> >     all known and CPU supported user and supervisor features except
> >      - "dynamic" kernel features" (CET_S)
> >      - "independent" kernel features (arch LBRs)
> >      - "dynamic" userspace features (AMX state)
> > */
> > fpu_kernel_cfg.default_features;
> > 
> > 
> > // size of compacted buffer with 'fpu_kernel_cfg.max_features'
> > fpu_kernel_cfg.max_size;
> > 
> > 
> > // size of compacted buffer with 'fpu_kernel_cfg.default_features'
> > fpu_kernel_cfg.default_size;
> > 
> > 
> > USER FPU CONFIG
> > 
> > /*
> >     all known and CPU supported user features
> > */
> > fpu_user_cfg.max_features;
> > 
> > /*
> >     all known and CPU supported user features except
> >     - "dynamic" userspace features (AMX state)
> > */
> > fpu_user_cfg.default_features;
> > 
> > // size of non compacted buffer with 'fpu_user_cfg.max_features'
> > fpu_user_cfg.max_size;
> > 
> > // size of non compacted buffer with 'fpu_user_cfg.default_features'
> > fpu_user_cfg.default_size;
> > 
> > 
> > GUEST FPU CONFIG
> > /*
> >     all known and CPU supported user and supervisor features except
> >     - "independent" kernel features (XFEATURE_LBR)
> > */
> > fpu_guest_cfg.max_features;
> > 
> > /*
> >     all known and CPU supported user and supervisor features except
> >      - "independent" kernel features (arch LBRs)
> >      - "dynamic" userspace features (AMX state)
> > */
> > fpu_guest_cfg.default_features;
> > 
> > // size of compacted buffer with 'fpu_guest_cfg.max_features'
> > fpu_guest_cfg.max_size;
> > 
> > // size of compacted buffer with 'fpu_guest_cfg.default_features'
> > fpu_guest_cfg.default_size;
> 
> Good suggestion! Thanks!
> how about adding them in patch 5 to make the summaries manifested?

I don't know if we want to add these comments to the source - I made them
up for myself/you to understand the subtle differences between each of these variables.

There is some documentation on the struct fields, it is reasonable, but
I do think that it will help a lot to add documentation to each of
fpu_kernel_cfg, fpu_user_cfg and fpu_guest_cfg.


> 
> > ---
> > 
> > 
> > So in essence, guest FPU config is guest kernel fpu config and that is why
> > 'fpu_user_cfg.default_size' had to be used above.
> > 
> > How about that we have fpu_guest_kernel_config and fpu_guest_user_config instead
> > to make the whole horrible thing maybe even more complicated but at least a bit more orthogonal?
> 
> I think it becomes necessary when there were more guest user/kernel xfeaures requiring
> special handling like CET-S MSRs, then it looks much reasonable to split guest config into two,
> but now we only have one single outstanding xfeature for guest. IMHO, existing definitions still
> work with a few comments.

It's all up to you to decide. The thing is one big mess, IMHO no comment can really make it understandable
without hours of research.

However as usual, the more comments the better, comments do help.

Best regards,
	Maxim Levitsky


> 
> But I really like your ideas of making things clean and tidy :-)
> 
> 




