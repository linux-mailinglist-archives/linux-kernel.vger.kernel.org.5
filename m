Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F927BA465
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240094AbjJEQFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237560AbjJEQEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:04:05 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EB77AA6;
        Thu,  5 Oct 2023 00:26:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32329d935d4so621809f8f.2;
        Thu, 05 Oct 2023 00:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696490766; x=1697095566; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AGYYSttdjbm4Vxe6u7LT5aarQ17DelLXBIN0Cg3r5h0=;
        b=gSp+iZgBL+GY5YKW3bfrLjpntaDeEO+0qhTN2KY/OydrdBKBLu3WO6PIyav9HxkjQd
         eFeFRM62rAsXFVA+S4A68kY+hIxr/Q5fWL3hXLQ17S8/pbwjtxrtpY3W7HAjWleka584
         t/auVaCI6k+goMXWoAq2bUxjQmIuEXNBt+defnMzY+VQHfTfWLqG+Dz2NfbIMl1lNrMb
         sx+fh31TU3nWV9qGTyHBrVgd7UKftqbpDi8ZDPHOgsZTljQZXtWkfzVh0CGcMXBW5an4
         ABfwZGwvO8EaEVoJRER5gRx7s3TyiS50qDdmOIS81CHpdkdUJfbz1aXFW/FHUZDkZt8c
         Fn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696490766; x=1697095566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGYYSttdjbm4Vxe6u7LT5aarQ17DelLXBIN0Cg3r5h0=;
        b=TmaLEYD0y4EpUzqBiCOD/AEHTBmK36VzBeZGNnuQtLreCJGjWsqoX2bCV5HGCzvaMu
         /82+hpiRPdn9mkQmEc07+d5efSyuJdj7CD9NoA7caA6oKQC5NlAGwBfEW69lAjrwYvuu
         5APVNKJ1/ZiELlpIZyuAi2QpxApIEFKrMBXk8mfFbRTbZSu7TyCEAXFyMoS5KyjmM3up
         epOak/0gW0+BoDaCt0wyK4dGssCcAmV7OPFRFJCJd4RHT5ofiB81uxXDu18AePfUK4Sj
         G9egCPHCujJMVc4wmDtJ3mfRd7mIqteObOZGA/iVH+fF/2hPtzeLmdJguLmNHqJLgsLy
         Mgxw==
X-Gm-Message-State: AOJu0Yxq7IceECszt+PfD3XomiqitSC483Bi3+F9kM0qp+f3BO/EP3cg
        9gwffayZdEZ66RGyUNs4mcuuwQ3rexEAzluXYVM=
X-Google-Smtp-Source: AGHT+IFOsR8bcDAMN52/cj4X6a3+o51XI/0aWe2O05i8XzyO1gLayHsWVB5H9d49ZRLb/znFkUaNAUvhg71omLR3Rxo=
X-Received: by 2002:adf:fd12:0:b0:321:4ca9:ee86 with SMTP id
 e18-20020adffd12000000b003214ca9ee86mr4214908wrr.53.1696490766088; Thu, 05
 Oct 2023 00:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230926105732.10864-1-dg573847474@gmail.com> <20230930161434.GC92317@kernel.org>
 <20231004105317.212f1207@kernel.org>
In-Reply-To: <20231004105317.212f1207@kernel.org>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Thu, 5 Oct 2023 15:25:54 +0800
Message-ID: <CAAo+4rVuwAsJ=mr8u3tG5XdwBzY_QQ=G4UkA3nxkB_hux7581w@mail.gmail.com>
Subject: Re: [PATCH] ax25: Fix potential deadlock on &ax25_list_lock
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Simon Horman <horms@kernel.org>, jreuter@yaina.de,
        ralf@linux-mips.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, linux-hams@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

No problem, I just sent a v2 patch.

Thanks,
Chengfeng
