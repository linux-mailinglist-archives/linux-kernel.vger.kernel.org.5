Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3060794615
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 00:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245029AbjIFWSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 18:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244890AbjIFWSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 18:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134D519BD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 15:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694038646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/UCYibyps03BeaD/1Nk79xBgk22JsdCefm9WuOhC/s=;
        b=KNCauIIUnNwa+z224tk87//DJgdyA4c5MR2SACxsO5ka2M5enI4tSZ6qB3yG3eNATPU5wN
        4H7b+xxZ5iLnIN3CzkQdzETeySYBiMia2RJQjM+ID3cIoZk94vuFBrkCS7q8HohS8MdvxR
        nenf+1ghQ4VOvpSN8TVl8WtahsoIJYo=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-TjTMhtdZMP26LzL8tmPJoA-1; Wed, 06 Sep 2023 18:17:24 -0400
X-MC-Unique: TjTMhtdZMP26LzL8tmPJoA-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-44d4361ce28so115326137.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 15:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694038644; x=1694643444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/UCYibyps03BeaD/1Nk79xBgk22JsdCefm9WuOhC/s=;
        b=TCNrF5If0/3sZ+e0jxGZHMaix1V11hslmYGWSd5F+iQ45Ht78MHAqol72uTuoW7c9h
         i/FX6wggUM8rgXxOGd4nCuWKwZnsi7NQqG2d2zeOQoNvMHO/poeUQI70c/o+vt9P9jTI
         vYYfV/MPeZwfYi4ziePvav2qJ3kAQz0OmQVKgIYufE6v+IsSalti3SZMeC70QRhoc9AU
         vDQ1El9HSjCGeQWi2KxIeO1Kmtp8cuGEnXGLotxq8Ooly+wRCKdkwTtMR4LHjHKMtlQG
         fxE229KZWE1tR3dXprmMJ+PIPmApX8jIUMpWRUJGQR4622TLqsLidGLtTz2Hf1DxsIbn
         rFDA==
X-Gm-Message-State: AOJu0YwIFQ5f9K1OJYMSenbK66B3aEfL7+cG5PDw1/Te7cC3qKJ5BtBC
        E0kvh2M/u32C3X+ezJ1NwF1K51UCIyH6ku2RjpesdoewIZuVFUeq4EzIfpn/Rkn3dsMV8WPkU/A
        12VRFRHtDVYGgzwFJbEuhXLZJ8/3vItlO5eP9Grcx
X-Received: by 2002:a67:f887:0:b0:44d:e70d:8a4b with SMTP id h7-20020a67f887000000b0044de70d8a4bmr4566486vso.8.1694038644369;
        Wed, 06 Sep 2023 15:17:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9bTrQsgAOigUVQNMSsTnCiw0gqhTSfkFbFpj/VTRj0g7Zbje3/rR2Wvm0S7hHF5lw776crY2rRCp8ybteIqY=
X-Received: by 2002:a67:f887:0:b0:44d:e70d:8a4b with SMTP id
 h7-20020a67f887000000b0044de70d8a4bmr4566473vso.8.1694038644156; Wed, 06 Sep
 2023 15:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230808085056.14644-1-yan.y.zhao@intel.com> <ZN0S28lkbo6+D7aF@google.com>
 <ZN1jBFBH4C2bFjzZ@yzhao56-desk.sh.intel.com> <ZN5elYQ5szQndN8n@google.com>
 <ZN9FQf343+kt1YsX@yzhao56-desk.sh.intel.com> <ZPWBM5DDC6MKINUe@yzhao56-desk.sh.intel.com>
 <ZPeND9WFHR2Xx8BM@google.com>
In-Reply-To: <ZPeND9WFHR2Xx8BM@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu, 7 Sep 2023 00:17:12 +0200
Message-ID: <CABgObfZ7MRShYm79NsH2=WwvTAcaoz5jUSBxPb57KEhotcr_oA@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM: x86/mmu: .change_pte() optimization in TDP MMU
To:     Sean Christopherson <seanjc@google.com>
Cc:     Yan Zhao <yan.y.zhao@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 10:18=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> Ooh, actually, maybe we could do
>
>         static bool <name_tbd> =3D !IS_ENABLED(CONFIG_KSM);
>
> and then cross our fingers that that doesn't regress some other funky set=
ups.

It probably breaks gvisor-like setups that use MAP_PRIVATE mmap for
memslots? It would instantly break CoW even if memory is never
written.

Paolo

