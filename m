Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B7B7FFE34
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377093AbjK3WAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377109AbjK3WAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:00:31 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDFD1704
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:00:37 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1151521a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381637; x=1701986437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apCUn8ziR5/FQTht29aZVAPAp67cMYlwQgKj/BLw0E0=;
        b=kmWyZYe4DOYklbG9UarMNCNjUL8JZj1Inpz1uVCsowBt8ItHYjJn4csGXm8HSJc5x9
         Vi2sv6F7ek9jDNhHoVD1e+mIMUUCZ90/Hwk3lv7TXdkWRDzkXzGyfZSd4i51MyV6SuFG
         to2+LyOO9H6/lwU7UBc9qsJF5IaYmMLkNLXQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381637; x=1701986437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apCUn8ziR5/FQTht29aZVAPAp67cMYlwQgKj/BLw0E0=;
        b=NfthTp4MAac90XFW8fqLX2xwtaDUyp/shSVeCtSKWrJAH3V/BGX888epRfPeX4WZpg
         ppYsWUtDDdaJi7Jq0io8E446cgFsL9PAAKnf48yRsiNWkTXfHufxs9bHPz7eLNgKL3pZ
         EtbCGDH+Mvo7OIkwPkwugdrgm+GMMxs4jfoYkB8ohQhq1lsGddY8FdxqMGA8Awtgkju7
         EYdrGVVu02u+sW0Xlt4ITuZUWSFYxwQPTCvZN6mkuAhVXpkeneqRXzK+/3QSdLsd5JuM
         gNTsaP2YFh2iMZAx4mgTmCIdjXPeeqOzhXk7sK2hJtf5vgV6o6FV1efQnJFvjVpx3LmX
         9G8A==
X-Gm-Message-State: AOJu0YxsryM0q20Aj6wz3reQm/3yYOiH7I5t+M5LjJOUJjS40kYHw7yK
        kU+2XPvNHJnmjV+Xf1SKn7eR7A==
X-Google-Smtp-Source: AGHT+IHeAXmsob0OovCgW5d5X0eNhEXfkTQ2ooTHhsGgT4RIS2FKAgLtfXERMjmGZkCm01B3myg7hw==
X-Received: by 2002:a17:90b:4d8b:b0:27d:9f6:47a3 with SMTP id oj11-20020a17090b4d8b00b0027d09f647a3mr26842962pjb.31.1701381636781;
        Thu, 30 Nov 2023 14:00:36 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a11-20020a17090ad80b00b0028649b84907sm956190pjv.16.2023.11.30.14.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:00:36 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: mdio: replace deprecated strncpy with strscpy
Date:   Thu, 30 Nov 2023 14:00:33 -0800
Message-Id: <170138163205.3649164.7210516802378847737.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012-strncpy-drivers-net-mdio-mdio-gpio-c-v1-1-ab9b06cfcdab@google.com>
References: <20231012-strncpy-drivers-net-mdio-mdio-gpio-c-v1-1-ab9b06cfcdab@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 21:43:02 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect new_bus->id to be NUL-terminated but not NUL-padded based on
> its prior assignment through snprintf:
> |       snprintf(new_bus->id, MII_BUS_ID_SIZE, "gpio-%x", bus_id);
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] net: mdio: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/3247bb945786

Take care,

-- 
Kees Cook

