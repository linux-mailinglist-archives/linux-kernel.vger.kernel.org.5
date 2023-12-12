Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D864080F223
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjLLQPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjLLQPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:15:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C712DC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702397709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2Jz0Vih/peGcNEFAH1I/vwL9Zvjs9OTM4jvQXkmuKw=;
        b=fFO16y9F2qN2JUXzDAZoz9j0yEJeQmSPdOnBRYWkRHbTKtJaVyJWY+AmLwRuQt/UuQYeg1
        hTPYxllOoh5ftkW9e0nEfd6mVN4BVDHxMgRTnwB0iz9eFDQeiqaM7Z3YZa6juEkGvGRkmG
        3lvvi8Q/KmuhL/LlgQkPpGaKl//m3RY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-HsGHzzOBN6aczCVwNBJRAQ-1; Tue, 12 Dec 2023 11:15:07 -0500
X-MC-Unique: HsGHzzOBN6aczCVwNBJRAQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3363101652bso395868f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:15:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397706; x=1703002506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q2Jz0Vih/peGcNEFAH1I/vwL9Zvjs9OTM4jvQXkmuKw=;
        b=DGP2A2gXxaX8WC4fGIUjiTrQ1bR7mwtNpIgtCDBo2DtYNPIj2W1bgSMzSzDtLjUo0F
         YVgyslNtqGPgJij7+Qj6Gt5C3T8np7wxlpnN4KIvkC89QJ8SPFbvI9mtdjOvOZrPfKqd
         FommyA9IPPvuOPiXM8xP4vi3HAb6xUcJGXPSGIDkRtIbs/Sr+PRORHN7g0DREkxYTDzH
         rJOdQufIH2j1s2f+Jpv2dv/J1F+9MoxhlwxV2b2ecQGsPMulHUFBLnYxWTOXxDDvaiBj
         F9WmJWUDPs1V0U6f4QvWdTnDimisMPGGH2dAesMLTeFmn5RGIHqS7A2Y9R3GRHVc7iJ8
         Bczg==
X-Gm-Message-State: AOJu0Yz7ep4qCogG4aNTzmqmvb3bCUoofL7oCO+OawGk/2ew4imBMEYL
        36kdah1PIBxTDv+k75pSocuvIfHY0eo/UpZZPfPhHn0kbQa4rcQiE5cWZ03imM+eAk1Maq+LpZO
        z1hHC/ZjAeIFhtut+DMLbp6JJ
X-Received: by 2002:a05:600c:4fd3:b0:40b:5e56:7b44 with SMTP id o19-20020a05600c4fd300b0040b5e567b44mr3106311wmq.141.1702397706193;
        Tue, 12 Dec 2023 08:15:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfYaO9aerEATODsvvXvfPwf/DmeS9S4RdZVSfiTQn3TL+p+4u6edQ/gY6/zAQL0WCJWMCW2A==
X-Received: by 2002:a05:600c:4fd3:b0:40b:5e56:7b44 with SMTP id o19-20020a05600c4fd300b0040b5e567b44mr3106296wmq.141.1702397705901;
        Tue, 12 Dec 2023 08:15:05 -0800 (PST)
Received: from redhat.com ([2.52.23.105])
        by smtp.gmail.com with ESMTPSA id gw18-20020a05600c851200b004053e9276easm19320264wmb.32.2023.12.12.08.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 08:15:05 -0800 (PST)
Date:   Tue, 12 Dec 2023 11:15:01 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Tobias Huschle <huschle@linux.ibm.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20231212111433-mutt-send-email-mst@kernel.org>
References: <d4110c79-d64f-49bd-9f69-0a94369b5e86@bytedance.com>
 <07513.123120701265800278@us-mta-474.us.mimecast.lan>
 <20231207014626-mutt-send-email-mst@kernel.org>
 <56082.123120804242300177@us-mta-137.us.mimecast.lan>
 <20231208052150-mutt-send-email-mst@kernel.org>
 <53044.123120806415900549@us-mta-342.us.mimecast.lan>
 <20231209053443-mutt-send-email-mst@kernel.org>
 <CACGkMEuSGT-e-i-8U7hum-N_xEnsEKL+_07Mipf6gMLFFhj2Aw@mail.gmail.com>
 <20231211115329-mutt-send-email-mst@kernel.org>
 <CACGkMEudZnF7hUajgt0wtNPCxH8j6A3L1DgJj2ayJWhv9Bh1WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEudZnF7hUajgt0wtNPCxH8j6A3L1DgJj2ayJWhv9Bh1WA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:00:12AM +0800, Jason Wang wrote:
> On Tue, Dec 12, 2023 at 12:54 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Dec 11, 2023 at 03:26:46PM +0800, Jason Wang wrote:
> > > > Try reducing the VHOST_NET_WEIGHT limit and see if that improves things any?
> > >
> > > Or a dirty hack like cond_resched() in translate_desc().
> >
> > what do you mean, exactly?
> 
> Ideally it should not matter, but Tobias said there's an unexpectedly
> long time spent on translate_desc() which may indicate that the
> might_sleep() or other doesn't work for some reason.
> 
> Thanks

You mean for debugging, add it with a patch to see what this does?

Sure - can you post the debugging patch pls?

> >
> > --
> > MST
> >

