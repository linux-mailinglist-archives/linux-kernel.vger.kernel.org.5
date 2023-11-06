Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338987E1F90
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjKFLJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjKFLJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:09:12 -0500
X-Greylist: delayed 728 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Nov 2023 03:09:06 PST
Received: from dilbert.mork.no (dilbert.mork.no [IPv6:2a01:4f9:c010:a439::d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FF8BE;
        Mon,  6 Nov 2023 03:09:05 -0800 (PST)
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10da:6900:0:0:0:1])
        (authenticated bits=0)
        by dilbert.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 3A6AttXT2689685
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 10:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1699268150; bh=my/IgPfusIE4M9FRFP6RHKyylmz6+9fhEowX1+bbe38=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=MCwGn8+DghdfNDHGtgSJCQgkkHvYfBJp9eZMdWQh65g8EiKO4Y2vYaT9hwGBzqm4q
         C3X8Tm5W1cNEXgHTfRLk7AotWV78E4snZIQEOV9EtQgI8hnFYn7O9uLU5ziY5a5Sp6
         2/m7OFwxcBFnCHC4Ht6ISMJTVgkWEY1EVtf8FJ3M=
Received: from miraculix.mork.no ([IPv6:2a01:799:10da:690a:d43d:737:5289:b66f])
        (authenticated bits=0)
        by canardo.dyn.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 3A6AtnvE1598821
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 11:55:49 +0100
Received: (nullmailer pid 1536086 invoked by uid 1000);
        Mon, 06 Nov 2023 10:55:49 -0000
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Ren Mingshuai <renmingshuai@huawei.com>, kuba@kernel.org,
        caowangbao@huawei.com, davem@davemloft.net, khlebnikov@openvz.org,
        liaichun@huawei.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, yanan@huawei.com
Subject: Re: [PATCH] net: usbnet: Fix potential NULL pointer dereference
Organization: m
References: <20231101213832.77bd657b@kernel.org>
        <20231102090630.938759-1-renmingshuai@huawei.com>
        <80af8b7a-c543-4386-bb0c-a356189581a0@suse.com>
Date:   Mon, 06 Nov 2023 11:55:49 +0100
In-Reply-To: <80af8b7a-c543-4386-bb0c-a356189581a0@suse.com> (Oliver Neukum's
        message of "Mon, 6 Nov 2023 11:18:39 +0100")
Message-ID: <871qd3up56.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.0.3 at canardo
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum <oneukum@suse.com> writes:

> yes it looks like NCM does funky things, but what does that mean?
>
> ndp_to_end_store()
>
>         /* flush pending data before changing flag */
>         netif_tx_lock_bh(dev->net);
>         usbnet_start_xmit(NULL, dev->net);
>         spin_lock_bh(&ctx->mtx);
>         if (enable)
>
> expects some odd semantics from it. The proposed patch simply
> increases the drop counter, which is by itself questionable, as
> we drop nothing.
>
> But it definitely does no IO, so we flush nothing.
> That is, we clearly have bug(s) but the patch only papers over
> them.
> And frankly, the basic question needs to be answered:
> Are you allowed to call ndo_start_xmit() with a NULL skb?
>
> My understanding until now was that you must not.

Yuck.  I see that I'm to blame for that code, so I've tried to figure
out what the idea behind it could possibly have been.

I believe that code is based on the (safe?) assumption that the struct
usbnet driver_info->tx_fixup points to cdc_ncm_tx_fixup().  And
cdc_ncm_tx_fixup does lots of weird stuff, including special handling of
NULL skb. It might return a valid skb for further processing by
usbnet_start_xmit().  If it doesn't, then we jump straight to
"not_drop", like we do when cdc_ncm_tx_fixup decides to eat the passed
skb.

But "funky" is i precise description of all this...  If someone feels
like it, then all that open coded skb queing inside cdc_ncm should be
completely rewritten.



Bj=C3=B8rn
