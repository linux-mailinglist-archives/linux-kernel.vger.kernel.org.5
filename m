Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAEF7D8573
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345374AbjJZPCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjJZPCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:02:33 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318FA187
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:02:31 -0700 (PDT)
Received: from [127.0.0.1] (unknown [154.135.84.71])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id B3A986FB;
        Thu, 26 Oct 2023 17:02:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1698332546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GIq7VKze7/YNlHMTHO1501ppnVinYDbNtzevWz67otA=;
        b=mwnfwqBdp+eT/hf0Iro83+z7Ih6IJQ+4AipPLZq9fCEfdSLFl3IcdCH3GKmN08MRc7tEyH
        D6k1GbUg197kRFHWWFZxbKngq9yCqQ1g+TageTzc2LUHrMN+UUdNZRVoXsKuB8uCf5MWul
        T1prrv7QW1+Bzibu+6xgYJigWV9Sgt3RXVAcNHvb33J8pYFv7i7LtIwaB5zuOPGeNIREIn
        Th1HNvaQ0ZIPChyUBWyveZmgGjvN+vYzi8wfbw0WuUkFSX3WqrdBa7kRHOUM03DNDQkpWR
        iTbvF3Qhr0WcVpzij52oioK3rtNnAPh55T/VLTCkpNBEIsmASMXrVySB98oNww==
Date:   Thu, 26 Oct 2023 18:02:20 +0300
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <pratyush@kernel.org>,
        AceLan Kao <acelan.kao@canonical.com>
CC:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4=5D_mtd=3A_spi-nor=3A_Improve_?= =?US-ASCII?Q?reporting_for_software_reset_failures?=
User-Agent: K-9 Mail for Android
In-Reply-To: <mafs0fs1xmrit.fsf@kernel.org>
References: <20231026012017.518610-1-acelan.kao@canonical.com> <mafs0fs1xmrit.fsf@kernel.org>
Message-ID: <8D87B330-8FA1-46BE-949E-5A8DFB8AACF3@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 26=2E Oktober 2023 16:39:54 OESZ schrieb Pratyush Yadav <pratyush@kernel=
=2Eorg>:
>On Thu, Oct 26 2023, AceLan Kao wrote:
>
>> From: "Chia-Lin Kao (AceLan)" <acelan=2Ekao@canonical=2Ecom>
>>
>> When the software reset command isn't supported, we now report it
>> as an informational message(dev_info) instead of a warning(dev_warn)=2E
>> This adjustment helps avoid unnecessary alarm and confusion regarding
>> software reset capabilities=2E
>
>I still think the soft reset command deserves a warn, and not an info=2E
>Because it _is_ a bad thing if you need to soft reset and are unable to
>do so=2E Your bootloader (or linux if you rmmod and modprobe again) might
>not be able to detect the flash mode and operate it properly=2E=20

agreed=2E=2E but=2E=2E=20

>I think we should just not unconditionally run this and instead only
>call it when the flash reset is not connected -- that is only call this
>under a check for SNOR_F_BROKEN_RESET, like we do for 4-byte addressing
>mode=2E

=2E=2E keep in mind that this is a restriction of the flash controller=2E =
the Intel one seems to be the only affected one (for now) and it's doing a =
reset (according to mika) on its own=2E=20

snor_broken_reset is a property of the flash=2E=20


>I don't have a strong opposition to this patch but I do think it is
>fixing the problem in the wrong place=2E

if the flash controller doesn't let you issue a soft reset (or does so on =
its own), what's the fix?

-michael=20

