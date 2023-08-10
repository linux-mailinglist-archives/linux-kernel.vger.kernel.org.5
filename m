Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92747782B5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjHJVaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjHJVav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:30:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A4026A0;
        Thu, 10 Aug 2023 14:30:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B31F64AA0;
        Thu, 10 Aug 2023 21:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAF1C433C7;
        Thu, 10 Aug 2023 21:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691703049;
        bh=HwppCFPvwSwZx+wlLwGlbLVfLPSGego30HtZ0L4HvQM=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=IMqNoFk7JXYVGd6jH3jDBTjTxiqE9IECKfWOkS6Qgk+rlo/KlU+QnlNlYqbvL7xU7
         QjYJ+UJ3yRGp2MKUCD8dfs52rRrJs3Flo1O+HmgKWdFqFtn+kHB4nTgIGJf1h4BriQ
         WAHbapPKuNOmohS74HIji0NgKai1JhjArjU+8f3EQ/Osq1g35mmmjSjFwQ/8YojfMm
         IQEiax56RX6H+YMhT1eF5XXn7VDf4WbH/nAbvp4lwBFE15V4DBiwVX85u8f2Sj0YOU
         tLVw7srzl7npvlNs0TTZcQaMccVhem8KpHfKUkeyOsej/E98BQ37fpaogkc5Ut/RM6
         cXqAbdqCs6jQw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Aug 2023 00:30:45 +0300
Message-Id: <CUP6OI811G6B.1TN6YQTBRA81A@suppilovahvero>
Cc:     "Mimi Zohar" <zohar@linux.ibm.com>,
        "Eric Snowberg" <eric.snowberg@oracle.com>,
        "Paul Moore" <paul@paul-moore.com>,
        "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] integrity: PowerVM machine keyring enablement
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Nayna Jain" <nayna@linux.ibm.com>,
        <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230809195315.1085656-1-nayna@linux.ibm.com>
 <20230809195315.1085656-6-nayna@linux.ibm.com>
In-Reply-To: <20230809195315.1085656-6-nayna@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 9, 2023 at 10:53 PM EEST, Nayna Jain wrote:
> Update Kconfig to enable machine keyring and limit to CA certificates
> on PowerVM. Only key signing CA keys are allowed.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-and-tested-by: Mimi Zohar <zohar@linux.ibm.com>
>
> ---
>  security/integrity/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
> index ec6e0d789da1..232191ee09e3 100644
> --- a/security/integrity/Kconfig
> +++ b/security/integrity/Kconfig
> @@ -67,7 +67,9 @@ config INTEGRITY_MACHINE_KEYRING
>  	depends on SECONDARY_TRUSTED_KEYRING
>  	depends on INTEGRITY_ASYMMETRIC_KEYS
>  	depends on SYSTEM_BLACKLIST_KEYRING
> -	depends on LOAD_UEFI_KEYS
> +	depends on LOAD_UEFI_KEYS || LOAD_PPC_KEYS
> +	select INTEGRITY_CA_MACHINE_KEYRING if LOAD_PPC_KEYS
> +	select INTEGRITY_CA_MACHINE_KEYRING_MAX if LOAD_PPC_KEYS
>  	help
>  	 If set, provide a keyring to which Machine Owner Keys (MOK) may
>  	 be added. This keyring shall contain just MOK keys.  Unlike keys
> --=20
> 2.31.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
