Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B7A7C610C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 01:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376524AbjJKXXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 19:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbjJKXW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 19:22:59 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D8DB7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 16:22:57 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c871a095ceso3206495ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 16:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1697066577; x=1697671377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeVNiGwxsvJF+wlAgF5WVj+lSxGM+0XrruYrnnJJkOU=;
        b=fTRaLDAeLANnR+vKmkYyrRo5xJ/uhI9DU1Yaw330T90gH6RusP7YjdSg8Q3IPpewf9
         HZK6eBdLr8eSbElRs/pyoQNmwCyUR7ioz8+mF0nbfslW39Vkv9BcN+saMAK/E8Nk/72a
         bRF1bKA9Fi/n0KxjvfYL34yLkz2sgzmyxjq1XVE9i5WU64mzBSEPhawkVK44teapXfNB
         Qgi2MM68hNKF5f6Er3irrTd/QpOSuLOVHSMBcACQKi8ilcK4AUeVBAT6NbFXZDk0cP10
         2EIB74RiYR8BauPca+y/3ctPauG6KwKbk9mi5QxsNv8J1S5DM8X06QvXF42vkV7SkYi8
         4I2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697066577; x=1697671377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeVNiGwxsvJF+wlAgF5WVj+lSxGM+0XrruYrnnJJkOU=;
        b=an0Ho1j3l5hFmtxwi0DkoYfZoxVv9Zxv5JZHgETB7s20TWYv5AIcaczPastke0OKk7
         h1AmWryE5qjhReY8voILRiUY9y3qBwPE8vVmaAmDx+YX6CGlV89KzKqIANp5K+jBUSNf
         JcUzElRU/pM/0SAPMPjtoA8V0aLSKc0KYJpXCocTN6MdHQTuNx66rQXO7FTqWIMjZuNm
         6TS1ymTK+vrTPpQHBiU8kFDzgXPpGt3BjlhqNa79v8p4NZyncfl4aoKyT/S0Q+c+P+Gt
         7wU02ENNzMbY2YVF2FM7laOIarsPimSHTSU0t+1/CdrVqXLpAfJ92VWuDxhCa/s8VZa8
         yLbw==
X-Gm-Message-State: AOJu0YwYiVHqZ+UpATm0AqgXNVzmJ/dXIQu5CaUYKDUGaUmFMxCUHhqu
        aXisPSdE9Oo4NNzKMBh7o3ff2Q==
X-Google-Smtp-Source: AGHT+IHuTxbgGR06/zGKzrw6PZahK5qMxccB9wlJMHwXl/wYWvrFE4DFpkAkP12v/5XzmFWgb40JpA==
X-Received: by 2002:a17:902:9885:b0:1c6:16d3:1783 with SMTP id s5-20020a170902988500b001c616d31783mr18560284plp.58.1697066577246;
        Wed, 11 Oct 2023 16:22:57 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id je6-20020a170903264600b001bbb8d5166bsm407618plb.123.2023.10.11.16.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 16:22:57 -0700 (PDT)
Date:   Wed, 11 Oct 2023 16:22:55 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: Re: [PATCH net-next v2 0/2] Switch DSA to inclusive terminology
Message-ID: <20231011162255.6c00bd6d@hermes.local>
In-Reply-To: <20231011222026.4181654-1-florian.fainelli@broadcom.com>
References: <20231011222026.4181654-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 15:20:24 -0700
Florian Fainelli <florian.fainelli@broadcom.com> wrote:

> One of the action items following Netconf'23 is to switch subsystems to
> use inclusive terminology. DSA has been making extensive use of the
> "master" and "slave" words which are now replaced by "conduit" and
> "user" respectively.


Good to see this.
I started on doing this in iproute2 CLI terms for bridge and bonding,
still a work in progress.

