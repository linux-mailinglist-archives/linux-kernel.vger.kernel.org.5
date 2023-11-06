Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5069A7E1D60
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjKFJmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjKFJmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:42:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36888DB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 01:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699263675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TEnutY17THkNaRY6NyZN3UsULbbbbRlsmNLZIgvxSu4=;
        b=ezZKwxGOgVHO9G0wISLyP20q/lGtJP/lFFy2tbHzUcOWCynICJ5BOHk+rC+v2e4cFgQ/0o
        PoLzkfCmVOvnP0JsIKW8JTZHlmVgD/XFSDF58fqXhtxZLoQQciNS+JAu95mMPU4Xn0wisO
        wYWffCN+YDXW8xy0ivp9zIYXkWKpQtE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-0Kr49iQSOhK8MibcEAnHpQ-1; Mon, 06 Nov 2023 04:41:13 -0500
X-MC-Unique: 0Kr49iQSOhK8MibcEAnHpQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-280997b23eeso3132010a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 01:41:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699263673; x=1699868473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEnutY17THkNaRY6NyZN3UsULbbbbRlsmNLZIgvxSu4=;
        b=ZugNZLC8HmMb+DgD+fUtbSL2izcbuHLYLkvEEWUlGqm7gKZmm7y+WdkmtJEb9kLU6S
         3IjAbz6C7qGu79i5ZguOJE9+WdW0obfyihYdMTjZbZBiIAu2Ni5tV/lwsvi3DK2s0XNu
         gdvTc5i8CEqp5ygX8WyVGYfLaAmiOrn2TTp4wzKmNQ+NDitixpa0TGZ9/RSAXFt4EAVu
         /xMDL1wsvTW+KrfGjE0rzblUYpz3ezwwABYlXtpjiPzZheXj3+a0eb6z4HgE8ZMTLSvU
         INAZoUQtKAqqmC4JyAtAd9zqzFtJfhJnGOyH9NmOwIoho6WXWuMkNnsbauTgZf9aDiki
         asVw==
X-Gm-Message-State: AOJu0YwkKdeF95GtjZx8swGBEAEA4e4ogQD6TFdPwWCDdLhgpGrEfga3
        Tx830UjRGTheOmr8ivNFuc5JQm6WtrPGQ4qSIBZVhGMB7maS6VqHECT4b7IhCgam/Z/Z8G+LGeK
        5fTi4o2PILofvNCedTKfWXRuMU3ZoE8y7vR1kEZ2f
X-Received: by 2002:a17:90b:3597:b0:27d:46e5:2d7c with SMTP id mm23-20020a17090b359700b0027d46e52d7cmr22120468pjb.26.1699263672818;
        Mon, 06 Nov 2023 01:41:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7AXFsZWATs/ZDYo1pTq6d/V+4GcyoNQCcNk+T1vx/PA1ZFED+fVNGEHrg/3IKAo0x8iisobaPTdH8HoGKbms=
X-Received: by 2002:a17:90b:3597:b0:27d:46e5:2d7c with SMTP id
 mm23-20020a17090b359700b0027d46e52d7cmr22120455pjb.26.1699263672500; Mon, 06
 Nov 2023 01:41:12 -0800 (PST)
MIME-Version: 1.0
References: <20231103173947.GA2059@templeofstupid.com>
In-Reply-To: <20231103173947.GA2059@templeofstupid.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 6 Nov 2023 10:41:01 +0100
Message-ID: <CAOssrKevJL_mBsAuEMFV=J0C9WgRGdZx+jBMTqMjdZ21aePNZQ@mail.gmail.com>
Subject: Re: [resend PATCH v4] fuse: share lookup state between submount and
 its parent
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 6:39=E2=80=AFPM Krister Johansen <kjlx@templeofstupi=
d.com> wrote:
>
> Fuse submounts do not perform a lookup for the nodeid that they inherit
> from their parent.  Instead, the code decrements the nlookup on the
> submount's fuse_inode when it is instantiated, and no forget is
> performed when a submount root is evicted.

Applied, thanks.

Miklos

