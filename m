Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4377275A229
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjGSWo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjGSWox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:44:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CEC1FE6;
        Wed, 19 Jul 2023 15:44:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 999BF61840;
        Wed, 19 Jul 2023 22:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E474FC433CA;
        Wed, 19 Jul 2023 22:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689806692;
        bh=KpGFKEUuiIitS8UfirDt+cuq2SuWxsDx+OdYFcxFU7M=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=JpRakYUuJVAkIJR5HXblpzkI9PdUqU4i6XmbSMiTmtzfemV4WD1akHLy5SRrSFQpN
         un+aQppiWBaKop97bHOHt21+1n5Lni5eMuEOpIRbNOIQw+sidPK0D5Pg+bixMmM/iT
         5x+yJ277k0CF6zsE7cPVFO/voXF/CTgmkLAMhiOiddjfli33xDNSUhJZVyNPVcWVMe
         /N7mjpOjsORLyfseS1M97Cx+eWLMUz5gcr35FhKsYEKzfkvyhrCKdrQjUpIFLkHSCx
         rHSKNa1leBY7DM/IVkwNmgKkCvpnnBeCpNNjaU+nXSyos4fD53d+gJSxubvCXqzjo2
         SL/39Pi2aAirg==
Date:   Wed, 19 Jul 2023 15:37:02 -0700
From:   Kees Cook <kees@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Kees Cook <keescook@chromium.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: Crash in VirtualBox virtual machines running kernel 6.5
User-Agent: K-9 Mail for Android
In-Reply-To: <d29c7e51-deff-c82f-81d4-8322b0c28d22@lwfinger.net>
References: <ab3a70e9-60ed-0f13-e3d4-8866eaccc8c1@lwfinger.net> <202307190823.086EFD42D9@keescook> <202307190835.752D710D@keescook> <d29c7e51-deff-c82f-81d4-8322b0c28d22@lwfinger.net>
Message-ID: <DC28E9B9-0F7A-4CA5-9FA9-6A4AB5DCD9D5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 19, 2023 2:24:52 PM PDT, Larry Finger <Larry=2EFinger@lwfinger=2Ene=
t> wrote:
>On 7/19/23 10:36, Kees Cook wrote:
>> Okay, please try:
>>=20
>> diff --git a/fs/vboxsf/shfl_hostintf=2Eh b/fs/vboxsf/shfl_hostintf=2Eh
>> index aca829062c12=2E=2E902fe3224453 100644
>> --- a/fs/vboxsf/shfl_hostintf=2Eh
>> +++ b/fs/vboxsf/shfl_hostintf=2Eh
>> @@ -68,12 +68,11 @@ struct shfl_string {
>>     	/** UTF-8 or UTF-16 string=2E Nul terminated=2E */
>>   	union {
>> -		u8 utf8[2];
>> -		u16 utf16[1];
>> -		u16 ucs2[1]; /* misnomer, use utf16=2E */
>> +		DECLARE_FLEX_ARRAY(u8, utf8);
>> +		DECLARE_FLEX_ARRAY(u16, utf16);
>>   	} string;
>>   };
>> -VMMDEV_ASSERT_SIZE(shfl_string, 6);
>> +VMMDEV_ASSERT_SIZE(shfl_string, 4);
>>     /* The size of shfl_string w/o the string part=2E */
>>   #define SHFLSTRING_HEADER_SIZE  4
>>=20
>>=20
>> The size assert doesn't seem to be used anywhere else, but I can do a
>> more careful binary analysis later today=2E=2E=2E''
>
>Kees,
>
>The testing was harder than I expected=2E My standard kernel would not lo=
ad the system disk on the VM, thus I had to build one using my distros conf=
iguration=2E It is really painful to wait for all those drivers to build, b=
ut I figured that might be faster than trying to find the incorrect paramet=
er=2E
>
>I can finally report that vboxsf no longer generated a BUG=2E It is getti=
ng farther, but I am not done yet=2E It now generates a line that says "Unk=
nown parameter tag" and then hangs=2E I have not tracked that down yet=2E
>
>I was not aware of the DECLARE_FLEX_ARRAY() macro=2E I had considered rem=
oving the union and creating a simple string[] declaration, but I do not me=
ss with file systems, and decided to let the experts handle it=2E
>
>I will let you know what I find about that unknown parameter=2E It probab=
ly is coming from VirtualBox=2E

It's possible the size really needs to stay 6 bytes=2E In that case, try a=
dding a "u8 legacy_padding[2]" to the union and restore the VMMDEV_ASSERT_S=
IZE?


--=20
Kees Cook
