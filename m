Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABA977E758
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345116AbjHPRM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345141AbjHPRMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:12:07 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C23326A6;
        Wed, 16 Aug 2023 10:11:47 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40fee14093dso39749521cf.1;
        Wed, 16 Aug 2023 10:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692205906; x=1692810706;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CHrFV+BLoLqZb0sjEUEfiiQy/Dpvp5ulOgsMUMyh6vc=;
        b=bVmyMeNTGFC2e+qf7OvmuYs32gbrMj2ecg8/3lAPyfgD9q4gWVLkJea3wVuYGwORrf
         jF87Vw9qYnSbuJVtaX/pK6Do/pXjZ/6PEc+3Vq0jbKZFF6llvMKIxe9XYn6G0IYGXlLg
         XJHdm06o4NrdIC19Z5KGYCNY1cxQWA4UjYNhdmBN31XccquMAmB8UyYZwY5Sed1pskvq
         7evciXoaL7os3j7sWIGgQ0ggWCPeKc7icNarbraTGuthHpjrxQULQhenNaWroqs/5UNc
         2YCVQyDUEmbsRAiewaysysEm6xsvxTnm0gSs+ui02u13gg1DnrSs/JQERcQlAcy6I2Dr
         ci9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692205906; x=1692810706;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHrFV+BLoLqZb0sjEUEfiiQy/Dpvp5ulOgsMUMyh6vc=;
        b=k7bhXC3uXd/moPy9mRi+yzAsm9vgACabKeb4Dm12bi+uL41JJC4FKYSP6UivvezYXV
         EDAOiW5Ubo4S3UnzpO8SoJi8m0QNDQkYKHXkGcqkGk66DptRCystqZqw9QF/Svx78LrX
         E+MbUwM38koBoA9IgEuQM84LnNZxBwFGmV2BjSReC5d6qehr76R97jdjRPm1PXrBCN5a
         hs4dN/qL3CFo3x0inybxzein5PI5qdzvpiPUTX6KdouHAOhaBfxnBSrBvFIWovhqZpmn
         09FRtcaXg4WA1BRO186n7P1XgpOQPuxDu+VLnI0+LJyfB0qflyU+tjk6q80tNM5c07tX
         1blA==
X-Gm-Message-State: AOJu0YzbdgvM0WEpbz1uTqieHjxB45ZpMprRqLzKMa32ZgDjjkQtq3CP
        laLSeowVIYcTchrrKv2Uajc22PtmHJhyyC+4lvw=
X-Google-Smtp-Source: AGHT+IFikkkFMd9V+q5JWBKVMPcqRsK9mmGFbFtEwrVeoS8einVCHYVPyl4AqUDrlyhYHQfPCF61vLGfrEs0lCzNXi8=
X-Received: by 2002:ac8:5a8a:0:b0:40f:e946:a3d6 with SMTP id
 c10-20020ac85a8a000000b0040fe946a3d6mr2258618qtc.31.1692205906654; Wed, 16
 Aug 2023 10:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230816155524.5913-1-dg573847474@gmail.com> <25b4000b-b61d-c109-0d5c-f71656d896d4@suse.de>
In-Reply-To: <25b4000b-b61d-c109-0d5c-f71656d896d4@suse.de>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Thu, 17 Aug 2023 01:11:34 +0800
Message-ID: <CAAo+4rVpKc1tc4yGmYekb3s4tgbs8tsdjhSoCSfYXWG6Ab93EQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock
To:     Hannes Reinecke <hare@suse.de>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        bigeasy@linutronix.de, dave@stgolabs.net, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review!

Best,
Chengfeng
