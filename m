Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E939802B81
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 06:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjLDF6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 00:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbjLDF6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 00:58:17 -0500
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239E9192;
        Sun,  3 Dec 2023 21:58:12 -0800 (PST)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1cff3a03dfaso11288945ad.3;
        Sun, 03 Dec 2023 21:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701669491; x=1702274291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mH7c+Pqxj4Crkp7emUE+D2KDKHscrm0H2Ws3X/+mLE4=;
        b=rwMpXQ/Dsx3PJZg2nuoURoxKdtwYWtzKzfliYv+yV1CTF/ysR7wLTj+tkSBl7r6i/T
         pbdu8rvmeXMBkN5RbGx+NyviR3c8GotSfO8XTW4h+ymhSk7cucwdOb332/jJtpTJmVao
         yJ20+wsgkqgmGRbSJR7GmMEgXKh4Xu/nZj/2QK6+hjcFG4xxJ4loG19kVcqcqXOD4C6g
         10f2E5sPc9pt+Vn9wrG0vZBDgjgLDv+PaS8EgcU1iy21SeD9UqJm8ah2k7Gll/JdG222
         ncIDz1ClbI6waHyEy+lR0vfopDP3AVeA3E6VZCGGChBSot6OjkHKTmjcdyiTaYkk0gTY
         5lOQ==
X-Gm-Message-State: AOJu0YzIz1RbqiC1lQe6q1hZoY128+fWChC9g0fc6nPJcRW7rmsZwyIF
        xUqzgRbXYdWLgkjqv/+/090=
X-Google-Smtp-Source: AGHT+IHeRXDeAgAlRj3lYBUI6cO8QZedS20zcb35oAgelMFTgGlsYmrODODsrVI1M7cOETOOSYv2Cw==
X-Received: by 2002:a17:902:e549:b0:1d0:6ffd:8341 with SMTP id n9-20020a170902e54900b001d06ffd8341mr852253plf.76.1701669491482;
        Sun, 03 Dec 2023 21:58:11 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902c44300b001d084f4fad5sm2363166plm.2.2023.12.03.21.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 21:58:11 -0800 (PST)
Date:   Mon, 4 Dec 2023 05:58:09 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v2 14/35] PCI: hv: switch hv_get_dom_num() to use atomic
 find_bit()
Message-ID: <ZW1qcVWfjCvz0JRZ@liuwe-devbox-debian-v2>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
 <20231203193307.542794-13-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203193307.542794-13-yury.norov@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2023 at 11:32:46AM -0800, Yury Norov wrote:
> The function traverses bitmap with for_each_clear_bit() just to allocate
> a bit atomically. We can do it better with a dedicated find_and_set_bit().
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Acked-by: Wei Liu <wei.liu@kernel.org>
