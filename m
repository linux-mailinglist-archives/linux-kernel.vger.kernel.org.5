Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCAD8110EB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377561AbjLMMTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbjLMMS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:18:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC21CCD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702469944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9OenjaI252jDFm5tBCpqUj00k8gqMRMfXOu979QIu3U=;
        b=fkrWvXxycYfa8Sf38/mIo8yQ7UmVyC07arEXKr4qfT4fL2mdBbqa2esSdfGMD7lAagLmCo
        NDRkU+VKgwxbHo5pqxa7nAj31yqJ2YKs+6WGHuasweKNiyqDcGlr9M0hytwym16IJqVHXv
        j8b5lcsIKvnPieGDCftVBMWx+82UHcI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-TBqOSlD-PQWC1yC1xQ9bcQ-1; Wed, 13 Dec 2023 07:19:03 -0500
X-MC-Unique: TBqOSlD-PQWC1yC1xQ9bcQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5c624e68b45so3397547a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702469942; x=1703074742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OenjaI252jDFm5tBCpqUj00k8gqMRMfXOu979QIu3U=;
        b=cMs6JC+zdqQrDeqwZjv6X4xZU7kxNcFyLUyNb3Egrf7y3QtcNmwlLxcy1TAiNtgS6j
         q5Wgutv+6iMNrX9cl7/zpV474DqkUfCtE0q1L9yIIFJrQCb9x+ottKBAz/5s/8OogJ1l
         5geV6nVUvhJ9TWTnWZJTccv0ocdsvrt16F2nuzxYMFWTRLGq4n5E0qRkM7k+Gnc1VvZS
         +9FN7WwykRza+bAv2MjcQayYyhzdmeI7hhGnTDXXLdUsLB+8AWoVPDPjuQLmFX4tRO5M
         miWawFhG26iNDs+YyeVtwOAqLaEdDBpFI+rs6OpEkvYoTs6jxJGqJlV7kr6/MfMhmHfe
         8gTw==
X-Gm-Message-State: AOJu0YzZkFTBqZ0hPgLCSV6wY/UXr8GhfGLfRuZBr9t8xQUN4TSPl1Zn
        6+/gCMb/7k3RUgj8WMkudMWqqZ0f7evCf+LUfMZkmgQ7RYBEf+cP0VT2cEVtr2PgClxwxoCC0eE
        elcHs0qEnZ6E2d6rhLFEzNWlPD4eiwourG8mLOIWu
X-Received: by 2002:a05:6a20:9495:b0:188:973c:ef84 with SMTP id hs21-20020a056a20949500b00188973cef84mr3763246pzb.9.1702469942717;
        Wed, 13 Dec 2023 04:19:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHR0T2JL9fDDpIZW3CvJFbOq91R6/I3nKFKh+DB9JS2YSkxLRf4rwRBOee7a1V8bWk6KRdgp2nKczpoEqW+zZs=
X-Received: by 2002:a05:6a20:9495:b0:188:973c:ef84 with SMTP id
 hs21-20020a056a20949500b00188973cef84mr3763242pzb.9.1702469942430; Wed, 13
 Dec 2023 04:19:02 -0800 (PST)
MIME-Version: 1.0
References: <20231211130426.1500427-1-neelx@redhat.com> <170236977177.265346.10129245400198931968.b4-ty@kernel.org>
In-Reply-To: <170236977177.265346.10129245400198931968.b4-ty@kernel.org>
From:   Daniel Vacek <neelx@redhat.com>
Date:   Wed, 13 Dec 2023 13:18:26 +0100
Message-ID: <CACjP9X-Ez80KXtquy-g1wqPwRr-orW8uBy=rvowh2hvJT1s_Nw@mail.gmail.com>
Subject: Re: [PATCH 0/2] IB/ipoib fixes
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 9:29=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
>
> On Mon, 11 Dec 2023 14:04:23 +0100, Daniel Vacek wrote:
> > The first patch (hopefully) fixes a real issue while the second is an
> > unrelated cleanup. But it shares a context so sending as a series.
> >
> > Daniel Vacek (2):
> >   IB/ipoib: Fix mcast list locking
> >   IB/ipoib: Clean up redundant netif_addr_lock
> >
> > [...]
>
> Applied, thanks!

Thank you.

One small detail - I was asked by Yuya to change the "Reported-by" as follo=
ws:

---
Reported-by: Yuya Fujita <fujita.yuya-00@fujitsu.com>
---

Would that be possible? And if yes, could you amend the commit
yourself or do you want me to send a v3?

--nX


> [1/1] IB/ipoib: Fix mcast list locking
>       https://git.kernel.org/rdma/rdma/c/4f973e211b3b1c
>
> Best regards,
> --
> Leon Romanovsky <leon@kernel.org>
>

