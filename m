Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BDB76927F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjGaJ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjGaJ4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577ACE5B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690797315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SQoMCvoY9z85LfglEVQlQxX/qlev/LvzY9LJJJIP4QE=;
        b=WyaUHIzCDiUAPdMTDzPcWfidMzyn8+8vh4CsiMBP5sbaZXl+3bG0fo5iu5Zz2tRceOGM7v
        wnn6q5LonwsClOG1XzEKQAplJmcoCORuvWGKSCY0PAtxHfyOdYE12/WepCCDPkg/4uLlNX
        cNYPND85hnIAPoKogfFMrJqgiloapZ4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-pFZpoOwHP-6LA_w2u5vbhg-1; Mon, 31 Jul 2023 05:55:13 -0400
X-MC-Unique: pFZpoOwHP-6LA_w2u5vbhg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5218b9647a8so2630938a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690797312; x=1691402112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQoMCvoY9z85LfglEVQlQxX/qlev/LvzY9LJJJIP4QE=;
        b=mFIF5rJY1yRVWdpvn/TFIfsGFQhGJlpg/zII+Yrwg0eX0zKyzzePMXKOzG2KxD6TmY
         Cr9lZCfDJ/ceGJkMqLHRIM70CGZ6NMvxoRnsby77fhS8pHrX3fAboWuyZ+EtDwVmFOJv
         7Gz42K7r7Yp1edEmbe7rnYSgA0D49TPyv0k5c3IKyVC50hFfM28hqKcjP76Lx7lBthbJ
         Zg648AYYsyGO2e5XkDNAhSngEqKp5aUpRcpSU4YM0cbuCFstT6CyOHaKnrRMKfhFGQbe
         9Kyyq1kEasZPrG7tywZ7caKK2kBC/59w84zf3/WkF44weVhDkI7VQhoDFlRNR+QNiUss
         MfaQ==
X-Gm-Message-State: ABy/qLazwqDqGBaQ3juDYD2kFB+wBkYrT14KObVCpF6bbQPbu+WSAGUe
        kx3B63lTXZinTWioGSb2pjeHcxcD/r2r+LShoJFvKrbVOOzg1hF/J0acopagxU5dlUnex+MeQTs
        NyedMs/ZUMzBfdw14yYtytszgeakyBvXE
X-Received: by 2002:aa7:c443:0:b0:522:55bf:21af with SMTP id n3-20020aa7c443000000b0052255bf21afmr7246378edr.7.1690797311991;
        Mon, 31 Jul 2023 02:55:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE58TsNYsn/mQvr3qBZ6RLFnKbCrKdzPm+vWtUuE+xxgcoyQK4b4Cl5YZ1mF+9BK4pUUO0zZg==
X-Received: by 2002:aa7:c443:0:b0:522:55bf:21af with SMTP id n3-20020aa7c443000000b0052255bf21afmr7246363edr.7.1690797311630;
        Mon, 31 Jul 2023 02:55:11 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-29.business.telecomitalia.it. [87.12.25.29])
        by smtp.gmail.com with ESMTPSA id i23-20020aa7c717000000b0051bed21a635sm5234603edq.74.2023.07.31.02.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:55:10 -0700 (PDT)
Date:   Mon, 31 Jul 2023 11:55:07 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] vsock: Remove unused function declarations
Message-ID: <ftvs2ivhynszqi3ib3w4uccfx5ren5dgkjagoeuyasbjdd76ac@4rbyljp2xnof>
References: <20230729122036.32988-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230729122036.32988-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 08:20:36PM +0800, Yue Haibing wrote:
>These are never implemented since introduction in
>commit d021c344051a ("VSOCK: Introduce VM Sockets")
>
>Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>---
> net/vmw_vsock/vmci_transport.h | 3 ---
> 1 file changed, 3 deletions(-)

Good catch ;-)

I'd used "vsock/vmci:" as a prefix in the title.

With or without:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/vmci_transport.h b/net/vmw_vsock/vmci_transport.h
>index b7b072194282..dbda3ababa14 100644
>--- a/net/vmw_vsock/vmci_transport.h
>+++ b/net/vmw_vsock/vmci_transport.h
>@@ -116,9 +116,6 @@ struct vmci_transport {
> 	spinlock_t lock; /* protects sk. */
> };
>
>-int vmci_transport_register(void);
>-void vmci_transport_unregister(void);
>-
> int vmci_transport_send_wrote_bh(struct sockaddr_vm *dst,
> 				 struct sockaddr_vm *src);
> int vmci_transport_send_read_bh(struct sockaddr_vm *dst,
>-- 
>2.34.1
>
>

