Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8719F7DE19A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344220AbjKAN01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343920AbjKAN0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:26:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27DAF7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 06:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698845141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5vuuw2hgFSjYMbIsoJnBkA458K2z+JiLRYE0TFB3z/Q=;
        b=X5tE5RRVaosEZ2WcNTMdi7crspO5//vhXK/Q5+uvcnpU9+HgSx8eAhCdpznOTKXQMi7atZ
        UKyUn7AirGiEEBYqExfqbst0Dy1Ec1jw1jl2uhvMVPVO21VU3uBB8GdbUWvzFFCHhVYnfj
        7uXFACvJ6z0Aw2miMHwuYkph5gB98io=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-feuweXS8N6WlLrIgsp88pQ-1; Wed, 01 Nov 2023 09:25:40 -0400
X-MC-Unique: feuweXS8N6WlLrIgsp88pQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9d28dd67464so269772466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 06:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698845139; x=1699449939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vuuw2hgFSjYMbIsoJnBkA458K2z+JiLRYE0TFB3z/Q=;
        b=tvMK6uiA5TBk0Cu/NSiOK/q6NBTQwUwK5cgpyql6PyzqsIjQTcMzhLSB5VNZxf0yoA
         WKAMkuytd5B0xmec9+ZMHT13y+u+8x9aMudMh+NjkUq4Jdd808IruT1X1SCFfA1QDQWR
         FV0TblHrpPd5EaI9srM4Y9VKH2E9/LciPcs3jtopTSSAUlo28FWX+7UOJqwBsz3P862/
         zDNMamkRSND7OYA2v3mkipFuNHnstXAQEci3JL2Ty5EM0TYaRD6hMXCYxjqLmXppSqak
         FAhJMmMs0mBI/tZHOhbxcF4qsNn0Rf+1YsbO+G+bDpYgxW0vNrXyWYQNldjJacUlprcn
         kD9Q==
X-Gm-Message-State: AOJu0Yyxktyek7TmMpMizu9QQa4rnnojczEZfWqsJ5IOwSCgXBCWPojb
        VRKBSeg9OC+BicKEuelI4eT+MLvd7Itnso0tszjbM0wv+PxmA1K7FAfeHlAs1e7HXQK3adgNo5+
        B5L4hJSoQyLONVtDpDI8iq4mt
X-Received: by 2002:a17:907:da1:b0:9d7:139:ca02 with SMTP id go33-20020a1709070da100b009d70139ca02mr1593788ejc.18.1698845139551;
        Wed, 01 Nov 2023 06:25:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH01EOmDvR1VZ1Vpqwf7/m2EHCZhBOjFFX6rLdJc7iyoXzWszkpEDc8Iv42M1PCJjd0h1kjg==
X-Received: by 2002:a17:907:da1:b0:9d7:139:ca02 with SMTP id go33-20020a1709070da100b009d70139ca02mr1593777ejc.18.1698845139229;
        Wed, 01 Nov 2023 06:25:39 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:e470:9af7:1504:1b35:8a09])
        by smtp.gmail.com with ESMTPSA id cl21-20020a170906c4d500b0099bd1a78ef5sm2397533ejb.74.2023.11.01.06.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 06:25:38 -0700 (PDT)
Date:   Wed, 1 Nov 2023 09:25:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: virtcrypto_dataq_callback calls crypto_finalize_request() from
 irq context
Message-ID: <20231101092521-mutt-send-email-mst@kernel.org>
References: <20230922154546.4f7447ce.pasic@linux.ibm.com>
 <ed47fb73ad634ca395bd6c8e979dda8e@huawei.com>
 <20230924193941.6a02237f.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230924193941.6a02237f.pasic@linux.ibm.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 07:39:41PM +0200, Halil Pasic wrote:
> On Sun, 24 Sep 2023 11:56:25 +0000
> "Gonglei (Arei)" <arei.gonglei@huawei.com> wrote:
> 
> > Hi Halil,
> > 
> > Commit 4058cf08945 introduced a check for detecting crypto completion function 
> > called with enable BH, and indeed the virtio-crypto driver didn't disable BH, which needs
> > a patch to fix it.
> > 
> > P.S.: https://lore.kernel.org/lkml/20220221120833.2618733-5-clabbe@baylibre.com/T/
> > 
> > Regards,
> > -Gonglei
> 
> Thanks Gonglei!
> 
> Thanks! I would be glad to test that fix on s390x. Are you about to send
> one?
> 
> Regards,
> Halil


Gonglei did you intend to send a fix?

