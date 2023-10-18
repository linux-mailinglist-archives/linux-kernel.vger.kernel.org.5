Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AF67CD9F3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjJRK7n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Oct 2023 06:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRK7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:59:42 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3550EA;
        Wed, 18 Oct 2023 03:59:40 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6c61dd1c229so1196938a34.0;
        Wed, 18 Oct 2023 03:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697626780; x=1698231580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RxnS7co15+PdbAYZNmOdkHSp2nhCKu09GQRS7+mII8=;
        b=uEYoAeTu/+7XRHvqC1rgohHkZWMF8acMxDdw8pGxplTA3aV5QhJe9/LYFN53khuV99
         duetJyDdg81KK6SDQ9ApReumbJBvvVM+/vT1QkMfkJRw0REvXogwEzAo1YWYlusXeRmK
         AJQIhTCFWvRaTlfY6YHZAREvGk3SrxLLBDaMa3VN7QOgK4qSRlD6k1r1hwI6++OWLt8k
         C9Lqa2RCFNUdywmvg5pvaV0P8ZUwBdSJJVHfr5WhA8cfSaqYCHtDThsF8mut3lp9CPll
         GT38gGg3nvODPT+a9Pl/srsPvegYw0pb2rKp/yK/i2x+vWWiSt/DNCV5JUnnudz20jFD
         nq1w==
X-Gm-Message-State: AOJu0YyIIfVPo3OdNML/H0CovvbN52cwnFy8Gfmi/kt242eCSgGS1Ac6
        CkuClHpYz4hWCjhi9EhHCOrdq77wxRrQDoc/lCs=
X-Google-Smtp-Source: AGHT+IHUwyamyh2hd8Z7ZR5yD79FUnXUBCgxGIK2Artnmhw8W14mvD0k7ctS4CTlv4If9RIGmL8TgoGAtmAgPE350Jk=
X-Received: by 2002:a4a:e1cd:0:b0:581:feb5:ac87 with SMTP id
 n13-20020a4ae1cd000000b00581feb5ac87mr906319oot.1.1697626780092; Wed, 18 Oct
 2023 03:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231016160828.373599-1-wse@tuxedocomputers.com>
 <CAJZ5v0itvrL7ijh07kB6i6o0ShCboWhv+09Gzo299DLK+GkH1w@mail.gmail.com> <1c5b051e-8ee2-6f61-dc18-3c6f75b428d5@redhat.com>
In-Reply-To: <1c5b051e-8ee2-6f61-dc18-3c6f75b428d5@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Oct 2023 12:59:29 +0200
Message-ID: <CAJZ5v0hMZh2vYKKRwBzf=D46-GWqNANF7VR3qqRo_zkWO-MRaQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: resource: Do IRQ override on TongFang GMxXGxx
To:     Hans de Goede <hdegoede@redhat.com>,
        Werner Sembach <wse@tuxedocomputers.com>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 8:38 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 10/16/23 19:33, Rafael J. Wysocki wrote:
> > On Mon, Oct 16, 2023 at 6:08 PM Werner Sembach <wse@tuxedocomputers.com> wrote:
> >>
> >> The TongFang GMxXGxx/TUXEDO Stellaris/Pollaris Gen5 needs IRQ overriding
> >> for the keyboard to work. Adding an entry for this laptop to the
> >> override_table makes the internal keyboard functional.
> >>
> >> v2: Rebase onto linux-next
> >
> > Hans, any comments?
>
> No comments, the patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Applied as 6.7 material, thanks!
