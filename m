Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5137DAA82
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 03:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjJ2C3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 22:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2C3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 22:29:35 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB3EC6;
        Sat, 28 Oct 2023 19:29:33 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41cd1fe4645so21714301cf.0;
        Sat, 28 Oct 2023 19:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698546573; x=1699151373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gWNO3l8fpnpIPgxgpu5uSSqh1fHCKLMt8L2nodlFyk=;
        b=Esxab5uaDgCZOe7KWZ3GkozbuE8uTMi6OM2kmk1Cy477megLYrBP+lbE3KxfvKhP3A
         Jirrqj1sXZB7SPPnsfTAjjHHvzW3cFhvG2xYu+hrIiU3b2qHWBi+LVzDedcAWXx7hr+i
         W2eNKoJtoGNEwIYi/KCQue3/uId3M8T1ghrMHEne63VbJmKXwRJPlF0FECIaaxKiTN8Q
         le9EY4+co4Wjz19hmvWoUK1wZ8P3/kASyZXi49uJ7CzMhPHof5N+SG5ePk/YEFsTeS5I
         Ue/4S2B9kr/86mdqf7kuCd11Vhpdlgo6Rwoddh0P0TvkWOijpwSJZns0BZQvOixBvvsg
         nneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698546573; x=1699151373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gWNO3l8fpnpIPgxgpu5uSSqh1fHCKLMt8L2nodlFyk=;
        b=lhArqEDsviAyWdCvKB6uWYEpt+jPWBVRo1kl94kXoeZMSsPs7J7gu8ggPKAFNYHUuG
         FU/oyCEAH2HRaekM81QD8n+cf9WQbCKr8iWJ6twRPJX3QKM3BNYZfscInPTlJBQxsT8B
         bD4di0BcR3EJ+Nz+MjQceiuwtPC8V7JrCMBE7uiuR9qbbYkHyvl/iwyW9XQp0Ds86jtC
         lUusN9uBhmJdQ4NVKiR+IllO4r370xU0nHpB7d+U1WnnLqwSN3D96ohdz/rSBU0vWzw1
         qqAtJUNnJxwloQO4Xbm08mFNh/5Cewej28UQ11zKkBlI3nnUulgGw7NekCOzaIv0aoOM
         UQ7A==
X-Gm-Message-State: AOJu0Yz8Bf0dffUAbhkE0/+huTmtvJ2ReSfAVOHRpfXqDUejjSa+xpU+
        OLY0iJFVuS7Bfc5YyAC1ix4=
X-Google-Smtp-Source: AGHT+IErpMIDGlNs7xe4F7SkYsIWBgQIXur/8MlOHteENWqs1PiDVQ5rzCKOA9AAhWycHof+33p9rA==
X-Received: by 2002:ac8:5c96:0:b0:41b:806e:81c7 with SMTP id r22-20020ac85c96000000b0041b806e81c7mr7553608qta.32.1698546572867;
        Sat, 28 Oct 2023 19:29:32 -0700 (PDT)
Received: from google.com ([205.220.129.30])
        by smtp.gmail.com with ESMTPSA id d5-20020a056a0010c500b006bfb903599esm3549848pfu.139.2023.10.28.19.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 19:29:31 -0700 (PDT)
Date:   Sun, 29 Oct 2023 02:29:02 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com, Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH v13 33/56] touchscreen: sur40: Stop direct calls to queue
 num_buffers field
Message-ID: <ZT3DbkmurIzBp7_p@google.com>
References: <20231019125222.21370-1-benjamin.gaignard@collabora.com>
 <20231019125222.21370-34-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019125222.21370-34-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 02:51:59PM +0200, Benjamin Gaignard wrote:
> Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
> This allows us to change how the number of buffers is computed in the
> future.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> CC: Henrik Rydberg <rydberg@bitmath.org>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Feel free to merge with the rest of the series.

Thanks.

-- 
Dmitry
