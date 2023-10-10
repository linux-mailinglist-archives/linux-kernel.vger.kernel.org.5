Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E527C42D7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbjJJVnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjJJVnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049981FC2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696974175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7j58jSxoMSjtICjzuYVhVJduEEO2aGmUt8x1byZkixA=;
        b=UWEg+ReFZeO2RljSv6kmUf9j9gqFubgbZ8AAjlwBkNCz4hqVpzohvQYralmuDupkE6hoDY
        57hbnBUKwesSiXiGDqOsbaJwBpQPHUpzFZDBW1h/nRUFn3Pd/KtPg95BmQ0zbegNMvseMO
        /DfFIjMK16hWgqcZ9jGnLQaK6/hUQaI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-lbHA_WKDN12MJr6FUpy6IA-1; Tue, 10 Oct 2023 17:42:54 -0400
X-MC-Unique: lbHA_WKDN12MJr6FUpy6IA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3172a94b274so4190275f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696974173; x=1697578973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7j58jSxoMSjtICjzuYVhVJduEEO2aGmUt8x1byZkixA=;
        b=GEo0jd/hFFL8jTwojrl+TYNtvSklmMiiHkNn7gJQ5cDZpENHaGoEWX6QakceHbMqCp
         Yzssnc2UVgdgb+7gmy/fQRdcige4xW1/CA/q1yD/Q3MB0RKh3nkBO1HNFvbfCZwvGwU5
         iKJuCZ6vNXOOD3leo+dJw5tzq4M1kwhaN3Gi8Ywz1fkCIY4LSUSHeUYFpYcZdzTaODos
         WdvHSXEe5/yF6UGruMmturcbH4MxqSp8D8gATQWWHI3TlefukXDvXiEPygiqpYjhOcu+
         uaiA0VLsKhvXgx52zVRlqCxE/Kw7riPPPNKlNkRm67C4n9C4rkKXu5J5DOCWtKqCKvFk
         PGow==
X-Gm-Message-State: AOJu0YwiZhHh4Hm8CRaPIKLrxoTxBajS7UyhZI8n+FSWd+ZU5uk2whYP
        N+mMI3uPjZctkpB5QR0b45vikNnzMsZZ1dzrcD+JjQHP4RaHMf6lqULAuteY5BJXPkGFDaExilc
        oJlJde8QZCPbrLvonswwnibrP
X-Received: by 2002:a5d:4486:0:b0:320:8291:5605 with SMTP id j6-20020a5d4486000000b0032082915605mr16776333wrq.2.1696974173621;
        Tue, 10 Oct 2023 14:42:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvlJv9piqdjwUmmSzkx4bf0GnL2+t+076ipCDe5oxu2XEBxAvFC4zjoEvDDXmhVt7SWixiKg==
X-Received: by 2002:a5d:4486:0:b0:320:8291:5605 with SMTP id j6-20020a5d4486000000b0032082915605mr16776313wrq.2.1696974173219;
        Tue, 10 Oct 2023 14:42:53 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
        by smtp.gmail.com with ESMTPSA id bv2-20020a0560001f0200b0032d09f7a713sm2878219wrb.18.2023.10.10.14.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 14:42:52 -0700 (PDT)
Date:   Tue, 10 Oct 2023 17:42:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Graf <graf@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        Petre Eftime <petre.eftime@gmail.com>,
        Erdem Meydanlli <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v5] misc: Add Nitro Secure Module driver
Message-ID: <20231010174115-mutt-send-email-mst@kernel.org>
References: <20231010191815.13641-1-graf@amazon.com>
 <20231010163151-mutt-send-email-mst@kernel.org>
 <aa782a43-ad4a-455d-bc14-a6a6bb4022e0@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa782a43-ad4a-455d-bc14-a6a6bb4022e0@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 11:29:00PM +0200, Alexander Graf wrote:
> 
> On 10.10.23 22:34, Michael S. Tsirkin wrote:
> > 
> > On Tue, Oct 10, 2023 at 07:18:15PM +0000, Alexander Graf wrote:
> > > When running Linux inside a Nitro Enclave, the hypervisor provides a
> > > special virtio device called "Nitro Security Module" (NSM). This device
> > > has 3 main functions:
> > > 
> > >    1) Provide attestation reports
> > >    2) Modify PCR state
> > >    3) Provide entropy
> > > 
> > > This patch adds a driver for NSM that exposes a /dev/nsm device node which
> > > user space can issue an ioctl on this device with raw NSM CBOR formatted
> > > commands to request attestation documents, influence PCR states, read
> > > entropy and enumerate status of the device. In addition, the driver
> > > implements a hwrng backend.
> > > 
> > > Originally-by: Petre Eftime <petre.eftime@gmail.com>
> > > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Could some documentation about how this device works be posted on virtio
> > list please?
> 
> 
> Sure! What is your preferred method to provide this? :)
> 
> Alex
> 

Posting patch adding a text file with it to virtio-comment would be best.

> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 

