Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FE7787A55
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 23:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243686AbjHXV0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 17:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243704AbjHXVZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 17:25:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934341BE9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 14:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692912314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PWKYbrMrb48JvhTQp4bhUeEoEYDgGEAEXO60JbRPDI4=;
        b=GDpglfeOukeKUDw1OtLJTCS1Y9cmt9bIl+5tez+RsdHa46Jai4JkVXLaNq7/das8izSnG5
        AAWrfH90b6udSIXX8Wj3OZ/5/oaXwuqgfhvW5Si19IzYdNVqA8GEnuX5/NehJIZ+yHVGX4
        xjuykFcU6cx8ircytjBD11wnonqIUpQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-60iMLT23PiSicbyszNo_CQ-1; Thu, 24 Aug 2023 17:25:11 -0400
X-MC-Unique: 60iMLT23PiSicbyszNo_CQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bf525c269cso4328725ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 14:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692912310; x=1693517110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWKYbrMrb48JvhTQp4bhUeEoEYDgGEAEXO60JbRPDI4=;
        b=TS3+zfMCnnUzcZfSr3YQsBL4HVB4ucioQMfA00zKGZ7sxJarUBqTxbLXir3oMdVVgT
         oKSHPHwCJichWoIW7GWyLZFoKnDWxSAisgT8PD3Q1q/lmkc2gTm4ZU9FnZ1xbc5BcdaO
         2peE/vEwxpsK6ogaYu6BadxjMXxC+VNkW8LirLedEJfaMr5ApK/XufEcm18eO6zmp7TY
         9/34NgPoUQH3gyDR9FkNwltedTrhL8aJNK8GIxRmRYmKgui1eiO+ZOt99Un9KL0G/rMi
         p/z/c0p2cGBZDVwk8c2cCvW2Iz/pTIQPSoNgxOPeSXQSxCfP2rWJaPU8LFC3OV1+ENMZ
         YVLw==
X-Gm-Message-State: AOJu0YxX3rnoamWSXG4dZ8La8FPwtvPklwr7ru81I2e4TGDcHCNPtqdt
        4Db3KCW7PiwGN/u7olMHnycqy2QX8eRtXIMwc1nUZ91aEA9qErSP9trrauVwH+L3UujJwqqogwB
        A16/TMpI/AFSLXwiGmmPodhILajxrR9dpxw9ElzST
X-Received: by 2002:a17:903:120d:b0:1b9:ea60:cd91 with SMTP id l13-20020a170903120d00b001b9ea60cd91mr17073407plh.7.1692912310344;
        Thu, 24 Aug 2023 14:25:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZZIK4S3ulab94FBMOHEmvsrXmPr0ilhfWEgbDzsd7rJe85li6R2bi+BV0VvdtEoqelM8btmXiw52wX20DH3Y=
X-Received: by 2002:a17:903:120d:b0:1b9:ea60:cd91 with SMTP id
 l13-20020a170903120d00b001b9ea60cd91mr17073390plh.7.1692912310054; Thu, 24
 Aug 2023 14:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002b5e2405f14e860f@google.com> <20230127051009.3881703-1-eadavis@sina.com>
 <6561085e-d4c9-bd04-d59b-eb39cfbaa3e7@redhat.com> <CAHc6FU5Zk6drhr_mC36hCMrq=ZmpDeBQsS9AZOT-NdsiXb1qVg@mail.gmail.com>
In-Reply-To: <CAHc6FU5Zk6drhr_mC36hCMrq=ZmpDeBQsS9AZOT-NdsiXb1qVg@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 24 Aug 2023 23:24:58 +0200
Message-ID: <CAHc6FU6O9nVzB2PvjRYRMKRq8b1aXFwkFT0qTt+6H7vk1saShA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix uaf for qda in gfs2_quota_sync
To:     Bob Peterson <rpeterso@redhat.com>
Cc:     eadavis@sina.com,
        syzbot+3f6a670108ce43356017@syzkaller.appspotmail.com,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've pushed the fixes for this bug to for-next.

https://lore.kernel.org/cluster-devel/20230824211948.3242607-1-agruenba@redhat.com/

Thanks,
Andreas

