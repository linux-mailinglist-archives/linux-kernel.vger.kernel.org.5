Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997787F36EA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 20:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjKUTqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 14:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjKUTqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 14:46:45 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DFE199;
        Tue, 21 Nov 2023 11:46:42 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40806e4106dso658635e9.1;
        Tue, 21 Nov 2023 11:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700596001; x=1701200801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KmH1+oaDprV5Eq23Jd2f7MjoyGQpqNp4zftRYgnu+Y=;
        b=QEkur83N1jgg/ZMhrqpfzPMeScPgsdF+XPiedHLAD/EcahhcqvCwgaCtUnDSVL5aRQ
         HYC9KyKMsuoZq0G/fha5PTWit2eadY4pKWQbip+OnGrHPLPXefETWw6LG0T7W4K87ufx
         bD8wEkNX87ZLNANbarL9CZzJJW437u2zEZZV7td02upvMKk37MD88Cl8HM9DiYw5KuSt
         +tQ1CyXDXTNlC8wV40ZNa+ns+PWaiws+LX0AgLWAC3XCYzrmquagQzh3bgabD1HL2gZS
         /x6nabsULTa4dCKP5M0We8XATKSP2k8RN8zxVeyiNVMW/RcM416r5vmnp9o/qJfNoLtR
         zmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700596001; x=1701200801;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8KmH1+oaDprV5Eq23Jd2f7MjoyGQpqNp4zftRYgnu+Y=;
        b=uKE2SXFOJnq/eFQHfxBiJuB4p2luhpf9TJV2n44xTiarnEPGQMYMa2vrr9VfuI6fUz
         eQ5GBcKsM4hNoAC8KyKYW03UDh0it5OC0qcb7J6y2EVSf7thw6IScJ6He8ZKcao9sXpV
         7qoug2GGoClqMmJLNAyFRhjhcMWwqdMlYfB+QUdpiULjiItrU/cmFSq0apPbefbI4gex
         uhErlKvmfmSiBHirfvj0nFrTt8FE80NRoXTAT5CBOA3iNjGZEp528Uc9iOxu/7pftwoQ
         OVEkGAoes0GzMwNXBXxYFdX00yyP89feYagVIDbCgNgbgKY1YkBRHreu6xY9m0rKcYd4
         YLdg==
X-Gm-Message-State: AOJu0YyJTkoZwP5wvDB4jykinlulbnEUlerN45wu8tdgiU9eGQKAnP9e
        tKcBA7wP73BCsGn9eTvzJ9c=
X-Google-Smtp-Source: AGHT+IHxUA7uZNyyQ8/99NcVE5JVL5kMKuuqWLX4uFZmbAk4bkPXh5GfW5KFXOoT/Ohxo4ZKCBFDnA==
X-Received: by 2002:a05:600c:5195:b0:403:aced:f7f4 with SMTP id fa21-20020a05600c519500b00403acedf7f4mr3308027wmb.12.1700596000450;
        Tue, 21 Nov 2023 11:46:40 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id fb11-20020a05600c520b00b004076f522058sm22349575wmb.0.2023.11.21.11.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 11:46:40 -0800 (PST)
Subject: Re: [PATCH 19/34] sfc: switch to using atomic find_bit() API where
 appropriate
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-net-drivers@amd.com
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-20-yury.norov@gmail.com>
From:   Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <4aa03b21-5503-1d62-66b1-aa1b3c42011d@gmail.com>
Date:   Tue, 21 Nov 2023 19:46:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20231118155105.25678-20-yury.norov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2023 15:50, Yury Norov wrote:
> SFC code traverses rps_slot_map and rxq_retry_mask bit by bit. We can do
> it better by using dedicated atomic find_bit() functions, because they
> skip already clear bits.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
