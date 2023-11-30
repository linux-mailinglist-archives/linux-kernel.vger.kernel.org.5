Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB4A7FE9F4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjK3HzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3HzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:55:17 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A4210C9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:55:22 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a04196fc957so80860566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701330921; x=1701935721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmZiZjvpBex4gcI04eLOJyAJ5t5SzkDiFqDMvfOAJ5I=;
        b=kZ4m63VovDbojZ+NnrIMxEo3p7BysYUDLJRKomKxTXYzBrSS0YginMEckYVdwfDnOz
         xNbGmYc0bWvFkrsn6vYSVWkVZ/7syKi7SCjSe2nu+OCL2NDTGK5Et5HDpXOXUSVjC89+
         SXr1rNMpZxT6bEOCyS/orTVfJ/LBwHfa1Ozn1kROHHCi14Ph2vOqORhNhUDJgjTkADvm
         vX0n75YdUq1XzsRL48CrnETMbdYkmlsP9Doiva6uQg2og3R6ufBRbCDALvrHF6UJ5bY8
         23ZbM8RYHIXoTzMn5+DU+AEWHdImOORkjMeG7XgcqT+MaNScNmiNq4moCq6XTG6nO0K2
         g7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701330921; x=1701935721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmZiZjvpBex4gcI04eLOJyAJ5t5SzkDiFqDMvfOAJ5I=;
        b=Ql1SZ/faFPxjw07hpEVYrl+Vj1qC7CZLANbVq5OOu7G0CtpieJN2tVgW47TNh/XP3o
         3OjXg9VBZPj6D3oN2YYcPNe8s+W3dlIR1bpN7pvzfPQxt7xiKlDiBpgHj5RAvHCZux3V
         McHpTUJU62gfqUjAtjCNMn6sb8QcIR9MHqSkfLGS6P2svZhJcSC4pEPLJBqrPXVdU30j
         TOvaEsE5WWMd0Lsb8K3wUCenmhEW2hGwRsh/TGccLW+3E8rXlaZu2zEOZFvpUsmh95Cx
         CyHIjDZqKfhCIhAyXSg9A20GTOgwzKvPcsI+my07PBardvPn+Ix1/UO+gTGLDWxeCY2s
         xvVA==
X-Gm-Message-State: AOJu0YyqWkYgt51PowG360zq1ZONx4EtYgEmR8igv4jm47aYH9mrxIlb
        r/fWp7+R9jRf2rv3oi/WfZRB4g==
X-Google-Smtp-Source: AGHT+IGEJFJJud5j9Fzl6gQW0ZgJYjI7kTFeop+xGL6tvHR+7fS5T2fIUIfa2sxukjpQQbokfOn1MA==
X-Received: by 2002:a17:907:9728:b0:9be:7b67:1673 with SMTP id jg40-20020a170907972800b009be7b671673mr18537863ejc.1.1701330921247;
        Wed, 29 Nov 2023 23:55:21 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id l14-20020a170906414e00b0099c53c4407dsm386981ejk.78.2023.11.29.23.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 23:55:20 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     tomasz.figa@gmail.com, s.nawrocki@samsung.com,
        alim.akhtar@samsung.com, linus.walleij@linaro.org,
        Youngmin Nam <youngmin.nam@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, semen.protsenko@linaro.org
Subject: Re: [PATCH v2] pinctrl: samsung: add irq_set_affinity() for non wake up external gpio interrupt
Date:   Thu, 30 Nov 2023 08:55:17 +0100
Message-Id: <170133091468.5615.2831369258503569310.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231126094618.2545116-1-youngmin.nam@samsung.com>
References: <CGME20231126091120epcas2p4a1320e3b0f9be8f8a0f575a322981d38@epcas2p4.samsung.com> <20231126094618.2545116-1-youngmin.nam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 26 Nov 2023 18:46:18 +0900, Youngmin Nam wrote:
> To support affinity setting for non wake up external gpio interrupt,
> add irq_set_affinity callback using irq number from pinctrl driver data.
> 
> Before this patch, changing the irq affinity of gpio interrupt is not possible:
> 
>     # cat /proc/irq/418/smp_affinity
>     3ff
>     # echo 00f > /proc/irq/418/smp_affinity
>     # cat /proc/irq/418/smp_affinity
>     3ff
>     # cat /proc/interrupts
>                CPU0       CPU1       CPU2       CPU3    ...
>     418:       3631          0          0          0    ...
> 
> [...]

Applied, thanks!

[1/1] pinctrl: samsung: add irq_set_affinity() for non wake up external gpio interrupt
      https://git.kernel.org/pinctrl/samsung/c/b77f5ef8ebe4d8ee3a712a216415d7f4d4d0acf2

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
