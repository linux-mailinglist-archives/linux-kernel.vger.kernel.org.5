Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4627C7782C8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjHJVnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHJVnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:43:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A0A2728
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691703738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2HtcNk1A7Nq+3/V6wlbgltFs7j7KhU3JDIUkHEFT9ak=;
        b=DgYXhQNaXTFcSKkKxvrNJ/Z2kgbh9xhpxxykVQkFxFE/BZwBVj/CCxdG3PwsWVGiu9RV25
        n6ttrXQuECOOhr/v2jKq4LCneqTgJP2QPOxedFtxv3F7+qES9XgSqCrsi+oFBRtiP/thAp
        19dCqUcPiGIw0M7zS+EC6Yv2Km3D+Ns=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-wut8qPNyPhCP2juoJnjlwQ-1; Thu, 10 Aug 2023 17:42:16 -0400
X-MC-Unique: wut8qPNyPhCP2juoJnjlwQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe4bda379fso9029555e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691703735; x=1692308535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HtcNk1A7Nq+3/V6wlbgltFs7j7KhU3JDIUkHEFT9ak=;
        b=EddPQjvJcigqkfiegIKGEsAuZ5rHxuzmGlNnFPv+hLbj4tR6beIxcdKPnYlQD11zzj
         IsC7uvtng2KTPYKemnIJTFp8Wt+pwNfiuVllWzyqszZLgQ1QQBzmeQGC4rbl/IjV/B9Y
         QbXnrNxqb52JHTopWja/K8b62jWouHcwAqtL7gpgRXbrblzjKe+4eb683O8wMcnKLxod
         z8y/hyVg5Sjcq5SuP20tFQXE8f/wkGzaffb3b+JFloYuEt+tYRuyVTbk1h7mPHdG2USl
         yDfcsDtMhDIrGNuOKDwluyIS4fZjCDgQKZIF960sGg78ny2kHSh+ZciZtpfAxzyi7C7M
         l4cg==
X-Gm-Message-State: AOJu0YztNwuEQ+s12y1kVDmu/ogQBPVjiu5lpA9FCI9ocpe9+xlI5DzM
        9bbSiqjimghMqF4CwEhWwkhoE9jsxQdCIfWa5mKSXR0UYb6AHqlk6FJt4jFugM4eh+vhHPYFJ6i
        1ZoZOZnHOhbEqp5VqCCIET184
X-Received: by 2002:a05:600c:218f:b0:3fc:186:284d with SMTP id e15-20020a05600c218f00b003fc0186284dmr107036wme.18.1691703735764;
        Thu, 10 Aug 2023 14:42:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8OFCHupC30sqzZHz8wZXJmFsOw+UxdKSTyakavwrTBFMqwiyoteEVk+I7wC7S8jsf3rwrDQ==
X-Received: by 2002:a05:600c:218f:b0:3fc:186:284d with SMTP id e15-20020a05600c218f00b003fc0186284dmr107027wme.18.1691703735439;
        Thu, 10 Aug 2023 14:42:15 -0700 (PDT)
Received: from redhat.com ([2.55.42.146])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fba6a0c881sm6129528wmj.43.2023.08.10.14.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:42:14 -0700 (PDT)
Date:   Thu, 10 Aug 2023 17:42:11 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Maxime Coquelin <maxime.coquelin@redhat.com>,
        xieyongji@bytedance.com, jasowang@redhat.com,
        david.marchand@redhat.com, lulu@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Subject: Re: [PATCH v3 0/3] vduse: add support for networking devices
Message-ID: <20230810174021-mutt-send-email-mst@kernel.org>
References: <20230705100430.61927-1-maxime.coquelin@redhat.com>
 <20230810150347-mutt-send-email-mst@kernel.org>
 <20230810142949.074c9430@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810142949.074c9430@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 02:29:49PM -0700, Jakub Kicinski wrote:
> On Thu, 10 Aug 2023 15:04:27 -0400 Michael S. Tsirkin wrote:
> > Another question is that with this userspace can inject
> > packets directly into net stack. Should we check CAP_NET_ADMIN
> > or such?
> 
> Directly into the stack? I thought VDUSE is vDPA in user space,
> meaning to get to the kernel the packet has to first go thru 
> a virtio-net instance.

yes. is that a sufficient filter in your opinion?

> Or you mean directly into the network?

