Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94BA792BA7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346110AbjIEQ4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354668AbjIENZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:25:05 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2127619B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 06:24:59 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-414c54b2551so447431cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 06:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693920298; x=1694525098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tm3HckoGhR0kOmO+Af+IuBe5cApLGm7dUdHeKiObbD8=;
        b=BdrrKLX0/JB6hufReHTkSYe8GQYIoYPiuhHD+7FGtqpqRYlgVIeRq1BAO8uKZODsZ0
         CmfgaX/EOIX68XlSOd+D5OL/PbcMHlJzziZ5+r0OeQd5Vkj5P1ul/BC6PGNMqG7hEnQ4
         8AgiJBFnXVSSGIFlH+ppuvS1rVYpphkPYvUXpGXyK0aF/rQF1SmYRIjg8JguesYQDZPq
         TZfPuKRrzMGBXICn3X3Iypf3yxGFGGLt98dpKcsIb4+LCN6fw6a87yQNlhV8fs95ssrn
         kzQe9j/sa3mbK5uH8VmYAnBmV84iKeic3J+HIM3D209AXifQQuKFW+HmR95c9WYXeZ2U
         kPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693920298; x=1694525098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tm3HckoGhR0kOmO+Af+IuBe5cApLGm7dUdHeKiObbD8=;
        b=ix/AtF0InHrjpl7xdpmeozHt+XBlGyonftFFgaoRiNSOXjUmLYpiuctS0CeWlfog45
         r+uokJInj3cSkQ6tXr7weqfepphTf1ajpfJJfNSWTOsZegWGUptQwFSOH5lp4w8wVd0B
         1oXG9EJdlATH5yyY3aqLY/uyUYUNY09OXRcIUnANNbMC0xsEmJMsvYaN3o/IAGe+/eoH
         v4mSXcTXOEf/vd3EL7XRdjdB6LBX56XxYdMrIHoKFHiVYHm7R1TI1r+n0jYdKDucl/O2
         rGUzObSlQZTkW8ZMSb2IgkcGVaggT63lwbxFG31P3T73Kg29YYv321RKT9yUf6bv2EgR
         +ktw==
X-Gm-Message-State: AOJu0YwYgOfSqt4rP6tQcFTIBjnoW+0c7oK7Dxqm3O/99fSNWQHBp2hY
        aNaQZ69mJmlGgfug892EyJibxX794yP17WcIdmvLAw==
X-Google-Smtp-Source: AGHT+IHtdxVPUzfXW+56VWtgBUPKNIoSWrDfX4dDhRXBKJt2RAJrcODOZo7O/yqUpi2HbVBDBMBnRzOM6zfFpx+vXmI=
X-Received: by 2002:a05:622a:199e:b0:410:8114:107b with SMTP id
 u30-20020a05622a199e00b004108114107bmr430079qtc.12.1693920298107; Tue, 05 Sep
 2023 06:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230905115013.1572240-1-mshavit@google.com> <ZPcgkO7omYremwyV@nvidia.com>
In-Reply-To: <ZPcgkO7omYremwyV@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Tue, 5 Sep 2023 21:24:22 +0800
Message-ID: <CAKHBV27wi53xtDK4JzM6xH0OB7Ps0A8SewN3A0OJdpTuT2856w@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Clean-up arm-smmu-v3-sva.c: remove arm_smmu_bond
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com,
        jean-philippe@linaro.org, tina.zhang@intel.com,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Tomas Krcka <krckatom@amazon.de>,
        Yicong Yang <yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 8:35=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Tue, Sep 05, 2023 at 07:49:11PM +0800, Michael Shavit wrote:
> >
> > Note that arm-smmu-v3-sva performs a second level of normalization by
> > mapping multiple bonds (now SVA domains) attached to devices with the
> > same SMMU (if those devices have the same RID domain attached) to a
> > single arm_smmu_mmu_notifier. This is not affected by these patches.
>
> Ultimately the notifier should be per-iommu_domain as well.

Speaking of, I'm questioning whether the multi-SMMU domain patchseries
and Tina's sva domain sharing are really prerequisites to get rid of
the notifier sharing. Is anyone really depending on or taking
advantage of this? The optimization only kicks in if multiple devices
with the same SMMU, share the same RID iommu domain (although this
would be improved by fixing SVA to not depend on the RID domain) , and
are bound to common MMs.
