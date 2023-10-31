Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D617DD28F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbjJaQrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbjJaQrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:47:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97F6468E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698770155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V8RNrz/Yva6AAXDhSbIVEu5DSJqLVVmt8DdeJIQrB/I=;
        b=XFB3/td4WwpQoWVwASiSjV59GEmSjL7c16qDtQTPEgg5GelEzqG33f1pShScgvi2KH67w4
        kzcfKMiaQ6zS/iLOn9tJNHPX/YNOcOQWlXBCJsilkHlCkjEvDhg02poRpL6YyRFLpOE1mi
        Be1z0z+OnnkEt3eCMpjD3EoUeo/Im2M=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-czRgGzCpO267_XlNWsZOZQ-1; Tue, 31 Oct 2023 12:35:49 -0400
X-MC-Unique: czRgGzCpO267_XlNWsZOZQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-542fe446d45so2156160a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698770148; x=1699374948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8RNrz/Yva6AAXDhSbIVEu5DSJqLVVmt8DdeJIQrB/I=;
        b=IZVbKMAwxc+MGW6vyg0GPzGuEpelJ18Ys6F65rXlDQ+dBVfYcsaJC+sGSML/o5hkbA
         rG3USq7kD2becUNU3O5T1O+Emp4Erl6vzE4VXuT1KvEjvjBIHWrYx23Ul8sNgqYWhx6i
         SWcI7IxR8ZZNQDWyxzRc6M4zn39/1X79dSPHo2VJkNVrwvKEvmZekovYf21V+J2hNggy
         sIu4PsEOyL2ZAMcpijV172H3H9idojyXNLSPIk61CJr2nwK+dfqtv4+5/tKVpiUFqlFt
         TN7HQk+ovBcwnllyoeF72O6oUfkfUSrls+9ezoZWBaysY2cwjilPnjAmdB8Sap7OOQKs
         HGYw==
X-Gm-Message-State: AOJu0YzP6hojbWEnEo3KQbueTugLpq5ttrYscVc7keu6UwKNxFBEGfza
        EXb6NjpcEP6YTMqkX7l1Fns371PZ/rDPSYRy1nNUq27+bi1AGEzFj+TRA5vuriLEy2UrNwh/5gb
        HBO8L11A3+r81GxS3o5wO/Wr4
X-Received: by 2002:a05:6402:221a:b0:53e:3d9f:3c72 with SMTP id cq26-20020a056402221a00b0053e3d9f3c72mr10202179edb.18.1698770148015;
        Tue, 31 Oct 2023 09:35:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG23z5vX3pCUte1bczUsVj5YelU4MviK3+Zf1D5qHUrCaDe+xind2RjKzLc9AzkbRpkpnJ+RA==
X-Received: by 2002:a05:6402:221a:b0:53e:3d9f:3c72 with SMTP id cq26-20020a056402221a00b0053e3d9f3c72mr10202159edb.18.1698770147712;
        Tue, 31 Oct 2023 09:35:47 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.178.82])
        by smtp.gmail.com with ESMTPSA id z7-20020a50cd07000000b0053e5a1bf77dsm1412398edi.88.2023.10.31.09.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 09:35:47 -0700 (PDT)
Date:   Tue, 31 Oct 2023 17:35:42 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
        anton.yakovlev@opensynergy.com, perex@perex.cz, tiwai@suse.com,
        virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, stefanha@redhat.com,
        manos.pitsidianakis@linaro.org, mripard@redhat.com
Subject: Re: [PATCH v4] ALSA: virtio: use ack callback
Message-ID: <7agwvbpra7ywyeghawq6xs4l2rxyksyyarborezzndb73wfd6t@bxtb2n4dsrfa>
References: <ZTjkn1YAFz67yfqx@fedora>
 <87cyx0xvn7.wl-tiwai@suse.de>
 <jmuevryxo2nlqriqbwz6y2ttwzxwajfsnb5vaez2oqu7etkrd3@lu3pgnfushmr>
 <20231027100703-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231027100703-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 10:10:30AM -0400, Michael S. Tsirkin wrote:
>On Fri, Oct 27, 2023 at 12:18:00PM +0200, Stefano Garzarella wrote:
>> On Fri, Oct 27, 2023 at 11:27:40AM +0200, Takashi Iwai wrote:
>> > On Wed, 25 Oct 2023 11:49:19 +0200,
>> > Matias Ezequiel Vara Larsen wrote:
>> > >
>> > > This commit uses the ack() callback to determine when a buffer has been
>> > > updated, then exposes it to guest.
>> > >
>> > > The current mechanism splits a dma buffer into descriptors that are
>> > > exposed to the device. This dma buffer is shared with the user
>> > > application. When the device consumes a buffer, the driver moves the
>> > > request from the used ring to available ring.
>> > >
>> > > The driver exposes the buffer to the device without knowing if the
>> > > content has been updated from the user. The section 2.8.21.1 of the
>> > > virtio spec states that: "The device MAY access the descriptor chains
>> > > the driver created and the memory they refer to immediately". If the
>> > > device picks up buffers from the available ring just after it is
>> > > notified, it happens that the content may be old.
>> > >
>> > > When the ack() callback is invoked, the driver exposes only the buffers
>> > > that have already been updated, i.e., enqueued in the available ring.
>> > > Thus, the device always picks up a buffer that is updated.
>> > >
>> > > For capturing, the driver starts by exposing all the available buffers
>> > > to device. After device updates the content of a buffer, it enqueues it
>> > > in the used ring. It is only after the ack() for capturing is issued
>> > > that the driver re-enqueues the buffer in the available ring.
>> > >
>> > > Co-developed-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
>> > > Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
>> > > Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
>> >
>> > Applied now to for-next branch.
>>
>> Cool, thanks for that!
>>
>> I just wonder if we should CC stable since we are fixing a virtio
>> specification violation.
>>
>> @Michael what do you think?
>>
>> Thanks,
>> Stefano
>
>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>
>Fixes: de3a9980d8c3 ("ALSA: virtio: add virtio sound driver")
>
>
>The patch is too big for stable - more than 100 lines added. See:
>Documentation/process/stable-kernel-rules.rst

Yeah, I see, thanks for sharing!

Stefano

