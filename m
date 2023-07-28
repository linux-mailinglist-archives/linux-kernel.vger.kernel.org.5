Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D56776651B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjG1HSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjG1HSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:18:44 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CB0F7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:18:42 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4036bd4fff1so210001cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690528722; x=1691133522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysCAGi0c79oB3HuNtN6di6oujNwWKPP9/x9YkXZxDSo=;
        b=x1RxhFdfUWgACKqP/g4NWP+tZISz9GTHfENu3cj4SbDWQXAlQFJ4jTLLGbrvDIciHK
         73o/+99jGa93LOdlBW3pF0NVLaUMw3pUW5g+NSTSY1+XMorkH5Mb+fKNyh5KQDB53+kf
         AJyKSOo21WkiW2kwoCb2hGtde4uJcUP8nVcKVNTDTvXp+pZgOV18/ZfOsQLjPLaefDjZ
         /vqj+I1/PYS83mq1FcZJSzOn62MnECAOIVyU4MoYVOuycuYIKqM+TfzoB8XzGCy3v4o4
         eUlbqoMlcYzsXV2nPb6PgELr/hjJQ1cmNW4fTGVmOlCJcNt8C9GTSg2BjpxAHGCtG85o
         WY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690528722; x=1691133522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysCAGi0c79oB3HuNtN6di6oujNwWKPP9/x9YkXZxDSo=;
        b=Pya2sZeE0KlacKx6sQjt7I09FOxRPX9G4NokXTZtaDh9Al+tyxEAGEEqNLXdY/6TX1
         q2G8xOjUKme6iBsShzxQ+B+EP0R/g7DZI/FkqyFLXyH/tyoxYuCI6BHE07tc1ht+OrQf
         fQG9VLH3kKXXuuqW9I7Hw/9UU598B079hi7FXePsSe4swh46VjhRss4i/bFZCps2S/5Y
         psGi0a6ADRP8shPB0w1/Xcjgw7xWumT7FKo7ZPSxHkPkCAo/oifUyfYa1dsrDf2R0ssw
         FidixcEPVfcJkbKUnR9ntTLHKfYLiwaSi8Hq+UBVzLd7DuULaUkKlydg0EVU6XezohfD
         IOIg==
X-Gm-Message-State: ABy/qLY2626/gfhDawa7CrEUzBNOfmvIzON1QD3ldNDillT0W8VZBwQm
        9MTKGWVxm5bYUqNThLO7kKJJ4qSuHnjMXLvrJ6wsPA==
X-Google-Smtp-Source: APBJJlEOrCpjFfE7xzbRq34bPLqamEsRreh52uuKwpcZ/sXYdpvtQf+IQ24Cmjhup27TEpRek85DUOqxBoOOvyOf2IA=
X-Received: by 2002:ac8:7d8c:0:b0:403:eeb9:a76 with SMTP id
 c12-20020ac87d8c000000b00403eeb90a76mr140572qtd.17.1690528721624; Fri, 28 Jul
 2023 00:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230727182647.4106140-1-mshavit@google.com> <ZMLRWfLET9FC3FQB@Asurada-Nvidia>
In-Reply-To: <ZMLRWfLET9FC3FQB@Asurada-Nvidia>
From:   Michael Shavit <mshavit@google.com>
Date:   Fri, 28 Jul 2023 15:18:05 +0800
Message-ID: <CAKHBV272tKQ=ky_ttA5TLcBBKeLf26WC5Hn_HFfH3LRk6udEuA@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Refactor the SMMU's CD table ownership
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 4:20=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
> The link isn't accessible for public. I guess it should be this?
> https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+=
/24729

Whoops sorry yeah that's the correct link.
