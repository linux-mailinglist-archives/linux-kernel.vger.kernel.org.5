Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA2C7BCCC8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 08:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344466AbjJHGmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 02:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344456AbjJHGmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 02:42:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C059D
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 23:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696747292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uYCw3ejgsMHs1TF/dQzWUZ9FJHhLcnSApWifqzzSdvQ=;
        b=SEoDgATkzfHK7fWrMmd4DwGcF6LW9R5ZiBE2lkkUDHxZFZZBnyrZ/xhF6/Zh3RimEc/lDP
        qzq4gWdAc3XvP9VgigZ4o+9jrNqr8Tqe5qgKVI3vqzRcKgpyME9dsZtJ920XTtbVrFtddG
        OF4KeblVO3B4qXcu3zFUEV2U6WiU0Ck=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-IinL3fJVMGWVZ_JY2QhM0w-1; Sun, 08 Oct 2023 02:41:30 -0400
X-MC-Unique: IinL3fJVMGWVZ_JY2QhM0w-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99bca0b9234so278016766b.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 23:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747289; x=1697352089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYCw3ejgsMHs1TF/dQzWUZ9FJHhLcnSApWifqzzSdvQ=;
        b=SGpqIqpyHwg3Gtqlk9f26lOyuGlp0Tjl8ZRZEF8yDy6N2GE6Bkemb7nzOoD0LkS3Cr
         tz2t0SbicxhwO0ALxGsGvUZUm3/jyIMD0EIzkGHT3zr5WtYS/tq80AVpc/N4bbOC1RiX
         z2zpTkrvD0qq7DMbqAM1YE6vuWn8j81acy/mO+9RuRxj0u2LEJH0HzbLj3mLb6AoK5nf
         iDX9/E+pT0bUFPOou0hXc0qoqvN+bUIkA4doCYmpiDlwlUO98bPSy/jnRG5MppTB5KRB
         Bz/Ja0Dpcf6cGgKf9G/A/lUAwJjA7mX9BYTjCnt2B55u6XyN0ExQMuAPwtXR0vKbN7I2
         wORg==
X-Gm-Message-State: AOJu0YzdevaZ9lcjvXPQpWzZWibfte4IInv2WCU0iggYiDM7AdmbwZ/Z
        dMiLxpvx9bpjuJUTlgCaoE/Ej4C25YCpdnO/fpDSpFQpbropDuPrFNs/Ef0SUltUuw8QeAAIRnq
        xVfzax7pZnwiICBf2g2NLqUBp
X-Received: by 2002:a17:906:2921:b0:9ba:97a:cea4 with SMTP id v1-20020a170906292100b009ba097acea4mr3136249ejd.65.1696747289224;
        Sat, 07 Oct 2023 23:41:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2TdQduQE0kVS/TzLbsch5g4rzkhFzD9IQ81NTdePePszD420kbTRAxTKKs+7cQpoyp4SfIA==
X-Received: by 2002:a17:906:2921:b0:9ba:97a:cea4 with SMTP id v1-20020a170906292100b009ba097acea4mr3136236ejd.65.1696747288786;
        Sat, 07 Oct 2023 23:41:28 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:d74e:e6b1:da81:860a:5e9e])
        by smtp.gmail.com with ESMTPSA id j18-20020a170906411200b0099ccee57ac2sm5208096ejk.194.2023.10.07.23.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:41:28 -0700 (PDT)
Date:   Sun, 8 Oct 2023 02:41:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH] vduse: make vduse_class constant
Message-ID: <20231008024039-mutt-send-email-mst@kernel.org>
References: <2023100643-tricolor-citizen-6c2d@gregkh>
 <20231008022022-mutt-send-email-mst@kernel.org>
 <2023100823-absurd-imitation-092d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023100823-absurd-imitation-092d@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 08:40:05AM +0200, Greg Kroah-Hartman wrote:
> On Sun, Oct 08, 2023 at 02:20:52AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Oct 06, 2023 at 04:30:44PM +0200, Greg Kroah-Hartman wrote:
> > > Now that the driver core allows for struct class to be in read-only
> > > memory, we should make all 'class' structures declared at build time
> > > placing them into read-only memory, instead of having to be dynamically
> > > allocated at runtime.
> > > 
> > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > Cc: Jason Wang <jasowang@redhat.com>
> > > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Cc: Xie Yongji <xieyongji@bytedance.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > Greg should I merge it or do you intend to merge all these patches?
> 
> "all"?  There's loads of them for all sorts of subsystems, so feel free
> to take it through your subsystem tree if you want.  I usually scoop up
> the ones that no one picks after a release and take them through my
> tree, to pick up the stragglers.
> 
> So it's your call, whatever is easier for you is fine for me.
> 
> thanks,
> 
> greg k-h

To clarify which commit does this depend on?

-- 
MST

