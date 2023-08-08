Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BF17746BF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjHHTAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjHHTAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:00:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E4E1EF6F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691515450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1G+UFT5WUV3++eACnsbOojH7Ps5z7GYiHoNSMdDXlHM=;
        b=SQKnXEYSpUpeZeaMZUz54nXAJyE/ZeUVgTAiRHSNzU3ilhaIqqXcmW3K049Y2ImLKMWyfM
        xGtWikC3SiAWtrvshrM2bBzkIHTdJFRILk/rHVFhdKit5yROl5Jx/YiUAkpTh/blVJ41Gd
        VN1dOS94nHox758dRSYxO0E0rAayAjQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-yZnASsfrO-ur--pUfdsgpA-1; Tue, 08 Aug 2023 05:13:37 -0400
X-MC-Unique: yZnASsfrO-ur--pUfdsgpA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5218b9647a8so3670420a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 02:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691486016; x=1692090816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1G+UFT5WUV3++eACnsbOojH7Ps5z7GYiHoNSMdDXlHM=;
        b=RQP5IsFPIBqFC+OnHiijzjoaktnUcoqRvSNc53gVxQXF7Y1OTXMl+tBnJBMzMExsvY
         dgfpoaT8DcIMZFdtSp1tWIcMQO68h9RW4T2yh88dQiIxDSETYXe9ev/P1CEBvHSPKhhO
         pJmzhMckB7r39FHY2a/TM9YTKUYlUsA+14NLs2owXdYr6XtFK9mTjgHyZcCtDlqM9Dm6
         X49kyFGJ/0X/aK06W4dpbNHH69di0UIaSmJMktVpdG+vCBfh9PXeNPalvuTUTbavjD2r
         M1ORd25bI06zO1UP5TzsrVMVIRSKLBhEVaNPc0xQnJikOF57O+6CkK4LKl1jrOpvmfaq
         OIfQ==
X-Gm-Message-State: AOJu0YzAHBoAP2I9b6gbX9iWNouJoD+vaqdJF5Xe1jY8fyuJyWRp5kyQ
        y9ZlfSCig6+oPsAiSesWrk3kkX7EiLwj+M8kdlF+ahbZDkqW0CdcWgeHTiw/ijCYLfX1zhZE7bd
        x/6D9igJVmkfymPRO1xfNPk9p
X-Received: by 2002:a05:6402:1646:b0:523:4025:49f0 with SMTP id s6-20020a056402164600b00523402549f0mr1960935edx.26.1691486016583;
        Tue, 08 Aug 2023 02:13:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxZ8yuMEFfPguOg8HjGVkFo31GvBbO4Td4uMFZbTfoUpq6uZFQFMLz4TWQNdMsMhExnizdSA==
X-Received: by 2002:a05:6402:1646:b0:523:4025:49f0 with SMTP id s6-20020a056402164600b00523402549f0mr1960921edx.26.1691486016302;
        Tue, 08 Aug 2023 02:13:36 -0700 (PDT)
Received: from redhat.com ([2.52.159.103])
        by smtp.gmail.com with ESMTPSA id d14-20020aa7d5ce000000b00522b7c5d53esm6375959eds.54.2023.08.08.02.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 02:13:35 -0700 (PDT)
Date:   Tue, 8 Aug 2023 05:13:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yuan Yao <yuanyaogoog@chromium.org>
Cc:     Jason Wang <jasowang@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Takaya Saeki <takayas@chromium.org>,
        Junichi Uekawa <uekawa@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Tiwei Bie <tiwei.bie@intel.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio_ring: fix avail_wrap_counter in
 virtqueue_add_packed
Message-ID: <20230808051304-mutt-send-email-mst@kernel.org>
References: <20230808051110.3492693-1-yuanyaogoog@chromium.org>
 <CACGkMEt53ziY_bmgJHVdJ6pkppTyVqKX3=Czygv+yhJR8_KiFA@mail.gmail.com>
 <CAOJyEHaXqmHStJnHrT0H4QsTJBxjBxVe+33EuWm9H3wApPKtxQ@mail.gmail.com>
 <CACGkMEuiVnLFRRDHaTH3Jnpr+znU9L33gLyRynbBabVqumN2ug@mail.gmail.com>
 <CAOJyEHaR1Y3VsKNpLqxf-ewAEf8JJDChjmnFM_0mv=hOg+X-vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOJyEHaR1Y3VsKNpLqxf-ewAEf8JJDChjmnFM_0mv=hOg+X-vA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 05:37:29PM +0900, Yuan Yao wrote:
> Thank you for reviewing, sent a patch with your ack.

Don't do this pls. And don't top post please.

