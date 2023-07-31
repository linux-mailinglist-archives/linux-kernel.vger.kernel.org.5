Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6DC76A0EB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjGaTLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGaTLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:11:45 -0400
Received: from abi149hd127.arn1.oracleemaildelivery.com (abi149hd127.arn1.oracleemaildelivery.com [129.149.84.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B65CAF
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=MmCddPORwyGMhO45TLDEY2+Z5G9cWBHInOBlZ2EgK9M=;
 b=b+QZdO5nLgMToo/z44/aBqv0i2xQxJTKUg2c5qWJJRj+LCHtv1rmNbL6jxRDfTMbtQT0iwp8KAP0
   tps7jRXmQTapWB8XemrrP4/jOxkgT9eMoBEtT1QYPVaT5gGSvCn8mPs0fgTugqP/FbI8muDODuy+
   1KELF9pyOXlEXStx9grRSrxy8iLX2Qo9h1RFwhN4bk/1xHG5ClgbjpWa6hL0jTV2e63qeX6e/e5t
   rnNdK1JG/OgCOUSVw1rtkZ9OaoslBByyUxDErvOntlkv0O2fnPEAcFhdQuv4rfIu62rpdeBRlMC6
   R1gihbJzWlIrYi9TulOwZkG5QgqSpFj9oW2Jhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=MmCddPORwyGMhO45TLDEY2+Z5G9cWBHInOBlZ2EgK9M=;
 b=TRbvF8hWn7Xh6ptKQQgYS7x7RnL6UoTfD6soA36LaLtiRMTeSrTcBtCEHN3RjiyoNb4dgBu1iMYN
   g1tBWmpJe5DwXMAVJdHBEjW6aaEUyPFk5KgPLvaP5rDy736vH/hB+4Oy7L5vLwvZoT/x8fm2hM4C
   hpK5230IrYTSCwZ5gkLrlLjqmsuMwLjURvJ9Is8+ymsQv26V9Um/jadsO+ZQCaTmxrx40GzYnP2W
   JShZO3S4XHhYbwf48t4Tpxr90s8oyebid2UvLtBLrU35zOBhXe8K0r/A1nvCGboDo4BzIrEcYX/d
   7h3un4jHiQIUrDfubASib5QHeSqOBWO9Bhgi0w==
Received: by omta-ad1-fd2-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230629 64bit (built Jun 29
 2023))
 with ESMTPS id <0RYO006X2DBIMKD0@omta-ad1-fd2-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-kernel@vger.kernel.org; Mon, 31 Jul 2023 19:11:42 +0000 (GMT)
Message-id: <40058d79-7363-9474-2af0-b8e02b7b01ab@augustwikerfors.se>
Date:   Mon, 31 Jul 2023 21:11:39 +0200
MIME-version: 1.0
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
Content-language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        nilskruse97@gmail.com, David.Chang@amd.com
References: <20230731185103.18436-1-mario.limonciello@amd.com>
From:   August Wikerfors <git@augustwikerfors.se>
In-reply-to: <20230731185103.18436-1-mario.limonciello@amd.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAGxKd0J+EDPNkJxyVSwXV8t9u0oYmwvO47EmDb/N7KkuuHQNewGDNL7XqL4XvXk
 NwsfeuoNmYe+xIBGUiBvhWydppa6afCXI4kCdXEWhBhqrP54E4jELLLFsSOeVlhg
 jbNaWmDyFxUqVZ/Z2h52VOYFHsAcxfZONf2+M1Ya5vjprII928j7jiSF/BUCYXMk
 OuqAuAU4MNSKQ5TIUezYSmMG4fPiU0TLGz+Ee0Q1FgY1bNnWEuOgsfTtqhYxyieM
 nczzINySIbeK2ybS0uMIQDGGuJVq/P+Xk9unmJtr10xSyl79E7RZbiKWNk7pRg07
 iaXcL78DTQO1bhUrk4+FI/LS/NYVaL+I5aDMC2xnn2qp6UPFORDgSt1OAyBExywj
 HcbdG+jouggaBZuMw+BbMkgD6hS6YtGtCh/rt8GiN5P+Owvm0NgiPMp4rW0nkvuA tyXeIKs=
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-31 20:51, Mario Limonciello wrote:
> Samsung PM9B1 has problems after resume because NSID has changed.
> This has been reported in the past on OEM varities of PM9B1 parts
> and fixed by firmware updates on 'some' of those parts.
> 
> However this same issue also happens on 'retail' PM9B1 parts which
> Samsung has not released firmware updates for.
> 
> As the check has been relaxed at startup for multiple disks with
> duplicate NSIDs with commit ac522fc6c3165 ("nvme: don't reject
> probe due to duplicate IDs for single-ported PCIe devices") also
> relax the check that runs on resume for NSIDs and mark them bogus
> if this occurs on resume.
> 
> Fixes: 1d5df6af8c74 ("nvme: don't blindly overwrite identifiers on disk revalidate")
> Cc: stable@vger.kernel.org # 6.1+
> Cc: Nils Kruse <nilskruse97@gmail.com>
> Cc: August Wikerfors <git@augustwikerfors.se>
> Cc: David Chang <David.Chang@amd.com>
> Link: https://github.com/tomsom/yoga-linux/issues/9
> Link: https://lore.kernel.org/linux-nvme/b99a5149-c3d6-2a9b-1298-576a1b4b22c1@gmail.com/
> Link: https://lore.kernel.org/all/20221116171727.4083-1-git@augustwikerfors.se/t/
> Link: https://lore.kernel.org/all/d0ce0f3b-9407-9207-73a4-3536f0948653@augustwikerfors.se/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: August Wikerfors <git@augustwikerfors.se>

Thanks!
