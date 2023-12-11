Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584BF80DF6B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345323AbjLKXV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 18:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345168AbjLKXVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:21:54 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E362BD1;
        Mon, 11 Dec 2023 15:21:58 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 6543DC01F; Tue, 12 Dec 2023 00:21:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1702336917; bh=RctkjfZ/uke+J5C79Z3MVEHpAx1sc8x3waMFXiBIDT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JjIdSjMjQL1JNut9IMYjBi4vvLTZvW49XIyfzyrcGkc9fQ85zliwL6U6rxPDPqMmb
         IXzxVpNzwNpm97PPSpYXVUZAE3dg0r0R71S9J6MmumATGg73Dqp/fygMtBgNfUjEs8
         fgJqGNO9W20aCUKHSoh4ff0Yzkh40KTKGWPooQ9uLN91kHumfHfTt+Fzvqn8iW8mlJ
         MOqbA1mzfpFl5jxissQRMP6m+DtPkQxKmK2ACnZRe2QUuVhcLgYDzKP+4dAJzdtU2t
         03DbS0O0ojMCYpD3yVAwIK27C1QvWqTXHGlK2crugSrn26iKGmIyoC7GYCHJ8HVIs0
         aFmdgfL+pCmfg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 82DE3C009;
        Tue, 12 Dec 2023 00:21:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1702336916; bh=RctkjfZ/uke+J5C79Z3MVEHpAx1sc8x3waMFXiBIDT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Odnq8u7wg88pa7i3Cw+3L4vmH+F6XkDUyoXumbgLwUo0ceDH5mmCZKmL+hTZvzKe5
         8bAGrTyAen597zv7HoUof6QTJhO05gha1cqezTNsi1RdU/ogMJaPdnYUZdySGfCApi
         fK3f9zVZGAVCVWOh2f70vqExnq1KfWQFQAskQnWYbfY+Zr8pTllIw42f7iPg3qdfVI
         Ed/m06uM6UwZdHHIIodZBe1uekJO/U4+jBw5N4h0YLJDb7WcPNhkfRjXw81x+Xj2IN
         uijtgLj1G550fCAoVd8OgoO+5cFpjGaZHNGoIDZy0+ETkig9erb0BiOGNkLtrG9VIt
         occqrp8xWhEuA==
Received: from localhost (gaia [local])
        by gaia (OpenSMTPD) with ESMTPA id 4e583e84;
        Mon, 11 Dec 2023 23:21:45 +0000 (UTC)
Date:   Tue, 12 Dec 2023 08:21:30 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, v9fs@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH v4] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Message-ID: <ZXeZevFb1oDvMFns@codewreck.org>
References: <20231206200913.16135-1-pchelkin@ispras.ru>
 <1808202.Umia7laAZq@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1808202.Umia7laAZq@silver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schoenebeck wrote on Thu, Dec 07, 2023 at 01:54:02PM +0100:
> I just checked whether this could create a leak, but it looks clean, so LGTM:

Right, either version look good to me.
I don't have a hard preference here, I've finished testing and just
updated the patch -- thanks for your comments & review
(and thanks Simon as well!)

-- 
Dominique Martinet | Asmadeus
