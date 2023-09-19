Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0162F7A688B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjISQDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjISQDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:03:09 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A4093
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 09:03:02 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso93787811fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 09:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695139381; x=1695744181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdCAOkMTmAW6whrbSu7a2PqS1auXhVVDN1XDsIh3f0g=;
        b=gyZqPYNE59oFw+i1eEAPz+lNzx1lSi09jD6SyG8rTjET6XrY32OhV/oHqgQO0NthzI
         qePuYf5rjFucw8Nsi/RW4pTAPrkyv+KoIPuIqCahernJQpK4lueAN1uEFcphFxjH7Yvu
         4c/hnDd96SVVpTgry936B356AvFOpKxQ/+fkQt5li85RxsNsq6cQQ/lNSFS+qrZBNiK5
         BoDkgeyuGl+77R01UCEnSLm3JyQ0LtvxDpkbCY/xAV6e96PNQkYPrtQPjCq3Kg99FsTs
         bmplIxHFQQXbKwJNvECDB+qtca8ReEf9NdNwdKe97QARyFyijAlsEJ+jMVj1rRZMIasB
         43/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695139381; x=1695744181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdCAOkMTmAW6whrbSu7a2PqS1auXhVVDN1XDsIh3f0g=;
        b=g8NPgybHN0ab0zp3sMtoBVA1oO31EmWFOb9ipJbI71KruiKlVGBq4/2s8XD6dmz+Gr
         +PQmgy6n577JQGHjjg57UCHq0qINj2B/8KYhtz7TRZO4xvyFj83J7Hkle5AxIxux1Z7H
         sQdg5l4Rj3Tmh2EPPQ2ic6EmztYC/4UDK8nNyTjvBBf71m74hBoatIFcDxeqRZK8TnZS
         rtK67gRU3tDoY7QaiDZ3uO8UjekfnMuCJmS/3yJzhGNl9cKoCiUVQK4JXYe1UaFS7t45
         WR/UtXB2xHJgRfwTkwzgaD/G8t6B0g7Ah7Pu1SaJbb/F5UAe0Wa+MfKOPfoO1QusKOiz
         N7Wg==
X-Gm-Message-State: AOJu0YyflOUX8xA7QFVzq1YmLYbI3MPGWMOvKuevVlMduWzg2gwb8CCV
        88qAZqTYBTTjhyJgOGAupSYtiHB72aw7CWdt7ZqasA==
X-Google-Smtp-Source: AGHT+IHA0KvMFC5B/OgYDUgOiwilx/o4jhSGmVMuYsiT2c6ZVOZTbPVujBPhpnyfuHGpvVifm9iRng==
X-Received: by 2002:a2e:9999:0:b0:2bc:c89e:d8df with SMTP id w25-20020a2e9999000000b002bcc89ed8dfmr10646034lji.48.1695139380700;
        Tue, 19 Sep 2023 09:03:00 -0700 (PDT)
Received: from 1.. (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id jx10-20020a170906ca4a00b009ae3e6c342asm340857ejb.111.2023.09.19.09.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 09:03:00 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <mwalle@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3 00/41] mtd: spi-nor: clean the flash_info database up
Date:   Tue, 19 Sep 2023 19:02:56 +0300
Message-Id: <169513932067.27768.2341524831414044809.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807-mtd-flash-info-db-rework-v3-0-e60548861b10@kernel.org>
References: <20230807-mtd-flash-info-db-rework-v3-0-e60548861b10@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=5210; i=tudor.ambarus@linaro.org; h=from:subject:message-id; bh=g8SbyLrdIPwEfgcmqq1bAcZZTilDdZ2HAc0rLIr7njM=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlCcYs25yE+Es7IZBpFahE5U2qBZKWv6j8ea+Pu vU9OnmhNjmJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZQnGLAAKCRBLVU9HpY0U 6TP1CACjyF/tQReio0iuKb+E3XjwsuhqyoO6ZfkN5dSe06CgDaACacU9MaiHonwTbT6oHam7w5b pSK4KHWejGdClarHiXi3oi8qE8XIOUYC7SZzLRMzPPERKCmtpAKDKiYOW7472+mE8TN6npSckez v5dB9yCNhFHFv9DlF12IpaaJG7RJSwweGeghRFk81ZFPpfSWt5k23b1ZtEXNc+QJcO2LX17HIcy ZxHQhqaE32J07LSyp0aLPkcgJSgEXuVwNO2SSB4fZtHBKkjURrE+nw5U4kx+8UG+pWihORVE0dG 2xOreBLdg1XRFUI9nxQ+N4yQGfi3NTNpQRfcNKafdTp8lFx9
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Sep 2023 12:16:18 +0200, Michael Walle wrote:
> The goal is to have slim entries for *new* entries and to have a
> flexible macro to specify the flash ID and get rid of the former
> INFOx() macros with the hardcoded ID length.
> 
> Here is are some examples how an entry of flash_info will look like
> after the conversion:
>   {
>     .id = SNOR_ID(0xef, 0x80, 0x20),
>     .name = "w25q512nwm",
>     .otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
>   }
> 
> [...]

Made the agreed adjustments and applied to
git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git,
spi-nor/next branch. Thanks!

[01/41] mtd: spi-nor: remove catalyst 'flashes'
        https://git.kernel.org/mtd/c/022545e057f3
[02/41] mtd: spi-nor: remove Fujitsu MB85RS1MT support
        https://git.kernel.org/mtd/c/d9cd5c9a6fe2
[03/41] mtd: spi-nor: xilinx: use SPI_NOR_ID() in S3AN_INFO()
        https://git.kernel.org/mtd/c/74b7ad768353
[04/41] mtd: spi-nor: xilinx: remove addr_nbytes from S3AN_INFO()
        https://git.kernel.org/mtd/c/afbfb8c5fb57
[05/41] mtd: spi-nor: convert .n_sectors to .size
        https://git.kernel.org/mtd/c/0554effe99f6
[06/41] mtd: spi-nor: default page_size to 256 bytes
        https://git.kernel.org/mtd/c/d0cfd228b34c
[07/41] mtd: spi-nor: store .n_banks in struct spi_nor_flash_parameter
        https://git.kernel.org/mtd/c/9983e6da917d
[08/41] mtd: spi-nor: default .n_banks to 1
        https://git.kernel.org/mtd/c/e255a79162b6
[09/41] mtd: spi-nor: push 4k SE handling into spi_nor_select_uniform_erase()
        https://git.kernel.org/mtd/c/9b6bb07eadaf
[10/41] mtd: spi-nor: make sector_size optional
        https://git.kernel.org/mtd/c/6dec24b1a34c
[11/41] mtd: spi-nor: drop .parse_sfdp
        https://git.kernel.org/mtd/c/3ea3f0ac242c
[12/41] mtd: spi-nor: introduce (temporary) INFO0()
        https://git.kernel.org/mtd/c/95c6e3d26691
[13/41] mtd: spi-nor: move the .id and .id_len into an own structure
        https://git.kernel.org/mtd/c/2d7f3a08875b
[14/41] mtd: spi-nor: rename .otp_org to .otp and make it a pointer
        https://git.kernel.org/mtd/c/83e62ffa7d1b
[15/41] mtd: spi-nor: add SNOR_ID() and SNOR_OTP()
        https://git.kernel.org/mtd/c/3e85be98875a
[16/41] mtd: spi-nor: remove or move flash_info comments
        https://git.kernel.org/mtd/c/da7e48db514b
[17/41] mtd: spi-nor: atmel: convert flash_info to new format
        https://git.kernel.org/mtd/c/f9d52efb3953
[18/41] mtd: spi-nor: eon: convert flash_info to new format
        https://git.kernel.org/mtd/c/ca7fb359d0a1
[19/41] mtd: spi-nor: esmt: convert flash_info to new format
        https://git.kernel.org/mtd/c/5a329c40894b
[20/41] mtd: spi-nor: everspin: convert flash_info to new format
        https://git.kernel.org/mtd/c/6ecc52e44dbf
[21/41] mtd: spi-nor: gigadevice: convert flash_info to new format
        https://git.kernel.org/mtd/c/29cd12e08cd3
[22/41] mtd: spi-nor: intel: convert flash_info to new format
        https://git.kernel.org/mtd/c/3de6404725df
[23/41] mtd: spi-nor: issi: convert flash_info to new format
        https://git.kernel.org/mtd/c/856f61797cbc
[24/41] mtd: spi-nor: macronix: convert flash_info to new format
        https://git.kernel.org/mtd/c/09e5a29fa3ad
[25/41] mtd: spi-nor: micron-st: convert flash_info to new format
        https://git.kernel.org/mtd/c/8eb4eb838f9f
[26/41] mtd: spi-nor: spansion: convert flash_info to new format
        https://git.kernel.org/mtd/c/bb2d5c67b926
[27/41] mtd: spi-nor: sst: convert flash_info to new format
        https://git.kernel.org/mtd/c/47541a60636a
[28/41] mtd: spi-nor: winbond: convert flash_info to new format
        https://git.kernel.org/mtd/c/348d772d04fa
[29/41] mtd: spi-nor: xilinx: use new macros in S3AN_INFO()
        https://git.kernel.org/mtd/c/8e52f54ca994
[30/41] mtd: spi-nor: xmc: convert flash_info to new format
        https://git.kernel.org/mtd/c/9e02cb5b1d09
[31/41] mtd: spi-nor: atmel: sort flash_info database
        https://git.kernel.org/mtd/c/a16ae25022d9
[32/41] mtd: spi-nor: eon: sort flash_info database
        https://git.kernel.org/mtd/c/bc16dfcbf27f
[33/41] mtd: spi-nor: gigadevice: sort flash_info database
        https://git.kernel.org/mtd/c/1d8e64f40b24
[34/41] mtd: spi-nor: issi: sort flash_info database
        https://git.kernel.org/mtd/c/947bb8f24b61
[35/41] mtd: spi-nor: macronix: sort flash_info database
        https://git.kernel.org/mtd/c/b0eea634d086
[36/41] mtd: spi-nor: micron-st: sort flash_info database
        https://git.kernel.org/mtd/c/9df3c9ac6ea6
[37/41] mtd: spi-nor: spansion: sort flash_info database
        https://git.kernel.org/mtd/c/8770a6a89b15
[38/41] mtd: spi-nor: sst: sort flash_info database
        https://git.kernel.org/mtd/c/1de410815768
[39/41] mtd: spi-nor: winbond: sort flash_info entries
        https://git.kernel.org/mtd/c/d3b5ea3cc5ba
[40/41] mtd: spi-nor: atmel: drop duplicate entry
        https://git.kernel.org/mtd/c/1d4c725453c8
[41/41] mtd: spi-nor: core: get rid of the INFOx() macros
        https://git.kernel.org/mtd/c/914efd602a80

Cheers,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>
