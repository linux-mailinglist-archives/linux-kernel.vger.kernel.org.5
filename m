Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C40751C09
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbjGMIqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjGMIpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:45:35 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD502102
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:45:22 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40371070eb7so181221cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689237921; x=1691829921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Q79c/OvfP4qr4NBPZHCFLwvY8dzwJlyvbkHoNMl1ds=;
        b=3bjgVTIt1JTtnkHk+MgnbYdzDKrD/JqGAViWxl4ZRYiEZ3tGle1rnB2YGtKEoQ4IrP
         rQida9wVL+gFpg4A+H+P5BOX5TtFJEkAqrPlrFhsyyaXWlU60ubx3DVrfbygIz4/+aQ+
         YnQQkmI+RQQJfbx0PUu6qo5fFf0I+F4fNcwOPvrTE2zuarH5ueitaMv4isrMBe59HTtc
         yd7zNW2re8vay05D5k8OtZmr52v0067Yjp1iLI4IAePtuyDFht+yQuCNZb0AKqULukuA
         Lp9wdxmatiUpkqwuzlcUpBE1yRcm3y3ptV9erV5qlVlH6jozJo9oiqCPk8pXbfSPxyar
         s/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689237921; x=1691829921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Q79c/OvfP4qr4NBPZHCFLwvY8dzwJlyvbkHoNMl1ds=;
        b=LN12u4Err5kEOKaSjupc+89gyrNQPyjaL4IoSV1e/E3nTJmysCWHJ0Tll6tzzAwC4l
         T1yF+tqdkInVeZp0mDj6W2aBdqWF0xg1PLgSKDlxClA+3vDnTRK0eAxSmkdHsyB1MUqy
         b8qMllzj61rsP+eHvjqoIl14A6sVmz2fDxsZQk7s5CEzFRSeXv/mKvCNs2boKgPVH8TQ
         i9XWTTnc7P+NXlHrxpCtMdQ1HewmWQS2wwo/nY7/aFQXjghTXmBiWM32sJWp3vIB5oMM
         HLbyos6TBQOY/+9meUKaWdkIywlXrOlfg1YwK8XRxTtlCxZqhq3wwmd5aug7QCrN9IyK
         o4Jg==
X-Gm-Message-State: ABy/qLZT1GJm9yARqQlj0eF0zvzkm1xIrT6ED1+RarsvYmsmaUTb269S
        coaBzQzZ6y8H8pzyysLvEFTELudmRGWMwu2mxQio8w==
X-Google-Smtp-Source: APBJJlHXesm+i+xAfOeS9zP/btd2JTeNsiyCDuYNbetw72DcwsPYgQxuCw2/cvFIS2FdMjWEX21pSxBW8kzjGULMJHs=
X-Received: by 2002:ac8:5b8b:0:b0:403:b6ff:c0b with SMTP id
 a11-20020ac85b8b000000b00403b6ff0c0bmr515839qta.6.1689237921386; Thu, 13 Jul
 2023 01:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-10-mshavit@google.com>
In-Reply-To: <20230621063825.268890-10-mshavit@google.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Thu, 13 Jul 2023 16:44:45 +0800
Message-ID: <CAKHBV24gX6nuCeb2O13XPLw7aohi95ReZfqKVtX1X05WM7LZQg@mail.gmail.com>
Subject: Re: [PATCH v4 09/13] iommu/arm-smmu-v3: Implement set_dev_pasid
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     jean-philippe@linaro.org, nicolinc@nvidia.com, jgg@nvidia.com,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 2:44=E2=80=AFPM Michael Shavit <mshavit@google.com>=
 wrote:
> +       mutex_lock(&arm_smmu_asid_lock);
> +       ret =3D arm_smmu_write_ctx_desc(master->smmu, master->s1_cfg, mas=
ter,
> +                                     pasid, &smmu_domain->cd);
> +       if (ret) {
> +               mutex_unlock(&arm_smmu_asid_lock);
> +               kfree(attached_domain);
> +       }
> +
> +       spin_lock_irqsave(&smmu_domain->attached_domains_lock, flags);
> +       list_add(&attached_domain->domain_head, &smmu_domain->attached_do=
mains);
> +       spin_unlock_irqrestore(&smmu_domain->attached_domains_lock, flags=
);
> +       mutex_unlock(&arm_smmu_asid_lock);
> +
> +       return 0;

A small bug in this patch as well: we return 0 when
arm_smmu_write_ctx_desc() fails instead of the error. Will upload fix
in v5.
