Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31E7800753
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbjLAJlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjLAJlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:41:17 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DB710FA;
        Fri,  1 Dec 2023 01:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1701423678;
        bh=SCXwSfrAxD/vcI+luNSFDB5IfnqNmy8gsBQXv6JPB3w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IIfeYu5L/5RzK2f/xIVe9akYSPr9OUtIDCqF0ZSWukqAoxSbGvI47Q/IMUaFCc5NX
         eR0adi7iztkf7mgm/uta3inz5/CWd/gu+euafba3GosMPRgAuIf+MHDBOWn574T1m6
         PjCMFpmeKFP4y0D2qWqpIjaaAdVksQf4SK2EngcfmtagQ472NxbKD9ofpGm7ssHsXN
         4pDDGQsscGpo0FjRxRFNGMAu5QKkFlmzJfpiaREE4EP7sP+tKswZAMF7WsFSdcefnw
         dFCIRPMk7U2ojLzveYhueAfmIcBFapD5wEBdvAzBe7rqBptKMbPNXcD/enUkqJ/sRr
         tkny6rYrj9JMA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4ShSk61ydCz4xVP;
        Fri,  1 Dec 2023 20:41:18 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Justin Stitt <justinstitt@google.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH] scsi: ibmvscsi: replace deprecated strncpy with strscpy
In-Reply-To: <20231030-strncpy-drivers-scsi-ibmvscsi-ibmvscsi-c-v1-1-f8b06ae9e3d5@google.com>
References: <20231030-strncpy-drivers-scsi-ibmvscsi-ibmvscsi-c-v1-1-f8b06ae9e3d5@google.com>
Date:   Fri, 01 Dec 2023 20:41:10 +1100
Message-ID: <87jzpy1cqx.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Stitt <justinstitt@google.com> writes:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> We expect partition_name to be NUL-terminated based on its usage with
> format strings:
> |       dev_info(hostdata->dev, "host srp version: %s, "
> |                "host partition %s (%d), OS %d, max io %u\n",
> |                hostdata->madapter_info.srp_version,
> |                hostdata->madapter_info.partition_name,
> |                be32_to_cpu(hostdata->madapter_info.partition_number),
> |                be32_to_cpu(hostdata->madapter_info.os_type),
> |                be32_to_cpu(hostdata->madapter_info.port_max_txu[0]));
> ...
> |       len = snprintf(buf, PAGE_SIZE, "%s\n",
> |                hostdata->madapter_info.partition_name);
>
> Moreover, NUL-padding is not required as madapter_info is explicitly
> memset to 0:
> |       memset(&hostdata->madapter_info, 0x00,
> |                       sizeof(hostdata->madapter_info));
>
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.

I gave it a quick boot, no issues.

Tested-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
