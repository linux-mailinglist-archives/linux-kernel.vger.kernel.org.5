Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F97765918
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjG0Qrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjG0Qru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:47:50 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E78F2704;
        Thu, 27 Jul 2023 09:47:49 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52164adea19so1487732a12.1;
        Thu, 27 Jul 2023 09:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690476467; x=1691081267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3gsQ/z+5cLrXPpwpVaTZvQsvN9FODKSUkdcyjzCiwU=;
        b=WISleUu8k7GFgZS9rTGQ7cB9ImJwmBpIA7sy3L+MrjSk2mS0YEUYfLqRfd/X2WcTJ3
         C1oNku7OG7wHXFGIrU2f4TK7PAk93TAwSwTtOc7LHtd9q0IvswtebEc42W6W/mWiDgiE
         QvCcJhJeY0UlajqCi3iD98Zhzl9+LoNK6iltG6Qp9EBnUg9TgKTSfgcRfGdm6oGdx/7T
         xcF+yMFHI+VY3e0HvMTnfgna0zBSE//5s1e5MLoWtw9eUu1SjDJTX90HwD7HLC9esNyJ
         pWOjcOa+pBc6jINP3kH4i1ArDP0FS3TaW2k4pNVgKXIvbgLyNXPYXbQybJNZLj1j8LfF
         uTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690476467; x=1691081267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3gsQ/z+5cLrXPpwpVaTZvQsvN9FODKSUkdcyjzCiwU=;
        b=kNSI2lHs8h+mZ13UGpbvDri5S4fPeTE9cJMYBdDcauW2YdF95KYe8I8sQHq0amLESm
         7bry1AI5UZ6vfzZDPHwT6k03VRBZuPxHCHMI3rTP3Z9zMP2/uCYHEjF2uEhc2jPtBcUL
         xpBjGIqCNXkdaJrzmUBEyRNK3Wqdr4gf3OD5aK9hUQPpVsCCd8AUQx0+XoSOpUViy1U8
         8h1b9vBzR3z8Q/NcWmQ7RGxYvUW8HHOrQFrL3Rihee3qc/Zjvq31Oz/cndjK2MxKL3ke
         Np7febKExWd7z9EqNVrwqM3z9yHe+0pP8VV98Vh6DOljWU12abm/4uO3hyfeM29IFalf
         B5VA==
X-Gm-Message-State: ABy/qLaYSJG1+6//uZQrWsRd+ACCn0UbuG2pOnK8GkDRHUq+I/J5HW35
        GR2gewUJjZA5bPcmuf1mQIg=
X-Google-Smtp-Source: APBJJlGxcnSGnb2HHxKkn5SM8nEwRi9FqOiTOcxIvGTjKsYuOy7oIgXGrBVHcpPau0IuAeQyqxh10A==
X-Received: by 2002:aa7:d7c3:0:b0:522:2a3c:6eb with SMTP id e3-20020aa7d7c3000000b005222a3c06ebmr1656540eds.39.1690476467343;
        Thu, 27 Jul 2023 09:47:47 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l1-20020a056402028100b005224d15d3dfsm832370edv.87.2023.07.27.09.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 09:47:46 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     jonathanh@nvidia.com,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] soc/tegra: cbb: Remove unnecessary print function dev_err()
Date:   Thu, 27 Jul 2023 18:47:41 +0200
Message-ID: <169047644218.3097949.1702711496048962025.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230506090735.23936-1-jiapeng.chong@linux.alibaba.com>
References: <20230506090735.23936-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>


On Sat, 06 May 2023 17:07:35 +0800, Jiapeng Chong wrote:
> The print function dev_err() is redundant because platform_get_irq()
> already prints an error.
> 
> ./drivers/soc/tegra/cbb/tegra-cbb.c:130:3-10: line 130 is redundant because platform_get_irq() already prints an error.
> ./drivers/soc/tegra/cbb/tegra-cbb.c:140:2-9: line 140 is redundant because platform_get_irq() already prints an error.
> 
> 
> [...]

Applied, thanks!

[1/1] soc/tegra: cbb: Remove unnecessary print function dev_err()
      commit: 10f975f8b0e8e563bf1e5c2f5e4ebada29fa7edc

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
