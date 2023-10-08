Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF9F7BCCF1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 09:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344463AbjJHHIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 03:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbjJHHIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 03:08:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CE7B6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 00:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696748868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R2fivEi497/0xD/eVssN8LHPs3sN6zS8/o+fjkoWBRM=;
        b=Cj+m2gstpuJs4MI/Xhf1S8YAeYw3H/YVWV0hlnby0WKMhqlrmbWg0E4rZXijREuMAbR4u/
        HZK9F/OSbfRlzNIqNAOYNUS3As8OeqB0far5+WPdGHLXTY2YS5b0GAiKA/nFOm6xdDTq5K
        UPGJGYbWRscXDwS7EoNCKs5IyhkCFoA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-4jpnEeBBMS2ydfpr-Pgopg-1; Sun, 08 Oct 2023 03:07:41 -0400
X-MC-Unique: 4jpnEeBBMS2ydfpr-Pgopg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-533f8bc82a8so2983694a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 00:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696748860; x=1697353660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2fivEi497/0xD/eVssN8LHPs3sN6zS8/o+fjkoWBRM=;
        b=VME5sJZFSw/HnjS8C+UPkHc6RIqvwPUafRn5XZPzDskC8NbfLAg/ksNZs353dXewhv
         bfkiDKrYsxKoFRQ64qqtliNOFNfUF46wvS9XQLJOgGT75214CotJ/PPWpEOAh2G2iSKj
         dvk6CLuZJ6lVFSTP9TBXBUmRKYyLkUO7GhiI8fHrVzkBVqgmEiwJhP/doOY9e2AZrBab
         /X+X90DKH6yl59CyIrhn77WVGcbxBlk/nHdjhNWmHOkKVR2l3+O2lr6V0KoOd9eQVP4n
         MOr2HUSDyOob4+QJIHycHUwbKzLQ4tyUGRImDsV6J05PPZ9nP1xmHW5Ernm0ZN6A19bl
         Nhzg==
X-Gm-Message-State: AOJu0Yyw9Znj02ZU3kxXQ1FblcPNHKRW0Tmp7DIa5JBmLIQk9zeLjMzl
        06ws1rHfw0nAf01neF4MA13heQhsDd94I2ne5xNcisJoIAImkBAzBunP6DQC/SiB30QogbFvyLV
        KM4lEpnHBP5vezEubL37N3CZ6
X-Received: by 2002:aa7:df13:0:b0:534:2e79:6b02 with SMTP id c19-20020aa7df13000000b005342e796b02mr11409845edy.39.1696748860326;
        Sun, 08 Oct 2023 00:07:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFySVBqxXAGtREE7jPD9CcOGGCbypdtm0B3v9aUgbouC7L+wvkutiu0pdF1XDBwRsDRHo6oQ==
X-Received: by 2002:aa7:df13:0:b0:534:2e79:6b02 with SMTP id c19-20020aa7df13000000b005342e796b02mr11409832edy.39.1696748859997;
        Sun, 08 Oct 2023 00:07:39 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:d74e:e6b1:da81:860a:5e9e])
        by smtp.gmail.com with ESMTPSA id e7-20020a50fb87000000b00533c844e337sm4701861edq.85.2023.10.08.00.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 00:07:39 -0700 (PDT)
Date:   Sun, 8 Oct 2023 03:07:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH] vduse: make vduse_class constant
Message-ID: <20231008030727-mutt-send-email-mst@kernel.org>
References: <2023100643-tricolor-citizen-6c2d@gregkh>
 <20231008022022-mutt-send-email-mst@kernel.org>
 <2023100823-absurd-imitation-092d@gregkh>
 <20231008024039-mutt-send-email-mst@kernel.org>
 <2023100835-driver-disrupt-9ea0@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023100835-driver-disrupt-9ea0@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 08:46:45AM +0200, Greg Kroah-Hartman wrote:
> On Sun, Oct 08, 2023 at 02:41:22AM -0400, Michael S. Tsirkin wrote:
> > On Sun, Oct 08, 2023 at 08:40:05AM +0200, Greg Kroah-Hartman wrote:
> > > On Sun, Oct 08, 2023 at 02:20:52AM -0400, Michael S. Tsirkin wrote:
> > > > On Fri, Oct 06, 2023 at 04:30:44PM +0200, Greg Kroah-Hartman wrote:
> > > > > Now that the driver core allows for struct class to be in read-only
> > > > > memory, we should make all 'class' structures declared at build time
> > > > > placing them into read-only memory, instead of having to be dynamically
> > > > > allocated at runtime.
> > > > > 
> > > > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > > > Cc: Jason Wang <jasowang@redhat.com>
> > > > > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > Cc: Xie Yongji <xieyongji@bytedance.com>
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > 
> > > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > > 
> > > > Greg should I merge it or do you intend to merge all these patches?
> > > 
> > > "all"?  There's loads of them for all sorts of subsystems, so feel free
> > > to take it through your subsystem tree if you want.  I usually scoop up
> > > the ones that no one picks after a release and take them through my
> > > tree, to pick up the stragglers.
> > > 
> > > So it's your call, whatever is easier for you is fine for me.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > To clarify which commit does this depend on?
> 
> The 6.4 kernel release :)

I'll pick this up then. Thanks!

