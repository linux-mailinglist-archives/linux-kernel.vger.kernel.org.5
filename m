Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695B57ADA2D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjIYOhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjIYOh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:37:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A258AEE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695652596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tsz7HOe9ogY6gp1h+q1EOev48I4dzKMW2GN4NhayDsI=;
        b=XVhqRQEfs5jyiZzE8VKodjtkb6S7lq9jzOzgRisOkEe8uYufHU63pAnJZcYTDBVilkasZZ
        LlbfsFcbci++E99AS1+fgnIGq2UHL8IsX85STPmbcHq+HqDiPMBqqZMNuvsDNRBay8lnj4
        B2T8U5YmZ5SshNbV7UgihqO1HxhZnz4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-suMnaxO6PKiXCvJ3TLd1aA-1; Mon, 25 Sep 2023 10:36:33 -0400
X-MC-Unique: suMnaxO6PKiXCvJ3TLd1aA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC2271E441D3;
        Mon, 25 Sep 2023 14:36:32 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.192.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91A54C15BB8;
        Mon, 25 Sep 2023 14:36:30 +0000 (UTC)
Date:   Mon, 25 Sep 2023 16:36:28 +0200
From:   Philipp Rudo <prudo@redhat.com>
To:     Jan Hendrik Farr <kernel@jfarr.cc>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Dave Young <dyoung@redhat.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, tglx@linutronix.de, dhowells@redhat.com,
        vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, Baoquan He <bhe@redhat.com>,
        bhelgaas@google.com, Luca Boccassi <bluca@debian.org>,
        lennart@poettering.net, "Liu, Pingfan" <piliu@redhat.com>
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
Message-ID: <20230925163628.2c39a98e@rotkaeppchen>
In-Reply-To: <ZQtr8Y_isZP4nG96@desktop>
References: <20230911052535.335770-1-kernel@jfarr.cc>
        <20230913160045.40d377f9@rotkaeppchen>
        <63952cb0-5217-42a8-9b62-8be6d03f5844@app.fastmail.com>
        <CALu+AoTAUWWtx8yChQMKF9J5X_Qd8+x0hz0jzVwoOvAvh5VmHA@mail.gmail.com>
        <CALu+AoRiok-bzM4OQbiix44O-PUgO2N6Yi+_qTOn4iWtk_u4cg@mail.gmail.com>
        <CAMj1kXFkQ+T9OjK6NkKjfyR8gW4EZKFw5rEk0rgrzkHyK2BNXQ@mail.gmail.com>
        <ZQtr8Y_isZP4nG96@desktop>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Thu, 21 Sep 2023 00:02:25 +0200
Jan Hendrik Farr <kernel@jfarr.cc> wrote:

[...]

> > Maybe we should do a BoF at LPC to discuss this further?  
> 
> I definetly won't be at LPC, is it possible to join virtually?

Yes, LPC will be hybrid again this year. Virtual access costs $50
although you can apply for an 50% discount when you are a
non-professional.

https://lpc.events/event/17/page/212-attend

Thanks
Philipp

