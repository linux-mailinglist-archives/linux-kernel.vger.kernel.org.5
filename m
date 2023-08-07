Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D779771CB3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjHGI5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjHGI5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:57:17 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FC11721
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:57:15 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-4871b63e001so935363e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 01:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691398635; x=1692003435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZucVtIkFM04mYucGiDt9qwXBSHx9kGCsGiHIGBFoRU=;
        b=U1NHO45ycyjKvWl60/fjlEDzivwhdLkR3bzkcIfXwDJC2AklScXN3a6FMkjOrtcfpg
         34TeKN5C0/ISgdMebzdXJpQT5wW0RbJdPnouAw9RFAAqkqZBKzb9DB4r/RfWj+8P2nmm
         rTFSMJv2VbHjFGiGmeuUpOaczHUJNU989cgBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691398635; x=1692003435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZucVtIkFM04mYucGiDt9qwXBSHx9kGCsGiHIGBFoRU=;
        b=K6yeKDTycxRR/10ePQ5UtyBnXq3lXL4lMk+LRlwIGmYGTIO3YQLxjqsk4W5Rn5Yjsm
         /bhHfBBPahsMxWFDyl6NALS3ubR30I2P+w9ygT/viwOTjlXY/DL1x0WFX8dJDXTgbIz9
         uO3P8gHJQdAuU7/swplZO9dpmc5rlqK3EyN6/PiRsrXdPIoP3zdv1z6WWq9kP7APEW5K
         qoIWDdC43GZRJ7dPIUPk8OQfqoUEaC9SFMF8cHAV3XTLTFXSJBmXUrI+KgrgnWrXfjTW
         JgbkqDZmXe4ANhAdrybUHi4Z+vPGKpEefB3BLqEjHpNLwPmEESrEQZOrE7ELz8o4APl6
         siwQ==
X-Gm-Message-State: AOJu0YzZwXD01i05hCnqfZsK40ZaFQEx7cpV25xA3wBDeh3m6nYFLBTx
        E9F+75vuMQ+tLgfSsaa9sUwbklCB6OTyCsDgR5Xx8g==
X-Google-Smtp-Source: AGHT+IFGPVEYqUoLZFZWLtEo08sa+SuiHjhI9DLsFSF9rOQonNyV+ovGZi4eITkhDaiZE2GKTyjjl+SKivF3876DLCg=
X-Received: by 2002:a1f:bd4b:0:b0:486:3cc7:5435 with SMTP id
 n72-20020a1fbd4b000000b004863cc75435mr3286235vkf.1.1691398634603; Mon, 07 Aug
 2023 01:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230807082419.38780-1-miquel.raynal@bootlin.com>
In-Reply-To: <20230807082419.38780-1-miquel.raynal@bootlin.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 7 Aug 2023 16:57:03 +0800
Message-ID: <CAGXv+5GaW5wtVqsN+GQJ6rzkmCq1R3c1xeZ=_hNmHmrkVZ=eug@mail.gmail.com>
Subject: Re: [PATCH v8 0/8] NVMEM cells in sysfs
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 4:24=E2=80=AFPM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
> Hello,
>
> As part of a previous effort, support for dynamic NVMEM layouts was
> brought into mainline, helping a lot in getting information from NVMEM
> devices at non-static locations. One common example of NVMEM cell is the
> MAC address that must be used. Sometimes the cell content is mainly (or
> only) useful to the kernel, and sometimes it is not. Users might also
> want to know the content of cells such as: the manufacturing place and
> date, the hardware version, the unique ID, etc. Two possibilities in
> this case: either the users re-implement their own parser to go through
> the whole device and search for the information they want, or the kernel
> can expose the content of the cells if deemed relevant. This second
> approach sounds way more relevant than the first one to avoid useless
> code duplication, so here is a series bringing NVMEM cells content to
> the user through sysfs.
>
> Here is a real life example with a Marvell Armada 7040 TN48m switch:
>
> $ nvmem=3D/sys/bus/nvmem/devices/1-00563/
> $ for i in `ls -1 $nvmem/cells/*`; do basename $i; hexdump -C $i | head -=
n1; done
> country-code@77
> 00000000  54 57                                             |TW|
> crc32@88
> 00000000  bb cd 51 98                                       |..Q.|
> device-version@49
> 00000000  02                                                |.|
> diag-version@80
> 00000000  56 31 2e 30 2e 30                                 |V1.0.0|
> label-revision@4c
> 00000000  44 31                                             |D1|
> mac-address@2c
> 00000000  18 be 92 13 9a 00                                 |......|
> manufacture-date@34
> 00000000  30 32 2f 32 34 2f 32 30  32 31 20 31 38 3a 35 39  |02/24/2021 1=
8:59|
> manufacturer@72
> 00000000  44 4e 49                                          |DNI|
> num-macs@6e
> 00000000  00 40                                             |.@|
> onie-version@61
> 00000000  32 30 32 30 2e 31 31 2d  56 30 31                 |2020.11-V01|
> platform-name@50
> 00000000  38 38 46 37 30 34 30 2f  38 38 46 36 38 32 30     |88F7040/88F6=
820|
> product-name@d
> 00000000  54 4e 34 38 4d 2d 50 2d  44 4e                    |TN48M-P-DN|
> serial-number@19
> 00000000  54 4e 34 38 31 50 32 54  57 32 30 34 32 30 33 32  |TN481P2TW204=
2032|
> vendor@7b
> 00000000  44 4e 49                                          |DNI|
>
> This layout with a cells/ folder containing one file per cell has been
> legitimately challenged by John Thomson. I am not against the idea of
> having a sub-folder per cell but I did not find a relevant way to do
> that so for know I did not change the sysfs organization. If someone
> really wants this other layout, please provide a code snipped which I
> can integrate.
>
> Current support does not include:
> * The knowledge of the type of data (binary vs. ASCII), so by default
>   all cells are exposed in binary form.
> * Write support.
>
> Changes in v8:
> * Fix a compilation warning whith !CONFIG_NVMEM_SYSFS.
> * Add a patch to return NULL when no layout is found (reported by Dan
>   Carpenter).
> * Fixed the documentation as well as the cover letter regarding the
>   addition of addresses in the cell names.

It seems this version no longer creates cells for legacy DT layout formats?
So while I assume the issue I ran into is fixed, I don't see any cells
created on the MT8183 either.

Is this intended?

ChenYu

> Changes in v7:
> * Rework the layouts registration mechanism to use the platform devices
>   logic.
> * Fix the two issues reported by Daniel Golle and Chen-Yu Tsai, one of
>   them consist in suffixing '@<offset>' to the cell name to create the
>   sysfs files in order to be sure they are all unique.
> * Update the doc.
>
> Changes in v6:
> * ABI documentation style fixes reported by Randy Dunlap:
>   s|cells/ folder|"cells" folder|
>   Missing period at the end of the final note.
>   s|Ex::|Example::|
> * Remove spurious patch from the previous resubmission.
>
> Resending v5:
> * I forgot the mailing list in my former submission, both are absolutely
>   identical otherwise.
>
> Changes in v5:
> * Rebased on last -rc1, fixing a conflict and skipping the first two
> patches already taken by Greg.
> * Collected tags from Greg.
> * Split the nvmem patch into two, one which just moves the cells
>   creation and the other which adds the cells.
>
> Changes in v4:
> * Use a core helper to count the number of cells in a list.
> * Provide sysfs attributes a private member which is the entry itself to
>   avoid the need for looking up the nvmem device and then looping over
>   all the cells to find the right one.
>
> Changes in v3:
> * Patch 1 is new: fix a style issue which bothered me when reading the
>   core.
> * Patch 2 is new: Don't error out when an attribute group does not
>   contain any attributes, it's easier for developers to handle "empty"
>   directories this way. It avoids strange/bad solutions to be
>   implemented and does not cost much.
> * Drop the is_visible hook as it is no longer needed.
> * Stop allocating an empty attribute array to comply with the sysfs core
>   checks (this check has been altered in the first commits).
> * Fix a missing tab in the ABI doc.
>
> Changes in v2:
> * Do not mention the cells might become writable in the future in the
>   ABI documentation.
> * Fix a wrong return value reported by Dan and kernel test robot.
> * Implement .is_bin_visible().
> * Avoid overwriting the list of attribute groups, but keep the cells
>   attribute group writable as we need to populate it at run time.
> * Improve the commit messages.
> * Give a real life example in the cover letter.
>
> Miquel Raynal (8):
>   nvmem: core: Create all cells before adding the nvmem device
>   nvmem: core: Return NULL when no nvmem layout is found
>   nvmem: core: Do not open-code existing functions
>   nvmem: core: Track the registered devices
>   nvmem: core: Notify when a new layout is registered
>   nvmem: core: Rework layouts to become platform devices
>   ABI: sysfs-nvmem-cells: Expose cells through sysfs
>   nvmem: core: Expose cells through sysfs
>
>  Documentation/ABI/testing/sysfs-nvmem-cells |  21 ++
>  drivers/nvmem/core.c                        | 269 +++++++++++++++++---
>  drivers/nvmem/layouts/onie-tlv.c            |  39 ++-
>  drivers/nvmem/layouts/sl28vpd.c             |  39 ++-
>  include/linux/nvmem-consumer.h              |   4 +-
>  include/linux/nvmem-provider.h              |  11 +-
>  6 files changed, 329 insertions(+), 54 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-nvmem-cells
>
> --
> 2.34.1
>
