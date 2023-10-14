Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DBB7C9266
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 05:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjJNDKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 23:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJNDKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 23:10:01 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E706B7;
        Fri, 13 Oct 2023 20:09:58 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6ba172c5f3dso153284b3a.0;
        Fri, 13 Oct 2023 20:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697252998; x=1697857798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CvKMbdn7FKE5QGFVsCvObNjkNOx6TggTnSdGQkHd+SY=;
        b=huoxeh8jH72cxYd6SZaO7K79ZEJQ4sCMP2hEPoJodPhA4vfYFtVV3Uo1jfyarST54z
         l04/EdNJfA4FRi61XBV9q4g0z7OErL+3mbAAWVOyNt1XC0wabL6lTb2DDiGspqh3YfQ9
         F2osuCnvSdGly3x+6ztfXnlaIhd9sX24/i7X3paPghAhef9MSrEnwq++oc+zPCWstHcO
         L7Y9wrtuUFAujvPwh2nBh31EFF0ffG6XKpXN/wvfDxhuuRm2OLsJYRbSTjgaaQdyNUKQ
         L7I1gozojHlVgY9eZ5C9BwYee6k4GNlgeuRC2YB4hdzT9EN8LI9sMxzzK01ZeDXYCOy5
         fghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697252998; x=1697857798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvKMbdn7FKE5QGFVsCvObNjkNOx6TggTnSdGQkHd+SY=;
        b=JVKw05TmpZyUlcygZNEMJ3CELqK0YA43PKEHr0J7XQ5wryqUDxaXvAxV0Z0uF0P5if
         JRlr6kwnhZKFAuXN7fIZmyh0I9Y2HdMUcZ/qucyEkrM5j4XEkP/3PtbQlCfBCoeSd9mm
         3iP20tQzoefgZptHnsEhWcaygrYg+sqnvpYIsDBKOh6UxOH5iosKZLjLU7n5tQ9MQkGD
         5Gw4wZmpIFuJGH9xB+HvGyBW83ay/qqRO4GCsUILEbQc7NXOqib26vBiwC4ZLKq4uXWc
         cDpgZei0FLyQTldDvVNpCvn82mT79Lc1I1g8eX40Ck8rZZ8JGFWCV/TaBjSluWqFgEsq
         kGWA==
X-Gm-Message-State: AOJu0YxquYA4KUinNMHuVcI/pikPBR4CEWihcNoqgLQsXxG196poW7Ww
        6RpTpD4U+sJWOoQg6Zjylxc=
X-Google-Smtp-Source: AGHT+IECXPKH+UW5eQCDhYgQBI/9PSivvZ4p4oO51x/HnPYJRp2yc4b2unX6MmqfXzBIXCEuNXVdBA==
X-Received: by 2002:a05:6a20:3d89:b0:174:210c:34b0 with SMTP id s9-20020a056a203d8900b00174210c34b0mr8978255pzi.0.1697252997929;
        Fri, 13 Oct 2023 20:09:57 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:469c:3411:2771:1b7f])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902d4cc00b001c61073b076sm4533737plg.144.2023.10.13.20.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 20:09:57 -0700 (PDT)
Date:   Fri, 13 Oct 2023 20:09:54 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-input@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: tegra: Use device_get_match_data()
Message-ID: <ZSoGghBfw9NsEt1z@google.com>
References: <20231006224432.442709-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006224432.442709-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 05:44:32PM -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thank you.

-- 
Dmitry
