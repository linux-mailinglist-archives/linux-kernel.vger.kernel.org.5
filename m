Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2987E6C4F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 15:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbjKIOQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 09:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjKIOQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 09:16:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8F82D75
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 06:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699539328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fz+SNSpXICiEI4BudbkKcKa+vdAT+04uMSQsV3j4UVQ=;
        b=HKpeDEFmd4gEugYLIjiZCmVv4sNXuTW1eRO2ccX9qP24FGXy93D2m7dbV3+43DPhaC8c9w
        WzYSKn/DzJXKtZcES8knn6t5zDeeYkOhdVVq49i1L3QlwJwQ9oGcrACbDeVV4bHy4JDPxv
        unjFIcodYZsmcOd/nocEXy6AaR/VyEI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-Arhvwt4FOHCs6ve0aqrEjA-1; Thu, 09 Nov 2023 09:15:26 -0500
X-MC-Unique: Arhvwt4FOHCs6ve0aqrEjA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9d4b8735f48so76721766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 06:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699539325; x=1700144125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fz+SNSpXICiEI4BudbkKcKa+vdAT+04uMSQsV3j4UVQ=;
        b=ZRE/bN3Sc0F6puVw2mgZJcrW76AmsC8Moq6GGYxpSms4W3gLJ5k2Dulz0oKPiw60Ar
         7Wc77PAlmnUE0JfTaUZURBUDNzZlleC8xo6kbAjb+xEcKLovYc2PDTICCeeeatYvSZnx
         51RaNqsB4/UgafQyri40ULCXZPCCBxQ5fiCSzGgUg4z9TBZzhbCYtPO2gs2UEhs9EXcV
         S7P8Kx9kg67uA1DC/xoVocJhAuInG/saJ4kaXEbx40sIkHyc2jsrqSTiiNFzX+nA8GfB
         BOBjmRDWBh9vTQ7S3n1eLkLQkRTBE2IFcOTBD+W8TadsA30RpIk9o6y1H4fykU7j8bhQ
         PSAg==
X-Gm-Message-State: AOJu0YxvDrGWPbWyZi/z0lM8ihCE1a5ID7Nx7uHFDHXYq48iOAysyr3G
        GE7ZHFeF3zebXUKyWTaIiMPLJ1dA4a+Foq85B9E3Bcsn9uhuDmv98bj1kOWGGcj8vIoortesyoq
        VJmz1MlZZRTfsKZbTW9Lsf1SWLy4o4k17pUm0MDzy
X-Received: by 2002:a17:907:3d8b:b0:9bd:a7a5:3a5a with SMTP id he11-20020a1709073d8b00b009bda7a53a5amr3010840ejc.36.1699539325623;
        Thu, 09 Nov 2023 06:15:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ6CkZqOvFWs9H+4kk5luYoXo17JBC8Pp80UIeV+XCzpH+qqNv1UJIq5Vpne80vBo1x34QbqoaP+TljRJakaU=
X-Received: by 2002:a17:907:3d8b:b0:9bd:a7a5:3a5a with SMTP id
 he11-20020a1709073d8b00b009bda7a53a5amr3010822ejc.36.1699539325368; Thu, 09
 Nov 2023 06:15:25 -0800 (PST)
MIME-Version: 1.0
References: <20231106191138.3179599-1-aahringo@redhat.com> <ZUyDvv0na03qnSH+@infradead.org>
In-Reply-To: <ZUyDvv0na03qnSH+@infradead.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 9 Nov 2023 09:15:13 -0500
Message-ID: <CAK-6q+jK7L=Vg6UAr=_vKbywBpQTMcor_1cU75tjx0tT2qNndQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] refcount: move kdoc to header definition
To:     Christoph Hellwig <hch@infradead.org>
Cc:     peterz@infradead.org, will@kernel.org, gfs2@lists.linux.dev,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 9, 2023 at 2:10=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Mon, Nov 06, 2023 at 02:11:36PM -0500, Alexander Aring wrote:
> > This patch moves the kdoc for refcount_dec_and_lock functionality to
> > it's header prototype declarations.
>
> That's not how kerneldoc works.  The comments should be next to the
> implementation.
>

ok, saved for next time. Thanks.

I will drop this patch.

- Alex

