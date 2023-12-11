Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF1280D09D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344317AbjLKQI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344283AbjLKQIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:08:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E96AD47
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3N5lAcUtexjyMcZlcm6EHnULS8QX5mhHesaKgXo2cQ8=;
        b=e+250S2gim1hWNVz5g/0n5GhIOZVLet4N+mad2eTKU3l5jNMMTeheJzFbxDh0S8Ljo3VHA
        f8x51hlk2gUF6m88GUiLsL+39uMi6fNLnDKf3a3V6IsQI/txUz6zB8JVIThInsYZYnivNb
        NqNum0EyTcTqAGdmgPb68EZALiztDEk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-8HARSt6fPyuVTlUUwkwSwA-1; Mon, 11 Dec 2023 11:08:50 -0500
X-MC-Unique: 8HARSt6fPyuVTlUUwkwSwA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-28678d625d8so2801099a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:08:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702310929; x=1702915729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3N5lAcUtexjyMcZlcm6EHnULS8QX5mhHesaKgXo2cQ8=;
        b=ATrpv3LbbJ47EwvSwt9n6aG/WvL6mQqimqxvcznAUYpWmVEmGELNiZyBiO3pSUXwOd
         MVLyZKiI337b7ay64US9299GxHl58nyk5CxY0D17IIyu4XgLsxPW8k88JWx15AMmM0ic
         0q5xl3L2RlY7JXeY4e2sJCN6256ZNckpPRHbdjDDQcLM/BIxnzCyor8tt0Y0NkZ527SC
         M7JDv79PswX0cH9/OaUWmWRJm3TiksxCBM5VcEXhlDNkBO4UKuK5rzax9iJEx/MjVzca
         tHlzrcHhpmetVM6vm588lcpsnxSVh8ackJGkO5GQ0S6kymYRo7z3nE3SBZUtG1A/9WyT
         6jxQ==
X-Gm-Message-State: AOJu0YzbVVMqJvU1CkJ8j3ziF35YrNRNLLm2NQzee7KzF9CHmnffosyM
        tbHZFrnJWCSzZfAxUEuOg1VbOV0/jlS3H7vyCQ28lwzLWfZsW+/rWRYcvDVBzLee7Onxh1txc9k
        vgVNwucmG1eZ7ssLaHVbZXJoGBAYY8o8GS4/airPJ
X-Received: by 2002:a17:90a:985:b0:286:6cc1:5fdf with SMTP id 5-20020a17090a098500b002866cc15fdfmr1769261pjo.98.1702310928951;
        Mon, 11 Dec 2023 08:08:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiUz1pxdLFncKj4z/9C3dpC7nihMurmeWObLH6KY07S0ymlRGydDN9nLTR/0Q/a+Bu0oVkO47ole5oNQm76QA=
X-Received: by 2002:a17:90a:985:b0:286:6cc1:5fdf with SMTP id
 5-20020a17090a098500b002866cc15fdfmr1769249pjo.98.1702310928623; Mon, 11 Dec
 2023 08:08:48 -0800 (PST)
MIME-Version: 1.0
References: <20231211131051.1500834-1-neelx@redhat.com> <20231211132217.GF4870@unreal>
 <20231211132522.GY1489931@ziepe.ca> <CACjP9X8+CgoQRjs2Y9A+OwWCVxMhKyqzLhEjaguxMavHsy8VRg@mail.gmail.com>
 <20231211152547.GC1489931@ziepe.ca>
In-Reply-To: <20231211152547.GC1489931@ziepe.ca>
From:   Daniel Vacek <neelx@redhat.com>
Date:   Mon, 11 Dec 2023 17:08:12 +0100
Message-ID: <CACjP9X-Oj2DFKY0bopMGTEAr1bShM4E+6TtskA+8Ym-bnAfnQA@mail.gmail.com>
Subject: Re: [PATCH] IB/ipoib: No need to hold the lock while printing the warning
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 4:27=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Mon, Dec 11, 2023 at 03:09:13PM +0100, Daniel Vacek wrote:
> > On Mon, Dec 11, 2023 at 2:25=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> > >
> > > On Mon, Dec 11, 2023 at 03:22:17PM +0200, Leon Romanovsky wrote:
> > >
> > > > Please fill some text in commit message.
> > >
> > > Yes, explain *why* you are doing this
> >
> > Oh, sorry. I did not mention it but there's no particular reason
> > really. The @Subject says it all. There should be no logical or
> > functional change other than reducing the span of that critical
> > section. In other words, just nitpicking, not a big deal.
> >
> > While checking the code (and past changes) related to the other issue
> > I also sent today I just noticed the way 08bc327629cbd added the
> > spin_lock before returning from this function and it appeared to me
> > it's clearer the way I'm proposing here.
> >
> > Honestly, I was not looking into why the lock is released for that
> > completion. And I'm not changing that logic.
> >
> > If this complete() can be called with priv->lock held, the cleanup
> > would look different, of course.
>
> complete() can be called under spinlocks just fine, AFAIK..

Yup, agreed. We ended up removing the lock completely in this function
with the other patch. This patch can be discarded.

--nX

> Jason
>

