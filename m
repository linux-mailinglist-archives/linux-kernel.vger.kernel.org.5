Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107CB782960
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbjHUMq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjHUMqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:46:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB6BC2;
        Mon, 21 Aug 2023 05:46:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0608A6167C;
        Mon, 21 Aug 2023 12:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0693C433C9;
        Mon, 21 Aug 2023 12:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692622013;
        bh=4DulVPM+YpEHTrMYx1DRU9SIjOoHAPVyvzLnF4PXuEM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aAO5mpJBgGTfndj3tXm5mRcOXJyni8kExU7/Uz4TSEdWoJo9VC/tanlTq/fsyySm1
         VHLRRAbkLZr007Q3JJBVh62nairquAHcxRrUzEENgeRskLMglxjpybsblFuWQIesyy
         oaNb+drd7/Zd7BWibycb2Z7lgpWg5JzYk9Ke8u3x04FKqcvZ2XuTBlTRMUilQcTmO6
         17EdXlaVrnvw99lYBxnMsKtZV0kHzcIlgxo8qzE5RVX1A7J3mothRXbcy7ZUsUrm9B
         Tn8pD3oSlZr1m7kWz1eJ4S1ZS3EJsq7SJrdw9I5fHns59ltJ8eRocU8oFlS6qlH2nW
         JkwZ4Bpxf3m3Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Greenman, Gregory" <gregory.greenman@intel.com>
Cc:     "duminjie@vivo.com" <duminjie@vivo.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: Re: [PATCH v1] drivers/net: intel: iwlwifi: fix two parameters
 check in iwl_mei_dbgfs_register()
References: <20230712131407.16462-1-duminjie@vivo.com>
        <7860d8cbac1eb699de033210c8256afaa8f7b35b.camel@intel.com>
Date:   Mon, 21 Aug 2023 15:46:49 +0300
In-Reply-To: <7860d8cbac1eb699de033210c8256afaa8f7b35b.camel@intel.com>
        (Gregory Greenman's message of "Sun, 13 Aug 2023 15:27:38 +0000")
Message-ID: <877cpok1fq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

"Greenman, Gregory" <gregory.greenman@intel.com> writes:

> Hi,
>
> On Wed, 2023-07-12 at 21:14 +0800, Minjie Du wrote:
>> Make IS_ERR() judge the debugfs_create_dir() function return
>> in iwl_mei_dbgfs_register().
>>=20
>> Signed-off-by: Minjie Du <duminjie@vivo.com>
>> ---
>> =C2=A0drivers/net/wireless/intel/iwlwifi/mei/main.c | 2 +-
>> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c
>> b/drivers/net/wireless/intel/iwlwifi/mei/main.c
>> index 54445f39f..e5d203a62 100644
>> --- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
>> +++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
>> @@ -1888,7 +1888,7 @@ static void iwl_mei_dbgfs_register(struct iwl_mei =
*mei)
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mei->dbgfs_dir =3D debug=
fs_create_dir(KBUILD_MODNAME, NULL);
>> =C2=A0
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!mei->dbgfs_dir)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(mei->dbgfs_dir))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return;
>> =C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0debugfs_create_ulong("st=
atus", S_IRUSR,
>
> The title should be:
>
> wifi: iwlwifi: mei: ...
>
> Also, why two parameters? It only fixes dbgfs_dir?

It would be better to just remove the check, from debugfs_create_dir():

 * NOTE: it's expected that most callers should _ignore_ the errors returned
 * by this function. Other debugfs functions handle the fact that the "dent=
ry"
 * passed to them could be an error and they don't crash in that case.
 * Drivers should generally work fine even if debugfs fails to init anyway.


--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
