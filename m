Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE1F7EAE5B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjKNKzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjKNKzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:55:53 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D65187
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:55:49 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-670237ba9b1so7597246d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699959349; x=1700564149; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iz/8sUCEjt69vJ4XCsLR7jS+dcEmOCYO3kX5c/nwzcc=;
        b=TqcxHNuauuG2hoetfqoaLn5KNhi0cGu2oa+2IB594arSBAvjEOk1WXi6fTb0HD2tTd
         O0EwuSz8T1hvCgcjLIB3d8D4NWdye/7qeW4RSZLChHF/Iy1Y7myhcZdTD/1lkf2VCZlp
         B/+Dsj/a0TfZo6qJntng9AKqrQxDneH18LxI0ZCwBrX78+eC5Lf4FcqX2929VkjkW8W1
         k96kR8DtWE3huRQD+hQVpQ+jaqamwe4OADKGDNGGTImYY57gn4VNWEQc8D/Oo6MliPmc
         IyfTbah5gPf6iDx2b5sOY3uaRvI1DKNw4bVXklJ40Pb+GMCMY13Kmd/KTX0IQjuq/l+8
         qepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699959349; x=1700564149;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iz/8sUCEjt69vJ4XCsLR7jS+dcEmOCYO3kX5c/nwzcc=;
        b=mBqvIoRpqGj4O9Kg7VNR+ixmdephlSzElrMGMvMPTK7tDVL5u5booo+Qlg13ritI1X
         ul48SPD0ltCQ0H5uRRudOPSCvjdyyF1U/q2186c1ekmSnKVht1xLiXL+E5IXHY+Z1G9N
         eYRWFzlk44LVxbqZTEARahR+bJgeGXmsz5EAO1DyJgppMihvUhVMCfUZ6MECBShjs6ul
         nRMUTfMlrxQ3pHKvbT/oCJ07Vv8sz8IpsPoX3tMU7zgamnbLIG4h8VxEfxbefTnhfPoJ
         PXWTp65o4TZZGT/2pDG4p49KRudf3l7wqOpQ31evZJT+Uu7aNn8lB4J8lz/ENgQn98et
         qS9w==
X-Gm-Message-State: AOJu0YxAxV2wQAFfI7NFNDyah7O5MOCIS6MF7I03qr4ibA8C1elrI3d2
        2IvtjBTnCeL85Qkdrx8ALaXmm0xAwDriwLH2VlSPKZR4VdSO7mmccVU=
X-Google-Smtp-Source: AGHT+IG7ap8IuRRxIfvqMo1zHHQzkuGEMlwEuAGQI+uH+u//FH8jud6DRfHdd8gd40Zrpjl6T2q9as8IxpGZhmdEVVA=
X-Received: by 2002:a0c:e80d:0:b0:66d:6111:5c5f with SMTP id
 y13-20020a0ce80d000000b0066d61115c5fmr1838674qvn.2.1699959348918; Tue, 14 Nov
 2023 02:55:48 -0800 (PST)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 14 Nov 2023 15:55:38 +0500
Message-ID: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
Subject: regression/bisected/6.7rc1: Instead of desktop I see a horizontal
 flashing bar with a picture of the desktop background on white screen
To:     alvin.lee2@amd.com, hersenxs.wu@amd.com, daniel.wheeler@amd.com,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Yesterday came the 6.7-rc1 kernel.
And surprisingly it turned out it is not working with my LG C3.
I use this OLED TV as my primary monitor.
After login to GNOME I see a horizontal flashing bar with a picture of
the desktop background on white screen.
Demonstration: https://youtu.be/7F76VfRkrVo

I made a bisection.
And bisect said that the first bad commit is:
commit ed6e2782e9747508888f671e1101250bb19045be
Author: Alvin Lee <alvin.lee2@amd.com>
Date:   Mon Oct 23 14:33:16 2023 -0400

    drm/amd/display: For cursor P-State allow for SubVP

    [Description]
    - Similar to FPO, SubVP should also force cursor P-State
      allow instead of relying on natural assertion
    - Implement code path to force and unforce cursor P-State
      allow for SubVP

    Reviewed-by: Samson Tam <samson.tam@amd.com>
    Acked-by: Hersen Wu <hersenxs.wu@amd.com>
    Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
    Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

My hardware specs: https://linux-hardware.org/?probe=1c989dab38

-- 
Best Regards,
Mike Gavrilov.
