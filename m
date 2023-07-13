Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87218751BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbjGMIoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjGMIny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:43:54 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B4C272B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:42:22 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-401d1d967beso187001cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689237742; x=1691829742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yM9D8Wn4tf81KIGl10BLC3f+dDmdYxYtYbJJvo+qETw=;
        b=LIIrcTlJ/0S9iLkK/yCdCp/74+2+s9KCAkZF+YQBFPiyj+s4mpNMGSfmb6RmKFYOwx
         vXuFS2VYcpBaOh0dypk6/GhVcCn8x3jzWfr12TSocnLU0Hq95pQCPs4Yo4zOyX2xdbh+
         kapgsUfLjn3WqZYtLdq6aQSBaMtvZKPGekJpq1XuYX3eUKXM2zA1snATLp7wfe8E3ltf
         WMg1P8RcLalncYXCq9SMjdheEN9X+RsQSSzCq+bV5XMYZDmZzz2d0JCtAPECfVs62KkN
         ssigb3A+7qzyNmXLoS5xgB31AO3QRFuI5xKr3nQPzGrscrxBsKDAdlRj9Phe7kK263Ok
         UuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689237742; x=1691829742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yM9D8Wn4tf81KIGl10BLC3f+dDmdYxYtYbJJvo+qETw=;
        b=E0zvUylMcOJNckOdb05x7eezSmf356lShTj464IcTEgQ6iYSiSitJAV6n5tstfLis/
         ruZvstgnmfAO4NuwaOQfFEOUAWXljRtKsKrS1eac1kSsEkZDF7V+eMjGT3ZK4GUNUNHh
         RUiYrPrejpq4v2CaMcAblkF4mKVzm+YWWY9v+F8RUd9k6c17r4d+aNXYBSAEmVH1+KkQ
         Ag9BsLrLSQxfNyUSMSGqJXBQXSRoe89Y8ST4WiYr9aReADuVJIDCjET/s080OwJG7W4w
         lFHlpaeU2juF9J5/QqT4HjtI0zF1M3GKYCRx0ODk0dSKvP2CEm+dQUK8wcg/Rjs7sYkM
         fTWA==
X-Gm-Message-State: ABy/qLaHjUEWptp4jVt1C710IGFVxp1f0ZAkJ7QOMmm4yXDBFQue8h95
        NoCA3GLeQHm9y9lAcUrZBOO2/ds//KazNDm6zATbcg==
X-Google-Smtp-Source: APBJJlGFCkELb9W0qLcD6Ra+EXy+AX80hvNLPJL36UOj2Zni8xwtiqtqy2trSWa7UrvWFggoM5iaNxg4YHXZTUoQUtA=
X-Received: by 2002:a05:622a:301:b0:403:ac9c:ac2f with SMTP id
 q1-20020a05622a030100b00403ac9cac2fmr380524qtw.17.1689237741861; Thu, 13 Jul
 2023 01:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-13-mshavit@google.com>
In-Reply-To: <20230621063825.268890-13-mshavit@google.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Thu, 13 Jul 2023 16:41:45 +0800
Message-ID: <CAKHBV24UZgcXyKd_L1s+Cvujw_Y1NDWXm+=xO=y4Z1GPb=Gmew@mail.gmail.com>
Subject: Re: [PATCH v4 12/13] iommu/arm-smmu-v3-sva: Remove arm_smmu_bond
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     jean-philippe@linaro.org, nicolinc@nvidia.com, jgg@nvidia.com,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Jun 21, 2023 at 2:44=E2=80=AFPM Michael Shavit <mshavit@google.co=
m> wrote:
> @@ -545,23 +534,12 @@ void arm_smmu_sva_notifier_synchronize(void)
>  void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
>                                    struct device *dev, ioasid_t id)
>  {
> -       struct mm_struct *mm =3D domain->mm;
> -       struct arm_smmu_bond *bond =3D NULL, *t;
> +       struct arm_smmu_sva_domain *sva_domain =3D to_sva_domain(domain);
>         struct arm_smmu_master *master =3D dev_iommu_priv_get(dev);
>
>         mutex_lock(&sva_lock);
> -       list_for_each_entry(t, &master->bonds, list) {
> -               if (t->mm =3D=3D mm) {
> -                       bond =3D t;
> -                       break;
> -               }
> -       }
> -
> -       if (!WARN_ON(!bond)) {
> -               list_del(&bond->list);
> -               arm_smmu_mmu_notifier_put(bond->smmu_mn);
> -               kfree(bond);
> -       }
> +       master->nr_attached_sva_domains -=3D 1;
> +       arm_smmu_mmu_notifier_put(sva_domain->smmu_mn);
>         mutex_unlock(&sva_lock);
>  }

I've encountered a bug with this change while working on a follow-up
series. arm_smmu_sva_remove_dev_pasid() is called on the domain if
arm_smmu_sva_set_dev_pasid failed. Removing the WARN_ON(!bond)
condition removed a protection against that scenario. I have a fix for
this change that I'll push into a v5 of the series.
