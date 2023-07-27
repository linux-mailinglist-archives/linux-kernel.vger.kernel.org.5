Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2E0764EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjG0JMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjG0JLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:11:35 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A3997;
        Thu, 27 Jul 2023 01:57:34 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe1b00fce2so235643e87.3;
        Thu, 27 Jul 2023 01:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690448253; x=1691053053;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=njYhEt4+eOi8+Tslvkgq6U+0tcgEtLytzTelQXXGBtg=;
        b=YLXps7D1mm5p8Mds8Qd9tHivV7E5PhSHgjV7yiKRqK7yjA1yNHHCa3yn4AqV3h2Pw9
         K02oJQrQ5YuH1iTOT91bXSWJMxTwL5t0F9QqdlYfda49ptyD9vRMBVS9JSfwPPhF8C4A
         QcIvCZtwVrDYofn5bpF0GiBPHUTYrMXECux23hYD/wwq/S3W+fMsJd3mnjFzEkV9hArf
         mOUocXGo1vVaTUeI7s8amquV54vjm/c29Q+Xl+dTthBv9zx03vYh17KlGocQ8O2Tz92a
         rCgogmVKD+FC1WgJAtEERMtqQA8/A44U40iyve/oSawA7uqcQJ/qMCZ2pzZvOF7dKNzZ
         sPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690448253; x=1691053053;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njYhEt4+eOi8+Tslvkgq6U+0tcgEtLytzTelQXXGBtg=;
        b=PnptCon87+GlSF1SZNH9URMDqNP9zgTQagE9+5ERM1s+fWwqM8EN7AOGzLw0fcS9QI
         U986B0gSWnSJJAytdQHY40NKBIbArQr9cZEoSpgx8BHw3qp2yADr4E0QvAonfzYldBtk
         cwolFokMWC8hBfy5c4WiV9ki4M1YeLZsypXvQ14woVlFwerIxmbrsMePep6fQMCluUJ7
         a8reL0hf0mVFg6cFDMOYPheE2WUCguu2jUoWcV3G6MIkO70TxnbjIOcntf20QgtU9Xcp
         mKu48EP1MN8Y+D9024fJmLlGn2kPumZkiQtBraN3MOBR+iRa/yW392uyBk941sFCk4JI
         d+3w==
X-Gm-Message-State: ABy/qLZJ/CXBDG43slms3xKyz/w/cPnnXJIde054cyhFd5+go85pYDH4
        dwo1yRNFfDjCpmnKZovJPdPBRn0q8yb4UnrTmb8=
X-Google-Smtp-Source: APBJJlGeD8o/CYv0QiyFLveOX/fqvIsAPDYKhOXXj6lHQrF5n5d+nHfejRKsDreaqLfM/r5FId7O4sjsBt/3scufObw=
X-Received: by 2002:a05:6512:3e29:b0:4fb:896d:bd70 with SMTP id
 i41-20020a0565123e2900b004fb896dbd70mr1616733lfv.46.1690448252498; Thu, 27
 Jul 2023 01:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230725173728.13816-1-dg573847474@gmail.com> <20230726214613.7fee0d7b@kernel.org>
In-Reply-To: <20230726214613.7fee0d7b@kernel.org>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Thu, 27 Jul 2023 16:57:21 +0800
Message-ID: <CAAo+4rWvCsYmQbzb8mFDw_LPFXx9tLky8gA-R68Kc3te79=7kw@mail.gmail.com>
Subject: Re: [PATCH] mISDN: hfcpci: Fix potential deadlock on &hc->lock
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     isdn@linux-pingi.de, alexanderduyck@fb.com, duoming@zju.edu.cn,
        yangyingliang@huawei.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. v2 patch is just sent to address the problem.

Best Regards,
Chengfeng
