Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6173878C637
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjH2Nha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjH2NgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2BAE66
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693316056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=meHgujCAcJWGepUP3mVRioCZxpb1/KV09es2CrqMcik=;
        b=Lai+Lrm+LgaE+LBtHVGV8ic3D7fgwkdGbcvJOL3QabgoNPWvSnSxLFA+SGur+zTsEnIsUt
        xuwfMe9sAmSqr06Jdd965uV0Co2Ruh48RNECK7y1cDfNCjGpHqOQ2Zn5NFXpXkiGa8n0Od
        VbvnRxpLyPcXpahn18l0eyghiECfH98=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-pDofYS_2OEqJMmIBLgET0Q-1; Tue, 29 Aug 2023 09:34:11 -0400
X-MC-Unique: pDofYS_2OEqJMmIBLgET0Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D63A2815E23;
        Tue, 29 Aug 2023 13:34:11 +0000 (UTC)
Received: from [10.39.208.19] (unknown [10.39.208.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A4F640C6F4C;
        Tue, 29 Aug 2023 13:34:08 +0000 (UTC)
Message-ID: <ad2b2f93-3598-cffc-0f0d-fe20b2444011@redhat.com>
Date:   Tue, 29 Aug 2023 15:34:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/3] vduse: add support for networking devices
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     xieyongji@bytedance.com, jasowang@redhat.com,
        david.marchand@redhat.com, lulu@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com
References: <20230705100430.61927-1-maxime.coquelin@redhat.com>
 <20230810150347-mutt-send-email-mst@kernel.org>
 <20230810142949.074c9430@kernel.org>
 <20230810174021-mutt-send-email-mst@kernel.org>
 <20230810150054.7baf34b7@kernel.org>
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <20230810150054.7baf34b7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/23 00:00, Jakub Kicinski wrote:
> On Thu, 10 Aug 2023 17:42:11 -0400 Michael S. Tsirkin wrote:
>>> Directly into the stack? I thought VDUSE is vDPA in user space,
>>> meaning to get to the kernel the packet has to first go thru
>>> a virtio-net instance.
>>
>> yes. is that a sufficient filter in your opinion?
> 
> Yes, the ability to create the device feels stronger than CAP_NET_RAW,
> and a bit tangential to CAP_NET_ADMIN. But I don't have much practical
> experience with virt so no strong opinion, perhaps it does make sense
> for someone's deployment? Dunno..
> 

I'm not sure CAP_NET_ADMIN should be required for creating the VDUSE
devices, as the device could be attached to vhost-vDPA and so not
visible to the Kernel networking stack.

However, CAP_NET_ADMIN should be required to attach the VDUSE device to 
virtio-vdpa/virtio-net.

Does that make sense?

Maxime

