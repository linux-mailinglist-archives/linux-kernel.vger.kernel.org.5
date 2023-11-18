Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E855F7F0023
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 15:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjKROcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 09:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjKROcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 09:32:35 -0500
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 18 Nov 2023 06:32:31 PST
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [IPv6:2001:1600:4:17::190e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E82A6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 06:32:31 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SXbfQ4L87zMpy3H;
        Sat, 18 Nov 2023 14:25:50 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SXbfQ1NRXzMppt6;
        Sat, 18 Nov 2023 15:25:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bigler.io;
        s=20200409; t=1700317550;
        bh=H+1zXZpsNczUhfrvwhG7NO2oFhIsltQEiYuOsbFYusE=;
        h=Date:Subject:From:Reply-To:To:Cc:From;
        b=u+0Wy3rDOk7Ccf38HwkOLq+WEGFGSOr0cPL92/DHC9HceH5spA0CbnWi5dvgz1ISg
         NggCA8dihtRH2oHxb7eeAN/Rog+Dr7wX4PWFBoYnm/RlmNXFJEnIibuIkTaqko+8Uo
         iUEF+3ZZrD+4FWkBZgNHF9AGelrIFkvNzLXwtR3w=
Message-ID: <8a415902c751cdbb4b20ce76569216ed@mail.infomaniak.com>
Date:   Sat, 18 Nov 2023 15:25:50 +0100
Subject: spi: imx: Increase imx51 ecspi burst length fails on imx6dl and
 imx8mm
From:   linux@bigler.io
Reply-To: linux@bigler.io
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     linux@bigler.io
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-WS-User-Origin: eyJpdiI6IlVmUDV4anJ4dUhYY0pOUTBhSDVPWmc9PSIsInZhbHVlIjoiU1o1MGtmTXVRZ0FZQkdqTFRrdEh6QT09IiwibWFjIjoiYzUyOGEyY2IwYThkZmRhNTRiZjA0MjU1ZTA1ZGNiNGEwMzdhYjY0YjgwZjg1ODhkZTE3ZGFiMGRmZGI4ZGQ3ZSIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6IklLSzNBa2lGNlNEcVFQMFZ2eW40K0E9PSIsInZhbHVlIjoid1pOdnhuR3c0NVprbUkvQmdHa1h2dz09IiwibWFjIjoiMmIxMzRiMGExMTJmNGMwOTQ1YjllZmMzN2FkNTU5YTljMmIxZDY3MmZiODljZTI4NjRlZjViMzlmMTRiMjI5NCIsInRhZyI6IiJ9
X-WS-Location: eJxzKUpMKykGAAfpAmU-
X-Mailer: Infomaniak Workspace (1.3.595)
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrade from kernel 6.5.11 to 6.6.1 the spi-devices on my hw=20
colibri-imx6dl and verdin-imx8mm are not working anymore (TPM2 and SPI-SRAM=
).

Analyzing the problem showed that the 2 commits introduced the problem:

spi: Increase imx51 ecspi burst length based on transfer length
15a6af94a2779d5dfb42ee4bfac858ea8e964a3f

spi: imx: Take in account bits per word instead of assuming 8-bits
5f66db08cbd3ca471c66bacb0282902c79db9274

Reverting the commits solved the problem.

The analyse with the logic-analyser showed a wrong number of transmitted =
=20
bytes and wrong data.
When I try to send 127 Byte with a incrementing pattern (0x01,0x02,0x03,..)=
,
504 Bytes are sent (0x00,0x00,0x01 0x00,0x00,0x00,0x02, 0x00,0x00,0x00,0x03=
).
We tested with different sizes and patterns, all are not ok.
While analysing the configuration and code I was not able to see any obviou=
s
mistake.

Has someone else discovered such misbehaviour or has any idea what is wrong=
?
Best Regards
Stefan
