Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B483B753694
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbjGNJbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbjGNJbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:31:44 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350853A8D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:31:20 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-403b622101bso216541cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689327078; x=1691919078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A15vHDj+qs7UNZzBMwI03zJC4sCAs4aUuXDdRIcnSVs=;
        b=23t02nWITv0Wxxhxy3MrlVo5UpZWpGqtNY99JyVpc4i0YrPyJFugH+a74Z+HQejnwi
         8y5tjlwL8dyocmDUsnu6466nguP409GuVO8AdgF5U7jhlWuUE/LVvDLiIC6WZthjJoJ/
         KHT814wJXQ7pO24EglIwQ3jjatH6YGtTFDqrzAGJQwnMNAxUhoQWVlJ8sKLvkc2b3ymj
         ESNz47qPcei7L/zYjdgb9JXnKVuVqz5Yr2VksPxKXLPtqKXf2uBLI3Wu0EMNF5tc0943
         Kstyzn6haWUeikwLIsqP5/THMoQ20VejsqUy5ZV/VF2DjU2NSB7nfTZtVA26Iq+s4Kd9
         2umQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689327078; x=1691919078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A15vHDj+qs7UNZzBMwI03zJC4sCAs4aUuXDdRIcnSVs=;
        b=HuShnIHCZ7oUH6aGtwudrjdyg+Afvnv+p/SLPAyePQ3dGUcumLeD0q00E8nc+1pr4v
         2eFCoHmj573fDiDI4Dp2DjyHdWJ9J00p/zJRFCXVTtkYsR11NuCcw2eqHSq0ChFww401
         dU5MABqxxwSw2KfzrRupreb80g5p29LKYsjWeF6itDmk3pibBviJ0jm4s+bQxxdUdcJD
         VVk9W5zsCWiErsJcKl57NKewUhq+1pkkBsNaBspXMtkxnSUKfiWL3OvfwNy1zr8jYriD
         7pYB7WRkiz2sqZEq/IxT+V9Iur40DVcrP6faJuY3Kb0OY/5d+2I+lCHAlNhUQStO+lgU
         gMYg==
X-Gm-Message-State: ABy/qLYCLun0akUNFvOH47Qsh80/tuDNeoYow5ff16rrXSALa3EhYspZ
        DzTNgJwXDlzLZugDxaKK9bAlb12x95n5ao+1z/xgexTIubO4laz86+IPvw==
X-Google-Smtp-Source: APBJJlGtQLNZ4CEjh45JYoT5xoNYLOuQWA5N5tdWmCZZHh+lh09PpSw9EjeWvnMLktNTEQAQXk16GheQDjXDImQhu8o=
X-Received: by 2002:a05:622a:394:b0:3fa:45ab:22a5 with SMTP id
 j20-20020a05622a039400b003fa45ab22a5mr792166qtx.27.1689327078299; Fri, 14 Jul
 2023 02:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-8-mshavit@google.com>
 <ZK+BZhwbo8JLMPI2@Asurada-Nvidia>
In-Reply-To: <ZK+BZhwbo8JLMPI2@Asurada-Nvidia>
From:   Michael Shavit <mshavit@google.com>
Date:   Fri, 14 Jul 2023 17:30:42 +0800
Message-ID: <CAKHBV27idVJ-8YgpekezaQP2n+Oz6OpKnDmYiu_cSOFh6z1S+Q@mail.gmail.com>
Subject: Re: [PATCH v4 07/13] iommu/arm-smmu-v3: Keep track of attached ssids
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

> And I don't quite get this part. Prior to this change, it issues
> one ATC_INV command covering all ATC entries per comments inside
> arm_smmu_atc_inv_to_cmd(). But now we replace that single command
> with all attached subdomains in the list? Any reason for such a
> change here?

Because we don't necessarily want to invalidate all PASID-domains
attached to a master. If arm_smmu_atc_inv_domain() is called on a
domain that is only attached with Pasid, we can restrict the
invalidations to those specific PASID by looping over them. But yeah,
you're right that we could potentially optimize this?
* Skip the per-pasid invalidations if the domain is also attached to
this master without PASID as we have to invalidate all its pasids in
that case anyways. It's hard to imagine clients attaching a domain
both with pasid and without pasid to the same device but could be
possible.
* Always invalidate all pasids by issuing atc invalidations on SSID 0.
This sounds like the wrong trade-off??
