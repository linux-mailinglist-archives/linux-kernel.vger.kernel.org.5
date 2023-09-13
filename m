Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C510879F155
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjIMSpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjIMSpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:45:51 -0400
X-Greylist: delayed 1698 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Sep 2023 11:45:46 PDT
Received: from smtp50.i.mail.ru (smtp50.i.mail.ru [95.163.41.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8971BCF;
        Wed, 13 Sep 2023 11:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
        ; s=mailru; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
        X-Cloud-Ids:Disposition-Notification-To;
        bh=uC/GvK0VJb251p0QooAtVuKXPJInsZMKbwarV/LC65Q=; t=1694630746; x=1694720746; 
        b=llgmpCAiaZPlD76x42X2GV3S0ty01H9aCNlqm8pZHjeG5RQYsChB1nZbBifXdyVkSzxqrulfaU4
        Av0Z2TpVF99Rt+dqSziLd0DdtQnYp/eS7Tq+ypXisCT3hz9N5P3avwGR4yI8haIR9ITR3sZee3d0c
        ETfkZ/HSCV5HVoPdB0Y=;
Received: by smtp50.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1qgUrm-0035qJ-2i; Wed, 13 Sep 2023 21:45:35 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.baryshkov@linaro.org,
        konrad.dybcio@linaro.org, quic_saipraka@quicinc.com,
        quic_bjorande@quicinc.com, a39.skl@gmail.com,
        robdclark@chromium.org, mani@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 0/2] Add SMMUv2 support for SM7150
Date:   Wed, 13 Sep 2023 21:45:23 +0300
Message-ID: <20230913184526.20016-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp50.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD902203E0DD57300EC89AAED3EA3F32E92EBA3BF9EE48D578D182A05F5380850404C228DA9ACA6FE27A482D244EA0E52CE8C490B82B4933EA9F35BE37809CE72BABBEB785991F343D9
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7D298878E5C9226A3EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637BB46061768088B55EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BE5CCB53A13BC8DBAC7BCD8C45EDABD4975B8F87FD08413F5CC7F00164DA146DAFE8445B8C89999728AA50765F7900637BA939FD1B3BAB99B389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8744B801E316CB65FF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C6D3A1509E1113711BA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B6AFFDA16987AEDD6B3AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B2FFDA4F57982C5F435872C767BF85DA227C277FBC8AE2E8BF783223E2FFF4BA875ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A557454068F431977F031D1C92F0B967687DE98A16635393DAF87CCE6106E1FC07E67D4AC08A07B9B08ED1AC82D843A2BB9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF683A57FDD2AEDC3755F9A89B3D25FCCBE48000011D0BCD8CD4A835B1DE932CF830FDAC359DA24632C4B8F2E8CFB8F57155B7AD3890BE6EE088F9DB833DDDE066E4EB81C25D25832B4C41F94D744909CE4BCAC77546666B612CC0CD5AA9A1B9887EE09F5AAA95A50543082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojoMTWofjSWSS/HwZJA1JtNw==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949812764E3BEC629204346C41B774C00143D8B323A312B9E97B1643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds SMMUv2 support for Qualcomm SM7150 SoC.

Danila Tikhonov (2):
  dt-bindings: arm-smmu: Add SM7150 GPU SMMUv2
  iommu/arm-smmu-qcom: Add SM7150 SMMUv2

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c            | 1 +
 2 files changed, 3 insertions(+)

-- 
2.41.0

