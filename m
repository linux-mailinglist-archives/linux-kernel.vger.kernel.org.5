Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8929C7B3796
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjI2QL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjI2QL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:11:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EAC1BF;
        Fri, 29 Sep 2023 09:11:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so13641068f8f.3;
        Fri, 29 Sep 2023 09:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696003911; x=1696608711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NaHkOTL+tQCia4LZStB+bSdtNal7dOzIzYnNEYf4aiY=;
        b=TMjq6p/sVuUQDrkIGzY9HeippcrffQGSuNzIrvhTeJ7gDv5xrsIBHoL2uMB1UfS2sf
         GdQjUgDNyCYz4vcLMBIqM+vQzgiun8+5KwbtdC9lDjV/FIW/atMQDhnOaQbQ8/mlva+T
         N96yLvJsDrUYfcNAg9fP6gisKwb2/60ans0oROTl8RkK4T96nyV7Kf64xd+nwZTo5L+w
         QE0NO0X3q/ohHwytfpcMojEb7TF042Y+yHTEeJRsQamktIH8XiF17jm/xRppRF0TGWkr
         DZOepIfr29C5PzogdSdPIZZApC2EYefeW5OxlLiFtohLC7Jc2FeV2pHNU4RAtBuYDv38
         5Y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696003911; x=1696608711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NaHkOTL+tQCia4LZStB+bSdtNal7dOzIzYnNEYf4aiY=;
        b=S/Lxgx1Dc1y+yrF9lR74VtYqKuoTHyRhYZixn2o0l2cF6tWBt476CQgEODZqx+pIcU
         joj1GdhlnWsaCXt3TJoLYbYr/YAC93PvAjmGdMXlLBaObpCF78s/CpjUjLl1znQB1oXW
         IfYxUsMKXxHRKt7Ka9LpcZmQ+h7mV2G+cJbCcU/SHydZY9cb3m9MDuxo98MtUzI9k2AK
         6f24vBtdkzut3S4w+9GDZy2+t98uyeQJRG1nxlGZSADKX3rL6428ryqldM0c9n7psZB2
         fyMn9uTPnHaM3RJ0Tq1Bzy4Wx0FgccFLYAqHUjV+3kj1PXQ3ML2Zn0QwqeBgm5/gqxdE
         YsEg==
X-Gm-Message-State: AOJu0Yxgx0zs56boXOhxTMkiuxPlGyidv2jUi+rzvReeXSEdxuMyMOEh
        WsW/y80kr2NHRLokannsNHbAR8Si0hTPoreNm7k=
X-Google-Smtp-Source: AGHT+IHr+u+zOpGkaj570uRF+LqFXlnadavmg/yFmYYal/X/++0jDAu2jVvYAbklMdnfJUV8vCrR4DKl+qVPX2B5ciQ=
X-Received: by 2002:adf:ead1:0:b0:315:ad1a:5abc with SMTP id
 o17-20020adfead1000000b00315ad1a5abcmr4244415wrn.5.1696003910825; Fri, 29 Sep
 2023 09:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230928145401.32918-1-dg573847474@gmail.com> <b3a5e717-90ab-42f8-8fe1-4a24fff404c3@oracle.com>
In-Reply-To: <b3a5e717-90ab-42f8-8fe1-4a24fff404c3@oracle.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Sat, 30 Sep 2023 00:11:39 +0800
Message-ID: <CAAo+4rWXP7_bPw8LwvQMGtic_nWZfHFq-51HyiPATeQDpOTvpg@mail.gmail.com>
Subject: Re: [PATCH] scsi: qla4xxx: fix potential deadlock on frwd/back lock
To:     Mike Christie <michael.christie@oracle.com>
Cc:     njavali@marvell.com, mrangankar@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, lduncan@suse.com, cleech@redhat.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
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

Thanks for the explanation!

I thought the two locks are the same so made this bogus patch,
sorry for the confusion and thanks much for your time.

Regards,
Chengfeng
