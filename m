Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5117FC20A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345269AbjK1ROu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjK1ROs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:14:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002BB10EC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701191693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gtaSo1ub4uORnqknoH16PJEFq9uekg4hoFlfPiGwcdU=;
        b=fVVUiW8FP4DnZ8v8CBmhM9525r8tcftgC8Y9VWdQJRNSc/MroRagZd7N/4bYkmchh8bBg3
        Y++JZnuAS7Wu4A5BU3dgAvCZeFk7QSmCTr2kUD2LpKvTBhManJ7KwhvgSAswDKfGOoQu5+
        VRmyThl2uuzkMAlYXECBIIJC3Pvj8Ug=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-pH4oR8HDOtSwq0ac3iOaDw-1; Tue, 28 Nov 2023 12:14:50 -0500
X-MC-Unique: pH4oR8HDOtSwq0ac3iOaDw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b393151d4bso321561239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:14:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701191690; x=1701796490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtaSo1ub4uORnqknoH16PJEFq9uekg4hoFlfPiGwcdU=;
        b=Fr5HIqC13Ge2QgkZo4s6bNB9sHBa2nQCCQlUAb8Tssl6R4sx7wOxslwPHSqo4//3Gi
         H6gbyb91gHvLBbBtfm1fxO+MzL7GXXI0I+ZlFYS7ImrmBWlzK7wSVsxUgJwD32nouuG0
         1ZcmoU3cj695cEvhprARs6S6YI4tcniOqmJMqEYRP/m/d7uJi3yOMDC76rl1+/8+L11E
         AnEww11Dj6sEwI0hKmDbkl7cl77o0jcFGWhkxrbX5Qkygm6qTC1XDsADtj/DPvSk91zl
         x1QMjAZOaT264rJI7cjOJNRqBML+8DUoXlPCwP0GmCFMj2vRGxW9IJY14ryL/BVu9uWD
         T8qw==
X-Gm-Message-State: AOJu0Yz8dEUwQY0Lxi/u0h9c9FsbI3ACW/v+n0rbaFWWqw8OCNjrm6Xx
        tmHhIUh82BJuEfTcYGvcfAJFmMmgSuQuKWl1HgTsygvkemawyU8U02J4R53M+PQmHPq2sj8ofp8
        jd2Nf3ZMrrFtmVDBt5cLSHnXJ
X-Received: by 2002:a05:6602:131e:b0:7b0:2037:68f3 with SMTP id h30-20020a056602131e00b007b0203768f3mr15000355iov.13.1701191689953;
        Tue, 28 Nov 2023 09:14:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFD6oEwpFjpUyHT/D0OGCBMhCVi5mSaIjGthKIjs5b6xAvuny8q9LhuouQv4++AjP9LEwy0Kw==
X-Received: by 2002:a05:6602:131e:b0:7b0:2037:68f3 with SMTP id h30-20020a056602131e00b007b0203768f3mr15000328iov.13.1701191689657;
        Tue, 28 Nov 2023 09:14:49 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id ep10-20020a0566384e0a00b00459949acd10sm2956452jab.39.2023.11.28.09.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:14:49 -0800 (PST)
Date:   Tue, 28 Nov 2023 10:14:47 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kernel test robot <lkp@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: arch/powerpc/kvm/../../../virt/kvm/vfio.c:89:7: warning:
 attribute declaration must precede definition
Message-ID: <20231128101447.2739afa9.alex.williamson@redhat.com>
In-Reply-To: <20231128124538.GO436702@nvidia.com>
References: <202311280814.KwQVhwqI-lkp@intel.com>
        <20231128124538.GO436702@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 08:45:38 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Nov 28, 2023 at 11:01:45AM +0800, kernel test robot wrote:
> > Hi Yi,
> > 
> > FYI, the error/warning still remains.  
> 
> The patch is still here:
> 
> https://lore.kernel.org/r/0-v1-08396538817d+13c5-vfio_kvm_kconfig_jgg@nvidia.com
> 
> Alex? Maybe you should send it to -rc now?

Looks like this was originally targeted going through KVM.  I'm
intending to do a v6.7-rc pull anyway and it's relevant to vfio, so I
don't mind including it, but I think we need an ack from Paolo.

Paolo?

Thanks,
Alex

