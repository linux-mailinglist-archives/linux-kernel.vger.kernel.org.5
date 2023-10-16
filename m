Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3107CB105
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjJPRGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbjJPRGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:06:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B12100;
        Mon, 16 Oct 2023 10:04:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7C4C433C7;
        Mon, 16 Oct 2023 17:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697475843;
        bh=PfysQKQ+U5oiVOeEEWSdmDvGFo/K4A19Hbz110sUuPQ=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=J+4TzggkoIquBGDze1MsMSJPBHkDy8YKKWcxCdmkCdY0evAc0vCDPTsGbFltdCzRW
         vm3HHHG9Zp8hANIV9o1QwqtVf0NwZSnhpzTJem3evF8aat8FqlyJpPCeV0UlLkRJkE
         RyNT3oJP6y4wgV3Xu9+zewRoBaiA0SCJqc9eTgtgZXy7XCIAajxKe/r6QodQ4E/fVb
         BCf9iMwM130jxv+7+hNrDUB61Gp5FeIcUlQNR8qrKk9/JJmbJQAkGd7BskIB/RRa9E
         tUHnUBnKISWQojXcvo6/1K0eMZHts1LA3FE7dP0LMLHcrCI5nuMqFFyBnuq1gWKXQQ
         Jj/G062WwDXkg==
Date:   Mon, 16 Oct 2023 10:03:57 -0700
From:   Kees Cook <kees@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <horms@kernel.org>
CC:     Justin Stitt <justinstitt@google.com>,
        Thomas Sailer <t.sailer@alumni.ethz.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-hams@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hamradio: replace deprecated strncpy with strscpy
User-Agent: K-9 Mail for Android
In-Reply-To: <FA371CE1-F449-44D4-801A-11C842E84867@kernel.org>
References: <20231012-strncpy-drivers-net-hamradio-baycom_epp-c-v1-1-8f4097538ee4@google.com> <20231015150619.GC1386676@kernel.org> <ede96908-76ff-473c-a5e1-39e2ce130df9@kadam.mountain> <FA371CE1-F449-44D4-801A-11C842E84867@kernel.org>
Message-ID: <123F9651-9469-4F2B-ADC1-12293C9EA7FE@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On October 16, 2023 10:01:20 AM PDT, Kees Cook <kees@kernel=2Eorg> wrote:
>
>
>On October 15, 2023 10:47:53 PM PDT, Dan Carpenter <dan=2Ecarpenter@linar=
o=2Eorg> wrote:
>>On Sun, Oct 15, 2023 at 05:06:19PM +0200, Simon Horman wrote:
>>> On Thu, Oct 12, 2023 at 09:33:32PM +0000, Justin Stitt wrote:
>>> > strncpy() is deprecated for use on NUL-terminated destination string=
s
>>> > [1] and as such we should prefer more robust and less ambiguous stri=
ng
>>> > interfaces=2E
>>> >=20
>>> > We expect both hi=2Edata=2Emodename and hi=2Edata=2Edrivername to be
>>> > NUL-terminated but not necessarily NUL-padded which is evident by it=
s
>>> > usage with sprintf:
>>> > |       sprintf(hi=2Edata=2Emodename, "%sclk,%smodem,fclk=3D%d,bps=
=3D%d%s",
>>> > |               bc->cfg=2Eintclk ? "int" : "ext",
>>> > |               bc->cfg=2Eextmodem ? "ext" : "int", bc->cfg=2Efclk, =
bc->cfg=2Ebps,
>>> > |               bc->cfg=2Eloopback ? ",loopback" : "");
>>> >=20
>>> > Note that this data is copied out to userspace with:
>>> > |       if (copy_to_user(data, &hi, sizeof(hi)))
>>> > =2E=2E=2E however, the data was also copied FROM the user here:
>>> > |       if (copy_from_user(&hi, data, sizeof(hi)))
>>>=20
>>> Thanks Justin,
>>>=20
>>> I see that too=2E
>>>=20
>>> Perhaps I am off the mark here, and perhaps it's out of scope for this
>>> patch, but I do think it would be nicer if the kernel only sent
>>> intended data to user-space, even if any unintended payload came
>>> from user-space=2E
>>>=20
>>
>>It's kind of normal to pass user space data back to itself=2E  We
>>generally only worry about info leaks=2E
>
>True but since this used to zero the rest of the buffet, let's just keep =
that behavior and use strscpy_pad()=2E

I'm calling all byte arrays a "buffet" from now on=2E ;)

--=20
Kees Cook
