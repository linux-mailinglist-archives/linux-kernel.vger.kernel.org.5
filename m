Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B2E76BE74
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjHAU1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjHAU1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:27:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF81E2683
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 13:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690921605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wy2TkA8uXc4KqWHCSUGw2dDqfqA9SqU7ECQFvC91hnU=;
        b=cH4PSjoSw7OFn3ihTRPkTVB9wQjjQztC8DeN8IMQtTg7zuU4jE+al2HnR0HfQ0YxV4Sof8
        C4+1pvsc2+JOUCiSSPVI8pXmHKQswOpbB4RBhnBNIzsLi7IgF8Y4884QV33lDLmbOhf2vp
        Z3H6TTZtv+tqnuWa/DBHW3ywfWQnq+E=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-Utr-QiHnNuWzlcHMCTsJrQ-1; Tue, 01 Aug 2023 16:26:44 -0400
X-MC-Unique: Utr-QiHnNuWzlcHMCTsJrQ-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-34908ea9bf8so34853865ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 13:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690921604; x=1691526404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wy2TkA8uXc4KqWHCSUGw2dDqfqA9SqU7ECQFvC91hnU=;
        b=Xl+Fm936mD747RYg0du6GUJ14PT/OJKCGbNBhT1cel8MW8nJnPwH5ArRprnnDvTb0p
         /SxoQW+yyJMRjK5TZ2FxGqOFXcJCts8uI+qJUFhRY4cARFxcVmzEx1CLwhSZfdAoHFfV
         zBX2zhirWdGYWqSiWZ9yuGCQDHVj5pu344HXLTsdDfCRiH8lSHLBhDrTRLjdW09fH5Ag
         tbbftmGaId/iguTtL+z/zIyUbLtKsRz8I1iLXYlwWRyXfaJrnlggb/ZmFiuZPRtemH9H
         fhf7UVhNtbVR3NJWi0fs3JCrQ4tY5W4PUvLx5rbKY/8FwEcfgBbjcrQ9+Wqs8s3GtkTT
         H4mw==
X-Gm-Message-State: ABy/qLY1JGhYXGd9IertkPVnV8XaALLx8PktifZBF5jh5mWBHXNpiPuF
        KwelYb7y2qKeI4vSSgbFXzy8+RjhtJiKcjAShgmU6N4fou6VFxcnykTwnU4Vd1nSGlMBiDlqIIb
        dH+fUZjCCqJbXmRQd4ziI32rx
X-Received: by 2002:a05:6e02:1142:b0:348:b114:a3d2 with SMTP id o2-20020a056e02114200b00348b114a3d2mr10362596ill.21.1690921604041;
        Tue, 01 Aug 2023 13:26:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEbGknYdks2X0/d/P9ZjLKRglWMfz6zhjFdkrvnM7ln7ilY6KAPsrDg/JLdp7L+95yKWi2IeA==
X-Received: by 2002:a05:6e02:1142:b0:348:b114:a3d2 with SMTP id o2-20020a056e02114200b00348b114a3d2mr10362588ill.21.1690921603816;
        Tue, 01 Aug 2023 13:26:43 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id gs14-20020a0566382d8e00b0042b61a5087csm3838753jab.132.2023.08.01.13.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 13:26:43 -0700 (PDT)
Date:   Tue, 1 Aug 2023 14:26:42 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: eventfd: fix NULL deref irqbypass producer
Message-ID: <20230801142642.1f73ca45.alex.williamson@redhat.com>
In-Reply-To: <20230801085408.69597-1-likexu@tencent.com>
References: <20230801085408.69597-1-likexu@tencent.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  1 Aug 2023 16:54:08 +0800
Like Xu <like.xu.linux@gmail.com> wrote:

> From: Like Xu <likexu@tencent.com>
> 
> Adding guard logic to make irq_bypass_register/unregister_producer()
> looks for the producer entry based on producer pointer itself instead
> of pure token matching.
> 
> As was attempted commit 4f3dbdf47e15 ("KVM: eventfd: fix NULL deref
> irqbypass consumer"), two different producers may occasionally have two
> identical eventfd's. In this case, the later producer may unregister
> the previous one after the registration fails (since they share the same
> token), then NULL deref incurres in the path of deleting producer from
> the producers list.
> 
> Registration should also fail if a registered producer changes its
> token and registers again via the same producer pointer.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  virt/lib/irqbypass.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


> 
> diff --git a/virt/lib/irqbypass.c b/virt/lib/irqbypass.c
> index 28fda42e471b..e0aabbbf27ec 100644
> --- a/virt/lib/irqbypass.c
> +++ b/virt/lib/irqbypass.c
> @@ -98,7 +98,7 @@ int irq_bypass_register_producer(struct irq_bypass_producer *producer)
>  	mutex_lock(&lock);
>  
>  	list_for_each_entry(tmp, &producers, node) {
> -		if (tmp->token == producer->token) {
> +		if (tmp->token == producer->token || tmp == producer) {
>  			ret = -EBUSY;
>  			goto out_err;
>  		}
> @@ -148,7 +148,7 @@ void irq_bypass_unregister_producer(struct irq_bypass_producer *producer)
>  	mutex_lock(&lock);
>  
>  	list_for_each_entry(tmp, &producers, node) {
> -		if (tmp->token != producer->token)
> +		if (tmp != producer)
>  			continue;
>  
>  		list_for_each_entry(consumer, &consumers, node) {
> 
> base-commit: 5a7591176c47cce363c1eed704241e5d1c42c5a6

