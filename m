Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0537A7AF797
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 02:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjI0A7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 20:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjI0A5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 20:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C35083F1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 17:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695773687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MwEDd7lXj2bXGV+so2/RWLmuszrHLj3xfaoIMd/pJXo=;
        b=OJMjLJNdycffdWEmYSEOl7hyqTC5sC3HOkdYnKX7HOvxmSE3WN64KtXcyBtzxQ3fXYQqFf
        UpEicSQLdQAM+fFfH7HKcap10KDbFZJJo5jU9/Z1aGdDYm/Msg7shWe5DLdzxkkYo8rmqA
        l87bHG6rsfiIBGg0aiLFpg/1bJlsWNg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-oDALSo7ZOnaxTmKVT_hOCQ-1; Tue, 26 Sep 2023 20:14:45 -0400
X-MC-Unique: oDALSo7ZOnaxTmKVT_hOCQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1836485A5BE;
        Wed, 27 Sep 2023 00:14:45 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 567262026D4B;
        Wed, 27 Sep 2023 00:14:44 +0000 (UTC)
Date:   Wed, 27 Sep 2023 08:14:41 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        vschneid@redhat.com, sourabhjain@linux.ibm.com
Subject: Re: [PATCH v3] Crash: add lock to serialize crash hotplug handling
Message-ID: <ZRNz8T1XOX7PWOt6@MiWiFi-R3L-srv>
References: <20230926120905.392903-1-bhe@redhat.com>
 <20230926135001.4eb6ca73b1a4aa6224355ad1@linux-foundation.org>
 <11bebd5e-8183-d7a7-6acc-53b00a6cc2d5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11bebd5e-8183-d7a7-6acc-53b00a6cc2d5@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26/23 at 04:53pm, Eric DeVolder wrote:
> 
> 
> On 9/26/23 15:50, Andrew Morton wrote:
> > On Tue, 26 Sep 2023 20:09:05 +0800 Baoquan He <bhe@redhat.com> wrote:
> > 
> > > Eric reported that handling corresponding crash hotplug event can be
> > > failed easily when many memory hotplug event are notified in a short
> > > period. They failed because failing to take __kexec_lock.
> > 
> > I'm assuming that this failure is sufficiently likely so as to  justify a -stable
> > backport of the fix.   Please let me know if this is incorrect.
> 
> Andrew,
> Correct, this is sufficiently likely to happen.

Agree. Maybe a Fixes tag need be added:
===
Fixes: 247262756121 ("crash: add generic infrastructure for crash hotplug support")

