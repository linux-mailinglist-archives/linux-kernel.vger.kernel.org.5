Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5790475B29D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjGTPaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjGTPav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:30:51 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2B22718;
        Thu, 20 Jul 2023 08:30:43 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-262e89a3ee2so473237a91.1;
        Thu, 20 Jul 2023 08:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689867043; x=1690471843;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VDNz4+C3Ia+UJJWOL2yYRO78JT/eW+cEwJdo8jSL20g=;
        b=j24kvBWwDfKqiI7V3bmAeDZ5ZnDfNQZLCeyyVHncofp6D55zjXVwXWSU+Afjz4+tlb
         IhZK7p8rsDbgglhVpFPiNNSLtPx6YGeFYk+fPsfgQo/G2NyU2c6hhJiyTH8M2qnMpA1Z
         S74UpLZMBdapuVFe9KZcO27vuZ2LX1qEoCZwVWUcpnV+URA+77WDH1zZmQdMRwX1OB/V
         hUf4fTVIx9F4//uzYbdKiwhzWN8eYB3tqnDGiM7HBmI6Ax8KuzWQHczF7JdgaPVrlE/q
         CI5R6E1bpY7MHLQ7aCf8pyUHu4imp6WuA9vuL/SoUFZeWHgGRJNf5CKPti7fzFmIMZLo
         FjpQ==
X-Gm-Message-State: ABy/qLbbKYxQUNvCyrh/29X3C3/Zlr4NuMBvPpM6ZTGd5RczNFFtML2A
        29PZ4vAWlVrgcmc3UzP1QgI=
X-Google-Smtp-Source: APBJJlEp60fdkh+BwPlnxV7BskYrzw4J3Aqy8/DijBF1o7Ei41aAzfcXecHcQpUp58++ywm58NVt+g==
X-Received: by 2002:a17:90b:23c5:b0:263:409d:6ef2 with SMTP id md5-20020a17090b23c500b00263409d6ef2mr6275576pjb.24.1689867042556;
        Thu, 20 Jul 2023 08:30:42 -0700 (PDT)
Received: from ?IPV6:2601:642:4c05:35c7:a9f2:f55:cb5b:263a? ([2601:642:4c05:35c7:a9f2:f55:cb5b:263a])
        by smtp.gmail.com with ESMTPSA id l15-20020a17090a384f00b00267b7c5d232sm2993691pjf.48.2023.07.20.08.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 08:30:41 -0700 (PDT)
Message-ID: <352167df-34fc-ddff-def9-902873796536@acm.org>
Date:   Thu, 20 Jul 2023 08:30:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 0/6] nvmem: add block device NVMEM provider
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, Jens Axboe <axboe@kernel.dk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dave Chinner <dchinner@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Jan Kara <jack@suse.cz>, Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Min Li <min15.li@samsung.com>,
        Christian Loehle <CLoehle@hyperstone.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Jack Wang <jinpu.wang@ionos.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yeqi Fu <asuk4.q@gmail.com>, Avri Altman <avri.altman@wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ye Bin <yebin10@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org
References: <cover.1689802933.git.daniel@makrotopia.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <cover.1689802933.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 15:01, Daniel Golle wrote:
> On embedded devices using an eMMC it is common that one or more (hw/sw)
> partitions on the eMMC are used to store MAC addresses and Wi-Fi
> calibration EEPROM data.
> 
> Implement an NVMEM provider backed by block devices as typically the
> NVMEM framework is used to have kernel drivers read and use binary data
> from EEPROMs, efuses, flash memory (MTD), ...
> 
> In order to be able to reference hardware partitions on an eMMC, add code
> to bind each hardware partition to a specific firmware subnode.
> 
> This series is meant to open the discussion on how exactly the device tree
> schema for block devices and partitions may look like, and even if using
> the block layer to back the NVMEM device is at all the way to go -- to me
> it seemed to be a good solution because it will be reuable e.g. for NVMe.

Is my understanding correct that these devices boot from eMMC and not over
Wi-Fi? If so, why does this calibration data have to be stored on a raw
block device? Why can't this information be loaded from a file on a
filesystem?

Thanks,

Bart.

