Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286EF7C5ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjJKVER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjJKVEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:04:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C93B7;
        Wed, 11 Oct 2023 14:04:14 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9b2cee40de8so46259766b.1;
        Wed, 11 Oct 2023 14:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697058253; x=1697663053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85+BYQFRFSvmZdXHyKa4CY/JoC3Hipg8cZZ4vbffeSE=;
        b=FVLQFioCf5NYWP30pIUB4JRGNo1Me5z1rYfrnytKrxMI/N5AbgOkewtl7ZwEX9bMF5
         w89KGG+paw7rIX9CKOJXSQACY6A9nbsVbcfQPkxuF5BfoujiMd4Sx//OzPcMxuPq+aEB
         LmMdyVli9WqSATcFama0dmUdKxTuxfG9JzJWXCGwEgzF6+HsgOTcDDDASoq7EzAzjYHN
         4hYt13MjZH3jHycpbTvFaAXbXBWPGoq5fhoV92hJL/nDDoUBmgFtDcMWwDFtSXk+Ncqk
         SpHPELLipaQsanj6okofczqaKQRn4xqATpkia55nq3Qv8PHCU0hQ+NW+KjOEfTTgEQEM
         KQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697058253; x=1697663053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85+BYQFRFSvmZdXHyKa4CY/JoC3Hipg8cZZ4vbffeSE=;
        b=Mbk4b5ApQAcXoifZcnWMpQX8gFG4sPdrl2UbLlbWm/VsO8ITEmeMHqtprZTYw+HswJ
         iBzIC7/d58/OweR0zY3E1kEI7LYBYTBnui5lXz3UoPdEuVe03Z/P957ml7tSQv9SaCqA
         UJ5bXT4kA1yZnb+L5GlPNozD555xOONCeHcJv+O5OcFGvn3zCf5I5ITqymoTfyxUQJTe
         XqT+6WyXSYc9xSiLD/AhZGId6x4JbRaFE9eSxRFn8M0C8pUkOzJeF4lFYayCYzIp/sWe
         7C64rvKh0/0wXjbua7T0S0tu6I4aaB/LvuHkCik836VFBHi3/PHYnbYJ5CswF8n3N3qt
         B+TA==
X-Gm-Message-State: AOJu0Yzre9kCjBjmlny4k45e1GFXiStXGjqtkuPziN1U35Vl+UM8ax7h
        04eY8y6OfMMWq2HMlWsDXqY=
X-Google-Smtp-Source: AGHT+IGYaWlBmZ4iitWU8HxMcch2DlFXQK5FbRl5zPCnhC6n5R7/if7Ci2j0Cffbx+l9VuXPfCVrhA==
X-Received: by 2002:a17:907:9491:b0:9a5:962c:cb6c with SMTP id dm17-20020a170907949100b009a5962ccb6cmr18457404ejc.31.1697058252720;
        Wed, 11 Oct 2023 14:04:12 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906059100b009929ab17be0sm10169412ejn.162.2023.10.11.14.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:04:11 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        Deming Wang <wangdeming@inspur.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: tegra: Fix a typo
Date:   Wed, 11 Oct 2023 23:04:08 +0200
Message-ID: <169705815168.1498101.14814421385743433176.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912121030.1759-1-wangdeming@inspur.com>
References: <20230912121030.1759-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>


On Tue, 12 Sep 2023 08:10:30 -0400, Deming Wang wrote:
> successfully, not 'succesfully'
> 
> 

Applied, thanks!

[1/1] firmware: tegra: Fix a typo
      commit: bde3ce7257ca68120f0d8db96b3df5bc14f8245d

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
