Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866B378A4FE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 06:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjH1EpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 00:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjH1Eov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 00:44:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5DB124
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 21:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693197842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fi86TLb/jHVvg9zjn7XHlWr0cwJimP6upmcGlNZVzgY=;
        b=cvqiR1IhtOOX6w3JSRg1Av17hF0j+DzOGnFNW55Ac9gOUODqtIzu8PZ/BuzdXNAIOa+uYS
        yhPLyQOXA6Uplv6QIV4/iLi6QLy3MHo4RiOnkWxAhG4VuL3onmgEKfGpiRFZFt2rDoyCLS
        uv6kNd8qR75EfItZb42A8clKPnHEpxk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-6SOYEKjdNLyFOUTqEliaKw-1; Mon, 28 Aug 2023 00:44:00 -0400
X-MC-Unique: 6SOYEKjdNLyFOUTqEliaKw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a355c9028so206588966b.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 21:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693197839; x=1693802639;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fi86TLb/jHVvg9zjn7XHlWr0cwJimP6upmcGlNZVzgY=;
        b=MbUj4/DjZU4PO0YNHM8Pv5r+gNRoD6rW4Dyj/rF4338rS67T4p4l3v9+ODCQKR93Ya
         LWQBjeqen+enswwbBr2lgR5uiBETwTPKj4fYSKv0ID2i3uWTlZL785Ryk+oCBC4sswEO
         2l5rDKRmzH/m4fpC4+w071vljARAOKnD4p0qJJ3ML6THC/+R6uP7SlK+K6mG1DaAM/6B
         b9gIa8FzsJdvX3bXHo0ARNsOiWWww91ak3KCWAd2fizcU+BPTOKrG/eoWK2I2nsNrrcQ
         Flx41NcQQ5Zytp67kth1fiOpWBepWFNBli5Ljzh/E+YNRWXXl/J42/j+tQVvDdlADzr/
         7p7g==
X-Gm-Message-State: AOJu0YwhQJjYThlE6uZlpxPhoQFYfGIQdzVEuMlzOEbXNJ0aRPRX3xSB
        mre7KMfBPTJZQ7t1nubJ4Oa1xY8qCE6U+BhANIQ/b8UXL2gM1XiDuKCP2CjEVwnHQj/2q1oEzdx
        mDy4WW8pUnnccplqBBn5efJ711y7xyShNHWY=
X-Received: by 2002:a17:906:2102:b0:99d:e8da:c20b with SMTP id 2-20020a170906210200b0099de8dac20bmr17292945ejt.24.1693197838865;
        Sun, 27 Aug 2023 21:43:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWMCQLqR83SRHv6bXmH/xQXTYbezZysqjUu1htVMzC8mLUN54SpnfBWNxtyVsQbnhcqrpwWg==
X-Received: by 2002:a17:906:2102:b0:99d:e8da:c20b with SMTP id 2-20020a170906210200b0099de8dac20bmr17292931ejt.24.1693197838501;
        Sun, 27 Aug 2023 21:43:58 -0700 (PDT)
Received: from redhat.com ([2.52.30.217])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090614d600b0099cfd0b2437sm4206104ejc.99.2023.08.27.21.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 21:43:57 -0700 (PDT)
Date:   Mon, 28 Aug 2023 00:43:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yuan Yao <yuanyaogoog@chromium.org>
Cc:     Jason Wang <jasowang@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Takaya Saeki <takayas@chromium.org>,
        Junichi Uekawa <uekawa@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio_ring: fix avail_wrap_counter in
 virtqueue_add_packed
Message-ID: <20230828004323-mutt-send-email-mst@kernel.org>
References: <20230808051110.3492693-1-yuanyaogoog@chromium.org>
 <CACGkMEt53ziY_bmgJHVdJ6pkppTyVqKX3=Czygv+yhJR8_KiFA@mail.gmail.com>
 <CAOJyEHaXqmHStJnHrT0H4QsTJBxjBxVe+33EuWm9H3wApPKtxQ@mail.gmail.com>
 <CACGkMEuiVnLFRRDHaTH3Jnpr+znU9L33gLyRynbBabVqumN2ug@mail.gmail.com>
 <CAOJyEHaR1Y3VsKNpLqxf-ewAEf8JJDChjmnFM_0mv=hOg+X-vA@mail.gmail.com>
 <20230808051304-mutt-send-email-mst@kernel.org>
 <CAOJyEHYgvw7za0ksKNPu9TF1+8MwVFbctMbukgbAoQnf9da+hA@mail.gmail.com>
 <CAOJyEHZs=59nZ=XTYu-mZWTz18OT7f6TknCxWksYeQZbPy2oUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOJyEHZs=59nZ=XTYu-mZWTz18OT7f6TknCxWksYeQZbPy2oUQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nope - it will be in the next linux release.

On Mon, Aug 28, 2023 at 12:33:46PM +0900, Yuan Yao wrote:
> I'm writing to confirm the process for the patch, since I'm not sure if this
> thread is done for this patch.
> Do I need any further steps to take to make this patch be launched?
> 
> On Tue, Aug 8, 2023 at 7:00 PM Yuan Yao <yuanyaogoog@chromium.org> wrote:
> 
>     Sorry for the confusing mail, I didn't understand how it works.
>     Thanks
> 
>     On Tue, Aug 8, 2023 at 6:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
>         On Tue, Aug 08, 2023 at 05:37:29PM +0900, Yuan Yao wrote:
>         > Thank you for reviewing, sent a patch with your ack.
> 
>         Don't do this pls. And don't top post please.
> 
> 

