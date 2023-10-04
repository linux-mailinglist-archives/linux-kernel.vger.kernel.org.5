Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9941C7B9872
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240374AbjJDW4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbjJDW4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:56:13 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3693895;
        Wed,  4 Oct 2023 15:56:07 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C0D9577D;
        Wed,  4 Oct 2023 22:56:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C0D9577D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696460165; bh=VGEewOivVVXxRe4yeWdnj6hs2luNc7hkwYEag1NXZWw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=tHHuP8QvrNgyqfwD29DAEB9Fyz/9m9K3y2sKAXSae3a3KPAXs4o196eUbjmVhXmc+
         DFmYoUWRH1ppihNXVcglkKTJuit12m9ESk/aU1Om5Lp0AQk8cJ3q+rViPWi3AYQY+j
         3CIp4qdj1gFMP/4l1vD8w/kRkCY4dZ/EGBNAgF5WsyUVACADAy6C6gLwEH4AlucGgM
         xRF578ij0imQW2Lmj/PbcEPj+4ozg47EDmULcRtc9XY73lXNfPaVNAeFvadkpSoxNv
         ts9OrI59d5JMZUAT2Kpm/2CHT8wjZZo8BlbD1AEiOdcejef62leajHNZhaiOK4Kvcg
         Mjq/XOV+Pay6w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dmitry Safonov <dima@arista.com>, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        "Gaillardetz, Dominik" <dgaillar@ciena.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        "Nassiri, Mohammad" <mnassiri@ciena.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <simon.horman@corigine.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v13 net-next 23/23] Documentation/tcp: Add TCP-AO
 documentation
In-Reply-To: <20231004223629.166300-24-dima@arista.com>
References: <20231004223629.166300-1-dima@arista.com>
 <20231004223629.166300-24-dima@arista.com>
Date:   Wed, 04 Oct 2023 16:56:05 -0600
Message-ID: <87jzs2yp2y.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Safonov <dima@arista.com> writes:

> It has Frequently Asked Questions (FAQ) on RFC 5925 - I found it very
> useful answering those before writing the actual code. It provides answers
> to common questions that arise on a quick read of the RFC, as well as how
> they were answered. There's also comparison to TCP-MD5 option,
> evaluation of per-socket vs in-kernel-DB approaches and description of
> uAPI provided.
>
> Hopefully, it will be as useful for reviewing the code as it was for writing.

It looks like useful information; I just have one request...

> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> Acked-by: David Ahern <dsahern@kernel.org>
> ---
>  Documentation/networking/index.rst  |   1 +
>  Documentation/networking/tcp_ao.rst | 434 ++++++++++++++++++++++++++++
>  2 files changed, 435 insertions(+)
>  create mode 100644 Documentation/networking/tcp_ao.rst
>
> diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
> index 5b75c3f7a137..69c1e53ef88b 100644
> --- a/Documentation/networking/index.rst
> +++ b/Documentation/networking/index.rst
> @@ -107,6 +107,7 @@ Contents:
>     sysfs-tagging
>     tc-actions-env-rules
>     tc-queue-filters
> +   tcp_ao
>     tcp-thin
>     team
>     timestamping
> diff --git a/Documentation/networking/tcp_ao.rst b/Documentation/networking/tcp_ao.rst
> new file mode 100644
> index 000000000000..cfa13a0748a2
> --- /dev/null
> +++ b/Documentation/networking/tcp_ao.rst
> @@ -0,0 +1,434 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +========================================================
> +TCP Authentication Option Linux implementation (RFC5925)
> +========================================================
> +
> +TCP Authentication Option (TCP-AO) provides a TCP extension aimed at verifying
> +segments between trusted peers. It adds a new TCP header option with
> +a Message Authentication Code (MAC). MACs are produced from the content
> +of a TCP segment using a hashing function with a password known to both peers.
> +The intent of TCP-AO is to deprecate TCP-MD5 providing better security,
> +key rotation and support for variety of hashing algorithms.
> +
> +1. Introduction
> +===============
> +
> +.. list-table:: Short and Limited Comparison of TCP-AO and TCP-MD5
> +
> +   * -
> +     - TCP-MD5
> +     - TCP-AO
> +   * - Supported hashing algorithms
> +     - MD5 (cryptographically weak).
> +     - Must support HMAC-SHA1 (chosen-prefix attacks) and CMAC-AES-128
> +       (only side-channel attacks). May support any hashing algorithm.

...can you please avoid using list-table if possible?  It makes the
plain-text version nearly impossible to read.

Thanks,

jon
