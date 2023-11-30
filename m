Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07027FFE26
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377083AbjK3V7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377057AbjK3V7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:59:48 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E666110F8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:59:54 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6cd97c135e8so1347656b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381594; x=1701986394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c42AEDWMN7hJC14TW3ZzrgHN/RRiE6AQecjZVC97Rac=;
        b=TQ9pbjhKrU5rFQvy+B1+FAg+X9JVsucoA3CuPnU/XHjtqk31ej/8NAiYDrGhpJ6X9E
         7/94nJmCozCed82FI4dkFZXQE5cXSut5U47nXLX91GT3FZ08XXIZuLpUBNYRheSTIO7W
         oiu4PPQPMAQgWPMA3ypSZNo1yq1gvGIegDfLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381594; x=1701986394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c42AEDWMN7hJC14TW3ZzrgHN/RRiE6AQecjZVC97Rac=;
        b=OgWn4j5rEse4RsH5+SSbmDSBlF7m/zpxZ4JJDL4ZmntwtJxt9ohX9mU+ftaUH/uSn1
         NJWXAO6mplsEE8NG80zn5+mN/d47oqdTEUN22KQkTFnqkLLHaRLM3E7qQgjc0GnGBAue
         B5BW+pL5nZDSt75VyeRqXLbjDvxcAN3RWrr6KTRTd2++1T2lnfxypsaegjvdmj9G9fkr
         acQyHbwMbTaoyKfyqtzAh6EtKYM36JSd+TUdbWS4PmEbU+qX3ts/WyaUmmwxXp/MC26+
         0jGQ8AhI2Hg9T//fziy8M2KAYBOQwuJxcJSTlJvVxDAwImvhdC/dwNT7eCJeCeRA/+42
         fL+Q==
X-Gm-Message-State: AOJu0YwTY/Al0XUn/IQfXRUe8YB1EI1eass3wF4IZvpwH+Owvv/uaJLM
        zLUNRc4TwBZjbF/DbV8bCRtMoQ==
X-Google-Smtp-Source: AGHT+IFop+NWNhZlt3dMNp594BdhHVQM6A0+JlzJPIGXbIDsGz+ug3GkLRQiPue5S2QQlbddVCJDDQ==
X-Received: by 2002:a05:6a20:3d0d:b0:18c:52d:8f79 with SMTP id y13-20020a056a203d0d00b0018c052d8f79mr24539635pzi.62.1701381594434;
        Thu, 30 Nov 2023 13:59:54 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902c38500b001cf658f20ecsm1891636plg.96.2023.11.30.13.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:59:53 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Shay Agroskin <shayagr@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        Noam Dagan <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: ena: replace deprecated strncpy with strscpy
Date:   Thu, 30 Nov 2023 13:59:48 -0800
Message-Id: <170138158571.3648714.3841499997574845448.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v1-1-ba4879974160@google.com>
References: <20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v1-1-ba4879974160@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2023 00:56:08 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> NUL-padding is not necessary as host_info is initialized to
> `ena_dev->host_attr.host_info` which is ultimately zero-initialized via
> alloc_etherdev_mq().
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] net: ena: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/111f5a435d33

Take care,

-- 
Kees Cook

