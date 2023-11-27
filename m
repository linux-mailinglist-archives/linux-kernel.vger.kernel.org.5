Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8137B7F9ED9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjK0LoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjK0LoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:44:02 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1648D13A;
        Mon, 27 Nov 2023 03:44:09 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1A39440E0031;
        Mon, 27 Nov 2023 11:44:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jX3lP-NCWyzG; Mon, 27 Nov 2023 11:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701085444; bh=ELUYa989rs/Q1r1rMywu+qeroXaCS1TWL2jrEJWHU/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F9s9/X26C/Ph1w0ByD8+3ZfuBni82sHS+PZZQGhOjHo9mS2lG7eNWR7Mz9XD9Vq5j
         6MQHqt5O4u4aOadL7lRzoCplG+zmulYwF/G+CRspKgli0frzKixPTswX14g3g+/0ZE
         OQN/byGnJnVOcN1nI6bWr3+x6ddxiZMZ8AN17FaA2PEoCOU9XTfmcfd8ivhtBwDnqb
         pomyoGGn1gr/5sf9AAwphLVxZGUHcWyT2AWOeoc/4OyAt7DXuoXc0jmkpm1Nttr6PD
         ci5h+Pm3DlG43yZZDCyPytiFb/IenmIJRaEGNL1IyHVviTaYi3TEF5ehHhZftQBGHu
         16tcvitSASIsfZnUmHuXkV77jy/7rFOThAUN8pfWfB9VZjCZu3w12LuAOsRqHU0C3d
         gikrjfbunIk0FIJ9vI22EJJ5M/Rhevcfqt0UCs6YYq2VmQhRS3lg7ZFAXOVvwwxZNO
         iAJMuNhjfO6dKtnasl2JFTeFzg8QM5v2XODy4bTPU3B4fBQTlnzOqApZxQwEZa5WE+
         Rd4xZRXD2BcRNH24H68NeDFDa/lOFb/erIsa3dd5bv9a92AGTAjj6AtyWEnrCUBPuB
         GLx1ity7vFD0pgYZNsnCBG+zrDKnb26rRb4AorjVAnfjCT9hyk39bvBCI2wSchU5Vj
         p7vWocI9Ym1Ad0c6dGO4QaY4=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 84EA040E01A5;
        Mon, 27 Nov 2023 11:43:55 +0000 (UTC)
Date:   Mon, 27 Nov 2023 12:43:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org, Avadhut.Naik@amd.com,
        Smita.KoralahalliChannabasappa@amd.com,
        amd-gfx@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 05/20] x86/mce/amd: Use helper for UMC bank type check
Message-ID: <20231127114349.GMZWSA9QADGqCXnTYe@fat_crate.local>
References: <20231118193248.1296798-1-yazen.ghannam@amd.com>
 <20231118193248.1296798-6-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231118193248.1296798-6-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 01:32:33PM -0600, Yazen Ghannam wrote:
> @@ -714,14 +721,10 @@ static bool legacy_mce_is_memory_error(struct mce *m)
>   */
>  static bool smca_mce_is_memory_error(struct mce *m)
>  {
> -	enum smca_bank_types bank_type;
> -
>  	if (XEC(m->status, 0x3f))
>  		return false;
>  
> -	bank_type = smca_get_bank_type(m->extcpu, m->bank);
> -
> -	return bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2;
> +	return smca_umc_bank_type(m->ipid);

	return FIELD_GET(MCI_IPID_HWID, ipid) == IPID_TYPE_UMC;

after having done:

#define IPID_TYPE_UMC	0x96;

and you don't need that silly helper.

And then you can do more cleanups ontop by doing

        /* Unified Memory Controller MCA type */
        { SMCA_UMC,      HWID_MCATYPE(IPID_TYPE_UMC, 0x0)        },
        { SMCA_UMC_V2,   HWID_MCATYPE(IPID_TYPE_UMC, 0x1)        },

and have all the numbering properly defined and abstracted away.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
