Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD6E7C41E1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjJJUtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjJJUtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:49:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0B68E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696970929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yoQjAPTcURxXWCLx6cqE+U+V9keOCLrJtF/2g/D8fIM=;
        b=hmpETmfs/l5+G44flwZrFckDx3GBH7mrDSAWtFuflj6v6ZYVh1mSUgg01E66Gfj1D0RdaB
        e0hEIEnRM+kK8nsfIL4J46JkyPyelgOY0SsFqkOR5FFhV0ZnfoGTVogVHRm9TS3qr+9z8+
        VE5MCxP3S2czCFid0CV3/ftHsS+Tvrw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-u5cxa_ZFOWmlU4qTrbY4AQ-1; Tue, 10 Oct 2023 16:48:37 -0400
X-MC-Unique: u5cxa_ZFOWmlU4qTrbY4AQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-65b13c48253so72793206d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970917; x=1697575717;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yoQjAPTcURxXWCLx6cqE+U+V9keOCLrJtF/2g/D8fIM=;
        b=GMwUbvVAy2ePO0duyjZhmMaFfxx+/2bBiYuYd/hH5SNyLnRZkCS96fjDzeVjMMABR/
         eLRkMR5GYHnuCrvmfo/1iCbXqYkAEMZyW8kn2cV/XWPb0yKIp+4NN7PMJ7Ra33T3ph58
         +ttfIwyoF5pc7iIBcYE+svZaFG9jxZtg2DTQY5vJH+UKVpp+mSN+FS3i+ZKZU6mgQYv9
         0iiJkhTdxnR1ONhNO/badLShHncOzSNQrXbfUlXxOwokkHZxjPOeunW2jFP6iZzt5bgR
         pVULm2nFXu14hKz8oAzHk2/f7bl5WtqzLmL0pLX9qeD4hbcQCKP/1Zw507Rno00M/3ej
         viww==
X-Gm-Message-State: AOJu0YzT5PWDps6zd+atX86m+zGEw7boZiuJvsAfI1ow1qLGLI5ekbQS
        j1QKM4sFl21FVd40adSR434JN/Ou8MH9pYG/12ncvOIPl1qFvKf9LU6i3Pcq2H2RhhzluNzdG5R
        dr9gosyMPyHMuFmf5nisKk2BI
X-Received: by 2002:ad4:46d0:0:b0:656:1c7b:5aa1 with SMTP id pm16-20020ad446d0000000b006561c7b5aa1mr18524662qvb.29.1696970917428;
        Tue, 10 Oct 2023 13:48:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh9fdgIdcyHl+Ds+CZNks3ocIk3vlVgDJQEvA54F6Sw8y4U793WZu1hsWDa/2UFNDTzyMSYA==
X-Received: by 2002:ad4:46d0:0:b0:656:1c7b:5aa1 with SMTP id pm16-20020ad446d0000000b006561c7b5aa1mr18524636qvb.29.1696970917066;
        Tue, 10 Oct 2023 13:48:37 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id c3-20020a0cfb03000000b0066cee934ae2sm1022196qvp.56.2023.10.10.13.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:48:36 -0700 (PDT)
Date:   Tue, 10 Oct 2023 15:48:34 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 04/15] firmware: qcom: add a dedicated TrustZone
 buffer allocator
Message-ID: <pmmetoy5pb6khrjzsg6cd565cw3eowvs5i67465ne4xlqkrqgk@befdv3vfran3>
References: <20231009153427.20951-1-brgl@bgdev.pl>
 <20231009153427.20951-5-brgl@bgdev.pl>
 <f6jspdoeyv6ntcrl6qndy2ud3mcdkoxxcnzqm3qpbtcd3ztdpi@7iw5f5og7is2>
 <CAMRc=MchBQrpSqHHs-cD0RmOdSoKt2SLd76a97E8mSmHYGUCUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MchBQrpSqHHs-cD0RmOdSoKt2SLd76a97E8mSmHYGUCUg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:26:34AM +0200, Bartosz Golaszewski wrote:
> On Mon, Oct 9, 2023 at 11:28 PM Andrew Halaney <ahalaney@redhat.com> wrote:
> >
> > On Mon, Oct 09, 2023 at 05:34:16PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > We have several SCM calls that require passing buffers to the TrustZone
> > > on top of the SMC core which allocates memory for calls that require
> > > more than 4 arguments.
> > >
> > > Currently every user does their own thing which leads to code
> > > duplication. Many users call dma_alloc_coherent() for every call which
> > > is terribly unperformant (speed- and size-wise).
> > >
> > > Provide a set of library functions for creating and managing pool of
> > > memory which is suitable for sharing with the TrustZone, that is:
> > > page-aligned, contiguous and non-cachable as well as provides a way of
> > > mapping of kernel virtual addresses to physical space.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> 
> [snip]
> 
> >
> > I got these warnings with this series:
> >
> >     ahalaney@fedora ~/git/linux-next (git)-[7204cc6c3d73] % ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make W=1 C=2 drivers/firmware/qcom/
> >     drivers/firmware/qcom/qcom_tzmem.c:137: warning: Function parameter or member 'size' not described in 'qcom_tzmem_pool_new'
> >       CHECK   drivers/firmware/qcom/qcom_tzmem.c
> >     drivers/firmware/qcom/qcom_tzmem.c:204:17: warning: incorrect type in assignment (different address spaces)
> >     drivers/firmware/qcom/qcom_tzmem.c:204:17:    expected void **slot
> >     drivers/firmware/qcom/qcom_tzmem.c:204:17:    got void [noderef] __rcu **
> >     drivers/firmware/qcom/qcom_tzmem.c:204:17: warning: incorrect type in assignment (different address spaces)
> >     drivers/firmware/qcom/qcom_tzmem.c:204:17:    expected void **slot
> >     drivers/firmware/qcom/qcom_tzmem.c:204:17:    got void [noderef] __rcu **
> >     drivers/firmware/qcom/qcom_tzmem.c:204:17: warning: incorrect type in argument 1 (different address spaces)
> >     drivers/firmware/qcom/qcom_tzmem.c:204:17:    expected void [noderef] __rcu **slot
> >     drivers/firmware/qcom/qcom_tzmem.c:204:17:    got void **slot
> >     drivers/firmware/qcom/qcom_tzmem.c:204:17: warning: incorrect type in assignment (different address spaces)
> >     drivers/firmware/qcom/qcom_tzmem.c:204:17:    expected void **slot
> >     drivers/firmware/qcom/qcom_tzmem.c:204:17:    got void [noderef] __rcu **
> >     drivers/firmware/qcom/qcom_tzmem.c:339:13: warning: context imbalance in 'qcom_tzmem_to_phys' - wrong count at exit
> 
> I fixed the other ones but this one I think comes from CHECK not
> dealing correctly with the spinlock guard.
> 
> >
> >
> > All are confusing me, size seems described, I don't know much about
> > radix tree usage / rcu, and the locking in qcom_tzmem_to_phys seems sane
> > to me but I'm still grappling with the new syntax.
> >
> > For the one address space one, I _think_ maybe a diff like this is in
> > order?
> >
> >     diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
> >     index b3137844fe43..5b409615198d 100644
> >     --- a/drivers/firmware/qcom/qcom_tzmem.c
> >     +++ b/drivers/firmware/qcom/qcom_tzmem.c
> >     @@ -193,7 +193,7 @@ void qcom_tzmem_pool_free(struct qcom_tzmem_pool *pool)
> >             struct qcom_tzmem_chunk *chunk;
> >             struct radix_tree_iter iter;
> >             bool non_empty = false;
> >     -       void **slot;
> >     +       void __rcu **slot;
> >
> >             if (!pool)
> >                     return;
> >     @@ -202,7 +202,7 @@ void qcom_tzmem_pool_free(struct qcom_tzmem_pool *pool)
> >
> >             scoped_guard(spinlock_irqsave, &qcom_tzmem_chunks_lock) {
> >                     radix_tree_for_each_slot(slot, &qcom_tzmem_chunks, &iter, 0) {
> >     -                       chunk = *slot;
> >     +                       chunk = radix_tree_deref_slot_protected(slot, &qcom_tzmem_chunks_lock);
> 
> We need to keep the lock taken for the duration of the looping so we
> can use the regular radix_tree_deref_slot().

IIUC, using the protected version is preferable since you already
have the lock in hand: https://www.kernel.org/doc/html/latest/RCU/whatisRCU.html#id2

Quote:
    The variant rcu_dereference_protected() can be used outside of an RCU
    read-side critical section as long as the usage is protected by locks
    acquired by the update-side code. This variant avoids the lockdep warning
    that would happen when using (for example) rcu_dereference() without
    rcu_read_lock() protection. Using rcu_dereference_protected() also has
    the advantage of permitting compiler optimizations that rcu_dereference()
    must prohibit. The rcu_dereference_protected() variant takes a lockdep
    expression to indicate which locks must be acquired by the caller.
    If the indicated protection is not provided, a lockdep splat is emitted.

Thanks,
Andrew


> 
> Bart
> 
> >
> >                             if (chunk->owner == pool)
> >                                     non_empty = true;
> >
> >
> > Still planning on reviewing/testing the rest, but got tripped up there
> > so thought I'd highlight it before doing the rest.
> >
> > Thanks,
> > Andrew
> >
> 

