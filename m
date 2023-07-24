Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEB0760348
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 01:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjGXXop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 19:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGXXon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 19:44:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0B91712;
        Mon, 24 Jul 2023 16:44:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 530376140B;
        Mon, 24 Jul 2023 23:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734ACC433C7;
        Mon, 24 Jul 2023 23:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690242281;
        bh=TfTwWIH4LXmyHUSfEAte1A0Fmqtzcc7N89tHwOeU7l8=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=tdsHWe0mWJn3MOipv9o9bjoobe+0GkxX56u+NNXwdXBkYjcsMM4s5PE2o7swCn81y
         uG1XZMp4pVnydbaUkS/VxTtD+BgeRBhjbdMVb1UqCYjjRbkVRNf4I7z/YAZ1a3T5oF
         ciSqdWTRlW2YtuDlJZrtLljDDBAgdP5h7NuH7R6sBDm3PtusP1sUYNS5aBmVZQ8N45
         kJ9T7kHYA4sNEfGVNBaszPuEafQK7b8dskg8Vjv1BhzyB70gfpoqMrHueQAo1pgzq8
         0nfd/FwAv5NVnQ2TWCvSVu5y9cxWfw0EEbQOJTBliDP5PH3L3/JSVomsXc0gucNHmV
         2ATi+wERmUr3g==
Date:   Mon, 24 Jul 2023 16:44:38 -0700
From:   Kees Cook <kees@kernel.org>
To:     sel4@tilde.club
CC:     keescook@chromium.org, Brandon Luo <sel4@tilde.club>,
        syzbot+98d3ceb7e01269e7bf4f@syzkaller.appspotmail.com,
        syzbot+155274e882dcbf9885df@syzkaller.appspotmail.com,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_fortify=3A_strnl?= =?US-ASCII?Q?en=3A_Call_fortify=5Fpanic=28=29_on?= =?US-ASCII?Q?ly_if_the_number_of_bytes_read_is_greater_than_maxlen?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20230724224857.2049906-1-sel4@tilde.club>
References: <4F5F9CC2-803C-4E18-968C-A46B32528F1F@kernel.org> <20230724224857.2049906-1-sel4@tilde.club>
Message-ID: <53423CC8-1A7E-4FD2-8F6B-83E88ABE30A5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 24, 2023 3:48:57 PM PDT, sel4@tilde=2Eclub wrote:
>From: Brandon Luo <sel4@tilde=2Eclub>
>
>If the number of bytes read is p_size and p_size is less than maxlen,
>fortify_panic() will be called incorrectly=2E Only panic if the number of
>bytes read is greater than the minimum of p_size and maxlen since that is
> the argument to __real_strnlen()=2E
>
>Reported-by: syzbot+98d3ceb7e01269e7bf4f@syzkaller=2Eappspotmail=2Ecom
>Closes: https://lore=2Ekernel=2Eorg/all/000000000000d8352e0600c0c804@goog=
le=2Ecom/
>
>Reported-by: syzbot+155274e882dcbf9885df@syzkaller=2Eappspotmail=2Ecom
>Closes: https://lore=2Ekernel=2Eorg/all/000000000000de4c2c0600c02b28@goog=
le=2Ecom/

Thanks for looking at these, but strnlen is working correctly=2E The probl=
em was hfs's overread of a cast be32 when used with strscpy=2E See:
https://lore=2Ekernel=2Eorg/lkml/202307182147=2EA5B81B67D@keescook/

-Kees

>
>Signed-off-by: Brandon Luo <sel4@tilde=2Eclub>
>---
> include/linux/fortify-string=2Eh | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/fortify-string=2Eh b/include/linux/fortify-str=
ing=2Eh
>index da51a83b2829=2E=2Ecde637f735fe 100644
>--- a/include/linux/fortify-string=2Eh
>+++ b/include/linux/fortify-string=2Eh
>@@ -176,8 +176,9 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char *=
 const POS p, __kernel_size
> 	}
>=20
> 	/* Do not check characters beyond the end of p=2E */
>-	ret =3D __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
>-	if (p_size <=3D ret && maxlen !=3D ret)
>+	maxlen =3D (maxlen < p_size) ? maxlen : p_size;
>+	ret =3D __real_strnlen(p, maxlen);
>+	if (maxlen < ret)
> 		fortify_panic(__func__);
> 	return ret;
> }


--=20
Kees Cook
