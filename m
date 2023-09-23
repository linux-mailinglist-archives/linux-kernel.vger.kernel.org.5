Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18317ABD48
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 04:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjIWCNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 22:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIWCNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 22:13:05 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0E2C6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 19:12:59 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50308217223so4952239e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 19:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695435178; x=1696039978; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=94Bskd58xVReBXeRtix4vcuwmuqzkWRde2XRgjbo05s=;
        b=Asj5PMAP8tU190Fd2j1GIaTf3Ssyth0pma1nBm6vGdNsQMlVmSabCzU7AE9TjaAauB
         I3NIkv5GOMaiRgHtic1fkyyxwpOWtPko8wBE87Q1Qy5ZF1MqvaIJ4xuukJ7EGF/xK+30
         oeTHx74vuJVODOVU8yvyn72i65LwPHOCTCOW0uuPqJUO0dtl/bh6DAMbBgPHjRJQGZ0/
         FGCQDrNIv9JSQqQt5p+8utS6VAfbyNaP4FxiW6MUwgSGEYUKJnk+4lOyD+Da0Mt1tvR1
         jE1Wj7DV+Ze867T2OdvE9jbLl6x2Z9YLb4g3ssOlFTCnZUCDiMJlnQxHsbPtjEIsasFx
         774Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695435178; x=1696039978;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94Bskd58xVReBXeRtix4vcuwmuqzkWRde2XRgjbo05s=;
        b=JB+aCG1QdXprSwxwgbYCUIDnDniqfamOwLbuWewWnVCk/EnUKnULhCdTh4nXOf4OCf
         eN6om/L6r+QE3/oQnXjh/AfWxWbke4p6FwpomjdJY3UN/qvU7uzL7II3qcEKT6+/3DDK
         xf65P5w23Nm5nMaVq9cDoqozbxcJrf21gz5PjMp0QKF/2E+7i8vTUaWKiksoZrKegkpt
         ktNGt6/6zglVZqxjNG/6meZ0pxSUwxaZj83dg53KJ/xMwRdNg0/8cYa9uTrol7IP2ehn
         ydPY/p2MnmeRQK4Ml/a312Ng1N1YHkQ3f31TjoPCCSWTf2LLTq6kaZ3U/F7macdBmrb/
         LLKg==
X-Gm-Message-State: AOJu0Yy5d2x6k606oVZoQBB1gMN4hC++q7b8CqJOuUgwrolcspHOZE3q
        nCevp4cKl37tNCJuVe/QOxXI413yNPQoM0a8R0W86n4CuQ0=
X-Google-Smtp-Source: AGHT+IFZb/cAOIOexevRwn8I9C0j9wjMVk/ZaeDwTUFJX3d16bl2cSW5/xzqPbnfco2AgPFoZKZVUI6BXxlml/bvTrg=
X-Received: by 2002:a05:6512:6cc:b0:500:7a21:3e78 with SMTP id
 u12-20020a05651206cc00b005007a213e78mr1066595lff.55.1695435177620; Fri, 22
 Sep 2023 19:12:57 -0700 (PDT)
MIME-Version: 1.0
From:   Naruto Nguyen <narutonguyen2018@gmail.com>
Date:   Sat, 23 Sep 2023 12:12:46 +1000
Message-ID: <CANpxKHHzre03bFfW_UpJy1W40oFa6Q6x688WrCXKtNeqkeVk7Q@mail.gmail.com>
Subject: Small MSS in vmxnet3
To:     kernel derkeiler <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Recently I found that packets sent from vmxnet3 driver on guest have
MSS value set to very small size, some 10 bytes, some 25 bytes MSS.
The vmxnet3 NIC enables TSO. Could you let me know any possible reason
that the packets are fragmented with very small MSS.and is it normal?.
Any way to avoid this small MSS or it's just normal.

In addition, when enabling debug for vmxnet3, in function
vmxnet3_tq_xmit, it has a printout

netdev_dbg(adapter->netdev,
"txd[%u]: SOP 0x%Lx 0x%x 0x%x\n",
(u32)(ctx.sop_txd -
tq->tx_ring.base), le64_to_cpu(gdesc->txd.addr),
le32_to_cpu(gdesc->dword[2]), le32_to_cpu(gdesc->dword[3]));

could you suggest an easier way to extract the MSS value from this output?

Thanks,
Kind regards, Naruto
