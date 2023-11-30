Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE1D7FEB04
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjK3ImN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3ImM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:42:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003EFB2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701333738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uTY8JL51negu1oTXaU6QSo32AKHRaSyM59v8HnADJ4Q=;
        b=MFHWq3oBbjs+nSrDxR/msuyLmFeN+FGtL/XimooT8kUEUy4QvanEWr7LMSgJRH4aP55WpK
        bkHmPbV/5of/bkourANx0kUtOS68JsijWcVBF5n0EU8eI4iG7CUI/MprRMIGp69mPiEju+
        VHYrHl2oOcDi7EQf+83tFAfPzNayRtk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-YQMyGeimOFeWdGrtcbCGkA-1; Thu,
 30 Nov 2023 03:42:12 -0500
X-MC-Unique: YQMyGeimOFeWdGrtcbCGkA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6BB03C0C48C;
        Thu, 30 Nov 2023 08:42:11 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7927C36E2;
        Thu, 30 Nov 2023 08:41:37 +0000 (UTC)
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To:     stern@rowland.harvard.edu, oneukum@suse.com
Cc:     davem@davemloft.net, edumazet@google.com, jtornosm@redhat.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com
Subject: Re: [PATCH] net: usb: ax88179_178a: avoid failed operations when device is disconnected
Date:   Thu, 30 Nov 2023 09:41:36 +0100
Message-ID: <20231130084136.172052-1-jtornosm@redhat.com>
In-Reply-To: <51cb747a-21fe-4b3b-9567-01b9cc9d8873@rowland.harvard.edu>
References: <51cb747a-21fe-4b3b-9567-01b9cc9d8873@rowland.harvard.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

> I am sorry, but this is a layering violation. You are looking
> at an internal state of the USB layer to surpress logging
> -ENODEV. If you think these messages should go away, filter
> for ENODEV where they are generated.
Thank you for your comments and suggestion.
My intention was also to avoid unnecessary and failed operations 
if disconnection was detected.
Ok, let me research more and do better.

Hi Alan,

> In addition, you should be more careful about the distinction between 
> "unbound" and "disconnected".  It's possible for the driver to be 
> unbound from the device even while the device is still plugged in.  In 
> this situation, submitting URBs will fail with an error even though the 
> device state isn't USB_STATE_NOTATTACHED.
Thank you for you comments.
I also tested "unbound" and stop and unbind operations were correctly 
executed. I just wanted to avoid the issues during disconnection, if other 
operations are commanded later I think it is better to warn.
Ok, I will try to do better.

Best regards
Jose Ignacio

