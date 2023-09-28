Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755C97B1673
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjI1Iwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjI1Iwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EFFAC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695891111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NkWcflk7o2IhAoW5ugdA3P4TxFldRrvEEsOTDIfjw5E=;
        b=LlGrtTweUgG0Mw1ZuDKwRx8D7xFVIg6oVj3O+e95APmwxe6xcv1w9hg214uuzQL5SQdVBN
        zRicWYE675AhbXkHfWzwNFX9YBFwBSdpHeEPGD7hjqhZYN/vqlhPalvfm+Enadsjzci+2A
        3XvrpccJqYtfjFlLVg3i6HWHZCNmMe4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-DVnNAnAyNjWsMZ0yidM2EQ-1; Thu, 28 Sep 2023 04:51:49 -0400
X-MC-Unique: DVnNAnAyNjWsMZ0yidM2EQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-418225fb5d6so113969841cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695891109; x=1696495909;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NkWcflk7o2IhAoW5ugdA3P4TxFldRrvEEsOTDIfjw5E=;
        b=Dj2H67SbKMmjXNrISt6xz7v2IBgDnT2JN/SnpZ2EZA+4LwIHw7n+5sgbkS+doq8iLp
         8fgcgaH7UJjqyZAeVpOg9Xt+wRMMFGkcsg2+LDi0NwgakD1HfmLEF6GU6JMZ62OcyAtM
         5kCKHx6FkfKLNBmK5hs5GcGOF9lVMKVTipztbsHA2wABgLWWis7ASHJPYomYrSiTwPPD
         tqV4yiejDX5cNh2ZkyXkbtrcGPfjlXyy1rdK99agqgzYpSt/HAYcJbMh28//jvsq88Gu
         uPR7PFXsJmBcvNDTYueKReJoYv5HCI3eXKNH5cVl5Yc8pVNKU3cyuLvQ7sqGkwfw31ua
         o9nA==
X-Gm-Message-State: AOJu0Yzv6H78ncB6wgNLQmMwCVw+c5bKz1KQqzL6Sb+cqQgxkruaXWz6
        y4gN/lBgw2fRG+ctkKeUbBlsOhQOUAnf/YVbZ7MPYhUhe5EQXY21T+kRksTwOU6BwTtuiy38znW
        8tkBSON9J3iRKPUWqcT9f328l
X-Received: by 2002:a05:622a:138b:b0:412:191c:ffa with SMTP id o11-20020a05622a138b00b00412191c0ffamr637754qtk.26.1695891109113;
        Thu, 28 Sep 2023 01:51:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+H2XpyC6g5cXAzUKMgVxYhAIA1uZrXD5jkN2vZZOVsLgR0f4SYCEkiNop7wfk3UqIpQAm2g==
X-Received: by 2002:a05:622a:138b:b0:412:191c:ffa with SMTP id o11-20020a05622a138b00b00412191c0ffamr637746qtk.26.1695891108882;
        Thu, 28 Sep 2023 01:51:48 -0700 (PDT)
Received: from vschneid.remote.csb ([80.215.217.124])
        by smtp.gmail.com with ESMTPSA id ig8-20020a05622a6a4800b004181127a230sm3614173qtb.76.2023.09.28.01.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 01:51:48 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, akpm@linux-foundation.org,
        eric.devolder@oracle.com, sourabhjain@linux.ibm.com,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3] Crash: add lock to serialize crash hotplug handling
In-Reply-To: <20230926120905.392903-1-bhe@redhat.com>
References: <20230926120905.392903-1-bhe@redhat.com>
Date:   Thu, 28 Sep 2023 10:51:45 +0200
Message-ID: <xhsmhy1gqu1cu.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/23 20:09, Baoquan He wrote:
> Eric reported that handling corresponding crash hotplug event can be
> failed easily when many memory hotplug event are notified in a short
> period. They failed because failing to take __kexec_lock.
>
> =======
> [   78.714569] Fallback order for Node 0: 0
> [   78.714575] Built 1 zonelists, mobility grouping on.  Total pages: 1817886
> [   78.717133] Policy zone: Normal
> [   78.724423] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> [   78.727207] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> [   80.056643] PEFILE: Unsigned PE binary
> =======
>
> The memory hotplug events are notified very quickly and very many,
> while the handling of crash hotplug is much slower relatively. So the
> atomic variable __kexec_lock and kexec_trylock() can't guarantee the
> serialization of crash hotplug handling.
>
> Here, add a new mutex lock __crash_hotplug_lock to serialize crash
> hotplug handling specifically. This doesn't impact the usage of
> __kexec_lock.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

