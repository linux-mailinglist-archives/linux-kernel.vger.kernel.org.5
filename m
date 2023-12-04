Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690BF80318C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjLDLb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjLDLbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:31:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B9F102
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701689489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jJEZOaCc2w94rl3BlMnubip+8eCagEswLw1gSwc8CGo=;
        b=bNMrTt9a5dAQ+w1oSMngtfh1p829bWtIymo/gOFwyS5sYKxiN32KWndhadQvJ8JDy6fO5y
        EwAMH1t0iVuUfvFeQlYMjDstKFFgfUASRRrxZImULdzYm5NGbyNHN5LWpE/pJTd3L4lcIK
        kmNUHti13hRj3X+Jij1XJc8KqCAFH6o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-iQPyttfTPUGA5LOLaM8WOg-1; Mon, 04 Dec 2023 06:31:24 -0500
X-MC-Unique: iQPyttfTPUGA5LOLaM8WOg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6147811E7B;
        Mon,  4 Dec 2023 11:31:23 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E76391C060AE;
        Mon,  4 Dec 2023 11:31:20 +0000 (UTC)
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To:     oneukum@suse.com
Cc:     davem@davemloft.net, edumazet@google.com, greg@kroah.com,
        jtornosm@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, stable@vger.kernel.org,
        stern@rowland.harvard.edu
Subject: Re: [PATCH v3] net: usb: ax88179_178a: avoid failed operations when device is disconnected
Date:   Mon,  4 Dec 2023 12:31:18 +0100
Message-ID: <20231204113119.11247-1-jtornosm@redhat.com>
In-Reply-To: <4ce32363-378c-4ea3-9a4e-d7274d4f7787@suse.com>
References: <4ce32363-378c-4ea3-9a4e-d7274d4f7787@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

> this is much better.
>> ...
> This is problematic. ndo_stop() is not limited to disconnection.
> It is also used whenever an interface transitions from up to down.
>> ...
>
> On a general note, you are going for a belt and suspenders approach.
> It seems to me that you have two options.
> 1. Do as Alan suggested and ignore ENODEV. You'd be acknowledging that
> these devices are hotpluggable and therefore -ENODEV is not an error
> 2. Use only a flag. But if you do that, you are setting it in the wrong
> place. It should be set in usbnet_disconnect()
Thank you for you help, I will do what you say.
I would like to try 2 first so that it only affects the unbind operation.
If I find any problem, I will try 1.

> O and, well, this is a very mior issue, but you've introduced a memory
> ordering issue. You ought to use smp_wmb() after setting the flag and
> smp_rmb() before reading it.
Thank you again, I'll keep that in mind

Best regards
José Ignacio

