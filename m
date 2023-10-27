Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337A67D950B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345620AbjJ0KS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345717AbjJ0KS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:18:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39457D7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698401891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jZY15p4oIEfxgWyNWClalrKHx1YMgCfc6TjxYt8iXs0=;
        b=S6gDp5uCMmgW5NZHSAi2sWe6lVerJ0ucK7psH/5I02TbJFTQe4QhbcR+CxCfeI6y4M8crd
        48ohPMkM0aNrteLq70hSZefOOcfNirZqQmlqtVskP8GpZiWpii4PjMrGGqqS6/zDr9K1QU
        sDsnoRZe84CFMXpv1b7LiMYaFgQajl4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-Ks1OdDqyPY2FKPZphDFJyA-1; Fri, 27 Oct 2023 06:18:09 -0400
X-MC-Unique: Ks1OdDqyPY2FKPZphDFJyA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-778b3526240so271533485a.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698401889; x=1699006689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZY15p4oIEfxgWyNWClalrKHx1YMgCfc6TjxYt8iXs0=;
        b=m7A3C97S7Y5ESP6rMabiu9WdJ0iPbzpXZ6CGRQye63i5DzOlDPW/MFqEb6cWCQfw0q
         mQjLALzsdiA/SrUc5UFQYGuc9JBVn9ii7C/Ll5X9tW4kuElFb0/qwwUrIIZnrfyXCkRT
         AJC4ovyOIf9pN8ZmHE6RB5/jj8gSYaAlX6N2O4i/JldrvFeCb488HH7sB0y3fYfCnOd6
         N7M7Fxa3LLqsizZwwWMALPZSReErzvrxZjaUqQF0Ncydcjn/9clsOvUBNv1G5Gk1k0+z
         dtJjOlQjV2f4c4rY7fFL3bqp6OonY47RHjULhVNSbh9OB8E2TDAUAtLzUziDPi6qIcYl
         A4xw==
X-Gm-Message-State: AOJu0YxCTSPs4Yj+y6mJApS2jbpSf+HjB/CdVwz560W8mT5WI94SSOAU
        tvhjPARQjKEQOiP8F7pvuEbkkQUk9O3Z6XCIOmTU/FaP5aHBe2sPf9sDVYbFOFw53PCvltnsvlb
        PehrL3fUzZnDXJCpsPbjU2s4+
X-Received: by 2002:a37:c247:0:b0:774:15ad:f34c with SMTP id j7-20020a37c247000000b0077415adf34cmr1906249qkm.70.1698401889182;
        Fri, 27 Oct 2023 03:18:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVbi3m4HtBsaAHCYuS1Gm+WqONcRY/f91+9J5q+xtfN+RS9/bPp7pN8qw6/VJVCiFy4pQCMw==
X-Received: by 2002:a37:c247:0:b0:774:15ad:f34c with SMTP id j7-20020a37c247000000b0077415adf34cmr1906237qkm.70.1698401888896;
        Fri, 27 Oct 2023 03:18:08 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it. [87.12.185.56])
        by smtp.gmail.com with ESMTPSA id y3-20020a37e303000000b00774830b40d4sm420637qki.47.2023.10.27.03.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 03:18:08 -0700 (PDT)
Date:   Fri, 27 Oct 2023 12:18:00 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Takashi Iwai <tiwai@suse.de>, mst@redhat.com
Cc:     Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
        anton.yakovlev@opensynergy.com, mst@redhat.com, perex@perex.cz,
        tiwai@suse.com, virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, stefanha@redhat.com,
        manos.pitsidianakis@linaro.org, mripard@redhat.com
Subject: Re: [PATCH v4] ALSA: virtio: use ack callback
Message-ID: <jmuevryxo2nlqriqbwz6y2ttwzxwajfsnb5vaez2oqu7etkrd3@lu3pgnfushmr>
References: <ZTjkn1YAFz67yfqx@fedora>
 <87cyx0xvn7.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87cyx0xvn7.wl-tiwai@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 11:27:40AM +0200, Takashi Iwai wrote:
>On Wed, 25 Oct 2023 11:49:19 +0200,
>Matias Ezequiel Vara Larsen wrote:
>>
>> This commit uses the ack() callback to determine when a buffer has been
>> updated, then exposes it to guest.
>>
>> The current mechanism splits a dma buffer into descriptors that are
>> exposed to the device. This dma buffer is shared with the user
>> application. When the device consumes a buffer, the driver moves the
>> request from the used ring to available ring.
>>
>> The driver exposes the buffer to the device without knowing if the
>> content has been updated from the user. The section 2.8.21.1 of the
>> virtio spec states that: "The device MAY access the descriptor chains
>> the driver created and the memory they refer to immediately". If the
>> device picks up buffers from the available ring just after it is
>> notified, it happens that the content may be old.
>>
>> When the ack() callback is invoked, the driver exposes only the buffers
>> that have already been updated, i.e., enqueued in the available ring.
>> Thus, the device always picks up a buffer that is updated.
>>
>> For capturing, the driver starts by exposing all the available buffers
>> to device. After device updates the content of a buffer, it enqueues it
>> in the used ring. It is only after the ack() for capturing is issued
>> that the driver re-enqueues the buffer in the available ring.
>>
>> Co-developed-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
>> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
>> Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
>
>Applied now to for-next branch.

Cool, thanks for that!

I just wonder if we should CC stable since we are fixing a virtio
specification violation.

@Michael what do you think?

Thanks,
Stefano

