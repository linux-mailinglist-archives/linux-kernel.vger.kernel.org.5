Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76877805BF0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346096AbjLERWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345778AbjLERWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:22:31 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BE3188;
        Tue,  5 Dec 2023 09:22:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701796909; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=cWT3Ly1xj+qjQiNaCukHUeUZ/2zObAP0yWVv4KUmiwC7fD+bQNxWhQVykEMMwrvH7us4xvjrnnW5aZXfKO41WZGcj+cZA9sZnVMMny4ybZJKsJus0vJyWM9ZqH2DB/FEk65hq68DpCr6N8VbWfRuGLbmbDVA8psMSd/9k3+k7J0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1701796909; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=ZOT5stgB/PObSmgMtYkbkXCE93C5EKs6ibg38Dj4Wfw=; 
        b=cc8n4CDq4pzr+q8szbJR0iIXjwXO341x8U1r0Hq0kjuY8OHVTbUUEFqLoZn5vlNhvfgT8ryd6Mi9FpesqOCGz6jgAto8ls8Z3bp8yGswO97O4VG0S5lbiQMk9xyL117uC0PfJzoHJwJgmzgzOXIBZlYev/RvFGH+xkBps6OGvvw=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1701796909;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=ZOT5stgB/PObSmgMtYkbkXCE93C5EKs6ibg38Dj4Wfw=;
        b=uF76BNgZzLgo27lRSsBSb4pUafsEMAaCO/1hUsNVFbibwRCCO+um8HhpbeTs0/7q
        P0oCRQwThoV8cV6LaSaV60LVYPSN7ynKsRb02GpV12XLtDUvPwXxWuOEDBeGLpZUW89
        6JRH+z13qSZ9lRgXFt64wMlUhylSsXV3VbpFaL8o=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1701796877595248.52755350576115; Tue, 5 Dec 2023 22:51:17 +0530 (IST)
Date:   Tue, 05 Dec 2023 22:51:17 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Suman Ghosh" <sumang@marvell.com>,
        "netdev" <netdev@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "syzbot+bbe84a4010eeea00982d" 
        <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
Message-ID: <18c3aff94ef.7cc78f6896702.921153651485959341@siddh.me>
In-Reply-To: <fd709885-c489-4f84-83ab-53cfb4920094@linaro.org>
References: <cover.1701627492.git.code@siddh.me>
 <4143dc4398aa4940a76d3f375ec7984e98891a11.1701627492.git.code@siddh.me> <fd709885-c489-4f84-83ab-53cfb4920094@linaro.org>
Subject: Re: [PATCH net-next v3 1/2] nfc: llcp_core: Hold a ref to
 llcp_local->dev when holding a ref to llcp_local
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2023 22:10:00 +0530, Krzysztof Kozlowski wrote:
> > @@ -180,6 +183,7 @@ int nfc_llcp_local_put(struct nfc_llcp_local *local)
> >  	if (local == NULL)
> >  		return 0;
> >  
> > +	nfc_put_device(local->dev);
> 
> Mismatched order with get. Unwinding is always in reversed order. Or
> maybe other order is here on purpose? Then it needs to be explained.

Yes, local_release() will free local, so local->dev cannot be accessed.
Will add a comment.

> > @@ -959,8 +963,18 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
> >  	}
> >  
> >  	new_sock = nfc_llcp_sock(new_sk);
> > -	new_sock->dev = local->dev;
> > +
> >  	new_sock->local = nfc_llcp_local_get(local);
> > +	if (!new_sock->local) {
> 
> There is already an cleanup path/label, so extend it. Existing code
> needs some improvements in that matter as well.

Sure.

> > +		reason = LLCP_DM_REJ;
> > +		release_sock(&sock->sk);
> > +		sock_put(&sock->sk);
> > +		sock_put(&new_sock->sk);
> > +		nfc_llcp_sock_free(new_sock);
> > +		goto fail;
> > +	}
> > +
> > +	new_sock->dev = local->dev;
> >  	new_sock->rw = sock->rw;
> >  	new_sock->miux = sock->miux;
> >  	new_sock->nfc_protocol = sock->nfc_protocol;
> > @@ -1597,7 +1611,13 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
> >  	if (local == NULL)
> >  		return -ENOMEM;
> >  
> > -	local->dev = ndev;
> > +	/* Hold a reference to the device. */
> 
> That's obvious. Instead write something not obvious - why you call
> nfc_get_device() while not incrementing reference to llcp_local.

Should I move it after kref_init()? Here, I'm bailing out early so we
don't have to do unnecessary init first, and the rest of the function
will never fail.

> > +	local->dev = nfc_get_device(ndev->idx);
> 
> This looks confusing. If you can access ndev->idx, then ndev reference
> was already increased. In such case iterating through all devices to
> find it, is unnecessary and confusing.

I agree, it was something I thought about as well. There should be a
new function for refcount increment. Maybe the existing one could be
renamed to nfc_get_device_from_idx() and a new nfc_get_device() be
defined.

I didn't want to introduce improvement patches in this UAF series, as
that would be an independent unit of change.

Thanks,
Siddh
