Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950F77B7A4C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241756AbjJDIk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241724AbjJDIk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:40:27 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE40B7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:40:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5334f9a56f6so3213593a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 01:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696408822; x=1697013622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8WGKt5xJKLtP2ADIqRkf3CB6lGKHNGdnXjYRt133n0=;
        b=CjUC9rrcyRJq5+T8VsF0HbBxUpUjlKUlwodwxpJhvxmid+QbEJn0vrDJOOafEVpL4c
         9QP+VPPl21RwtN6cf3GOCHg+1p2PDakT0llKQAYVOWlpt52pknGME5SieYddJIykXlwS
         dg/wxC7wAdO48CZe/8hiG8ZVoC5dcPDhEPivZgxMJ8unAGriQ2+oEMqWSO53mbZi80MN
         cQXL5b5Gt9qmlRGoP1M/MYLeairY2IgSv0KYHwufuGMSronQzNY8v2y9wcXy87laqtoa
         xo31m+HKWS+9YyFbpsAeZ+HzpbNarTRg0UcwAxetB8/EcxdkO8cJG0domlQaSZV0QW6D
         OBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696408822; x=1697013622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8WGKt5xJKLtP2ADIqRkf3CB6lGKHNGdnXjYRt133n0=;
        b=dLk5XGyWbv5mqJrjS+PCE/zr+GTcQq8PE/JLDLO4lO6yXngPBzP9zDAH3JlLcZnpMd
         HX+yrC90vXRJuhIDiS6/SpO9146YKOw46Tnj6Os0VPGfJfDCw8RisKLZ6Pc2GPpvCSPI
         DHbh7/JNec4Rst4YSD9IPxRU6Ui1QAqDjLmY2GVxJXBvGkHxL0nQfKSSijpH5O2XdQPi
         NU3TUwkk6YuvdWPzhNJgOPRY4lD3V7WpbfO/+46hzRnJQh78Zsw7tWgFB0YmBcIWl33v
         HKBUR+RSvynv+yxBTg8pCa6Ez/9B3CBaNACb8kF8WbvuNV+YHk0PfLPL0+lOzPQZOwY/
         oiYQ==
X-Gm-Message-State: AOJu0YwytO/h5ojAwfMIYRTN7V0xXRg44578jJ7kJM2OaHm+p7s7w8Yx
        2g1VFTds50ouvF06P9ZgVDzh2w==
X-Google-Smtp-Source: AGHT+IHw5seqeKoI/sbo9QFySuzZW0FEmpPAHbEOEQZvv0+IZIt6O+GVLsiRHyIgDrJLflXTsuXDHw==
X-Received: by 2002:a17:906:cc2:b0:9ae:5db5:149 with SMTP id l2-20020a1709060cc200b009ae5db50149mr1287930ejh.35.1696408822128;
        Wed, 04 Oct 2023 01:40:22 -0700 (PDT)
Received: from hackbox.lan ([86.123.99.172])
        by smtp.gmail.com with ESMTPSA id j24-20020a170906411800b009b65a698c16sm2351094ejk.220.2023.10.04.01.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 01:40:21 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] clk: imx: imx8mq: correct error handling path
Date:   Wed,  4 Oct 2023 11:39:41 +0300
Message-Id: <169640874935.222477.17041733753562302865.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231001122618.194498-1-peng.fan@oss.nxp.com>
References: <20231001122618.194498-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 01 Oct 2023 20:26:18 +0800, Peng Fan (OSS) wrote:
> Avoid memory leak in error handling path. It does not make
> much sense for the SoC without clk driver, to make program behavior
> correct, let's fix it.
> 
> 

Applied, thanks!

[1/1] clk: imx: imx8mq: correct error handling path
      commit: 577ad169966e6e75b10e004389a3f79813e84b5d

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>
