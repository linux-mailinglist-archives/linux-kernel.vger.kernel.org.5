Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5D7771BDC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 09:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjHGHxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 03:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjHGHxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 03:53:41 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4151BC2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 00:53:18 -0700 (PDT)
X-UUID: 73fcd5ac34f711ee9cb5633481061a41-20230807
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=LkWwtZsl/ZS2ofti0t2kC2R0Fufo15InoHqryA/vhoA=;
        b=ZbkBirJnxdcW2Wb91f84BI/K9t2jkpCNbCPfHHTZP0xMuzofUkoYh5bDH49O8kTzqt4WM9IEidqxxj8O5QiZx6HfoCB3iRzhrZQMDz8JvZwyXQEReeoKuIfjvBJepxDJ2EP1lPYmEFMmXNMNaUwzuoJZAedflFDTT1YnlSu/Lak=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:85cb0795-ced5-4932-a652-3b7a648eacd0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:1fcc6f8,CLOUDID:9c59f8a0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 73fcd5ac34f711ee9cb5633481061a41-20230807
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 224011429; Mon, 07 Aug 2023 15:53:10 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 7 Aug 2023 15:53:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 7 Aug 2023 15:53:09 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <lecopzer.chen@mediatek.com>
CC:     <arnd@arndb.de>, <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH] ARM: ptrace: fix scno of -1 cause SIGILL
Date:   Mon, 7 Aug 2023 15:53:09 +0800
Message-ID: <20230807075309.6188-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230724121655.7894-1-lecopzer.chen@mediatek.com>
References: <20230724121655.7894-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> In commit [1], the -1 scno is used as a special scno when the task's
> syscall is traced.

> After commit [2], PTRACE_SET_SYSCALL will always mask syscall with
> __NR_SYSCALL_MASK, this makes the condition `cmp scno, #-1` broken,
> and some test like Android VTS[3] is also failed because SIGILL
> interrupt the test program.

> Let's test with `and` logic with #0x0ff000. Instead of #__NR_SYSCALL_MASK
> because of the constraint of ARM Operand2 rules and avoid conflicting
> with ARM private syscall.

...

Please follow the commit from Kees below and ignore this patch, thanks.

https://lore.kernel.org/all/20230804071045.never.134-kees@kernel.org/


